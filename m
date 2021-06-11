Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F63FC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 09:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8327E613EE
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 09:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhFKJ55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 05:57:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:59723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhFKJ5y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 05:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623405340;
        bh=JcpHQ08Ydd5FFsitJpxE3iFrKWuqMFZUhKhH1gRFxOo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UAUff8PMbB2Ji9SwoZeIukmo3Hr6kKJH7OXEH8Up6hcJmbP4qe9wN/wbmOnSv8d4u
         KeBUVHfaeCmUQ+zL/x71A9gPSBqt1IRtOazHnAJEmhKjbvVyrDXU4D1nWv3C0EVfwN
         iY+vAvNuE6s2P9pLtQmX22g05pjWZYgf+1Pwfj20=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.213.18]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MatVh-1lJxlH38Id-00cR0w; Fri, 11
 Jun 2021 11:55:40 +0200
Date:   Fri, 11 Jun 2021 11:55:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/4] *: fix typos
In-Reply-To: <7f21cd15-5149-fe50-64ce-7b596dcd9bc8@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2106111155011.57@tvgsbejvaqbjf.bet>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com> <c40ad4a058a75d57adc97b8252ad0f57600b8d86.1623085069.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2106101029490.57@tvgsbejvaqbjf.bet> <7f21cd15-5149-fe50-64ce-7b596dcd9bc8@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ro+dXqHzLpyttEd7a9Vgv2zG16rICq1affc+BGOduvAO+Mz1KsD
 1Lg3QuUbG999XvKu+SNZJpc8Lsc5BJ8k2VrrV3y/+QOzUn4Dwe4So94Hfv4GvSQs3tgOpU/
 YpXPk8hz6cPId0tC9W1fAN0/jIFN8GQpYwWbtZ0EvBXb044+o670iOB3RAxg/aIk3txIoh7
 irUWN0mVtPJ9aZZzaAg0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MnEgRDld90Q=:OmJkHTMgXWcsVVaSdY2wEL
 6DaRw/giRkh1TMCM9LL87HrDTCQThCEG9I7coc0dgjry4kgX3Dy0REuR3k4/ARF4bE0JOVOjV
 g4/Yb9j0/dBZ8vOmsG3Bhr7kkDVDRpgEQIh5z6R9d7krFL+LmiZkhW7xz5xBBZtyduATSGt+a
 JkKJCmmk9xZLzHTjNa6snbqEzQTO/ra0rBG4BfbH9qUAv3XfEfw40tuUJ2Zg09VyP8pBhdShB
 kUnkWwqCt9C5ISa72R4LjXV7yZIQyNpT46w5Fxv1nut27V+vN27+Go0efO9opMMeIHbs5BzDP
 Ne4bki8r6WWPQOWiJNPqsJSs42/T76iUKk2sADUCCX6D1x6BWIZECxNQm6AnDe9ypfARyBcoo
 1oHsAKeCy9ngB/oPLJ/cupeenfAJP/3DsjlA3ZbezyCGRRcHf0eLnlMVnCj9fr5nEBndZU6cU
 orsaul5wOc/at28/xTDzaO0Zzmpkdeu49UvPj53xmuEOePp2ouPEAEOUyYH78zeURlsWYHITb
 V2IS5wpR1e2eA2MgnymDbeQAaBF9ZWcNd7c40o/zv5wxvyc9AxBWJ7SKWgRK2jYlaH2ZxST5H
 uW5rGSisJV8P9PRdg9PbpHPoq7bchkzolEVWHoMoU0Z72JmKy0eQJ9XmZrbfhsvbD3zEs4zqe
 2w6GFnpPFHj1d5so2Gqhc6ArX3U1Dv1QY+bi3kNumq7t7P2nZwGchltID4e0hXeo+kGQqqNgO
 9leq7/rVumXTiiugeUQdxM1/n6QxK6aGQTyykKdbpH4rU4z55KmXP5ZSH6f1XXrs+GsSZsKJA
 Tv4hmrnNdBQ9RyxVSRijv0QTG7qI0R3XsmZ4B+omSTigB5lW+XjLG84MSn6PT/eXiihT8qoQF
 y4F/PZ87l1v0efJHBn/RFnuWnZvkEh14FS+NIzehVSMp+sHiAlTj8AKUCbxbL2bSm2J8iQsF0
 EpqtyKiGeo1igNDxy/HTKjFHeP7Ashwf8wQKNZd0NSDFG3luNepHpu4dOnt+Ndq2Tl+4Npu+w
 NJ+toj5fiSf8ekuVEjaBVEwLmvURfXdsObbbSo1XTPFjSMWmpI1YZMf8ZCArsYh9k8OKqsHc5
 Cm7ShIfFismIzNn90YElEEuEn0fXPEFNcatq2uwSwatjV0dZg4f/orjgQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Thu, 10 Jun 2021, Derrick Stolee wrote:

> On 6/10/2021 4:36 AM, Johannes Schindelin wrote:
> >
> > On Mon, 7 Jun 2021, Derrick Stolee via GitGitGadget wrote:
> >
> >> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> >> index 5c47ac4465cb..7039b5c6028d 100755
> >> --- a/t/t9300-fast-import.sh
> >> +++ b/t/t9300-fast-import.sh
> >> @@ -1538,7 +1538,7 @@ test_expect_success 'O: comments are all skippe=
d' '
> >>  	commit refs/heads/O1
> >>  	# -- ignore all of this text
> >>  	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER=
_DATE
> >> -	# $GIT_COMMITTER_NAME has inserted here for his benefit.
> >> +	# $GIT_COMMITTER_NAME has inserted here for this benefit.
> >
> > What is this even supposed to mean? I fail to parse that sentence in b=
oth
> > original and modified forms.
>
> I missed that there appears to be a second typo, s/has/was/, giving
>
> 	# $GIT_COMMITTER_NAME was inserted here for this benefit
>
> implying that the environment variable exists to allow changing the
> committer info during this process.
>
> > Looking at 401d53fa350 (Teach fast-import to ignore lines starting wit=
h
> > '#', 2007-08-01), where the comment was added, I deduce from the commi=
t
> > message that the personal pronoun _was_ actually intended.
> >
> > So maybe a better way to express the original intent would be this:
> >
> > 	# comment added by $GIT_COMMITTER_NAME; fast-import should ignore it
>
> I think the first comment "# -- ignore all of this text" satisfies
> that need, so maybe we just delete this typo line?

D'oh! That's the best solution. Just delete that line.

Thanks,
Dscho
