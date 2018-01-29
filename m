Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E501F404
	for <e@80x24.org>; Mon, 29 Jan 2018 21:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeA2VIH (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 16:08:07 -0500
Received: from mout.gmx.net ([212.227.15.18]:49999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751812AbeA2VIF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 16:08:05 -0500
Received: from minint-kr8j64v.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MbOoG-1eNdLQ3Uai-00Iidh; Mon, 29 Jan 2018 22:08:00 +0100
Date:   Mon, 29 Jan 2018 22:07:59 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 4/8] rebase-helper --make-script: introduce a flag to
 recreate merges
In-Reply-To: <xmqqa7x4gwpz.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1801292205551.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <b9cb2d915aa4ff564b1960ce0352664b1d26eecb.1516225925.git.johannes.schindelin@gmx.de> <CAPig+cSn_X-0iir-cKSd=P8p5QCxrR2qU_GBj7zDbv8zTc+AQw@mail.gmail.com>
 <xmqqa7x4gwpz.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uD78kcOvMafpcGF8Z6T7UVJ2XAk0he7zmq3YZT9TrZjHMA6WpL9
 0D1hcPDY8BJDjC85/iPpctBodZW7K6vFYkXtwcA94FZ3KW21f95psr8yArvCZ7ku7e9gw9k
 lXilel7N1iQjp1HNcI1fbfp0R/EKyTtPzOXLLpeF51V8Y6DMLgYEyOfhdNkoycYwZrCqTfl
 hcyeF4o0vVI+q70a9Ouow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yZRev0ohXuw=:0vdVyRRn/lZ8W9rQNWYZlx
 CEnEuBqOQCO48rTfMbqpkQRaOZc6cesqULsRx07wjatElC5akvNer76hQzJdKtLhITPlMiToX
 53oCttO0BPV5FOaiDr6tV0pm0114R0PkJMQzfRIfZGxS4P+mWYoVECjhDso/rlK6kVGVRhIzH
 vQ/HqU+p6nWEqEyU9BWagaykZlCtEwr7i1Au6mWZPJvTOE1Cx0aKjSqSN2qHm+CXKN90G93sA
 l23RurLu+wc9YsV4j4PYisjKeXBi2HmTkYL4xSRchIXjfNCobILcCHbJaFBTcbcDHpEVP/giR
 sNLfOt3nzmG8fZnDOVPlfPIKTV+B4QAjpwDyx5Gx/iGV75nkuohSrCuwvuNqvbxlZmKBqwz41
 E3AXbnNY+4RLqN27ieCZXbEtAHXv+TylGDzvELERhGYQgjmnDyeJq2dYez/Vempy4n5UkP/AJ
 EwyXDTeC7VNtNqDxb59PRGmTkOV9OEMvxcoJSBf90W1BG6TkVIs7IsRn/XoGMzvxOjcV2Nf7p
 7VwCsaY9rWqCu8wl9Hm9m+1tsjbFodD++HRA4zYj1Zzd8L9FpNWE0DSSeBBEVIMcqVHsTLPft
 QF3oKQQCq5Z4QMu1QsWbS4Aqqixr9Yq7eyaARFqWCcAODxoG8F005lKNVDP5ZGxL9YQ6rwi7Z
 RUUewi9jbpOK6HdvJIZWi8g2xU/6Awwyrid+vevLBPjQ9VZ5w/2/fYf8V9sotEQYkMIWpB0Pq
 Kmkjtj3q7wpE1uEybwLs8Z1Nz5mswv5Yb8UaotNEBgHZhXEK//tcVr8faSUTuw1zr6yae+8ug
 NFckw2YGIrlGJRc6H1Va57XKxdJxOg3a1wvvdtm4N+YtRRAs0PBemRGkYAGnOcCDqJUn+/d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 23 Jan 2018, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> >> +               is_octopus = to_merge && to_merge->next;
> >> +
> >> +               if (is_octopus)
> >> +                       BUG("Octopus merges not yet supported");
> >
> > Is this a situation which the end-user can trigger by specifying a
> > merge with more than two parents? If so, shouldn't this be just a
> > normal error message rather than a (developer) bug message? Or, am I
> > misunderstanding?
> 
> BUG() is "we wrote code carefully so that this should not trigger;
> we do not _expect_ the code to reach here".  This one is expected to
> trigger, and I agree with you that it should be die(), if the series
> is meant to be released to the general public in the current form
> (i.e. until the limitation is lifted so that it can handle an
> octopus).
> 
> If the callers are made more careful to check if there is an octopus
> involved and reject the request early, then seeing an octopus in
> this location in a loop will become a BUG().

This has occupied both of you for way too long.

It is *not interesting*. What *is* interesting is for example the
discussion about the "cousin commits". And maybe both of you gentle
persons can spend your brain cycles splendidly by trying to come up with a
better term. Or by trying to beat out obvious or not-so-obvious bugs in
the code.

Seriously, I am not interested in a discussion about BUG() vs die() as
long as there may be real bugs hiding.

Ciao,
Dscho
