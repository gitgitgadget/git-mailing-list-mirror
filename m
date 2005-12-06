From: Junio C Hamano <junkio@cox.net>
Subject: Re: Some Documentation/Usage Notes
Date: Mon, 05 Dec 2005 22:11:11 -0800
Message-ID: <7v64q27o1s.fsf@assigned-by-dhcp.cox.net>
References: <E1EjVGk-00015M-Np@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 07:11:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjW2n-0007MV-9X
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 07:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbVLFGLO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 01:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbVLFGLO
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 01:11:14 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:185 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751023AbVLFGLN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 01:11:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206060930.BJCB20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 01:09:30 -0500
To: Jon Loeliger <jdl@freescale.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13255>

Jon Loeliger <jdl@freescale.com> writes:

> Note to $self -- here are some tidbits ToDo:
>
> o   --help  doesn't work on:
>       git-hash-object
> 	git-init-db
> 	git-write-tree

Noted.  Thanks.

> o   There is an odd <any-file-on-the-filesystem> argment named
>     in the git-hash-object documentation.  Would <file> be better
>     and more consistent?  Or is there some subtlety that I am missing?

The subtlety is that it is the only parameter to the coreish
command set that happily named a file outside the project
directory (i.e. you can say "git-hash-object /etc/passwd" but
you cannot say "git-update-index /etc/passwd" --- even if your
repository is at /.git, you would say "git-update-index
etc/passwd" for that). But you are right.  That distinction is
irrelevant.
