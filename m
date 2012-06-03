From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: i18n: git-submodule message does not appear in git.pot
Date: Sun, 3 Jun 2012 17:14:34 +0800
Message-ID: <CANYiYbH3p8Ti02CCri+ZxkcNgxzFqb-cqUchSXF_Py_OFOhQXg@mail.gmail.com>
References: <4FC9FA97.7020908@lyx.org>
	<CANYiYbFrdNGpyTy3sVHPfm9R0bK-0S0Yh8BxxK4WkAbaaQRaNA@mail.gmail.com>
	<m2r4tw3isb.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 11:15:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sb6u3-00088i-OT
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 11:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600Ab2FCJOg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Jun 2012 05:14:36 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56182 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab2FCJOf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jun 2012 05:14:35 -0400
Received: by obbtb18 with SMTP id tb18so5494993obb.19
        for <git@vger.kernel.org>; Sun, 03 Jun 2012 02:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mwC758/iE5VE+szmXBvcT6+OAghxixDwtYcWdW2hroY=;
        b=k+Ld4l/4ucZMfr28+PNrAfcmO8BVsNUr6V9LksZqhDzI7Alfahk2Z/bfs/BaSaL9i7
         qu2toXEuKdCQBKXAlN7RwR25VzSnV6OaZDTytegzbFV8HD3uOAg27GhconduKo6TLyZj
         9gMYU1wAxY2rGnOJ35QV46txu/ZzDC1yTYlA5OksteXgmcUx5EGM7Oazef6uCej71yEt
         kzBxUYPWx7L8dieJ/FSl+HSkp2ZZmifTII+RFiZrxAYiJwRFmhX8T5BZ0YfRbRXiqis7
         omkDwA/LAc4YYYqZxlojMLKpyYFsu3cH4Clga2DGkmqSoIm7Zu1G9f/a0nm2bPml6TBD
         67MQ==
Received: by 10.50.104.170 with SMTP id gf10mr5347157igb.52.1338714874596;
 Sun, 03 Jun 2012 02:14:34 -0700 (PDT)
Received: by 10.50.111.194 with HTTP; Sun, 3 Jun 2012 02:14:34 -0700 (PDT)
In-Reply-To: <m2r4tw3isb.fsf@linux-m68k.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199072>

2012/6/3 Andreas Schwab <schwab@linux-m68k.org>:
>> =A0 =A0 =A0 gettext () {
>> + =A0 =A0 =A0 =A0 =A0 =A0 # Bypass options, such as '--'.
>> + =A0 =A0 =A0 =A0 =A0 =A0 while test $# -gt 1
>> + =A0 =A0 =A0 =A0 =A0 =A0 do
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 shift
>> + =A0 =A0 =A0 =A0 =A0 =A0 done
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0shift $(($#-1))

That's better.

--=20
Jiang Xin
