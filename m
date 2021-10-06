Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA82C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC736113A
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhJFUMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:12:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:34345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229922AbhJFUMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 16:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633550991;
        bh=MyBBXRWFP5qy9ejFLtL7xTlOn6axr4f04EZCOu9wJ4s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dlg4LHKmf9a9Wf0VddTLyPf4WQ55Y+im7XvmE0+oRdAPZ/9n8c9HKzTWD8KPA39VK
         SvVNIUmuFfWPMcYp/khR52ByJ4SQuSReJTcz21VZFpEYnK2nrQ6F/EwMJS6Fs1tI/R
         ZMRLu2JdGApCf/dHhndi/MxbYzHIcuLk2Vvg7SKg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.23.42] ([46.183.103.8]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3mz-1mN36z31pb-00TYjL; Wed, 06
 Oct 2021 22:09:50 +0200
Date:   Wed, 6 Oct 2021 22:09:47 +0200 (CEST)
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
In-Reply-To: <xmqq1r5qzv35.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2110062139040.395@tvgsbejvaqbjf.bet>
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com> <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com> <87r1dydp4m.fsf@evledraar.gmail.com> <87ilz44kdk.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.2109131914080.55@tvgsbejvaqbjf.bet>
 <87mtofnzv1.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.2109141432520.59@tvgsbejvaqbjf.bet> <xmqqilz32hhr.fsf@gitster.g> <xmqq1r5qzv35.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Fod8W9rz9/KOI9J6otbJ17vbwAecJIV76rscZeA9I9wTmXNu9Qc
 iDTt2996MgcbNkLhK6OKRAKad1vxeh2DeBDghreQO1i51e3ov2eGVONHPCpsXADT0wrt5Nh
 zzObQ13nZrrJlv662aZ+cn1mNJG9w6MZ982g8yBvOmfAWd1YXIJqtvSES+fD6xN5xme7x4c
 kIYiQ96cAtqUzt9Ytq4vw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v/m/5oeLa/0=:uKut6lvGWufXymbGqKIt0H
 GwSlZnAOsk4s+PO5v/g7XOWCE2e2r+QYqiObH2aak+C102wpknFro3/JKGM02ih/XpJiF/IO0
 DO3K9uxxyncSutunopAiKuVBJHnHXayU3acCACF90sxlPNusN6rx5fgCrcaMs8+T+xB4ZBC9T
 j9WaCK+/yo4Al/d/4M5z8HisJjL+LKqmNX+cWF1zEybYDpDfPtREVn3QMJh4aL6//NeAbVW9A
 eEOr+mZs/hzWTMcT6Bw/r+Zi+bDdcYFXvJ3rtZCr0pzn43rGZK61dUKc8AoMD3gPaMdRu5p2t
 VTkeqTeg2vwSvZoiEW74GvKrktbEibOz0cpYshZm6JNGjzEmvYXfpVHUFjBxzItZY6WHR5Fcm
 wENX9vAcFBe2qjfT2dPy8aU9Q2EZR1JoBQErEanOPRVR4RDND6c1lMm/4w1HGuaN1Ptg2aJfl
 a21Xm3hAO+uSxEOWI9OAXJT/aCcUUiQ0vcDhWnjLbWh4z2XddAqwqNQqe5hP9/3AhHY05gsaq
 /sN42YJpHSfOd5KKXQwoNctYYBgajmvkjhQ5aFHUrJym9/Kd2BE5gzYHOBSAPxlIDen7CN7PA
 eFIrJ/Dd4ls99DtyrETGqw2J2cg5y8WVRhGbuKKAAQ7WpNRv56HcZR23MDw85za/ab8+HAfF1
 cdKL7uGxhgAiWBHC3VZe1dH4O8yM8ESa0a1je5U/ndfo3R2rw6ystqO2MaxfUzMBN3fAvAzFw
 E6slViGGat0UMFMeZn02+QqPIEzLHbAnOiUiyR1I8QEKCmiv09UN673VWoBqJp31F0QTDnNck
 SQBRdDvsl2VZZwLD4bz3WQmi9J6dMCZIFaY/+Xr0rGrK4jjJWc/GiVD2o+fKb6yVa8Muz9R5n
 j7/VCJgt0I+h5yFScEhZLuBz2PupmAogXq81uo6CKiQrNyYYp0UAvBKCAEgrHjaPe8hH1susD
 g+MilHmWjfE9RYWNAG0w95OJg33UTeLSQikejtC5LAjOw5Q9aJe5ZSynOoKUYjYstziGgfn+e
 0wS/CuVnfmgTJacFZdkIrR02QNlxufigB+VPhU/cLWErT4vK6UmBb6MpZAZIYGzvGCugmQq2N
 El/lruqnEwZDPvckcSt3RcYn+t1niZLKzTg
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 14 Sep 2021, Junio C Hamano wrote:

> An alternative would be to bypass the contrib/ phase and start as a
> new subcommand that is first-class citizen from day one and let it
> spend as much time as it needs to mature.

I don't think that there is a lot of sense in that. The main benefits of
`scalar` are in the `register` and the `clone` part, and the most natural
end game would hence be for `git init` and `git clone` to sprout new
options to support Scalar's features, in a Git-native way.

As I have explained earlier, the `scalar` command has existing users, and
therefore its command-line interface is not up for discussion (for
example, turning `scalar` into `git scalar` would be a usability
disaster). Scalar's _functionality_, however, should make it into Git
proper. Into existing built-ins, that is.

So I don't think that the contrib/ phase can be by-passed. It would not
make sense to port Scalar to a new builtin. To the contrary,
contrib/scalar/ should be the final destination for the `scalar` command.
And you can't bypass a final destination. That simply makes no sense.

So why bother with contrib/ at all? you may ask. The reason is that it
makes it substantially easier for me to move the features into core Git,
as I can incrementally implement those new options for Git's built-ins,
use them in `contrib/scalar/` instead of duplicating the functionality,
and then make use of Scalar's Functional Test suite for a much more
comprehensive testing (which has served us already really well in the
past). It also doesn't hurt that this way, my day job will be very happy
because Scalar users directly benefit from that work.

Of course, these suggestions to integrate Scalar more into the core part
of Git (missing the point that the final destination for the functionality
is not a new built-in, but rather new options for existing built-ins) made
everything much more cumbersome for me instead, for no gain that would be
apparent to me, impeding on aforementioned ease to move the features into
core Git (which has not happened yet, as a consequence), but hopefully
this will soon be a thing of the past.

So I would like to request that we close the discussion about the question
whether to integrate Scalar more into the top-level Makefile or into
git.c, and instead go ahead with keeping the `scalar` command in
contrib/scalar/. The freed-up time can then be used to focus on the much
more rewarding project of upstreaming Scalar's functionality such as
teaching `git clone` a short-and-sweet option that Just Makes Sense for
large monorepos (i.e. that imitates at least a large part of what `scalar
clone` does right now).

Ciao,
Dscho
