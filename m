Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B921F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 10:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbdFHKWw (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 06:22:52 -0400
Received: from mout.gmx.net ([212.227.17.20]:56819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbdFHKWv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 06:22:51 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4ScS-1e4R8H0K6O-00yemF; Thu, 08
 Jun 2017 12:22:41 +0200
Date:   Thu, 8 Jun 2017 12:22:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] t1308: relax the test verifying that empty alias
 values are disallowed
In-Reply-To: <20170607181553.GE110638@google.com>
Message-ID: <alpine.DEB.2.21.1.1706081221090.171564@virtualbox>
References: <cover.1496851544.git.johannes.schindelin@gmx.de> <3325827e66b1a9e693f81e8aa4cae44f41dfdc25.1496851544.git.johannes.schindelin@gmx.de> <20170607181553.GE110638@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qhO091VJ0hxi7lHkqrDbGW4Ope9kZuX7S1wHoecBnADZGZDEv33
 4YS0cXi/MB1g99rKw5a5zVS/lA9cIE/h9XuQGFVi/c5SYC5ClpEFXaNXHrdeDBs/FMINRvQ
 xF7DedpJ1qga1QNafpfLYTPfK0TUIjfrtIg8rpLqaBYl0tUt2mh6zLbC7ZcTpu/6zoyWyxs
 sXBlJMtZBGnhtapPuqgMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8Xbl0EyAgvY=:Y8iekOsKsHelaYsbqr7Sp1
 6vHHszDBhvXgYwHhAUHZlIclowk92mZC3uqPo4rP0SAMjglk6+Ws0KcFS6TzJLv2VrOxpQxve
 FoCRtcgNyTJQ1zZFWP0zapnxlaQcye9aPVRdBosoJZo6gqf7bmOfhyHYnPJZ0HaNghpAGnLhp
 B2zzSpAbfNCXjv9I2nnx/nLGe6K0KdShDhGOYwKqpWkVZ9GxvjlYowNYGjS5J8b0ie0sQw8da
 Fk2d0jzMNvpZYVCrKvon6wgtckwjxasLqzxLOV5F3Juh+jOSJtY7ZlWPF5ouVG1KmvWvfVBpb
 VmVqRb70MJmY0CT8D9F4GX2tIClVLpUl5LoeQfGBH9zF4HpgrFqaU5oIeeRCM9o0txZu4BeBm
 lMu1IfLAT46uFpBnETRHJheCJqP7ddcSUi7TFuV7PSIKZyXEqzGC5pKuG37pSbyc1Sj9Mh3YW
 +ngdXiqgy7+mAjyJg+j9Z6mcrSVA5b+zYHI2v96gIn+inz7YLZ1pAK4dwSDZPdBX4JqO6Pa97
 4WHTGJ/xq87h4Bn1ZPyhwZLiaO40+mq8kzSpW7PzwoEwyK0BFJW8Hd/z3QK8frNDEXrwuz41Q
 8ZAUqyuW/cKO516EGvgSgD9x7UqD8VioFwTWgJ7/XA7y2rFfiGZgzQD1o7tdzzZfpBkKWnBls
 JeoqayR1FVe+WGKUbhLEtPZpsiFEl6EzSPOZApAaFc5JxlnwZ1Ta5VoDYtTMtqQANGbtREyuE
 oEYeEHeGWNmjwWaGWNI0kSvSxN9tb4Pwp9llnxmq1fp/bO8eOqbtRWTsSIwWJ72ckjX0qfYvg
 hDBP5dV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Wed, 7 Jun 2017, Brandon Williams wrote:

> On 06/07, Johannes Schindelin wrote:
> > We are about to change the way aliases are expanded, to use the early
> > config machinery.
> > 
> > This machinery reports errors in a slightly different manner than the
> > cached config machinery.
> 
> Not a comment on the patch but just a genuine question: Is there any
> reason why they complain in a different way?  Doesn't it make sense for
> the errors to be reported consistently?

Yes, I agree that they should not complain in different ways.

I had a brief look to see whether I could quickly fix that "while at it".
But it seems to be quite a bit more involved than I am comfortable
slipping into this patch series (whose purpose is not to fix the dichotomy
between direct and cached config parsing, after all).

Ciao,
Dscho
