From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Pass -DDEFAULT_GIT_TEMPLATE_DIR only where actually used.
Date: Thu, 22 Jun 2006 10:11:49 -0700
Message-ID: <7vodwlp12i.fsf@assigned-by-dhcp.cox.net>
References: <0J1800MC1NKJD2C0@mxout2.netvision.net.il>
	<7vwtb9veqv.fsf@assigned-by-dhcp.cox.net>
	<20060622131235.GA21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 19:12:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtSii-0000wU-Je
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 19:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWFVRLw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 13:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWFVRLw
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 13:11:52 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:44512 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751579AbWFVRLv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 13:11:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622171150.LUXQ27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 13:11:50 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060622131235.GA21864@pasky.or.cz> (Petr Baudis's message of
	"Thu, 22 Jun 2006 15:12:35 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22348>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Thu, Jun 22, 2006 at 09:19:52AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>> For that matter, I do not think tracking prefix_SQ makes much
>> sense since what matters are bindir, gitexecdir and template_dir
>> which are already covered, and prefix is merely a convenience to
>> set these three (four, counting GIT_PYTHON_DIR; we probably
>> should add it to TRACK_CFLAGS).
>
> $(prefix) will be passed to perl/Makefile.PL.

Then probably it shouldn't; instead we woulld probably want to
pass the moral equivalent of GIT_PYTHON_DIR.
