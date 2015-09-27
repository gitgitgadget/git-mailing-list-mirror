From: Andrey Loskutov <loskutov@gmx.de>
Subject: Re: Single brackets matching in .gitignore rules
Date: Sun, 27 Sep 2015 18:35:11 +0200
Message-ID: <2578959.p0AHc2Ulk9@pinguin>
References: <2606743.RipZrg6Xoz@pinguin> <m2oagotf1d.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Sep 27 18:35:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgEv4-0007ZP-5J
	for gcvg-git-2@plane.gmane.org; Sun, 27 Sep 2015 18:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbbI0QfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2015 12:35:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:54299 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbbI0QfP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2015 12:35:15 -0400
Received: from pinguin.localnet ([79.247.98.244]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0MPDeK-1Zkcd547ns-004OuB; Sun, 27 Sep 2015 18:35:12
 +0200
User-Agent: KMail/4.14.9 (Linux/4.1.7-100.fc21.x86_64; KDE/4.14.9; x86_64; ; )
In-Reply-To: <m2oagotf1d.fsf@linux-m68k.org>
X-Provags-ID: V03:K0:DOgSL6yeQvzvoen2tnPyMhCz/W5qhtQWv/0uPCms54Rhiq809CC
 iyqngRh/iZTd25svSNi7pKzmGxqVy4Q0Wua6boVFpBkJ0OQSeTiC547/kMAfCVDiFjaNtUt
 aXKPOZv5ktVCS9yvOmnjwmospt53fDqwAntUOjzHdQBQ8jXbQDQeLbxbGja5yyFcpPoLPer
 e1o6yn+jSvfV+SrZec7rg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9acAADywglg=:0Cu75y/3JR2aSpu4ehAFwG
 RYSpKRS1aIvXC2++zqCh3i+mx3N6N1Wl8jbjDElNXZmnk6XO9II+nE17R4RgbgvyOcgwuWd2w
 T/ubO7ObAUEhdCD810Wgl1IarsgLteH0N1B7SbXKmoD2lB7q89a2J5iXz/JCD0lLQ+uIT/jiH
 7/CpnowmZbl4ug8hhZdzU+1fvezdh4YizL3Syuo5Nz51uH12jt4rNQtQHsKqoscphp7OyfL1y
 e/RA12OGWdD9n+ax7IlRZcR+pbdMU7cmqc4KTj+n09n/4CDENPZyGtSrKSofshrEUahHcU1/i
 aX//b9Q/JVxos57t/vYRKRllRP6QzbhC9TCAP0VaCBGlImvhlA2X7EsLXX0VUwDFfxyeOn3ul
 4rXhUsi47ImnPrH6OUWBCQthaRggZW/KThHfVhGYz6gjmB8O6FN9qcFm3IHARpgDu1k1ryPwn
 IHUGP4DfdZS9ZKVNMgrR62DT/KK3SMoXuuJWqf9GtMw9w2g12fXJpWlqK/h8VwGzO49+7XWWB
 cVl2LNBhbM9Ys+mKG18TaKyV/p6/LhRH7rne1lAVbxskiql4U+jyOpCZCaoniO0ZVlYZ0ezo2
 QVvesgMLY1wXcExRna1bjcUKCGMPYKC92CtdNSq5PkGVP7AvGHcQnForM/IxxiBtsdlejdA27
 tc3DrYdBvPnwnwgUpjMCAfGLgGbBXwiaN/1Zwtbuo0sjYFAYuaFDPtdrZNXvUv/ZjlfPkU4BH
 FBAuVEqX9U2VW33iMZs2M+jR9/1HvGI1c+nWGA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278709>

On Sunday 27 September 2015 10:58 Andreas Schwab wrote:
> 
> ] by itself is not special in a glob.
> 
> Andreas.
> 

OK, this would explain the current state: once Git sees opened bracket, it always tries to parse the glob pattern and if this fails (if the bracket is not closed), the ignore rule does not match anything. This does not happen for closing bracket and therefore the difference in behavior.

Thanks!

P.S.
In case anyone is interested, here is the path for JGit: https://git.eclipse.org/r/#/c/56773/4

-- 
Kind regards,
google.com/+AndreyLoskutov
