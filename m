Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A46C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 10:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiBVKa7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 05:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiBVKa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 05:30:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DCB15AF16
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645525827;
        bh=kzAUA81UfacFAxI8076nKvVCe2QJEOEKFr4oe670Fi8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VGmLK2BVvXD4fvKmvkow7r3e+YTCsSjepCBXjLAQ80vS3UPx3FRH64ukI737M15Db
         g02TtKABkR2ZSgQ5a4kVeeh/RVW9uLU/7p2vwYPVNNCUxGajDYmgyJGA83hTS/Hdyq
         VT+hBTrxAazUx+SfgQprTWjPwpPVx2SEAv715ftI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4Qwg-1oLP3l2Txu-011VjY; Tue, 22
 Feb 2022 11:30:27 +0100
Date:   Tue, 22 Feb 2022 11:30:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
In-Reply-To: <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet> <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2147411772-1645525827=:4418"
X-Provags-ID: V03:K1:0CcmjTErBhYY8JlcSHRxvu5bRYwP0vKAoKbCa2+xgq4KzDxUSNB
 Fi5mGA+vNaENQjP7IuZ70Z4Czo4RQ2nZc4bzl8DQOjUcaPBkb1B+pbJSk644/kbE9bqya2J
 r5DycX9MCn7+29McsBRnbervGx4QOqRQP0Aq4zXO88rk67zQOUrW8Bie7faJRgWIFbyI2RM
 VdpOGCJvsRiRSNhSXkbSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o2WfBhnYeMk=:5p9z1kLvoRkiT85j6E/TMq
 qbDVHbMly72GovzHEhWpvSvls1k+sh3PVM/RMstcQXuUMgK6Mlld40abJ57Eu7VRgXoBzIT+A
 AtZmn2wTfqZW50yIxA3SPx5PgV4CTgahUX6FekzwLPvjUMbLgtlDERfJv3R7XXlRtntYRffdC
 XE5Dw6wCgVMNsJHhSSzvGE/T+Yaa8haPvTqpD7yDpOO4izNhx+O3oraUQQZaN7Sl2uUsswU0O
 T+Ky5sCryWDe3lLYkVJrTP7d1J0Ld32YEs4j/C6NNRwZQmZJArzzbFEbVFqOKsf/4U1y/H5of
 2kih2oi30qVprwz8GMxhSUTcWgZG6+ZS6hwtiooEvh2gSoKjzcfmRPkMLkQe4BeDR7j6UeIM/
 ywWPKCtI86sK3ZjbGxkr7pLKJDsX2H2re8zKqMFv10VNfV9svYZbMlBh1Z3A0KRxfYJlNM4Fk
 GnfKp/FagQiL/TT/CXd1XgjKYCvJVBIWxgt87lgAShEPvfqVDOhYeXfp2LdJ+V2fAFBV4sZch
 0tItGl3jIuIWSR/M6vAUPPDrhUBBn015GMr0d8t/FQsJGdMEBT8kEXd80e7sHoC5MPVHPFdwJ
 XI3ZjlOtsVRBL6g3cve+XogtGjH9Qa+SW3ckf9TukxDwb34hUgvqonVz/SGOYYpQxqZ1rKtL5
 xR+wWIUL206Kg9ARhuRF0dGP2qwAq7euOHPS4pCWIpAyEfdWtVt+x8A/+PG8AoscJ5C1tOhQW
 2rcSkJlt093IjWoFCHEX58VWCWlhB08lYNUBM2fZ2uhjsh3zZleDZemS9YuXn3KtXPTUlrreg
 CvSKZkcLzAEa+TprHK/fL9D/T4NonMAFX4oTrSapMflbqyuBZi9T6EtWMqymOSnkUXG63tjI3
 KiasY2vsXWAE0d3XuwH9eyYhJalsu6gjasuZVA0+GQhXAJmW5gjC61G7Gowt5Jd84dHVXgCH6
 kMGVzF/lq1jT9sL5yD5cif1THEraSWXyIeV9UlW56mRoppHcqcSWPONiv4GWC95bYDajSxvsX
 gx7CVT64d1Lf+H3ChOLD4ZQXfhWbtjiTC3pnJOK7AlcHa+LVaxHg4PSTwVIZlA9COJdm8W6st
 4bu8hR/8RgPhYg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2147411772-1645525827=:4418
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Sun, 20 Feb 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Sun, Feb 20 2022, Johannes Schindelin wrote:
>
> > I notice that you did not take this into `seen` yet. I find that a lit=
tle
> > sad because it would potentially have helped others to figure out the
> > failure in the latest `seen`:
> > https://github.com/git/git/runs/5255378056?check_suite_focus=3Dtrue#st=
ep:5:162
> >
> > Essentially, a recent patch introduces hard-coded SHA-1 hashes in t300=
7.3.
>
> I left some feedback on your submission ~3 weeks ago that you haven't
> responded to:
> https://lore.kernel.org/git/220127.86ilu5cdnf.gmgdl@evledraar.gmail.com/

You answered my goal of making it easier to figure out regressions by
doubling down on hiding the logs even better. That's not feedback, that's
just ignoring the goal.

You answered my refactor of the Azure Pipelines support with the question
"why?" that I had answered already a long time ago. That's not feedback,
that's ignoring the answers I already provided.

I don't know how to respond to that, therefore I didn't.

Ciao,
Johannes

--8323328-2147411772-1645525827=:4418--
