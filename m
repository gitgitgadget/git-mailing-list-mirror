Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 086D11F453
	for <e@80x24.org>; Mon, 29 Oct 2018 20:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeJ3Fff (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 01:35:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:54565 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbeJ3Fff (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 01:35:35 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqRKT-1fdTjk3JxJ-00e3Ju; Mon, 29
 Oct 2018 21:45:05 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqRKT-1fdTjk3JxJ-00e3Ju; Mon, 29
 Oct 2018 21:45:05 +0100
Date:   Mon, 29 Oct 2018 21:45:15 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     gitster@pobox.com, christian.couder@gmail.com, git@vger.kernel.org,
        pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH v3 2/3] shallow: offer to prune only non-existing
 entries
In-Reply-To: <20181026204914.134946-1-jonathantanmy@google.com>
Message-ID: <nycvar.QRO.7.76.6.1810292047130.4546@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1810260956230.4546@tvgsbejvaqbjf.bet> <20181026204914.134946-1-jonathantanmy@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2FJd6rKouz4XeAj5suNuHZIkXFvABxQLJ8EPyy5jVgRympn3x9L
 SEDhA4pz0P0+fccrDts9oxMk3ezqQEagaPY6Dva0ELU/0HNoB+hntxG9g+Y9kLGUJmNPosD
 pRL7e5ZdMU0h3gZh80yxE2sMnxKFqmlKn3n8mmJH6I8Kv0c1izW1yi7LS09Nukse4lYL4b8
 kDVSQkFYq0ohENyLehJyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nBOEUGHTWKg=:oEPw8Ty/TriXxRKPjR3EBQ
 JoW/loaK+y8D6fx0X/X5FZfv0o4xDNDSae2UGTI3cLYCVGvTddH1dbWyNDhTOJKDTnMpxyJS2
 tajoSY2n+OPiqLxl3BVUXcujfgnqw5zSJt87D0QTBp6oyK+NiEnyQZW1BFnwVUn6VzkwVe+Xu
 y99lUoGolXEeu1ySs0fk1Af7WdaeMJnVx9oetl5RFPIr08waXu73uIfg0zZbTzWP8AlD3STxz
 iGPWjJH+3qZ53IMJY7YE1pd1LzyYrjvippgIlpJyk3MblJKK7WkYVvlqpPgCbmlArPkw8YJ8r
 9PS7LHDQezHVLap09tXIhZ9MOjYfUVkm8w7aT99iFa6V9sz2gVmKgVbZ2LmoVuLnJcl4qrl8M
 3NiEixpPGKbJxuYcmrssLqW6RnMSZ1h36KDwk+HF4UmMo4KerNsGrP5+jgM00/wX/uhML8Tz0
 qm8i1sL0JSBhH2d8xkfAcHuCotPqe/FIZGuX3Qgpx46iT3ip5IIzhxeOvaOfXDDYjdUg9wc9h
 g9uKaNVa84mRXlv5zXpmZbDslUF25vP5bTw1Vgihelf2HLqSAJHR8zEX3oDQcZKc4iZRLS7vw
 XBSqLpJ1rV1XwAHlQAA1XAhNkERbImhmS6KJJqp3Ssmjrr6w8rr+j6yFMUh+fmvLwGJ6l1kDp
 xNMoH5sw1HtztMqiMUBJnnKRoMCXpZJC4R+7spLWV+cvLKNtq542atFI9prT+ClRQvsB8LTl2
 E2ohCiwfx6PsWAIsfF+dTTH3t+yM6/Grk/kq5dZGlP2lyeGPhMJeQNB2Ry9msssxmAnpXcET3
 cUjAQASX9helCL6AVnd2BV0zjyYNES2KYPksF8MLlSEWkDGOgo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Fri, 26 Oct 2018, Jonathan Tan wrote:

> > So even better would be to use `is_promisor_object(oid) ||
> > has_object_file(oid)`, right?
> > 
> > This is something that is probably not even needed: as I mentioned,
> > the shallow commits are *expected* to be local. It should not ever
> > happen that they are fetched.
> 
> That would help, but I don't think it would help in the "fast-forward
> from A to B where A is B's parent" case I describe in [1].

I don't think that that analysis is correct. It assumes that there could
be a promised commit that is also listed as shallow. I do not think that
is a possible scenario.

And even if it were, why would asking for a promised commit object
download not only that object but also all of its trees and all of its
ancestors? That's not how I understood the idea of the lazy clone: I
understood promised objects to be downloaded on demand, individually.

> My suggestion was:
> 
> > It sounds safer to me to use the fast approach in this patch when the
> > repository is not partial, and stick to the slow approach when it is.
> 
> which can be done by replacing "prune_shallow(0, 1)" in patch 3 with
> "prune_shallow(0, !repository_format_partial_clone)", possibly with a comment
> that the fast method checks object existence for each shallow line directly,
> which is undesirable when the repository is a partial clone.

I am afraid that that would re-introduce the bug pointed out by Peff: you
*really* would need to traverse all reachable commits to use the non-fast
pruning method. And we simply don't.

Ciao,
Dscho

> (repository_format_partial_clone is non-NULL with the name of the promisor
> remote if the repository is a partial clone, and NULL otherwise).
> 
> [1] https://public-inbox.org/git/20181025185459.206127-1-jonathantanmy@google.com/
> 
