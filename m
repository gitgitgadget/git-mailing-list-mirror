Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C003B1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 16:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeDFQP6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 12:15:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:49511 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751638AbeDFQP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 12:15:58 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Md31i-1emPDH0QOA-00IGw0; Fri, 06
 Apr 2018 18:15:53 +0200
Date:   Fri, 6 Apr 2018 18:15:36 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Joel Teichroeb <joel@teichroeb.net>
cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, gitster@pobox.com
Subject: Re: [PATCH v5 0/5] Convert some stash functionality to a builtin
In-Reply-To: <20180405022810.15796-1-joel@teichroeb.net>
Message-ID: <nycvar.QRO.7.76.6.1804061813240.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180405022810.15796-1-joel@teichroeb.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MvisPuzP8GgnTZaAd+qYS90BNn5XtikAfBUy0gcqULtr0H6meRB
 DslRL95Rg6qTo5SPPBE6hrbOPTsmYrA459OQqMVsmN6m6QOGR+R475c+ARoKHYYWed/O9jB
 mgkHxz2rCATUPDUNbb13K+8MKXlciq1XgM013/f1t5ayFeJ0JL5wjKRnlbJ7Cvb7yHe5Mvj
 mH92pm/pipWIhYFljPNsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6mtpiqreGVs=:elY8RLki9Y16CT3Ik3k3Kw
 E16pvIK93KpOQcuP7pbyXuZgQZ7UBArSbaAfn3C9buO8KONeBfPsyVl1GZUvF0JZzA30/9HsN
 l8wuuUEDrZsfHzJ8h3aYn2rnWvdYaW+sEFDHy0yVghDdB6P93g2SoEpJfNk9Wi5SN9zAUcsiO
 IZcBgnLrRviycgDsavUrmYWMUL8e8MNFALNtGgGsGfH3iJzcVRCJZQEAm6PnYifS0HZW9wyFc
 OJXiD+eW43ZKYYN4U30oG3iFSewoJh37YHW6DW+yfQhrgKYuGC28xuPDHh97Lja6K8zXnqwBp
 3FW2nUIqqG/2QF6a7wDYeKMGYL5OUYPf+2mzar8RX5h8+aN3PqlTYH94r5iKtdAomLGLgsrD/
 Sp6kndjA4h0Tnoa4fp7yptip1KFLZ0n8F9jKsBCLADWxrtOD53rK1puVf6O8Py1fa1Nass6yS
 tIQ6W0Pzkl2VK/MiEU+VVU9VDQKxlwh8PRV8dooHUQC/CCa44refvQE3ATKcdM6J/9dFtNd9h
 ECobP6NGYJBhRYg9or/8qlo9Mt89rayg5WTv18ejZPLITGnYeMKecgvDhs2yOHjyBMZSyDcMB
 SKDokAbFLBoc/KyvXuypdw0a5fiR/W0geZNg/f8q48veQF3KlodENgFQbwrErfcQPLZq7SqC4
 nHoWelnjX8d+grxhl7KAF+JKrk2yCPy1xZDDFjcYTFtMEwPLWQn8vqDkODbmEEC1crbtAzZ7Z
 7pOmYT0wPypmWpVJDxlg7AY6E5b+l+luClIvnxiK/Pm02lz869HVFZTis95sU86ho3a2fszAw
 3vfqb+2X47lrFp8azywJTfEHaSzj71DBGBdv1mxFB1gn7NQUrCqjUr07SvjlgytqQi9nGes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel,


On Wed, 4 Apr 2018, Joel Teichroeb wrote:

> I've been working on converting all of git stash to be a
> builtin, however it's hard to get it all working at once with
> limited time, so I've moved around half of it to a new
> stash--helper builtin and called these functions from the shell
> script. Once this is stabalized, it should be easier to convert
> the rest of the commands one at a time without breaking
> anything.
> 
> I've sent most of this code before, but that was targetting a
> full replacement of stash. The code is overall the same, but
> with some code review changes and updates for internal api
> changes.
> 
> Since there seems to be interest from GSOC students who want to
> work on converting builtins, I figured I should finish what I
> have that works now so they could build on top of it.
> 
> The code is based on next as write_cache_as_tree was changed to
> take an object ID. It can easily be rebase on master by changing
> the two calls to write_cache_as_tree to use tha hash.

Very nice, thank you!

I reviewed all five patches, and offered a couple of suggestion.

As is tradition on this list, I also offered way more comments that do not
require any action from you, please use discretion when reading those: I
definitely do not expect you to do anything about those "for the future"
comments.

This patch series is in a very good shape, methinks, and should not need a
whole lot more work to enter `next`. From that point on, a GSoC student
working on the `stash` project (if we get any) could take over.

Thank you so much!
Dscho
