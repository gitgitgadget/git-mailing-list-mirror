Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999EFC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 21:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbhKVWCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:02:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:59889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232667AbhKVWCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637618341;
        bh=W6V6GhUB+g0LsmsL0RNpd3To+hVjFP7XbYDNhkcgWOw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Tyv4NKfCgWv/KymsJzvret7BidCtW2G36mfBveG0sZJ7Hdrnc0isNjD+Jybk18pfN
         yJzyf8uHa7T1vvvMIlfWIouvNP5hS2ak0U5EHoRVRsTtgq7kpVVeywtrTBKqIRGoiB
         lMnFLMn/yYw05/rrmJeUK0keJWLQ6qdC63nrUi4A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1mJXU10dGu-00nhvR; Mon, 22
 Nov 2021 22:59:01 +0100
Date:   Mon, 22 Nov 2021 22:58:59 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup??? Merge branch 'ab/ci-updates' into seen
In-Reply-To: <211122.86ee78yxts.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111222257430.63@tvgsbejvaqbjf.bet>
References: <pull.1081.git.1637578930464.gitgitgadget@gmail.com> <211122.86ee78yxts.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-356719844-1637618341=:63"
X-Provags-ID: V03:K1:BkR/TjY8Rn/U4CKJq3NU5aUc0mve/duI6evpuwmeLNzE0JvRotS
 d/aSYj9A9iE3WhOfEquMDw4YFCnzLTmybkBqTyELfJMUCqSOYgNp+XP2td9FYKX7UrpnIpz
 11hRu6+pPLqhjRWm9sXLRcy/YbUrCvsJsDGx62evRw2OVV5EUHJEpLTFotPjOvxNe9JVAKl
 18rKteqCO7LyQ6B9pIXOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6iGY9d60yT4=:TDQ5NQLpdwL7Okmzq9bOlj
 pLV0bN5mJAACVo49el7a4p0pvFCbmTJx1B4W/Y/kB7yUnJN2L/wj38YxaYwj74ixIIN1OGjpP
 OlmAhf1tBLPpQWs96L4jzY5atmav1qKlz03Savi74bfJwwnoF3Qbk2S+QM34d+JulobUGhTz2
 lUIMUTyI5AU2+OizcjCWd2C0VZ+XUFl4P7v8j3/jHx+vMAwJYjapwhCH7wUoOlb4tiCVEZPxa
 k/7zSSCSvpf9fP+TxLifR+s7G5A64Nrz/3UEyRMDVZLLxu1sO9LK9gcnqCpWetC7KjbiN30xb
 97JTBg7PtxEtpu77SlfHxfESrP3CucTS3Hz+EX6/4McQXGI0yMnCN/TYZNyopZAE4UNY0Jiuf
 IY2iK8G8LVXHOgt+cY0dNm5RrJD3Du0YkuCGRhcjAr8KlDXv7rx0tQtjoY4cy0qEiQfsisQrK
 FYi/P9+gQJV5RLLyJenOlkfzBApJjz+mhBDEi+PJqxTc0qlr2BO9OtVvXg/m/vHKcl82quMgB
 x/J6yw+nUFp5lg2HjpsBJIAqmpnSZ59BDogRSI/pO6gXplSOeoK+S+pMdw+S/eF8rVtg8ZF+x
 1IIAT3Shfxmb9lcLf3QfGslmGtwO/pp6ABpFS9tfkARDCmnmg67r3pvIzD4jeI3eCEX7rnh0x
 +f45MBJffxo9Jlx7KEQWuqITHbUj4YsPn5eQa+aHYy9PLUWwUBkFmN5i/RkREsPgYttcdBAik
 L/QWt7LxAUw8BN/uM07XitMaq3coXK6mLi6mZu+Q+GISpXi4sFuO+4V1l/U4LCrD604nyckTb
 gQCoq3lA4DtRemKlHgS1v6uujNuss1QN2BxCfzD30EAOrPHgATi/cfreFPt0mhaMCBU6EBsal
 hQF7nvJBwx5gNk6BhktKEhA8UASd+ZddqHg0bSFdUMSoYnIceyIdpqK3g412MIutk9APCjyLN
 iRa/28f0jRkxVZv05f/hN11YO/XRAiridLUouLnT6d/BExbPBg/oFkj8mYXGJeGKp/CsbaepV
 y6eT+zjnRuz4zUEWE24ypPRjP/c3XHTKz+O7IMA7PEODsTeF22ajHtIGE1+keORhZz1AyaEDF
 v4/wUEjhFX8Fcc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-356719844-1637618341=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 22 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Nov 22 2021, Johannes Schindelin via GitGitGadget wrote:
>
> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> > index c0bae709b3b..c508c18ad44 100755
> > --- a/ci/run-build-and-tests.sh
> > +++ b/ci/run-build-and-tests.sh
> > @@ -45,9 +45,8 @@ linux-gcc-4.8)
> >  	export MAKE_TARGETS=3Dall
> >  	;;
> >  esac
> > -make -C contrib/scalar test
> > -
> >  make $MAKE_TARGETS
> > +make -C contrib/scalar test
> >
> >  check_unignored_build_artifacts
>
> The CI breakage was introduced with the merger with ab/ci-updates, but
> the combination of the two just reveals an existing breakage in
> js/scalar.

Which shows that I was wrong to pander to your repeated demand to include
Scalar in the CI builds already at this early stage.

Will fix,
Dscho

--8323328-356719844-1637618341=:63--
