Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8696A1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 16:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbeGSR1S (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 13:27:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:48997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731625AbeGSR1S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 13:27:18 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXDo1-1fUNfB3bOf-00WDfD; Thu, 19
 Jul 2018 18:43:12 +0200
Date:   Thu, 19 Jul 2018 18:42:56 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] repack -ad: prune the list of shallow commits
In-Reply-To: <xmqqh8kxrfrf.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807191840490.71@tvgsbejvaqbjf.bet>
References: <pull.9.git.gitgitgadget@gmail.com> <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com> <20180713203140.GB17670@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1807142351100.75@tvgsbejvaqbjf.bet> <20180716173636.GA18636@sigill.intra.peff.net>
 <xmqqh8kxrfrf.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2Q6L/f7Y3QO5jDptcs6KbCFjK7KzV2QyFmGSbal9yPnNLsqDX6G
 aVYOVdalR9RkY6VnkAP1A63lWvroIvwt4Jt59uOenpUzMcB6SsBw1ede1KUEt9Eqq9vAuMx
 dy1Kpb41oZ3YBancp7yTmX7/Vnp3dlcjOqBRsPKqdOl5kq0usMymW7lUyfO+8Pdfyml/aWP
 wmCGYH83G9X9TvN9cPaCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SDe7o2N+74k=:aMSY4cjCvWbjTpm5NtUv9f
 oHZLsxDstlt+tNdlNunuhQIMfPUq8s/dX5m+N8i3+qdAavtP5bibtHapJajcyttokM8U8QIl5
 pVrABQTXGDq5T55patuYVzqiIORA1ZZDvx2S2QIQte+iSgZzRRaDiY+R3w3xoWkg6pmE2vLs9
 4ZoxhBb7zim3LYIK/CFbjSNoRASoYDaUsUAIhnuf7EBz49C8Wq48XlY5UFfvr5D4+xDiR3KWf
 TufZZby7bWvj6htud1A+MMxymfrLWWAiM6BN3lRE5wXiufLX1VoVv3nzKciIgrFnVXWY+k/jy
 U0v/QeimYQgL4irkozvl5D+/hDMRCEjdP8maUM9aMewv8muKpw6bcjlu4OvoWZSal+z3n6lzF
 m0S4gNdIXvhgmsZGzmSKa4lYriwPujDKt5SvJSOpK51sWSsZ7vYDj834QTF6fhScbz6MTLjTI
 msZhv0UF9YQQx4XTOnO2Z4C/EquKPrLuksQaDwH4/B7AbUPN0CSV53MZhufAfRs4ZwKc7knZV
 UgKiNEqpyz4ka6BIjmLoSKUoQDh3AbXmd9pWIXHIzqh0Z5enil9V25PxNaYgUqPifEt6eKU42
 +y2ACL21Z4ErqyoeS6Bm+urAMLH9s0vy1uoWmuqA/4sopd4riziPKtmh83t1x828pFGXBiRs0
 /T/F7N+mgJMTYvpQG120//HQGIUoOMWBzf0yxwyC4pOp4pljgFU370XevKpT2FGaYJvLWWXmZ
 I/Hg4uAqmbkbA0T6leoh4l2c0PNYAwhj5tioG9O2qqVhqlyNQUX1aPiuhjJLBR1UQtKTC9BYS
 BA0u7TY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 17 Jul 2018, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm OK with having a partial fix, or one that fixes immediate pain
> > without doing a big cleanup, as long as it doesn't make anything _worse_
> > in a user-visible way. And that's really my question: is pruning here
> > going to bite people unexpectedly (not rhetorical -- I really don't
> > know)?
> 
> Yeah, that matches the general guideline I follow when reviewing a
> patch that claims to make existing things better.  And I do not
> think I can explain to a third person why pruning here is a good
> idea and won't cause problems, after seeing these patches and
> the discussion from the sideline.

It is very easy to explain: `git repack` can drop unreachable commits
without further warning, making the corresponding entries in
`.git/shallow` invalid, which causes serious problems when deepening the
branches.

The solution is easy: drop also the now-invalid entries in `.git/shallow`
after dropping unreachable commits unceremoniously.

While I am sympathetic to Peff's attempt to make this a bit more general,
I think he overthinks it, and we do not even need to complexify the code
for now.

Ciao,
Dscho
