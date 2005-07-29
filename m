From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Fri, 29 Jul 2005 10:55:52 +0100
Message-ID: <tnxfytyey1j.fsf@arm.com>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722192424.GB8556@mars.ravnborg.org>
	<7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	<1122068634.7042.35.camel@localhost.localdomain>
	<7vu0imh23q.fsf@assigned-by-dhcp.cox.net>
	<1122108098.6863.38.camel@localhost.localdomain>
	<20050723093035.GB11814@pasky.ji.cz>
	<1122114452.6863.72.camel@localhost.localdomain>
	<20050728194748.GD24948@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Bryan larsen <bryanlarsen@yahoo.com>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Fri Jul 29 12:06:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyRlB-0004Hd-2y
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 12:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVG2KAo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 06:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVG2J6j
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 05:58:39 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:52209 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262554AbVG2J47 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 05:56:59 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j6T9tes4017272;
	Fri, 29 Jul 2005 10:55:40 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id KAA22963;
	Fri, 29 Jul 2005 10:56:25 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 29 Jul 2005 10:56:24 +0100
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050728194748.GD24948@pasky.ji.cz> (Petr Baudis's message of
 "Thu, 28 Jul 2005 21:47:49 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 29 Jul 2005 09:56:24.0468 (UTC) FILETIME=[C7ACBD40:01C59423]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> wrote:
> The committer field generally identifies the committer "physically", and
> isn't usually overriden. You'll find <xpasky@machine.sinus.cz> in my
> committer field, e.g.

I thought GIT_COMMITTER_{NAME,EMAIL} were added to be able to override
the defaults like username@localmachine.

The latest StGIT snapshot uses, by default, the committer's details
for the From: line when sending patches by e-mail, assuming that this
is a valid e-mail address. One can define his own e-mail template and
use a different From: line but I thought it would be simpler to
provide some defaults based on this.

If StGIT users don't like this default template, I can change it.

-- 
Catalin
