From: Junio C Hamano <junkio@cox.net>
Subject: Re: Recursive remove
Date: Fri, 13 Jan 2006 09:37:54 -0800
Message-ID: <7virso9ggd.fsf@assigned-by-dhcp.cox.net>
References: <20060113132119.GB23655@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 18:39:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExSsC-0003kn-9a
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 18:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161567AbWAMRh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 12:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161571AbWAMRh5
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 12:37:57 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:56455 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1161567AbWAMRh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 12:37:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113173653.CFTP20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 Jan 2006 12:36:53 -0500
To: "Peter Eriksen" <s022018@student.dtu.dk>
In-Reply-To: <20060113132119.GB23655@ebar091.ebar.dtu.dk> (Peter Eriksen's
	message of "Fri, 13 Jan 2006 14:21:19 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14631>

"Peter Eriksen" <s022018@student.dtu.dk> writes:

> A way to recursively remove a directory /Some/Dir/ is a follows:
>
>    git ls-files -z Some/Dir >rmfiles
>    git update-index -z --force-remove --stdin <rmfiles
>    git commit -a -m "Remove directory Some/Dir"
>    rm -rf Some/Dir
>
> What is a better way to do it?

	$ rm -fr Some/Dir; git commit -a -m 'Remove'

perhaps?
