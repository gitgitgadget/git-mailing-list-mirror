From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Git.pm: Support for perl/ being built by a different compiler
Date: Sat, 24 Jun 2006 20:14:09 -0700
Message-ID: <7vk676orjy.fsf@assigned-by-dhcp.cox.net>
References: <20060625014703.29304.12715.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 05:14:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuL4g-0007QS-HL
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 05:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWFYDOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 23:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWFYDOL
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 23:14:11 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:57015 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751363AbWFYDOK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 23:14:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625031410.NPAH27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 23:14:10 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22583>

Petr Baudis <pasky@suse.cz> writes:

> dst_ on #git reported that on Solaris 9, Perl was built by Sun CC
> and perl/ is therefore being built with it as well, while the rest
> of Git is built with gcc. The problem (the first one visible, anyway)
> is that we passed perl/ even various gcc-specific options. This
> separates those to a special variable.
>
> This is not really meant for an application yet since it's not clear
> if it will alone help anything.

Do things link and work fine if we do not have the GCC specific
options?

I would question why the rest of git is not built with Sun CC as
well if that is the case.
