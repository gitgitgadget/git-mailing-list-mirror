From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] CET is only one hour ahead of UTC, it even says so in date.c
Date: Fri, 16 Aug 2013 22:32:46 +0200
Message-ID: <877gfl1imp.fsf@igel.home>
References: <1376649800-442-1-git-send-email-maandree@operamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mattias =?utf-8?Q?Andr=C3=A9e?= <maandree@operamail.com>
X-From: git-owner@vger.kernel.org Sat Aug 17 00:28:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VASVL-0001iB-Mm
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 00:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403Ab3HPW2T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 18:28:19 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:39057 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286Ab3HPW2P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 18:28:15 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3cGx6m5bcYz3hhmQ;
	Fri, 16 Aug 2013 22:32:48 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3cGx6m1s1Pzbbbr;
	Fri, 16 Aug 2013 22:32:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id TuzCHH4oTdUs; Fri, 16 Aug 2013 22:32:47 +0200 (CEST)
X-Auth-Info: d0D6+iPTk6ksAmWa2awb951bW5PT10eW+jtb06vGpz0=
Received: from igel.home (ppp-88-217-106-70.dynamic.mnet-online.de [88.217.106.70])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri, 16 Aug 2013 22:32:47 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id BEF782C0C08; Fri, 16 Aug 2013 22:32:46 +0200 (CEST)
X-Yow: I'm into SOFTWARE!
In-Reply-To: <1376649800-442-1-git-send-email-maandree@operamail.com>
	("Mattias =?utf-8?Q?Andr=C3=A9e=22's?= message of "Fri, 16 Aug 2013
 12:43:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232443>

Mattias Andr=C3=A9e <maandree@operamail.com> writes:

> diff --git a/Documentation/date-formats.txt b/Documentation/date-form=
ats.txt
> index c000f08..4dbaafa 100644
> --- a/Documentation/date-formats.txt
> +++ b/Documentation/date-formats.txt
> @@ -11,11 +11,11 @@ Git internal format::
>  	It is `<unix timestamp> <timezone offset>`, where `<unix
>  	timestamp>` is the number of seconds since the UNIX epoch.
>  	`<timezone offset>` is a positive or negative offset from UTC.
> -	For example CET (which is 2 hours ahead UTC) is `+0200`.
> +	For example CET (which is 1 hour ahead UTC) is `+0100`.
> =20
>  RFC 2822::
>  	The standard email format as described by RFC 2822, for example
> -	`Thu, 07 Apr 2005 22:13:13 +0200`.
> +	`Thu, 07 Apr 2005 22:13:13 +0100`.

This timestamp cannot be in the CET timezone, though.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
