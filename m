From: Junio C Hamano <junkio@cox.net>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Fri, 29 Jul 2005 19:11:09 -0700
Message-ID: <7vll3p82ma.fsf@assigned-by-dhcp.cox.net>
References: <20050728183904.GA24948@pasky.ji.cz>
	<7v4qaeqrh3.fsf@assigned-by-dhcp.cox.net>
	<20050729070628.GA24895@pasky.ji.cz>
	<7vmzo6jbme.fsf@assigned-by-dhcp.cox.net>
	<20050729081051.GH24895@pasky.ji.cz>
	<7vek9igfgw.fsf@assigned-by-dhcp.cox.net>
	<20050729094046.GO24895@pasky.ji.cz>
	<Pine.LNX.4.58.0507291254100.5849@wgmdd8.biozentrum.uni-wuerzburg.de>
	<20050729111304.GS24895@pasky.ji.cz>
	<Pine.LNX.4.58.0507291424070.6247@wgmdd8.biozentrum.uni-wuerzburg.de>
	<20050729122844.GA21909@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 04:19:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DygwM-00020D-0F
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 04:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbVG3CSQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 22:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262928AbVG3CNn
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 22:13:43 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:21979 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262766AbVG3CLP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 22:11:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050730021059.VUTY16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Jul 2005 22:10:59 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

>> > How would that document anything normal push wouldn't?
>> 
>> git-merge?
>
> You have to git-merge anyway if remote head is not your ancestor yet,
> otherwise the push cannot proceed.

Indeed.  And if git-merge fast forwards, then you would not get
any trail, so the "documentation by merge" argument does not
stand.
