Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B37C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 12:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbhKWMdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 07:33:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:42127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234692AbhKWMdi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 07:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637670611;
        bh=kagD8SV9ez1wkSjbTqpPc2U4OrFHohOoJISgA4+13SU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Z2QpcUKKBQclohJwEbCS/kz7ZzU9fnuYXIA9NSXmhYjKEywNwbAiaosXO+nTfJ0nN
         ge30ATNVGRAleF77YDDHChbo1y0QAMraWbXW2q5pEuW9QZrYCDDrjT2+hoouvdQxaG
         QE1wT88eyVnH/I0CuOaIdjNDIJk/hxOn61fYHlFs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89L1-1mluAC2LaN-005Kja; Tue, 23
 Nov 2021 13:30:11 +0100
Date:   Tue, 23 Nov 2021 13:30:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
cc:     Aleen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Aleen <aleen42@vip.qq.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v10 1/2] doc: git-format-patch: describe the option
 --always
In-Reply-To: <683ecd80.13.17d4a65cf94.Coremail.pwxu@coremail.cn>
Message-ID: <nycvar.QRO.7.76.6.2111231330000.63@tvgsbejvaqbjf.bet>
References: <pull.1076.v9.git.1637564554.gitgitgadget@gmail.com> <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com> <59bce7131dab858e8c87944ccb02eae8ba5fd459.1637567471.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2111221258440.63@tvgsbejvaqbjf.bet>
 <683ecd80.13.17d4a65cf94.Coremail.pwxu@coremail.cn>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2018748421-1637670611=:63"
X-Provags-ID: V03:K1:pS51I2/vpKitEkGFL91VpP6up3MRv0QbgGhtCljDMb0REujttlQ
 b1r5a5oRio2F3bcbbDs7nDSbE7CqAYWlIc/0cJFljrQLkncpLa3L2oQ+fsqy2f3NUkwguN+
 wO/o6mGE6ci1mvDKl+UaimtW8PPv2Os8IwL9qywqbZ93uyiUkSmRjl4oxPUHHKXYFbX+e3I
 0Z9Wm/bS2FV/yW+4z4Nbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JTkgxLVTNAw=:93QpoQfG+ZNLxQ5qKhuAVu
 JpEuwd/n4Ix0Ov11zqqKJs2K+2AJZn6DfU8TKQKHBH5GclRaldTn+oABJ+XDRJa9uGp4/txXj
 wAf6dVxxQZntZcgptA8aVwyftCx/gleu7I7qQHgaXOmWndLc1wkBA526+lnxZLYIpWpKwdkqa
 rBgVpUGe5shcgBRt4GocCIFr86jP9QQPv3Y8lUFF9dJhXaDntwgEaS7LMbLeIjaSmkijl2b2T
 b1wqX5DQ5RBVfkw/jzLoPA0MN6F+zb0j6uR6xnAXGJU5lCMAfX5gfA2N47kSFM6a5Z55QKzoE
 Ak6j/v3qr2zLVocjDbOu9CBIdt1tHsbj81YC0/sYOjwqQc5hs1W0BC3Fzknf/Iwrr5RhqeRNS
 KCIGWC8jp3rFP0PmzOUFCUnOpRWDoufmpaeNpr6jULtobMnD83jN3dGFzaU0cBq8SaBPQ5mu/
 COPVRgUUuvQfyJ0HLrkXxhpCeTZGU1+O6CdtlE/EuyPPeJXGzBT/05rD1cclatVpA4QeKb1T4
 m+XhOM9qZOBegghuFwvYSDVNbxU6Q08XnQetYnQFaYHNy86nkY5KLvNyGPmalUtXWIyMP6Tw9
 apkSNRwjWRd2PUSJrcE2NgWxWYlGqGtZQvv1XsxzYpRAVnAI2mCVhIRz1xS1VQgNYn8L4TtB1
 OhC2UioMEzzSoDv6w9N9dWOcDAoc8NiSi8V6AdZJv1ufxOTlLBkmr0J+rnpkLcBFwTCHT2GDJ
 NeBlyfGcGVPgs5sdFbdaLM/JLQG9eViZ1Yf7E1LJveim9HAYjbYxbPxX+P751yEZxoGp0rvpa
 wyS88yPK5YhYwUj5OYj8dkHKXd2FzjvVB7y1TZnGvZBH+iwwpA3Zd0aLEnvYVp0tgYqTEfs7Q
 K+713RPDETqEQskImhv63U14sE84SGr9ht6dcS21Ti9CzQ9DXpiCExIQ6/bATuqZX5SWqg3/H
 vLAQUv7Rg+bunJl1nU2Kdem2BTZF3UoVUWuayKd8zQUmesOq2ZcfPfnmx+Qsrv+f2H1yARc+k
 e+AJCShBYzD9ztApN7HBXIp91ioSEnx+Y3xVRBUbEXS32WiOk2aEUTht49YrXkviBwRoWXtVm
 0+eF2tTYg+/pmw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2018748421-1637670611=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Aleen,

On Tue, 23 Nov 2021, Aleen =E5=BE=90=E6=B2=9B=E6=96=87 wrote:

> > Hi Aleen,
> >
> > On Mon, 22 Nov 2021, Aleen via GitGitGadget wrote:
> >
> > > From: Aleen <aleen42@vip.qq.com>
> >
> > FWIW this information comes from your commit, specifically from the
> > author information recorded when you committed first. To re-set it in
> > these two patches, run something like this:
> >
> > 	git config --global user.name "=E5=BE=90=E6=B2=9B=E6=96=87 (Aleen)"
> > 	git rebase -x "git commit --amend --no-edit --reset-author" HEAD~2
> >
> > and then force-push to your branch.
> >
> > Ciao,
> > Dscho
>
> The main problem is that it broke when I tried to submit via GGG:
> https://github.com/gitgitgadget/git/pull/1076#issuecomment-976087421

Whoops. It seems that the `From:` header cannot be parsed by GitGitGadget.
Most likely because the `<` and `>` of the email address are on the next
line, not the same line as the `From:`.

I had a quick look and opened
https://github.com/gitgitgadget/gitgitgadget/pull/777 to fix this.

Ciao,
Dscho

--8323328-2018748421-1637670611=:63--
