From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] C implementation of the 'git' program.
Date: Fri, 11 Nov 2005 11:37:30 -0800
Message-ID: <7v7jbfm0w5.fsf@assigned-by-dhcp.cox.net>
References: <20051110182631.3C5615BF90@nox.op5.se>
	<m3lkzv4qnz.fsf@harinath.blr.novell.com>
	<7vveyzskdk.fsf@assigned-by-dhcp.cox.net> <437488E6.2050100@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 20:37:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaeiN-0008LS-BJ
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 20:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVKKThc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 14:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVKKThc
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 14:37:32 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:2191 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750820AbVKKThc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 14:37:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111193624.DVEJ24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 14:36:24 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <437488E6.2050100@op5.se> (Andreas Ericsson's message of "Fri, 11
	Nov 2005 13:04:54 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11632>

Andreas Ericsson <ae@op5.se> writes:

> Thoughts? I've got a feeling I've overlooked something here.

If you are doing it, it might make sense to include it from
Makefiles in subdirectories, so that on a platform with non GNU
tar, you could say:

	$ cd t
	$ make

and get TAR=gtar definition from ../config.mk

I think Smurf's libize repository has something like that; it is
found at:

        $ cat .git/remotes/smurf
        URL: http://netz.smurf.noris.de/git/git.git
        Pull: libize:libize
