From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 0/5] gettext docs: programmer docs in po/README
Date: Fri, 10 Sep 2010 23:21:25 +0000
Message-ID: <AANLkTinojLSMFbgg6RMer0_hnhG4DwM1V3CX99-SSOgi@mail.gmail.com>
References: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
	<1284147353-18000-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 11 01:21:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuCuS-0001ij-3V
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 01:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553Ab0IJXV1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 19:21:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43484 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841Ab0IJXV0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 19:21:26 -0400
Received: by iwn5 with SMTP id 5so2650325iwn.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 16:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Bk8unYmCzF0OLXAzrHAcEiTZYiCi5WSxXY7sVU+Hpek=;
        b=g+Iw151fYPPW2e696Q/w7b2l2db/zhrdVfO8lGNKahngOTXy/qCsexkLkLLLoP+uXW
         QtAI1RbtQjnwIwcjmCTPw7r9zA2ghCHRDCR8GLzhEBuQplx6Xb9LLg6rBpPtMlruKj0Y
         WFFAsq/456ufgIXaXovJQ0H6mA2Y0xcq9ZqJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pklpzIIGcbXHrcQguYWkm8FxyP0cYMx+Cbn5r8zatMtX+NJmXTWRJw2Zkf18w0fthK
         Rt6YobU7FoVG46SSaJ04XMpuFLmnV6e+k1BvE5T9dEAzgDbxGXnEBauuvLYTS0HsEjfG
         n2Q8Fgxn9UXUHJdhz2sQKu90khQdQ+Xhoiarc=
Received: by 10.231.160.77 with SMTP id m13mr1797079ibx.22.1284160885741; Fri,
 10 Sep 2010 16:21:25 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 10 Sep 2010 16:21:25 -0700 (PDT)
In-Reply-To: <1284147353-18000-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155986>

On Fri, Sep 10, 2010 at 19:35, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> On Fri, Sep 10, 2010 at 17:17, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>> On Fri, Sep 10, 2010 at 16:01, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>> As a companion update to 6495411 (gettext docs: add po/README file
>>> documenting Git's gettext, 2010-09-03), we would need a file in
>>> Documentation/ directory to describe the use of _() and N_() for
>>> programmers and point it from CodingGuidelines.
>>
>> I can add that to ab/i18n-for-junio, but haven't already. Isn't it
>> better if I send that to the list for review instead of just tucking
>> something at the end of the series. I can do either.
>
> Here it is on top of ab/i18n-for-junio. These can also be fetched
> from:
>
> =C2=A0 =C2=A0git://github.com/avar/git.git ab/i18n-for-junio-with-doc=
s

I fixed the wording on this as suggested by Junio, and a trivial
whitespace issue, but not the N_() example.

This ref can replace the existing ab/i18n ref in pu.
