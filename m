From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH on ab/i18n] branch: remove lego in i18n tracking info strings
Date: Sun, 6 May 2012 20:06:46 +0700
Message-ID: <CACsJy8Axy3Vaqqd3D4Az-wUO6dS+jGgVLARz0TnURQ2KNYnmog@mail.gmail.com>
References: <877gwtyalt.fsf@thomas.inf.ethz.ch> <1336050720-21200-1-git-send-email-pclouds@gmail.com>
 <7vr4v0apwe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Christian Stimming <stimming@tuhh.de>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 06 15:07:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR1Bs-0006b7-HY
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 15:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556Ab2EFNHT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 09:07:19 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62387 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543Ab2EFNHR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 09:07:17 -0400
Received: by werb10 with SMTP id b10so764679wer.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 06:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kNRv7Inhasmin2FX1qgqBCvghiWGH6Znb0vmnEEr3vI=;
        b=AL1JsdOEzMMh5QWKUQ40lpiLtj52tLnPs0J+rSEUkcjs+VXoE+bSr+PrxKV/XHO/vZ
         ktiHHoAauaMnGx52JVr9TVM+nkDgbr/YpdrXEw+bcjZ2aO/jrHUwAV7mvqousH15a3LE
         Xy94kZsiZV7JhCP/En1h8qqsmG8HCZoLffoZ6pKHcfZQP5jeeeWseqyqKaIwCu90in2j
         M/VB9K05NG5Y8udf5ojHgP7L9zNck+i0CoiCLG95Jy9gbG7uGtJL677JfJvO4npOIN0y
         hjkOuNKrm8i3Hl5Y9XLC9Zw2OjYT4sNbKezWrrEGl8yq5vtmHUHCFHq245NU0iuxPr1A
         n8Nw==
Received: by 10.180.88.67 with SMTP id be3mr27198924wib.20.1336309636528; Sun,
 06 May 2012 06:07:16 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Sun, 6 May 2012 06:06:46 -0700 (PDT)
In-Reply-To: <7vr4v0apwe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197182>

On Fri, May 4, 2012 at 11:10 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> Pseudo html tags to to mark color, like
>> =C2=A0"On branch <color1>%s</color1>" is probably not a bad idea.
>
> The output machinery needs to understand _some_ color mark-up if the
> destination does not support ANSI colors natively, and there already =
is
> such a code in compat/ for windows IIRC. =C2=A0Adding yet another col=
or mark-up
> wouldn't help anybody. =C2=A0I would suggest to just declare that int=
ernally we
> use ANSI colors as the standard color mark-up and be done with it.

=C3=86var started a new thread about this and I elaborated a little bit
there [1]. We cannot just put straight ANSI colors in the string
because they are customizable. We don't know what color to put in the
string at compile time. So we need an intermediate color
representation for translators anyway to avoid fragmented strings. The
problem is which way is better, "On branch %s%s%s", "On branch
<color>%s</color>" or some other ways

[1] http://thread.gmane.org/gmane.comp.version-control.git/196869/focus=
=3D196908
--=20
Duy
