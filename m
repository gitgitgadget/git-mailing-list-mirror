Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BA8C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 23:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344979AbhLJXSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 18:18:37 -0500
Received: from mout.gmx.net ([212.227.17.22]:57617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237592AbhLJXSh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 18:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639178091;
        bh=vr/v087fXautATqPQjmEGHuCxhYjZNEoV2mIZGayDuE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OtE9RBjfP9CGN38RwEsOtVHwi79WJDAkuOByzw3ohdAUu4oHOmEQC+d/K5/3kI+70
         oGa0UL9D9m0u/+bN06aNFfLvgtQLQKa/he05qSl+l7GSOJCp1yPYOp9YCBjtu97zgn
         32In3v9CFeARFKMoadw3zxk9Hg93jCUmD79TtBqs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([213.196.212.194]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCKFu-1mmVQX1jxi-009SJA; Sat, 11
 Dec 2021 00:14:51 +0100
Date:   Sat, 11 Dec 2021 00:14:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
In-Reply-To: <xmqq8rwu278d.fsf_-_@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2112110003530.90@tvgsbejvaqbjf.bet>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com> <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com> <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com> <xmqq4k7nmksi.fsf@gitster.g> <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
 <xmqqh7bi27o9.fsf@gitster.g> <xmqq8rwu278d.fsf_-_@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:r3P0L6rWs8RuofgamQAfn5JOID5IueSonvcPrR+8tKNP9aAzyln
 gdsvwQeXhL/XFNepXc2pA5tuehjmR25Ujn5wjD/fgV2Xb7ou8ImjMGC+EbfexwQeM981P11
 IU7ZGgaP367Vrp/L1dxi1uHqGW8QiffzNnMmXJEDRCsFRsxI/jNsaTrd0uked/FQ2/TVh5j
 sEvEsJytMc9jqiFM0toZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2dmEWiMa4Pk=:dmGf95oRLghcBZ+woIqtUw
 I4UnuDrDoWX+9IaNR45Sr3bEKfrkJZ97+QD6/9ZFfD71ROfO5HA8sjmqtzbWxhqo+aNKnW5zg
 ay+BnywkAZgTJkFoM+8RcJRKKTmIC6r+moLdcxDf/2n6kSzDUvz43zcldAKJtrKxoVc3zap9o
 N0HWMinxqgsvZ5v+i7X9rA1b0c2zj1PyD2TSiAy4O6mUG6Rb5VoonImky2UGy24RmPyG1hFRs
 1bTSRGChb5B4YpBIhY7eh8ClCG2uxKQMBTQQTH3pDT6AOlQvdnHvDkb7n6d5Xs8kasf+lP5aE
 2N5SRNUNJsnttSoNoKlNiRyidT1VweOWOkJTigthC6jBeWUA0F6RZssYYddH+o5QhrQW59pvs
 ZFPrvxU/ajzDfiVJYoRVKBuQbFpWdGSZ/+em/N+LrTdhToU4ZSl1TK3sjU2JXYrZxW90FDSp0
 +YiTUe7Cp6zSlVPNLNR+nsGUM5QxGj3kPKrAaQ3YWqtBir+KlbLt3Y7Qhd1sU4iYgIaXRlfmr
 xhk2O3Oa43KbWlKEAGcP40BOxvTK0M6QUZunwCcvIS8I0h6d4f+AS+JUKFfGX56XftOMW4gOE
 EcO3c1ETLPd5rFNp9aGZr4sCZiLmfTdNYHsM27jAyCpBXUxKeCiwk20VVW8M8c033HccFPc/n
 tXI0ECaJHH+CBSGZAr1s/7ktczJHPV7X1UQq8FETOxwxvlTJIWQriYEc0nWM8AkQ3q0nJRsE8
 lnSiANGEGkEyYVXJqls/WHMaU+8MN4EE7+3xWRcCEQKGgSE/I0YVVBlz/NWSs1O+8+jprBueU
 8I/qSgfqxg8s9Z10OMCzMRpkBYL8HjTwHvY9yP8/4LLGTdKbNdaZob5hP3cX9RgTuMznyvbJa
 stCMfih/HQj/Jzw8Ppl+Gwrz80qy+hyrL8YjktyBo8CwnGHFi6ewIfBUvmaGYb2y7BEuYtYC4
 6WrdHEc6k/fNzJ3X3vHvun0q4WOz6fklFeLF8QafPW9y+1kGOndj2yjOGKDR6L/m99R+k5fwb
 3MJROyq8irL1pkZxvmdzumkjXKJzmy4nIMOMIYmGdYjFlJ8B9XxzRI/lAJVrMUJafUaDsycMy
 7wzew2TWvZBDW4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 8 Dec 2021, Junio C Hamano wrote:

> We ship contrib/ stuff within our primary source tree but except for
> the completion scripts that are tested from our primary test suite,
> their test suites are not run in the CI.
>
> Teach the main Makefile a "test-extra" target, which goes into each
> package in contrib/ whose Makefile has its own "test" target and
> runs "make test" there.  Add a "test-all" target to make it easy to
> drive both the primary tests and these contrib tests from CI and use
> it.

That sends a strong message that the stuff in contrib/ is now fully under
your maintenance, i.e. first-class supported.

If I were you, I wouldn't.

> Junio C Hamano <gitster@pobox.com> writes:
>
> > That is an interesting way to demonstrate how orthogonal the issues
> > are, which in turn means that it is not such a big deal to add back
> > the coverage to the part that goes to contrib/scalar/.

I'd rather focus, _some_ focus, on the actual Scalar idea and code.

> > As the actual implementation, it is a bit too icky, though.
>
> So, how about doing it this way?  This is based on 'master' and does
> not cover contrib/scalar, but if we want to go this route, it should
> be trivial to do it on top of a merge of ab/ci-updates and js/scalar
> into 'master'.  Good idea?  Terrible idea?  Not good enough?

Peff mentioned a couple of times how tedious it is to address CI failures
e.g. in the Windows part of Git's CI runs.

So it makes only sense to avoid the same problem with contrib/scalar/
altogether, especially as long as you keep saying that you are still
uncertain whether it will make it into Git as a top-level command.

Which is a strong argument in favor of just leaving the CI part of
contrib/scalar/ out for now, and let it remain _my_ responsibility to
react to any build/test problems arising from unrelated patch series
entering `seen`.

Doing it that way would also have the benefit of allowing more focus on
the actual code in contrib/scalar/scalar.c.

Not that it needs more review, I don't think, as both Stolee and Elijah
gave their thumbs-up already, and I've not received any feedback that
would require further changes to `scalar.c`, at least as of _this_ patch
series.

Ciao,
Dscho
