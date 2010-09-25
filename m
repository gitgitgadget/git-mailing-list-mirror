From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCHv2 16/16] Add missing &&'s throughout the testsuite
Date: Sat, 25 Sep 2010 17:05:41 +0000
Message-ID: <AANLkTi=0ByRX2E_MDE7eeb4LR=bKXeah1xD1MRpW1+Jk@mail.gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
	<1285366976-22216-17-git-send-email-newren@gmail.com>
	<AANLkTimfvo-nUDROSKWVFzB0HdAH4MfbH+oU4AP+pRqO@mail.gmail.com>
	<AANLkTincF9qu62w1+WLcidxFAYb8iqf_Jw+ETwuy=rg9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 19:05:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzYC3-0007ZD-SX
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 19:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284Ab0IYRFm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 13:05:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55247 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab0IYRFl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 13:05:41 -0400
Received: by iwn5 with SMTP id 5so3338510iwn.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 10:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/lg61HcQfsGeHcefMhIAdw0F1yfUx5WO3Oim/G3cWbw=;
        b=kYFZ7oto6FetTMb0AwttauWtMF2T7rVA8KFeoHJjHe7EasXwlhhpGWliG+agXDECCw
         4EL7ItWVoDIQM7EUxf8rLhI3VMyGKgKiKtSJCbMUWflcML7rNp80FEQ1s/muLJRQAx0c
         wpcOSKKeGz6VpAajfWNx30VFgk9SqMz1owOvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=n09Eh9IisDNkQ55+7/KbayCm15TX1Sfq5v9UTavbmNwNwJCC5Qj1q7KOIjlMrbmRXi
         Cgvw1+voRDLuE2Uw7KRFKiyM0pjgHlOV6C6uNFwJogYKk6q96vY7b0O2CbGLkxg8trVD
         KWebZcMUGmGTzqYuKniXlHEA7Fnfc2hmWQH+M=
Received: by 10.231.35.8 with SMTP id n8mr5859990ibd.78.1285434341204; Sat, 25
 Sep 2010 10:05:41 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sat, 25 Sep 2010 10:05:41 -0700 (PDT)
In-Reply-To: <AANLkTincF9qu62w1+WLcidxFAYb8iqf_Jw+ETwuy=rg9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157167>

On Sat, Sep 25, 2010 at 16:50, Elijah Newren <newren@gmail.com> wrote:
> On Fri, Sep 24, 2010 at 5:18 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> On Fri, Sep 24, 2010 at 22:22, Elijah Newren <newren@gmail.com> wrot=
e:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0(
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_CONFIG=
 GIT_WORK_TREE GIT_CONFIG
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_CONFIG=
 GIT_WORK_TREE GIT_CONFIG &&
>>
>> These are all bad, see c289c315c2bfcd5fde99f9e4dbb109f89e29dfce for
>> why. If it's possible maybe we should have a new:
>>
>> =C2=A0 =C2=A0test_returns_whatever unset FOO &&
>>
>> To make this more self-documenting
>
> Isn't that what test_might_fail does (even if documented as being onl=
y
> for git commands)?

Yeah, maybe that should be used. But it might also be better to have a
different one for OS commands so they can be easily grep-ed for. I.e.:

    easily_greppable_string unset FOO &&

Instead of:

    unset FOO;
