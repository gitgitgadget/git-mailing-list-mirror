Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2052BC433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047CC61037
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhJGLAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:00:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:53031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232418AbhJGLAW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 07:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633604284;
        bh=qRsMhghD8+xSnYKZPtNihf7jb+0hehZNB8thgjaPW/Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kQ1nmYTU4MgHzxBJNDF137NJKMoJAvHGQWBkFqV3ZI8ibBEvvhDYoSTDC81mKevGh
         2nfts5IheYRUZTNbEd8xl6EqBpS/8PRZvF7y7APMC2hXY1R7r5VzLY+5JNXsq2BcSq
         /Df0TG4kWgtJruWinSa4G+iolSJtYqjhfaKekPi8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.23.42] ([217.197.83.193]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWASe-1mIRSz3FHu-00Xb8t; Thu, 07
 Oct 2021 12:58:03 +0200
Date:   Thu, 7 Oct 2021 12:58:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: Train station analogy, was Re: [PATCH v3 00/15] [RFC] Upstreaming
 the Scalar command
In-Reply-To: <xmqqr1cxrjdl.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2110071256110.395@tvgsbejvaqbjf.bet>
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com> <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com> <87r1dydp4m.fsf@evledraar.gmail.com> <87ilz44kdk.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.2109131914080.55@tvgsbejvaqbjf.bet>
 <87mtofnzv1.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.2109141432520.59@tvgsbejvaqbjf.bet> <xmqqilz32hhr.fsf@gitster.g> <xmqq1r5qzv35.fsf@gitster.g> <nycvar.QRO.7.76.6.2110062139040.395@tvgsbejvaqbjf.bet> <xmqqr1cxrjdl.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cjqbkKzRc9vQu9SBKWYP+BdXdNVMWV5MWQ9kcAsN3bvq308Ot+G
 uQ9hpQViE/qCd9Ao3y1vOhTF2jdfEf0jeL/VOXJiX3DwoPIbR8L4KlYnf37I5KjmJfF9wW0
 VzHpOyQ0qsSma6j2cz4NK4PB4AjRPzkpa2gpHbilF/Edq75w/3c5reL5YrQT3u5TJGLcUuu
 Ys8ZmdZfk0LxRoli0HPZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WohB3CF8UEU=:6nWyUbHCNljN/5E7lBaQry
 hwPNhDpyNKvy2pJEF5mhrXCuEL/Cbzcj3YZQH2B8FPzLzTSk2u0LaSTz1RCrDsSgi38IFbs75
 A0DPqhnKOdri6DbBRhSTa8cvHKBsFqf++DIEhx0MYqwD7f5jQN5q4Q84CdCmEPekITrHUZifi
 OMs9FEg9rHomq92AtZUr+WelXzUPbPW7hV32JFC9l0a+UralEn1m0ff2YDvJMJT9JTJmSnUQE
 IWquFGXw7Z2dxaFvasPcJ+nEbNEvT+rxmhOzxBo/QZT6wGaQlcGf6tWvcGx1FdTV8mcNa4X+5
 bDG4OveFDsiyc3Wiej6ZfOArggfk0o1ON/383c+oSm4ayK83d4Gt4aVv/S06f3sJKSsi70F+h
 vsUk6i9Gl61updpqhU30SU4LvMtvIBkBByEYU95CLPekhvjKHngsGaDB5f1tfCsXrSXvf6umU
 8v0HbnLpMkQSuqvYknfk4mT880lHXKpyhlGIEcXRHQBSI2RmWz8CEPAQKiKiz+qdSC7RWolV3
 nTpamsxJr8e6eITiETBpVStyb55W3kqAh8/0ZhIojrGBb+mNhkKrIrJXW894tCqGE7On2MU0K
 V2UvbXP3Ld8xJK3lEodK03oqvILUkNEXLA/JGs64n7MNjTK72I3nPtiwV/EjGMbeUW7Hx0HtC
 lZCkz62sf9VDx1BskX1xI3RqeDxocYwCGvn+nwpcRLGpRDH7NBEOouhzvGEEbmcmhqABb/ZN8
 5meER5nyfEcvB+kTmIhKdwLJXoBETCU0JWF1Xe1Jtj3eSV8AzGgrHvghCpAUK4WsmpGRTbiFg
 hFunByNNoozk/MmIPw7Bhb7NrRs0oHNLEYqi5QePJ8xWJR/HmFU2v1nm6SAgC8VNmpqTodxsV
 El156dmYiLAXMxp4cTyt3Lps6yUjkR6+rKhCZ5Ff5GAtjvt0V0S4NCxd9bvLxUwCVAiCaVway
 hMWMXSYlrVrGZCzrjBbg7ttKZd5n/xWsGJ1c5pb/nayEtdGQxh7jDIWssnOHFJUsOTBrYtTsa
 J7ItPEbmMOhoFFvK4cYB/48zedCjF0zlbxfiKmOw04wfji2xS9ifz0VC9dLuMK84mh9lFFaz7
 /2yAMdBVzHwdrI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 6 Oct 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I don't think that there is a lot of sense in that. The main benefits =
of
> > `scalar` are in the `register` and the `clone` part, and the most natu=
ral
> > end game would hence be for `git init` and `git clone` to sprout new
> > options to support Scalar's features, in a Git-native way.
>
> Yes, that is even better.  An endgame where everybody benefits
> natively would be highly desirable.

I am glad that this question is now resolved.

> Now you are back, do you think we can have the "no more preserve
> merges backend" topic graduate to 'master', or do you prefer to cook
> it over the cycle (or even two)?

I did not see _any_ problems with it, so I'd be in favor of promoting it
to `master`. But if you want to play the game more carefully, I would be
fine with that, too.

Ciao,
Dscho
