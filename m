From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv4 15/15] Replace "unset VAR" with "unset VAR;" in
 testsuite as per t/README
Date: Wed, 29 Sep 2010 20:28:30 +0000
Message-ID: <AANLkTimPQ+CHugJnMPCjCrcAF9sd86mh=Ors8sgwQTUU@mail.gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
	<1285542879-16381-16-git-send-email-newren@gmail.com>
	<7viq1omiv8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 22:28:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P13GX-0001rB-Bj
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 22:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755089Ab0I2U2b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 16:28:31 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50061 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054Ab0I2U2b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 16:28:31 -0400
Received: by gye5 with SMTP id 5so308211gye.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PHy1Evm9VpFEEnT74pysBElqycMvKj7L30d2QdxpOWE=;
        b=NW+kIiO4fBRjAU3O61g03BWr4Zi5+oVI062TxYTmdEvu1dXgIaHYgP5xpodo0JJNqd
         7B6nf/n+3fLSrL0J2Q/QmKSoPUDALC0R5J31rMl+P0UnQzL/eE1ClgdAEBYB91lu1Ngp
         hmCIXdimUPmDQEFg1rtWSIvQYdJowCTzGBLoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b7l7i/c7DBloq87NgYCXPM7ldI+dct6mIX+wSoxDMoUro9MNV6ME8isTJXLkSvcGf1
         utyxMsb1mdhWVVrtbzpNBYHNEpFk6/49FBLos/nkdDYOyuOFtEgbRCexQJueNGWGMRop
         SQtZ1MgrrkqMjx0yVK5tjK/OqxONoxd16dEhs=
Received: by 10.231.149.198 with SMTP id u6mr2407941ibv.7.1285792110054; Wed,
 29 Sep 2010 13:28:30 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 29 Sep 2010 13:28:30 -0700 (PDT)
In-Reply-To: <7viq1omiv8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157597>

On Wed, Sep 29, 2010 at 19:48, Junio C Hamano <gitster@pobox.com> wrote=
:
> Elijah Newren <newren@gmail.com> writes:
>
>> Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>> @@ -175,8 +175,8 @@ test_expect_success 'init with init.templatedir =
set' '
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git config -f "$tes=
t_config" =C2=A0init.templatedir "${HOME}/templatedir-source" &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mkdir templatedir-s=
et &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd templatedir-set =
&&
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_CONFIG_NOGLOBA=
L &&
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_TEMPLATE_DIR &=
&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_CONFIG_NOGLOBA=
L;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_TEMPLATE_DIR;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NO_SET_GIT_TEMPLATE=
_DIR=3Dt &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export NO_SET_GIT_T=
EMPLATE_DIR &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git init
>> @@ -187,7 +187,7 @@ test_expect_success 'init with init.templatedir =
set' '
>> =C2=A0test_expect_success 'init --bare/--shared overrides system/glo=
bal config' '
>> =C2=A0 =C2=A0 =C2=A0 (
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_config=3D"$HOM=
E"/.gitconfig &&
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_CONFIG_NOGLOBA=
L &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_CONFIG_NOGLOBA=
L;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git config -f "$tes=
t_config" core.bare false &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git config -f "$tes=
t_config" core.sharedRepository 0640 &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mkdir init-bare-sha=
red-override &&
>> @@ -202,7 +202,7 @@ test_expect_success 'init --bare/--shared overri=
des system/global config' '
>> =C2=A0test_expect_success 'init honors global core.sharedRepository'=
 '
>> =C2=A0 =C2=A0 =C2=A0 (
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_config=3D"$HOM=
E"/.gitconfig &&
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_CONFIG_NOGLOBA=
L &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_CONFIG_NOGLOBA=
L;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git config -f "$tes=
t_config" core.sharedRepository 0666 &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mkdir shared-honor-=
global &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd shared-honor-glo=
bal &&
>
> These three hunks look wrong as they break the && cascades. =C2=A0All=
 others
> (including the change to 7502) look Ok.
>
> Personally I do not agree that ";" at the end is explicit enough as
> t/README seems to think. =C2=A0If we want to be explicit, I'd say we =
should do
> so by saying something like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unset VAR ;# can fail

Or, as previously suggested:

    test_might_fail unset VAR &&

Doesn't test_might_fail work for the unset build-in too?
