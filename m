From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Thu, 12 Nov 2015 19:40:33 +0100
Message-ID: <87fv0b12ou.fsf@igel.home>
References: <56428A6A.5010406@ramsayjones.plus.com>
	<CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com>
	<56437F3F.7050305@ramsayjones.plus.com>
	<CAPig+cS54yTsZ8NWjyh6kj6nXy966EkYPHh_sjMbMcDGemnFuA@mail.gmail.com>
	<5643ABF0.5080207@ramsayjones.plus.com> <5644232C.2060700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 12 19:40:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zwwng-0008MO-R6
	for gcvg-git-2@plane.gmane.org; Thu, 12 Nov 2015 19:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbbKLSko convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2015 13:40:44 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:58206 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188AbbKLSkm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2015 13:40:42 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3nxWvm21Hsz3hpPT;
	Thu, 12 Nov 2015 19:40:35 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3nxWvl4lHvzvh1l;
	Thu, 12 Nov 2015 19:40:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id FgfNn1N6f_Q8; Thu, 12 Nov 2015 19:40:34 +0100 (CET)
X-Auth-Info: qMafwnf8iGl7C1QGF2mXqRvyTh86AKQQPrpr2eoZqZ9o0kzq3iRsbAIBwoihauoq
Received: from igel.home (ppp-88-217-6-197.dynamic.mnet-online.de [88.217.6.197])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Thu, 12 Nov 2015 19:40:34 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id DDEEE2C1F6B; Thu, 12 Nov 2015 19:40:33 +0100 (CET)
X-Yow: Okay, BARBRA STREISAND, I recognize you now!!  Also EFREM ZIMBALIST,
 JUNIOR!!  And BEAUMONT NEWHALL!!  Everybody into th' BATHROOM!
In-Reply-To: <5644232C.2060700@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 12 Nov 2015 06:27:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281220>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> So whenever a long long is printed, I can warmly recommend to use
>
> PRId64

PRId64 is not suitable for long long, only for int64_t.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
