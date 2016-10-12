Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68769207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 12:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753073AbcJLMMx (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 08:12:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:54156 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751529AbcJLMMw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 08:12:52 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MPIvU-1bpuZm0H3I-004R1H; Wed, 12 Oct 2016 14:06:10
 +0200
Date:   Wed, 12 Oct 2016 14:06:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 05/25] sequencer: eventually release memory allocated
 for the option values
In-Reply-To: <xmqq4m4ic0gw.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610121405410.3492@virtualbox>
References: <cover.1473590966.git.johannes.schindelin@gmx.de>        <cover.1476120229.git.johannes.schindelin@gmx.de>        <a67af02ef363311b526bddba864c7f1ca9087b43.1476120229.git.johannes.schindelin@gmx.de>        <xmqqzimbc0gw.fsf@gitster.mtv.corp.google.com>
 <xmqq4m4ic0gw.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vONtM7U63dA8OK0dAJbfhk3VhNfG1IEs25uEzz2SrISpk6K6Fxp
 WhBEsvXeaY1/LYQcB3MnPv3Ipy27VXHLvCcHchjNA+hI41yl5ZLMikx9KOntZxGrr57wMGn
 vIDfdwVZwMn/p1Xhxae2X03uS0llNzu4PHtmJXsCEgqFaNalgnTc2wwBiqFOZLkEb43wPqI
 6ci/pcW+aBpngn8X2+1iQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H5BZ29vUojY=:occKR2gDQ2YTfun2pduLZZ
 cnTBU0rmRtbsvAkELzBnSkm/q4wjcZbnIsbT3iIaPt8WHMXEa8eI/qi3eAt8SSYjxCK+FBss5
 sNokGc68BIkQkgY+EPBwWry1PngLl1fhiQTr1+PPbpRfXY8tSauIh0Y6ypGFu85ShE5ko/Bjw
 9myuyhH+UFmFH+nwfhPzWt9Lo1WASJu8NT7xwGcgHs8ORdq1XeVfWASeSAgD/RyzD/OL/zBme
 9fdT2InxtImoZKNSDqp7IXLI7NlxqOyuZoFYTib3AYhxVJBdqhjObprccSUZywfo3yA53wmej
 U82dqKxVutfn7+Ufyd/Q7KHULDTY97j9RA813mvnNd+HFCabu1J0aj9UCklOAOIQutsNb6fn6
 EErrUXOH59aCwMoMaSMwFLTRDMsF4l1h3CmTrpzFccigw6sRQCqYCDdJDOi3xG6u8H1Ry27ai
 d6etuL4OHyvixMK/KHV+XPeiZAqHvQSWGmsd0pP9DqtwEZ0VwZ0XnqgHDtQaOGhkqXHuFOLSA
 oJeB8VCHgFfXZR8L2eXnBZYGqsWGK66gMTN7Bf/q1DXyZUHefedFoKWwuzVJ4kVpajStGTrAf
 ovPDRYLl6BeAUfHrHdBZPaFchFCAt3ThVmtiRWu/Zt0n/USFlwG5dLT0DrKwbVydaCFYC07s/
 nXW4uUQkiN+ehnBs9UiEzmA81Gm8YQPx01ZI4NgPNTA6ln4KIhbL/HDKii6vrENya2H1hbxko
 bAcnGOYdQ2GhCgOUul3Iw8sO/coTLjtRTphi+JvkS9ec7I5i26Yz46vtcsSAH/n71HCBd8IAC
 YrFXkIn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 11 Oct 2016, Junio C Hamano wrote:

> The only reason why the OPT_STRDUP appeared convenient was because
> options[] element happened to use a field in the structure directly.
> The patch under discussion does an equivalent of
> 
>     app.x_field = xstrdup_or_null(opt_x);

Oh, that xstrdup_or_null() function slipped by me. My local patches use it
now.

Ciao,
Dscho
