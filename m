Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C961F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 19:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754308AbeGGT1P (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 15:27:15 -0400
Received: from mout.gmx.net ([212.227.17.21]:46257 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754150AbeGGT1P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 15:27:15 -0400
Received: from MININT-6BKU6QN ([89.204.154.202]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MY3Ho-1fXZQy2qmG-00UvOf; Sat, 07
 Jul 2018 21:27:08 +0200
Date:   Sat, 7 Jul 2018 21:27:07 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 01/20] linear-assignment: a function to solve least-cost
 assignment problems
In-Reply-To: <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com> <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet>
 <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Q6D5fr/jTtkBrN2k2kwWmFvgikp1uPy8uml0bVyohMVaj6VCvMy
 Yu2w8hvY18f0uFhe+FbkodmX1ujE/sqUhNHNibB0HUFc3YUy36yL8yFclJl6kjA3p9JxHEA
 SpF2wIbnsmWf7gaiUL2YFtd2URmrGrh8Eqk7HclrD2w0IU2e9fL4+yR7BJF5xC3wv4rSZat
 GtKSRk4ZeeASqdIvDQWYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QPb8O74pWY0=:ZLwXdN4BYZ5DuwGChIaxiY
 BL78/J8nzQIOsDBNu2azAsvmXW2MZdw+I948cBwAjgcUcbrSQ3wIil5FzDA9aIeERs5MuswF5
 uJyVdiLz0/HF0aZM3T/ydXe8DVWFHPiGAUQIFNvZoZ09zEBwwMNZgj90BFT0uhXwl2oFzPc9B
 C4WjKlTYodwNTn5A3MbhMeGWTCrlPtyyWhTGtEpGAzNjrpipmLBPlwHwpB0NMQxZRzdvcDBn8
 8Rp6qcyjcaTh6Z5/goWoTi0bBK1gjajAACi7zfV5O6UxEbMkGelCPm9g+TrgiibSuCnzX7s6Z
 eXQcH9M7IsR41H5VMi8U+/sDBI5dDeXr7cpW5LYsSIzZ28Zey1mwf+VhuKtKbU5rp65UD78KL
 cAxpkMdZyAtptPJlP+Jh+wrKfM+7BEMXyfYEnZRlhWXhG7qGRS69Fj0NcOYpIIP3rdskSEAEk
 MbBc1nYcLDJpF2z+2NcGOuatJ1eJKQILVH5gOm4a0g7YPbIx4+gv0QToYeYvOieqV/xWykcYi
 aL4uBLHHbJWkrcIllZuBrOeawkSka7DrgHE0kGtGzr72rluSw0B66DxulrkOJwih7musqooZY
 loA4z1a/yYQTENiBWvcEeb3TNRud0lS9oTWok84xY/BfzRCKkJuTe+Ac2CuJnJrg5SHSAG7rv
 PQENxocET0ruZlC75mJDb5t9gVeCPHnUMy95XVwaMyLqDNyip2P9piGbVpWFtn43U2iZ0pitE
 fNfaZ0GzCzfT01jReeU2JnbFQCqurbzy1akfqJ0hW2TarD29QDUFOJ01Kpmhlp9MMNwhr8PrJ
 JE7Sy/i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 7 Jul 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Does the "gitgitgadget" thing lie on the Date: e-mail header?
> >
> > No, GitGitGadget takes the literal output from `git format-patch`, as far
> > as I can tell. So if at all, it is `format-patch` that is lying.
> 
> format-patch faithfully records the fact about the commit that is
> made into the patch.  How pieces of information should (or should
> not) be used depends on the purpose of the application that uses
> its output.

I guess this is one of the fallouts for abusing the `format-patch|am`
dance for `rebase--am`.

> I'd suggest to match what send-email does, which is to notice but
> use the current date when adding a Date: header.  An option to lie
> to SMTP servers may be OK but I do not think we want to encourage
> such a behaviour by making it the default.

I opened a PR to add a TODO:

	https://github.com/gitgitgadget/gitgitgadget/pull/15

> What is missing in the core-git tools is an ability to tell
> send-email to optionaly add an in-body header to record the author
> date of the original.  We add an in-body header that records the
> real author when it is different from the sender automatically, and
> it is OK to have an option to allow doing so (but not encouraged
> around here---it is easier to reason about the resulting history for
> everybody, perhaps other than the original author, to record the
> first time you show the change to the public as the author time).

Pull Request-based workflows keep the original author date all the time.
If that is not desired, we need to do more than paper over it by adjusting
`send-email`.

Ciao,
Dscho
