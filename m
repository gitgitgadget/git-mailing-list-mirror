From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 0/5] ignore SIGINT while editor runs
Date: Sun, 11 Nov 2012 23:08:43 +0100
Message-ID: <m2mwynkd1w.fsf@igel.home>
References: <20121109192336.GA9401@sigill.intra.peff.net>
	<87a9uq5tql.fsf@Niukka.kon.iki.fi>
	<20121110155209.75EFC2E8B68@grass.foxharp.boston.ma.us>
	<871ug15k5c.fsf@Niukka.kon.iki.fi>
	<20121110220811.DC6A42E8B68@grass.foxharp.boston.ma.us>
	<87wqxs4o6f.fsf@Niukka.kon.iki.fi>
	<20121111154846.GA13188@sigill.intra.peff.net>
	<20121111163100.GB13188@sigill.intra.peff.net>
	<20121111191520.GA9474@shrek.podlesie.net>
	<20121111202419.7602E2E8B6A@grass.foxharp.boston.ma.us>
	<20121111204305.GA20599@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Fox <pgf@foxharp.boston.ma.us>, Jeff King <peff@peff.net>,
	Kalle Olavi Niemitalo <kon@iki.fi>, git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 23:10:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXfjE-0002OA-QR
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 23:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198Ab2KKWIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 17:08:52 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:48788 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab2KKWIv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 17:08:51 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Y08Pn0hCXz3hhl6;
	Sun, 11 Nov 2012 23:08:44 +0100 (CET)
X-Auth-Info: Z9Sy7x88ugykEaiVM6NH25z6hsjaJrs7HKGqrx1D4kY=
Received: from igel.home (ppp-93-104-148-16.dynamic.mnet-online.de [93.104.148.16])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Y08Pm51vczbbcw;
	Sun, 11 Nov 2012 23:08:44 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 17D63CA2A4; Sun, 11 Nov 2012 23:08:43 +0100 (CET)
X-Yow: My EARS are GONE!!
In-Reply-To: <20121111204305.GA20599@shrek.podlesie.net> (Krzysztof Mazur's
	message of "Sun, 11 Nov 2012 21:43:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209450>

Krzysztof Mazur <krzysiek@podlesie.net> writes:

> That's why I'm proposing in case of SIGQUIT just killing the editor
> (SIGTERM is sufficient for ed).
>
> So git will ignore SIGINT, but die on SIGQUIT (and kill editor
> that ignores SIGQUIT).

system(3) also ignores SIGQUIT.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
