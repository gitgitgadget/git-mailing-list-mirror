From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/5] gettext docs: add "Marking strings for translation"
 section in po/README
Date: Fri, 10 Sep 2010 22:31:10 +0000
Message-ID: <AANLkTi=Ahh1vvwwYoAKNSVQE5dxV7RLdvjSefHOx+JK=@mail.gmail.com>
References: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
	<1284147353-18000-3-git-send-email-avarab@gmail.com>
	<7vmxrpgrqe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 00:31:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuC87-0005bR-1V
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 00:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab0IJWbN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 18:31:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53388 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340Ab0IJWbM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 18:31:12 -0400
Received: by fxm16 with SMTP id 16so2111621fxm.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 15:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KTdZtVOZFGg1nzWLvLRXoFZi4KPeATVaJPrYDYXIOk4=;
        b=AxppG/SYxLwl0vj1mSsLKoIT0H/ZxL/VWeCmfR7M3Z+WYRo/BYn1fiHyZUlTxhTuUu
         4jRoq0G2SH+r8Q6aaxC4cjdX4BqR901zijw+cLAaVq2H3tXBz8/WhYHpWsaXE75R0Pi5
         EyFsNsMgttMx1faxZtHfAXUI2R28kQdVeKSSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QV+ELZQlyhwU4PN6ZyC1dv45Vkui6zsb5JBjYEWSZauVsXMwIWzur5fg/Jju9pdupU
         qhJWb7H5mt8G16x1DAn4VhhRSffA+HSGeu3Xa4MR80Qe3CnChbUxQZUHoGRrLmrlQ+ic
         VJ/kXjkgAY0wTMEo7z5ky7eNMW3PL5iTrjEoQ=
Received: by 10.223.107.65 with SMTP id a1mr986294fap.2.1284157870635; Fri, 10
 Sep 2010 15:31:10 -0700 (PDT)
Received: by 10.223.120.14 with HTTP; Fri, 10 Sep 2010 15:31:10 -0700 (PDT)
In-Reply-To: <7vmxrpgrqe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155976>

On Fri, Sep 10, 2010 at 22:26, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> + - Don't mark everything for translation, only strings which will b=
e
>> + =C2=A0 read by humans (the porcelain interface) should be translat=
ed.
>> +
>> + =C2=A0 The output from Git's plumbing utilities will primarily be =
read by
>> + =C2=A0 programs and would break scripts under non-C locales. These=
 strings
>> + =C2=A0 should not be translated.
>
> Hmm, I had to re-read the above twice and then mentally annotate "wou=
ld
> break ... _if translated_" to make sense of the advice. =C2=A0Perhaps=
 other
> people are much less dense than me?

No, that "... if translated" wording is better.
