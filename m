Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D0AC47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 22:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981E161242
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 22:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhFBWSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 18:18:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:59683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229724AbhFBWSY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 18:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622672191;
        bh=RV9LX5pP8GDCHS1xlEj6SYOSqdarI+zhtQSTIkGETbU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=McSKiR/SABD4/gnTlcj66PFpqCc7ihNDBO95MPalGo/6h6iEDccqNFevHNfgD0kKG
         Apy+wCA8mCJ9dZXZxyPnKw6DO5j2IF3SALiu9Xm7z5IqCCzExraD6UBxLyWJ4Fun3h
         HbW2zq2cvCWqTK8BVkB9H4nVOeUH8vx/ypnLytRg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.8.58] ([89.1.215.222]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUqF-1lfXGa1Dzz-00D0RV; Thu, 03
 Jun 2021 00:16:31 +0200
Date:   Thu, 3 Jun 2021 00:16:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Somogyi Henrik <Somogyi.Henrik@eqnet.hu>, git@vger.kernel.org
Subject: Re: getting git.exe for Android Studio on Windows
In-Reply-To: <YLdhGa8eWs9uyh4A@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2106030012000.55@tvgsbejvaqbjf.bet>
References: <773cf7ee-f897-a568-92be-9ee7c2813c3b@eqnet.hu> <YKcI8BGHBgkanYPk@camp.crustytoothpaste.net> <80336a2e-fb75-5fc1-1516-f1d1d96ff529@eqnet.hu> <ba109d68-9953-569f-56a7-a2f557bf971f@eqnet.hu> <YLdhGa8eWs9uyh4A@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UIu/X6ha7ewiGv7muK947Tm879NTU7PTG5DkZTvRJii2Uig4q98
 2hL1FvypnRpMRPCjyQYVCxQ45z6rbkf7gII4cIvMkE8+Rt6sEg+XfcE8HHobpd4INNvvflF
 B4BW7o9McvGl0WzjUZ+DtSAUi5ARyv83VfLhSYrI5TW4mMwjdprvZAVJop0wrOASRmwb/6w
 jytgM7Es+AiLBHsr6mUDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pjrgRgn3gFE=:iUiuagSP/220anuHmPyIIi
 PGWqHR21XV2Bz6Aus3QnCX3EvO+Ggv3we+qQ9keD4vNXfmZMo139Mw7zwOWmedXpsubY82FTn
 AR6rTSmPkSHgKBELOpamPDBduB8Esxv0P4QPFbJg54/i73yGyZ3Fkix/Y4ZE51gzLe2gDc8L8
 VR6irEkpYI8hvKHrK718rQukNrj7yqkYuk1z3BEGEux/BKFvkJUFBJpYgbuUlsy/A62O2PKxw
 49SliXCMtIADRm28afPI19LxZ2oKJj3UMshE3S/I5UEd5I4zB3ZyPc+n5i+QZvFu5eiL+iTeZ
 pFaHp3Y5gJAOoX0iVppL8VJ0OKdrtrN2zG2RcDdG599jBo4Hs0P6G4pQc9xBUaZKl9Mt5TlR9
 2riRT7HTUaroOV10rY15tqWEVZi7M84fSPw60I5pOf+v5QhJly8aHdbjRqEjURd/ygHnRC73+
 1XHN5t8uVAqqUtOLSQ2nO8bucUdL0hyWVp7mJirh5uX1sSHElGz6kH6x9cMrCy6noHgPfwriY
 YFCbnmfe+A27pjrx28T17UV8EbDQ30XbSh+QI5/yeLRytL4PJJliqXyqkze7i5TDqF1a1E7XE
 rvYOVyOL2PDRQox6qTqLjhK1VG118C85tREt0DmJaEVJg+0co1CH68fUukhPuCdpTaZqNTQmr
 p2O9xWOaAMF6J31Y0q3ettOxFvmdE7djII48oUe9xVyrhuRJIUNP3WX1YLhDCZaT6fYdkGI9Y
 ICjOK9CCOWD6HLTPqqAkw5Hxtg1uYaa+0RrXqJaNcFeu15HlMrET8RqA4rh2PYnPyeoEIerlj
 4BcTGJXeqov6uTG3vJFYS/PhkM0Lcms1xQ1iIlJWMfB6zXwxVDUIAhKzg2ivc6Hrownc1ZfVL
 LpfVjcBZLxuj9imcVnjtBplaRQoSyDmueSb4QiG+An2Na9tl4gV/+/n5tgOYBr0gNHjxJkvOR
 K0z8pxA59uUAGSO2e1dko5UOcH4o1FfHQln26wYTDpL29zK70L10OqC/9dT3c9DvNhIkTcN9v
 Knc5fmczvh0eoHByzbuAheucVftUHaORgs9nFJnmA6OpvaYcY/NN7dx/mX+q2NS07muD4F0j0
 +8Qw1EYZGb260BRvfDkp+wenxWyGLon9/bi07eYK34TqTtQqJRufnHdMg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 2 Jun 2021, brian m. carlson wrote:

> On 2021-06-02 at 05:53:55, Somogyi Henrik wrote:
>
> Please keep the list in CC so that everyone can see the discussion.  I'm
> not that familiar with Windows and may be offline for a few days soon,
> so if you CC the list you may find someone who is better able to answer
> your questions.
>
> > I have installed "Git for Windows v2.31.1".
> >
> > I only need the git.exe so that Android Studio can use it for dowloadi=
ng a
> > sample Android app from GitHub.
> >
> > But now I got 4 git.exe programs:
> >
> > F:\programs\Git
> > 	\bin\git.exe
> > 	\cmd\git.exe
> > 	\mingw64\bin\git.exe
> > 	\mingw64\libexec\git-core\git.exe
> >
> > Which should I specify in Android Studio as the needed git.exe?
>
> I believe you can go to a command prompt and type "where git" and that
> should print the proper location.  If you've installed the portable
> version, I believe the one in the top-level bin directory is correct.

The one that is guaranteed to work is the one added to the `PATH` when you
choose to add Git to the `PATH` via the Git for Windows installer, which
currently would be `C:\Program Files\cmd\git.exe`.

For backwards-compatibility, I reintroduced `C:\Program
Files\bin\git.exe`.

Do note that both of those are simply redirectors. The actual binaries are
in `\mingw64\bin\` (and the keen eye will not have missed that
`libexec\git-core` contains a mere hardlinked version of the `bin` one),
but there are too many binaries there, therefore it is not recommended to
add those to the `PATH`.

If in doubt, stick with what the Git for Windows installer recommends. I
do put in an effort trying to choose sensible defaults that work for the
vast majority of users.

Ciao,
Johannes
