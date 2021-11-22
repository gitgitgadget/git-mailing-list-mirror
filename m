Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1A8C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 11:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbhKVMAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:00:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:40773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhKVMAv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 07:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637582252;
        bh=rDErKP/xHyq2zVts2HBnjBrOD7hhG8mKk0DkVw0eJMk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eQO/x9OU9kcNZxZiVfMD6iZwGOALSEid01N3YJAF6/EzZL95WPo6RGlccsANaGlEG
         jjVGcd0NB47Eot/vR4DQBuojWTs3aNPL0/tY/WkvW4SQyq5C1V+wm/6pcBc5RdyhdZ
         Qw8/QXTPD79k6UnMp5xNPsREvvi4TLIPlA2wuIdY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9X9-1mxgWT1RBJ-0099ZY; Mon, 22
 Nov 2021 12:57:32 +0100
Date:   Mon, 22 Nov 2021 12:57:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v6 0/3] am: support --empty=(die|drop|keep) option to
 handle empty patches
In-Reply-To: <xmqqr1bcqe6p.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111221256040.63@tvgsbejvaqbjf.bet>
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>        <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>        <xmqqilwpuiv4.fsf@gitster.g>        <b9c1244.36.17d35decb26.Coremail.pwxu@coremail.cn>        <xmqqmtm0snol.fsf@gitster.g>  
      <2ebb863f.246.17d37140518.Coremail.pwxu@coremail.cn> <xmqqr1bcqe6p.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-100164848-1637582252=:63"
X-Provags-ID: V03:K1:qfqbW84USDP/AuV9H8+jJThpA1t5sZdLWAvBfkUhqfdWS10/WNS
 vNne87Htp5RvV1yKe23Aqk3P4Odkb75ppj1lGpnXw4lYvcKKGe4W2WWeALv8odtAZpD8w5W
 eggtHL2uYyoPxQaMNEH1Y2xq5lgYGoD4WRRmzrU1GT5pIDGsGBnNjTjC6B4t6VAvF2OKidn
 xyoRsnH77nDZTZJHvDaSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1e4aolmop3M=:XZ2aMJWrEg8rtDldy2sB1/
 1BgLLeHXRRFZKNHaoUApABlSvA5fGebq1HYQ/w3v8uyMdVzp9dtpSO6pQyMEJgcm/RawS1eUd
 BhuXrPfbEBfTvDZ6nVwP/LHGZVqHmIA9b0klqRSIDgZIhhJKzFejfc4sAVAH4aNvtEP4WzNOy
 RKoMT8joasbp2f4DtOvcCGudwgF97UKKgpHcRmJ5e3+XvYVJnoEECzTykxZGdnRYly+D6+vbj
 zsoclGcT0K5Wh65H6DbrPH54hJ/QCn31bUMrSgotTuUI9FcZVtUSuXIj9JVA8ROOhQl2FaYWt
 Qh8TOWY0PaVniRmxI1sPtM0Q+vgiTj0heom3ZjyvrGCF2Ct4RTkGipweRAkiYK/RiyMFyZI8g
 wm0/cGCFNSMnyebYQkVklaRofDmca7R4c7b0ZpYntmLqC9GQB3HPfiDfX7E1nF+85TaRrkwmy
 IgxvvbxfM4YWfJ6Ss2tYJa2a5HyjwVxHUcZAZDIgE0iC5Zk8XpBTC4Xvb7BiekyrZR0gKnU1b
 2JRksSjkTRVKWJoVFzw/f+z0eS5GaWyRcZI1HxwoTQxYmjMb0uzDeEoZCmASbPyuDl1IB7Bv5
 LiXRPAtdQIzTDE4SbAf0lKnvdcMw487U360cckZf16R/EFEqU9TlqZHNzvGa0Hwph2Tkg54WO
 Fo70fNykRwB+LDcZ1mampocmPOkvABZhZQ/vclNP4fvh0fNtLFC+6pt/o1IkBv1amfVt3W9Rz
 VMru4UGgEJ5F3ObPV8lXiSkCgy/WnAJUmF2dchMD1XS8vAQtTengDvSuZdGj16zS0wQmc94wG
 RcMLU9yxNC6H72aMVs5J1Pz24AYyaziuk/zX0e7/g3yotqvNMqmsYoo7dc/ZTA81lj2Ksy/i8
 K7zFU5DzB4XokdLHn86a35zHWIjh8K3vmMIoznoAzVd14WZlOvmdka69ZVvfTql+6JWeAmjlN
 lPsFiuiWH2Zk5l+F5ZZolI52Nz1n8kgOm1jrFx2DfEkfLZKZEx+Hqyu65cHd/r4YzafwXppyr
 ObzTfi1Rjwse9tayChmGIevpOfBiaAmoMTJCnric40tGsJeXEGBkxdszDJbn84nO06+ir2Q6q
 DQriNKEvJLeqVA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-100164848-1637582252=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio & Aleen,

On Fri, 19 Nov 2021, Junio C Hamano wrote:

> Aleen =E5=BE=90=E6=B2=9B=E6=96=87 <pwxu@coremail.cn> writes:
>
> >> Yes.
> >>
> >> As the URL you were referred to explains, the sign-off procedure is
> >> to keep track of provenance of the code, which is a more "legal"
> >> formal requirement than just "I use this pseudonym everywhere".
> >> When a big company comes to us, claiming that "this code is our
> >> intellectual property stolen from us" and pointing at code added by
> >> a patch from you, we do not want to see us in the position to have
> >> to say "eh, somebody who uses psuedonym X signed DCO, but we do not
> >> even know their real name".
> >
> > I know it, and as I said before that gitgitgadget need PR creators to
> > sign off user name of GitHub account, according to the DCO check. I ca=
n
> > confirmed that "Aleen" and "Aleen =E5=BE=90=E6=B2=9B=E6=96=87" are bot=
h the real name of mine,
> > the committer. I can use the account aleen42@vip.qq.com to confirm thi=
s.
>
> Can somebody from GGG land help this user?  I _think_ the easiest
> workaround (other than not using GGG and sending e-mail in the old
> fashioned way) is to commit and sign-off under the real name, and
> push under whatever GitHub username to throw a GGG pull request,
> which GGG should be able to take, as I have seen users forward other
> authors commits just fine.

GitGitGadget looks at the author information, so you need to ensure that
the "Author:" line in the output of `git log` shows the desired name. If
it does not, you need to configure `user.name` (and user.email)` as
desired, and then re-commit with `git commit --amend --reset-author`, then
force-push.

Ciao,
Johannes

--8323328-100164848-1637582252=:63--
