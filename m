From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] i18n: po for zh_cn
Date: Thu, 2 Feb 2012 17:42:00 +0100
Message-ID: <CACBZZX5AceH+pc-teFm=PE9u14PM88GLtLnNg5ENOpNni0Tsig@mail.gmail.com>
References: <1328111436-58925-1-git-send-email-worldhello.net@gmail.com>
 <7vr4ye15kr.fsf@alter.siamese.dyndns.org> <CACsJy8BPTuS+u8Grx0ojhdX-5+Vn6=DuojSWO0or7fJE1dbAEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 17:42:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rszjw-0005Gc-27
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 17:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848Ab2BBQmX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 11:42:23 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37325 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754712Ab2BBQmX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 11:42:23 -0500
Received: by lagu2 with SMTP id u2so1380308lag.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 08:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2o7MOn0AKWO18WWAb9vE1KtjqGqXEW42RDTnu7LTYfk=;
        b=BT6AhgWeIvi4+3N2T7y2ghw2FYcptd5lVHEnZVAQ7jKesoySUI8JN1lUvk7XiKf1D5
         ssHNOoSMfHj1a5WWBOefzwmxAgi8X1L+yS0JOo8IZ2zTDysfby83gnpLXJmP92HOMsK5
         nwEZ+0n8HiJPAJxhsaO/5i0JfvC0x29fwCasg=
Received: by 10.152.104.202 with SMTP id gg10mr1884161lab.2.1328200941138;
 Thu, 02 Feb 2012 08:42:21 -0800 (PST)
Received: by 10.112.30.67 with HTTP; Thu, 2 Feb 2012 08:42:00 -0800 (PST)
In-Reply-To: <CACsJy8BPTuS+u8Grx0ojhdX-5+Vn6=DuojSWO0or7fJE1dbAEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189656>

On Thu, Feb 2, 2012 at 14:29, Nguyen Thai Ngoc Duy <pclouds@gmail.com> =
wrote:
> On Thu, Feb 2, 2012 at 6:45 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Jiang Xin <worldhello.net@gmail.com> writes:
>>
>>> Git can speak Chinese now.
>>>
>>> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>>> ---
>>> =C2=A0po/zh_cn.po | 3568 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++
>>> =C2=A01 =E4=B8=AA=E6=96=87=E4=BB=B6=E8=A2=AB=E4=BF=AE=E6=94=B9, 356=
8 =E5=A4=84=E6=B7=BB=E5=8A=A0(+), 0 =E5=A4=84=E5=88=A0=E9=99=A4(-)
>>> =C2=A0create mode 100644 po/zh_cn.po
>>
>> I do not mind Chinese in the patch text (i.e. below), but I would ha=
ve
>> preferred the above not to be in Chinese, which I do not read---I ca=
n
>> guess what =E6=96=87=E4=BB=B6, =E6=B7=BB=E5=8A=A0 and =E5=88=A0=E9=99=
=A4 are, and I can also guess that =E4=B8=AA and =E5=A4=84
>> are units of counting, but nevertheless...
>
> Such a stat line would be wonderful in an all-Chinese environment
> though. I'm thinking perhaps it's a good idea to support
> core.officialLocale (or workingLanguage). Commands that produce stuff
> for outside like format-patch would prefer core.exchangeLanguage over
> $LANG. Commands in blurred zone can learn --official option to ignore
> $LANG.
>
> We can then have a shared config with core.officialLocale =3D
> en_US.UTF-8 somewhere in git.git. Developers of multi-nation companie=
s
> would be pleased, I think.

=46or now we can also avoid this whole issue and just declare that
anything that's used for interchange or permanently stored
(git-format-patch output, reflogs, merge commit messages etc.) will be
in English.
