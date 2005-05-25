From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-cache path restriction fix.
Date: Tue, 24 May 2005 18:24:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505241814220.2307@ppc970.osdl.org>
References: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505241757280.2307@ppc970.osdl.org> <7vekbwru6x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 03:21:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DakaL-0007sw-MX
	for gcvg-git@gmane.org; Wed, 25 May 2005 03:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVEYBXD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 21:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVEYBXD
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 21:23:03 -0400
Received: from fire.osdl.org ([65.172.181.4]:42942 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262229AbVEYBW6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 21:22:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4P1MrjA008986
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 18:22:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4P1MrSv029337;
	Tue, 24 May 2005 18:22:53 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vekbwru6x.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Junio C Hamano wrote:

> >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
> 
> LT> No, it's more broken than that.
> 
> I'll take a look at this later and submit an update, but an OT
> point I feel I should address.

I checked in the fixed arg parsing already ;)

> The comparison lists things in the ascending order from left to
> right.  The fact that 1 comes before argc on that line of code
> visually makes it obvious that I am talking about argc being
> larger than one and that is the reason.  I'd write (argc < 4)
> not (4 > argc) for the same reason.

Hmm. According to that logic, ">" and ">=" is superfluous.

Also, what language do you actually speak? Every human language I know
(admittedly, apart from Finnish they are all related) tends to say things
like "if you have more than four children, you're in trouble", rather than
saying "if four is less than the number of children you have".

Notice? People compare something _to_ a number. They don't compare a
number to something. We say "if more than four", we don't say "if four is
less".

Sadly, I can't get google to match "1 < x" and "x > 1" (it just considers
all special characters to be basically whitespace, so "1 < x" matches "1
x" and "1.x" according to google. Usually google is a good way to get a
feel for how common some phrase is, but not on things like this.

		Linus
