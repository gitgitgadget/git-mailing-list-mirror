From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Fri, 29 Jul 2005 13:34:49 +0100
Message-ID: <tnx8xzpg592.fsf@arm.com>
References: <tnx1x5ryvn2.fsf@arm.com>
	<20050722192424.GB8556@mars.ravnborg.org>
	<7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	<1122068634.7042.35.camel@localhost.localdomain>
	<7vu0imh23q.fsf@assigned-by-dhcp.cox.net>
	<1122108098.6863.38.camel@localhost.localdomain>
	<20050723093035.GB11814@pasky.ji.cz>
	<1122114452.6863.72.camel@localhost.localdomain>
	<20050728194748.GD24948@pasky.ji.cz> <tnxfytyey1j.fsf@arm.com>
	<20050729111056.GR24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Bryan larsen <bryanlarsen@yahoo.com>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Fri Jul 29 14:36:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyU61-0003RY-Hp
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 14:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVG2Mfy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 08:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVG2Mfy
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 08:35:54 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:24473 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262581AbVG2Mfv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 08:35:51 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j6TCYbs4022503;
	Fri, 29 Jul 2005 13:34:37 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id NAA26308;
	Fri, 29 Jul 2005 13:35:21 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 29 Jul 2005 13:35:21 +0100
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050729111056.GR24895@pasky.ji.cz> (Petr Baudis's message of
 "Fri, 29 Jul 2005 13:10:56 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 29 Jul 2005 12:35:21.0224 (UTC) FILETIME=[FC063880:01C59439]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Fri, Jul 29, 2005 at 11:55:52AM CEST, I got a letter
> where Catalin Marinas <catalin.marinas@gmail.com> told me that...
>> The latest StGIT snapshot uses, by default, the committer's details
>> for the From: line when sending patches by e-mail, assuming that this
>> is a valid e-mail address. One can define his own e-mail template and
>> use a different From: line but I thought it would be simpler to
>> provide some defaults based on this.
>
> Why don't you rather use the GIT_AUTHOR_* variables?

It was simpler since the template variables were based on the patch
details. Anyway, it's not hard to modify.

-- 
Catalin
