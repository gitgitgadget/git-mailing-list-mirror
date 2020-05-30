Return-Path: <SRS0=yrqn=7N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEADC433DF
	for <git@archiver.kernel.org>; Sun, 31 May 2020 21:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DACA206DA
	for <git@archiver.kernel.org>; Sun, 31 May 2020 21:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SZfuFHel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgEaVVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 May 2020 17:21:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:40273 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbgEaVVY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 May 2020 17:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590960078;
        bh=bnB3yas0ZQL8imzw/S9awXBMg/a9OOPkTqhY7rbDvr0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SZfuFHel5xsgydM0Esy1yRCvNtyVZjUTvYszE4MPw14cvaRq61qG5rZEWjTr/lPzA
         FE5Ky/YRCyPKAVvCwiV7BqChp6hOa6cL6vOo4Q5hndxIxxkdC/lZbvvuL5FfnUEBnc
         s2LILSd50USf5PV3fq0EnWBfNKUsFhEu+uTaTxpw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([213.196.213.84]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1jEipU1zBG-00joaS; Sun, 31
 May 2020 23:21:18 +0200
Date:   Sat, 30 May 2020 10:03:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org
Subject: Re: symbolic links in Git for Windows v2.27.0, was Re: [ANNOUNCE]
 Git for Windows 2.27.0-rc2
In-Reply-To: <20200530164932.GK1915090@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2005301002180.56@tvgsbejvaqbjf.bet>
References: <20200526204539.6181-1-johannes.schindelin@gmx.de> <nycvar.QRO.7.76.6.2005282322580.56@tvgsbejvaqbjf.bet> <20200529223200.GJ1915090@camp.crustytoothpaste.net> <nycvar.QRO.7.76.6.2005291539080.56@tvgsbejvaqbjf.bet>
 <20200530164932.GK1915090@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:shkxxUo5CuJ+YqktUpmJ2COpL+op4bMqG6BEPXTzValhcdKxIMr
 qDM6eXUomlYK4xFqjhmhXOjdPOrzCkEuis22efTY1R+BjB/tiPKjo/5MNN44/BproGlovlr
 SuuAEnBgxVPM9PRbNT4Ke1QnPZoCj+vRIHs36/V3hjVRbbMhhgDUIV25jGOkaMjfplnmHwz
 UFa+zYhvjcqh9jeIZT2Ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IsGkThb3XR8=:uqy7moFAs7txfEOS3YPVsj
 for5lcQLxbXjEB1tsP369JLNKB9mcPagLu23K1dcU4GUBtvcaro5X3mbkAbuOcKHX4wyrGjCX
 Wui0FGYi96+Z6AnHb0aK6txCp6NOUV7PhtC4+bhiZdnZRqm1ooMNAPhi7GMH9XOcFAI3b/9Rs
 kQ4lxzSAHKGsxbqaXlbAB04/uTJJbz/czMYuNl1/X4E06FhWSWyKN7ABOzNUANmrqS6OLv7aS
 8PxOSZw5YHG1T2HPPotgglv/1CabCo/NEq/RYrP3fEUcIovvw8jpmd82R7HJqLct0qjS6CdxD
 3ajZK1BCrreNzhLdaNU6pNnBVo3l5pWaPJXedm80/rXJWkt77ZkNH+3Qlk93H71BiY6c9gBIq
 82F6n+lUFkH4nLTpyFAuR+SlqO6CcgcBcPU84WQOtEleBwBXcVodfXkszC/TIYrIrPvSm1pBI
 3Gtj3SqwG90Hg0TBEGcYKUcmhNb3n76vmBd/zYj0SmG+b0bEjRuBw3G+THyMXDOZxQUnlK+q9
 eoL78DKZZ8VFo3avEzslBYtsn8KGn7ocrgrD8b2aCPacRdxN6OQTB6BZ5LvEhQSREKPOaxAtV
 0NP0I1yoLc3zXe5/WeBrGAbciGJ+h+Q2biGS7vT2ouXvJZvtLkPovkQEVHPh6/U3o3gTrk2PY
 ccz2Ys3bczoLkaD57D+EGu6VsfllylUBteR3eHiA4uJgwxzBP9NGeBE3MPVZ+TxyH4fKPfKPz
 NeAPuvwFH9lFzI0fbNfjEHRwaJZIi6/aYMEE4izp7aVN9oEJJorLj+jbLEEpso3LyEgBIacXC
 jlvJnrd+sg0XyYEe/lulOxBp/lOfiL89OldUHOUT8UV2IJNpbmJUo0yFzkh8j7ztcPRuCpHlL
 ydHamsELNsGz+DdvqVZrjHCVJ254bA2x0Z2xKlN0ulVkUON4dCTKGw1EQzzqJtI/ieakgYMxi
 PnadLJTHMBYA48ih9Fy8i69mx7BGvxpI3Nv/vajj0Ay0YG6cCWoHE6q/SWr02/moGPQH2mv/F
 wPwYSurPhb9xuuVLJ+26gtmeL5+or3r/XP89gMFj4XgHxRoHQa7UaUHHNW45R3NlC4kxUnrH+
 0adda+5nuDlbAwVnLKRgoa1T4RbXzIRgVaWHolUL9RJzGmSfkNMmAbbX7Ct17n7oKfFqI6zwu
 ckUolPd7s907CgeLddy2hnNYA7mQfhhfcwgHVxSrhDmnx+VPRjPPzw0ZwuSuZw/eK92Awq2al
 BxUBpnPq78k6/9UkN
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Sat, 30 May 2020, brian m. carlson wrote:

> On 2020-05-29 at 13:40:03, Johannes Schindelin wrote:
> > To be quite honest, I had no idea that it was a pain point, as it did =
not
> > come up on the Git for Windows tracker.
> >
> > Do you have a list of pain points on Windows that you're aware of? I w=
ould
> > love to get my hands on it to triage, prioritize, and address those
> > issues.
>
> No, I don't, but I've seen this particular issue on Stack Overflow
> probably four or five times and answered it each time.  I didn't think
> to look at the Git for Windows issue tracker, since I just considered it
> a difference between how Windows and Linux report symbolic links, not
> something that could theoretically be fixed.  Obviously I was wrong.

Ah, that makes sense. To be honest, I did share your expectation that this
is simply something that cannot be fixed. Imagine my delight at seeing
myself being proven wrong ;-)

> If I see more Windows-related problems show up on Stack Overflow that
> aren't on the issue tracker, I'll send folks your way to report them.  I
> want to assure you that I'm not intentionally depriving you of the
> information you need to fix problems; in this case, I just didn't think
> of it as a thing that could be fixed.

Oh, I guessed that it was that (or lack of time). Thank you for
considering to suggest bug reports in the Git for Windows bug tracker.

Ciao,
Dscho
