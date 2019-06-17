Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6301F462
	for <e@80x24.org>; Mon, 17 Jun 2019 18:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbfFQSZ0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 14:25:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:45593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfFQSZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 14:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560795917;
        bh=luFdOBAVWD1HPu/a0iN2XYuRl6h0aXSG9aVPf41xpJM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=StG3rsFnjQP94ETmDH1Zyph7Jcz56cPgKyQZHp5+2PhdjZRGpoq/pJuxqvYrIEPY9
         qVAWHRWhLKXX1H+FXp9rpAg5JKhaT/+agYr3s0k94uBv5PT/9yGxQAmOcB38Rivjup
         BQpmMejPQ7LU0GMhGViBor798ncnr/ya1MBjV8z4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6qM-1iLviT18yC-00lTHr; Mon, 17
 Jun 2019 20:25:17 +0200
Date:   Mon, 17 Jun 2019 20:25:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: sg/rebase-progress, was Re: What's cooking in git.git (Jun 2019,
 #04; Fri, 14)
In-Reply-To: <xmqqh88ruc1b.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906171944170.44@tvgsbejvaqbjf.bet>
References: <xmqqh88ruc1b.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lANW49niQ1EvDr+1FhJkUCFi1MvueN9l0XgF5hcZgTt06WSnMs5
 37PS/PeFUhD/zVSe4BhQD0pUKYJksc2P4R512zR/8l6gq7UEYxvdurbKbb+1ye91Of/JbAG
 Od8Hlwkm3AwjgOn52bnf93jADCSp6emkREuIef2J1ejl4lYSP/BDbDKeVjf0jS49u0WETwn
 Zp03NzaiMI1UXwv7qga9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3dNLY/jsDsI=:jIG6gqgcR2U1b5fDbXwCi1
 RPTkzsZu8ZzrtqguFLvIR3X5AadJBq9abgeb7DBdBDvrsD8fdvDZCqpkGpMQMBzlTUyy3G+V6
 0dKkhgdqTQVTqGPZRzsk5F+g2SsqLRcvOtMC12RrT/bbdscuuLgx9lL4fIkJXxcviMQGEXGFu
 clR+aXMvle+8ZtXdLPUenq+i1PQHulVboBJue1Sv5aVyumSFZjcgG8ys766AqAbFLGaYTju7B
 JBolwNvusq9Fm+2lWaQqvYzemj9NmyBA8cZ2bs3AseHwBogRWKW3qihxoE5ki+jnGMrZ+lyB9
 dF6+2AgMayWplIP69/K/U9xA5sLwzgDzM/qJbnLb+yuS7QdNgkAoADFfYvhyqI6SQqFwC1EBH
 +Aq2assl3hCiT6r66pwtE/k79+qQBnjfb5U4fr5KQtHg8Kq5UlMvJVHTGkb61D2zNiG5JMSHC
 weHgWr3av96HI8JKOQ8mqtP28+mVPGMX91x0o9/ZNdECCv+BVub9Sc+aMR5sROlXUA2fVULEw
 c/RsYqpplSju6kDKc6AmG/F4NByD1ysMU4pC8Oc2qpsJi5FWFjb6+miN6Mn7Ksqgg5xP4fraS
 H2ez17KL2fd3fVo4+i0/vpcKuqzXI2eri1SeNCON5iERRQRN/gGQfJa9/5G0oxR2qNyjBsTae
 jkgGOvGee3rXg5O591lKUjS8JlLL3c9/u2NT4vSlGa1crLoq9UC0KB7cI7jF3GME17BspB3fb
 k6U97mOlCiDKjgZ+GBNCqJtW/2bDrrCUyLS8gVPph+bEk3wkMXnvM4MjCd5PSxctcW1jqO4KI
 +NMpSyA1RRHNk2gzu3ePr3nvhd/Xx3iD4Rp8DC0LJJJD6EWntXbbcr3uL1BsjsJ9nm/JiGsRG
 S53T9ip0jvutsruHU2tGaI8X7uxNtxnulbpzLdl20VkjZ4TUKnlo0Jfq5N+k16KL/AtAteRKa
 36TYFK1oNh0vON1OjzMwGMDU/pWoTKpmD8XotRzPn6lM0w35T5d9/
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 14 Jun 2019, Junio C Hamano wrote:

> * sg/rebase-progress (2019-06-11) 4 commits
>  - progress: use term_clear_line()
>  - rebase: fix garbled progress display with '-x'
>  - pager: add a helper function to clear the last line in the terminal
>  - t3404-rebase-interactive: use the 'q_to_cr' helper
>
>  Use "Erase in Line" CSI sequence that is already used in the editor
>  support to clear cruft in the progress output.
>
>  Its test may have to be updated to work around glitch in test setup
>  on Windows.

Two thoughts on that:

- the problem is an existing test that had to be adjusted for this patch
  series,

- the existing test has the underlying issue that it casts too wide a net,
  and catches *non*-regressions more easily than regressions (read: it is
  false-positive-happy).

And most importantly, the "glitch in the test setup" was actually a
full-blown bug in Git for Windows' MSYS2 runtime (not very likely to hit
anyone, though), and I fixed it in the meantime. The build for `pu` passes
now:

https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D10882

and also the build for `sg/rebase-progress`:

https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D10885

Given that my remaining gripe with the tests was hardly introduced by this
patch series (although I would have loved to see it fixed in the course of
a next iteration), I tend to be in favor of advancing this to `next`
as-is. I can always offer a patch on top to clean up as I had suggested.

Ciao,
Dscho


