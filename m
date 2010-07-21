From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git name-rev for fun and profit (Re: [PATCH] t/: work around 
	one-shot variable assignment with test_must_fail)
Date: Wed, 21 Jul 2010 11:32:49 +0000
Message-ID: <AANLkTil38MCB--6J0jOPk_0aVTPLWNM-PA318zHZu8xx@mail.gmail.com>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil>
	<iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil>
	<AANLkTilzC8iMikfBieS_pcChP7_F4hA6bT1ydWHD4etP@mail.gmail.com>
	<20100721000101.GB4282@burratino>
	<AANLkTik0gKFfDCmcLZnn4WFCFY3Lb5zRgrzKLAgD5qH6@mail.gmail.com>
	<20100721001402.GE4282@burratino>
	<AANLkTil8gyaOcjHGm0tLTdYDdTT4VckUr9nELNiBlKNa@mail.gmail.com>
	<20100721010539.GF4282@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	erick.mattos@gmail.com, jaredhance@gmail.com, drafnel@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 13:32:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObXXm-0003xL-TM
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 13:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277Ab0GULcx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 07:32:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63814 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680Ab0GULcw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 07:32:52 -0400
Received: by fxm14 with SMTP id 14so3429347fxm.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 04:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=R8H+opiAEtHwulPc9uKW9QB7NMoGdvxO6MyLNLCq/oc=;
        b=S7j3CA64/8mHCeQQQQCrfenisEiN42+pRWYxfPm/rwuEgSdohDhbciBFbbJYJ86tkd
         RqjD229Obj6wZtebeZSBFaUpAKNZ+cSzr6Pah6pRVdeNMrlvQthmh5UwXzwbt+WPoVg1
         gHMzlDkJ0Dy6tf0O4AFl2l1geKzNK5++7En2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q2BFuiPxxP7zI7oJHJMS5mMLgAVMnCFkehFyxTzVxQZ9IbUb9HvvykjAsGQtsQF6n6
         C1+MS7Qbbhq5CV+KeChjTqD4161uB/piuGmECdfqWZtaPdkM/F/GyEYZDFJjQllXiOuq
         Ib4Kz9DMbx3pLxKxy31bM/XRp51qb7OEYFYzE=
Received: by 10.223.119.210 with SMTP id a18mr11758far.52.1279711970944; Wed, 
	21 Jul 2010 04:32:50 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Wed, 21 Jul 2010 04:32:49 -0700 (PDT)
In-Reply-To: <20100721010539.GF4282@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151393>

On Wed, Jul 21, 2010 at 01:05, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> As an aside, how do you make these 61-commits-after-rc0 commit ids. =
Is
>> there a sha1->that tool that I haven't spotted?
>
> =C2=A0GIT_PAGER_IN_USE=3D1 git log --all-match --grep=3Dshell --grep=3D=
export |
> =C2=A0git -p name-rev --tags --stdin
>
> v1.5.6-rc0~61 is 61 commits before rc0 (well, the 61st-generation
> grandparent using the first parent where there is a choice). =C2=A0Th=
e
> distinction matters because =E2=80=9C61 commits _after_ 1.5.6-rc0=E2=80=
=9D is not
> well-defined.

Thanks, added that as an alias in my .gitconfig:

        abbrev-commit =3D "!f() { git name-rev --tags \"$@\" | sed
's|.*tags/||;s|\\([0-9a-f]\\{7\\}\\).*|\\1|'; }; f"

> If you want the latter sort of description anyway, =E2=80=98git descr=
ibe=E2=80=99
> might help.

git describe was actually more like what I wanted. I'd used it before,
but forgotten it. Thanks.
