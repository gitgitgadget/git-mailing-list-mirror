From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [RFC/PATCH] Update compat/regex
Date: Fri, 16 Jul 2010 16:17:54 +0200
Message-ID: <m2630fqzn1.fsf@igel.home>
References: <1278549735-19278-1-git-send-email-avarab@gmail.com>
	<7viq4ppxt9.fsf@alter.siamese.dyndns.org>
	<AANLkTikuGY4LVrCB6UoGFhxthoI8MgvAXCwCbiXhwq_d@mail.gmail.com>
	<7vtyo0vdpz.fsf@alter.siamese.dyndns.org>
	<AANLkTim-4I5Sdu653yJOmnVYDqI8bb71839Vqfd3FKCi@mail.gmail.com>
	<20100715220059.GA3312@burratino>
	<AANLkTimQZDT3PuiLDdjPXzWlLiEI5Iv1zy5iFPlRswyC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 16:18:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZljo-0007Ns-3f
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 16:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965689Ab0GPOR6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 10:17:58 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:53003 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965654Ab0GPOR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 10:17:57 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 2AECD1C005F8;
	Fri, 16 Jul 2010 16:17:55 +0200 (CEST)
Received: from igel.home (ppp-88-217-114-100.dynamic.mnet-online.de [88.217.114.100])
	by mail.mnet-online.de (Postfix) with ESMTP id 1C12F1C002F0;
	Fri, 16 Jul 2010 16:17:55 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id E51E9CA297; Fri, 16 Jul 2010 16:17:54 +0200 (CEST)
X-Yow: Yow!  I'm out of work...I could go into shock absorbers...or SCUBA
 GEAR!!
In-Reply-To: <AANLkTimQZDT3PuiLDdjPXzWlLiEI5Iv1zy5iFPlRswyC@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 16 Jul
 2010 13:58:03
	+0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151151>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This patch has all the glibc-specific stuff that makes it break hard
> if you don't have the GNU C library. Writing macros/definitions to fi=
x all that
> stuff up was the "easier said than done" part I was referring to.

You might want to try out the gnulib version instead.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
