Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A5411FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 14:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbdBJOCo (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 09:02:44 -0500
Received: from mout.gmx.net ([212.227.17.22]:56238 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752174AbdBJOCn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 09:02:43 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyB6P-1cNSCz458H-015ZH9; Fri, 10
 Feb 2017 15:02:17 +0100
Date:   Fri, 10 Feb 2017 15:02:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Philip Oakley <philipoakley@iee.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Ashutosh Bapat <ashutosh.bapat@enterprisedb.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Bug with fixup and autosquash
In-Reply-To: <454E7D934160418EB4C4871ED209CBCA@PhilipOakley>
Message-ID: <alpine.DEB.2.20.1702101459200.3496@virtualbox>
References: <CAFjFpRe8zqxs4OLbCrjnuEzF=75sbBJ+HuZqek49B=O=TFHq8A@mail.gmail.com> <xmqqbmucuwb0.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702092142020.3496@virtualbox> <454E7D934160418EB4C4871ED209CBCA@PhilipOakley>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZJjglYo8E/rMDovtD8mgh4EcSbzxaUl/rBL0rXgdDsW9nRKD9Jd
 trbYRbTclbfcQh1AxvHNSUDJzqTFsKxwVjsEV61bpJEEX8+6bfOpq7F3FmfEXW9bwTRQVOz
 KaM9B9Sqt9Rnsd0pLlgRl0OH9GO09TX0FHF3b1YmmB2i1iJTh6zko2pIaJe0hjA9bUB2oww
 zWnXyX7Lah8ZdVikhVQ4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:udExm3sZdyM=:GHB/bZtYN4j+VXWpCY6Gx+
 nOqYAX2nbryhQIq4E+nXvgYB+xMOdBfDvFcYrOXhFQVVYkGY8hApSf/DYBLvK4iB7k7k/GwVh
 J4kLyCcgcz3Klzob0g653VY5dLhCqYqUbzQBK6D8tmNA8VitadOpMwQM1/sFJk+gV8dVF5ZLF
 dawNip12nHsPRxaAKY8A1cSWY7Jz7L/yDJjFDwDZxdoQVz68XyGBYxZZOKrsWk9KYvM6ZNsAj
 DxORQ/WwrPT8CuiV3+F4l71rd3DRcfVUbr/sVvnyGsyjHOFTeL5KUa44wTHUKPxPPj5goJWvY
 pvxgvwMURC/xOq9JlMKRXZoL9Sa3swDiqki3yiB+tjXEmuR+LW9wVtz9k2O28cKvmKvIXMDqH
 hk7qY46yEJKceijgLoXB7tYVZC0LDA5/xwnkZuw2TFiX0eb7MCqdBFhODlrOe5ea1DTL71Lzh
 BJLLOUs16S3NSIWuR/30Kd42AnYN3WQg8nWn+tGnPPvwE/7bGUqlkq6uhLcL93ETAqqqVA9vV
 Z+TJSe2lniIPwEVrUM9Y+edC2cs4coFu7h3J/umtD4VMmDQ3kXRcQVQDIR6KyUZIijcL7pAlH
 DskA9RgJwwCHnKHMlZczkvbvD6+nKb14Ttds3eQW2mohUzbFdWVAE/iY9l2QNYfksj36Pg2Re
 TYZ7SLZEP96Rue1InKOCLg/my9B1TRLIAFFFdbkyDnikN8VTTNo8+BKbBsCRzJdbD+q9iHguH
 v+HRFmPHXK+Xk7unjXNQO0P6692gsihqulF1hiPj/k72t8VQoj0g0Z+CaWWnawe3j+g5Z85nJ
 nKYlTHN1iL3rXtRZGGEgKqnVv9Fsg84DlyXeAp6xWAKoNYBBspBQt1eKIDIxHtyMHlMrN4Lkw
 1tpPGGlHQQhYiG8eeTot5W90tHWPAuuoZzeZEvUO9ZNklZKYk4S/TN+Q3DuxpMQ10K2n8GyL4
 uiZlz+s22lYLdy9pfRYVteqr9kEHR5vPNC43KHmSr205SOiFCP7cUH7gb6J/7EKZLMhFpGUnJ
 PQ9jphZ1ZHt6637H/7I2uA4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Thu, 9 Feb 2017, Philip Oakley wrote:

> From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> Sent: Thursday, February 09, 2017 8:55 PM
>
> > The rebase--helper code (specifically, the patch moving autosquash
> > logic into it: https://github.com/dscho/git/commit/7d0831637f) tries
> > to match exact onelines first,
> 
> While I think this is an improvement, and will strongly support the `git
> commit --fixup=<commit>` option which will, if the sha1/oid is given,
> create the exact commit subject line.

That is already the case (with the exception that it is not the "exact
commit subject line" but the oneline, i.e. unwrapped first paragraph).

> However it would also be useful if the actual commit subject line could
> have a similar format option, so that those who use say the git gui
> (rather than the cli) for the commit message, could easily create the
> `!fixup <commit>` message which would allow a broader range of ways of
> spelling the commit (e.g. giving a sha1(min length) that is within the
> rebase todo list).

It is already the case that `fixup! <sha1>` is accepted, see the code
replaced by above-mentioned commit:

https://github.com/dscho/git/commit/7d0831637f#diff-0f15aff45d5dd346465c35597a5f274eL780

... and its replacement code in C:

https://github.com/dscho/git/commit/7d0831637f#diff-79231f0693f84f3951daeea17065aad9R2800

Note that both preimage and postimage code try to match onelines first,
with the new code changing behavior ever so slightly: it tries to match
the exact oneline first, then a commit SHA-1 of an already-seen `pick`
line, and only then falls back to the (expensive) prefix match.

Ciao,
Dscho
