Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEBF91F660
	for <e@80x24.org>; Tue,  3 Jul 2018 13:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753055AbeGCNGS (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 09:06:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:47443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752832AbeGCNGK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 09:06:10 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2Ldk-1gSIZN2kTM-00s91q; Tue, 03
 Jul 2018 15:06:05 +0200
Date:   Tue, 3 Jul 2018 15:05:49 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/branch-diff, was Re: What's cooking in git.git (Jun 2018, #07;
 Thu, 28)
In-Reply-To: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807031504130.75@tvgsbejvaqbjf.bet>
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5nLCAqvgtvY2BkhaxAnCFfseShmDNwtKCbqqLxHyL4WYVbDm+Cd
 fA3ikTDhyEr5ee08ivrIAlSYndKXmPI0Fqkl31ZHLUBf8DS/IHR5V6btz5e/VYHeDniFXik
 aet/q9GlfpbKytwi2AFHQwBETO+qCZY/vygbYZdPeXbhiqIelB5sHA36ouz5MeZn7Wsws4p
 4gvUwd33JvVWxveqKdCcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:re34JB0BBc4=:CUNGLf1KnRNStk+WuHAk3a
 QQLQ2m2n4W41GG2BJQsEpKSE0CDDJ+WG3jA6WKpdkR/94SQARL9iUD+ZL858fqA79dflbP1gd
 V43h9n9KqzE+y8xzhKb9vOfgEBonLBXUq2KX3mUjjnP5Iy80ifQG782cGmbqBunc/goSubw35
 LWShE+TbLjff0OFSUj63ovjZteWQhMtpM/fs6NP5934KiglxO2LIMSDqDDSe0UxOjBibYEuiE
 439x5ehBHjNRASIt8pCuNgvbBsQV7rIlUA9D1nI0BPZjFNY+RaXPHkf5MpcMdZlxBcSdCn6vk
 EWqjvk0NpjF1lJtceq/PC3h/3r8GfjXgpkVTdgbvwGXWc/KFyJBB+POrztuq/lyk8geJ8SRUV
 7PNJ65Pr21ck3c4ptHQsRnUFmGW1GNG2nXixJue19APAhUEMRAl/DDMT9H2FeSWJYLIHzpvN3
 +4cVoEH0VNPm3l5B2qYUuCunjJjCfbunejWh5VtwZ4wfao7NpCPfv5+Q6vs7fESPPykF5ZwU+
 Jg9/WGRBEgH3bZ6ztmaCeO1TctJLrarEqvT61XuChdoXjsQbWOiGaaTPve5czeXORxzwuq4E3
 lyX/oeWO/X9NfJzTApOIZ4vIMC77X4cMkQIwkAeixCYUhDTLKiPZ834Buqn/FBXGR9OZnZM7A
 3duB5EnkeuM6LDJjyHxpQvZlwGGFBn7lwUgjJ3VF4Yn9ccwklrSsznvCPrcjZhk4/Uodwso1R
 06FUd0lZLXFhsARkzDO9ka0r5PO9daWyUeO7DxRyT+n4k0tHcuxoPJY55RORLgpAUlVX7yahS
 rFNExT9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 28 Jun 2018, Junio C Hamano wrote:

> * js/branch-diff (2018-05-16) 19 commits
>  - fixup! Add a function to solve least-cost assignment problems
>  - completion: support branch-diff
>  - branch-diff: add a man page
>  - branch-diff --dual-color: work around bogus white-space warning
>  - branch-diff: offer to dual-color the diffs
>  - diff: add an internal option to dual-color diffs of diffs
>  - color: provide inverted colors, too
>  - branch-diff: use color for the commit pairs
>  - branch-diff: add tests
>  - branch-diff: do not show "function names" in hunk headers
>  - branch-diff: adjust the output of the commit pairs
>  - branch-diff: suppress the diff headers
>  - branch-diff: indent the diffs just like tbdiff
>  - branch-diff: right-trim commit messages
>  - branch-diff: also show the diff between patches
>  - branch-diff: improve the order of the shown commits
>  - branch-diff: first rudimentary implementation
>  - Add a new builtin: branch-diff
>  - Add a function to solve least-cost assignment problems
> 
>  "git tbdiff" that lets us compare individual patches in two
>  iterations of a topic has been rewritten and made into a built-in
>  command.
> 
>  Expecting a reroll.
>  cf. <nycvar.QRO.7.76.6.1805052351560.77@tvgsbejvaqbjf.bet>

I rolled it around so hard that it got dizzy.

(Yes, I just made fun of this Git speak "to re-roll".)

Seriously again, I sent a new iteration:

	https://public-inbox.org/git/pull.1.v3.git.gitgitgadget@gmail.com/

Ciao,
Dscho
