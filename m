From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] i18n: po for zh_cn
Date: Thu, 2 Feb 2012 20:29:09 +0700
Message-ID: <CACsJy8BPTuS+u8Grx0ojhdX-5+Vn6=DuojSWO0or7fJE1dbAEQ@mail.gmail.com>
References: <1328111436-58925-1-git-send-email-worldhello.net@gmail.com> <7vr4ye15kr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 14:29:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RswjR-0008NM-P6
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 14:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755914Ab2BBN3l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 08:29:41 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48319 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776Ab2BBN3k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 08:29:40 -0500
Received: by bkcjm19 with SMTP id jm19so2090378bkc.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 05:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mWVgPEXzcvj6Yehu6ENqRhCVR0hyMDJtNs+60JDB754=;
        b=q/ReaFEbqGTCPYY5RbDdWupZbyKQG78xSNLRjVtaSlYnZr4inbBc792yQov/Lf8OZH
         /3A1D4CjIOrNXqIK4gX5FThfySjvJDduz/1ccp4e6CBURZ3PXs5/HMhcAGxVH/djFMUn
         bIE16g9+fzo1jekcNyqQ5NbaAcAvkJHXFqRR4=
Received: by 10.204.152.75 with SMTP id f11mr1319835bkw.127.1328189379205;
 Thu, 02 Feb 2012 05:29:39 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Thu, 2 Feb 2012 05:29:09 -0800 (PST)
In-Reply-To: <7vr4ye15kr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189641>

On Thu, Feb 2, 2012 at 6:45 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> Git can speak Chinese now.
>>
>> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>> ---
>> =C2=A0po/zh_cn.po | 3568 +++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++
>> =C2=A01 =E4=B8=AA=E6=96=87=E4=BB=B6=E8=A2=AB=E4=BF=AE=E6=94=B9, 3568=
 =E5=A4=84=E6=B7=BB=E5=8A=A0(+), 0 =E5=A4=84=E5=88=A0=E9=99=A4(-)
>> =C2=A0create mode 100644 po/zh_cn.po
>
> I do not mind Chinese in the patch text (i.e. below), but I would hav=
e
> preferred the above not to be in Chinese, which I do not read---I can
> guess what =E6=96=87=E4=BB=B6, =E6=B7=BB=E5=8A=A0 and =E5=88=A0=E9=99=
=A4 are, and I can also guess that =E4=B8=AA and =E5=A4=84
> are units of counting, but nevertheless...

Such a stat line would be wonderful in an all-Chinese environment
though. I'm thinking perhaps it's a good idea to support
core.officialLocale (or workingLanguage). Commands that produce stuff
for outside like format-patch would prefer core.exchangeLanguage over
$LANG. Commands in blurred zone can learn --official option to ignore
$LANG.

We can then have a shared config with core.officialLocale =3D
en_US.UTF-8 somewhere in git.git. Developers of multi-nation companies
would be pleased, I think.
--=20
Duy
