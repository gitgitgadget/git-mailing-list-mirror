Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C121F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 09:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbfJDJdy (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 05:33:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:43463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387406AbfJDJdx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 05:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570181632;
        bh=mQXFmFDBgU+YRj3ALcgYEr94X/Co04ycRTE6+nyjIl0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RtwhwaDMCeMkv6+g5tJEc9IFvEWyZ94yAyN+u6baV6M3wTBW70oC1w0AZNgmcT5wo
         gLNw9tdTdXWjN6P2h9SDo7NY6wDntd0FsxARQ9TY6w6psXBzV8LBH7mw/0UjVH+e02
         3OxKubdEclp8w5kp8dpABqFy7TNQ6B9QnVTzcSD8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.189]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCKBc-1iObgz3z9O-009TvJ; Fri, 04
 Oct 2019 11:33:52 +0200
Date:   Fri, 4 Oct 2019 11:33:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alexander Mills <alexander.d.mills@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: bad error message - Not a git repository (or any of the parent
 directories): .git
In-Reply-To: <CA+KyZp6MKqL0mz-iCHGEcvZi09P+GmS7QEogX10-2OJ5nMPDRA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910041125490.46@tvgsbejvaqbjf.bet>
References: <CA+KyZp6MKqL0mz-iCHGEcvZi09P+GmS7QEogX10-2OJ5nMPDRA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:x5dvQopwiOvJVvzQcaiI0yGyXxXr/3QPZvQwPTEaCR7u2CwRrnI
 TRNrPvIfhYGD60kP1KK0id3T5DYoMlZOKB1L7DD71pwzdZtEqHEJMPe09sOWV6PAa5iwRHY
 o3Pl54ES1pz7CDkUhjKxc8695WMVTqMNUns+BKO1uNGXSojeAEvs0Vi01Q2V6ZJJM9Y/RZn
 B3GvDXxOBw/uAHcWgxraw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C0QVccv4yZo=:5Et1tVZ/F4jt/GcvNqTjNt
 JWT/n1KUP7NVVUl42m84A+foocVh4Ofdf5kKpj3JZUhjB1wQQ6Ny62nYVlfjm8pNl/K2nZ1QK
 tNb2W4dDu69rWQ736aFB8opl9jxRoo3zo6+5JlXskY0gcQ/zcKE2ZpYS6YpSWSEazeRiaa3oG
 FPM35AGo8s71msM9nd528BZn0/qONmT8d0neNqogGT74haBv9gatTNGEqmBItSnHoC6yHvkQi
 MPNZI88t3za+nghiaRvX/Bmk0O2JM4jmpo6Hha7Agv7/u3wkHLpJv8pdfZwGHamwOogbCnd3D
 dDGpqK0qFkp0PHnMBfG2q7wOmLga7F9753PW439bRGnGd4d8F/AFcI458BBP9frqk2q2WgurI
 U5Q4tAWBQQaZPSrY3lLmoEQDo5As+a9fDbFF4bmtg25Uv3J5by8gtm86L4YiYZEO4Wp3TcUUu
 IqHLVCvqA+NBFcXMLVZoqZawZLsi0x85fbz2x8SAL0dlR0AY8JbnXTnB2H5DlTgTFioQuOGbr
 d1hCFOlpJPRtemoOXeVC9yC3sAQb0xK7jkhbhjbfl1aCV/YVW4wqJ9OpX+xoVNgiB27FurZxD
 37KTH1zR451yodJkdyx3pf7HdpkIFiEOVTLBrE/UOwHgmMa95aQyZBEpsCGDqTo4SyvEQpkBg
 RmrhIkQPNAA0wx9TJa0DMvs3vRFJ14mJiNJuU3qFuPmGuHCmmFE+GIzfRaYJvG8RZTHVjSX3i
 Pk+MNGHmEuimPbT4qr2tT7v6hpnJgXMbvdpXmO2mKf7BFFBzH3VDN0kFwoZ7ZqB2lVu54SrG6
 6M2nprppe3TI7Qygi0VWgvkw5TMwagSiz3PUDQW6Z2tQnDkpJvYWAnvqHapu7ItEMNEDSwfMy
 IZ1w5z7uDL3aRuafVp/gluChRHQCWTvw8/SO1y6YQ1pIKFKi+p0WtimayDa1hNNxScuQm87id
 DXXDRdss3DYVd0DKtUh1KaQRZ0x96Bfypp5ksUz0jSQUdf/pwPbTZKVET1PQqvld39J+uTCaL
 c9TpN9qttXWSxZTCNhBST2gk2PdHnP2wJCKJgpl0lMhGD0XB1jb/qUKRDvqwMoPrsvlpPzbZ9
 LN7eWegV0d65d5uiV2w6K5u3hvBavvPisbGhyywzwkU6Tm/5PLycvEIbQua17zsxnQ554mWvF
 vGre0liQ8vG2g+jxT2GtFFPMXNijb64T2LD+3n00rWZMH5gLYzNLLBo/8Int20xdvfd3EAr6u
 Zcm4IWrnxfZCvKs/8uJJnsBgdfyDh54/aEdXUgTylnhdBenSgKA147nB4Jxw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexander,

On Thu, 3 Oct 2019, Alexander Mills wrote:

> when running git commands outside of a git repo, we often see:
>
> fatal: Not a git repository (or any of the parent directories): .git
>
> such a lame message lol.

An equally ornery response might point out that reporting this as a bug
instead of providing a patch is probably just as "lame"... :-)

> can we get an absolute path on this message in future git versions, eg:
>
> Not a git repository (or any of the parent directories): /home/ubuntu/xy=
z/.git

Just clone https://github.com/git/git, then look for that error message:

=2D- snip --
$ git grep -A1 "or any of the parent" \*.[ch]
setup.c:                        die(_("not a git repository (or any of the=
 parent directories): %s"),
setup.c-                            DEFAULT_GIT_DIR_ENVIRONMENT);
=2D- snap --

You can then wrap the argument in that second line in `absolute_path()`,
build (using `make -j$(nproc)` on Linux), and test (use
`/path/to/git/bin-wrappers/git` instead of regular `git` to test without
installing). Once everything works as you expect it, commit it.

Please make sure that your commit message focuses on answering the
question "why?" more than on "how?", and that it wraps at <=3D 76 columns
per line. Also do make sure to add your sign off
(https://git-scm.com/docs/SubmittingPatches#sign-off).

Finally send the patch to the mailing list for review. You can use
GitGitGadget (https://gitgitgadget.github.io), submitGit
(https://submitgit.herokuapp.com) or send it manually
(https://github.com/git-for-windows/git/blob/master/CONTRIBUTING.md#submit=
-your-patch).

Ciao,
Johannes

> ty
>
> -alex
>
> --
> Alexander D. Mills
> New cell phone # (415)730-1805
> alexander.d.mills@gmail.com
>
> www.linkedin.com/pub/alexander-mills/b/7a5/418/
>
