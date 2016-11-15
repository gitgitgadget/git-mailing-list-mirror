Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C032E2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 16:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbcKOQyi (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 11:54:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:56359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752445AbcKOQyh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 11:54:37 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVJze-1cIFSE0fK2-00YlDy; Tue, 15
 Nov 2016 17:54:20 +0100
Date:   Tue, 15 Nov 2016 17:54:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Lars Schneider <larsxschneider@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0021, t5615: use $PWD instead of $(pwd) in PATH-like
 shell variables
In-Reply-To: <xmqqshqux9il.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1611151753300.3746@virtualbox>
References: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de> <xmqq37iy3q0s.fsf@gitster.mtv.corp.google.com> <fa11def5-a878-a5c8-6e7b-627ea8cda7e2@kdbg.org> <2b69d098-92ef-77b0-367a-516e9edbe257@kdbg.org>
 <xmqqa8d53ky9.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611121237230.3746@virtualbox> <xmqqtwbcyyfe.fsf@gitster.mtv.corp.google.com> <0BEC2674-20B5-4AD1-851A-97CA34C0CE7F@gmail.com> <xmqqshqux9il.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TETMLp7sUklTiAwrdmhWQXD3SkmnR2oQ6/XXcvjxbmXaYfi7J+t
 UGrKA7btJzqE5uib1m7HfIn7O5s0FnbUlEUgPVqgwNdvUphGzwVpgh/U6V6nWXbotDPiKj8
 VTzSAOWbjHXMay3NHHTnmsNkwEC/z8x2UZxOgbhnGY1KNyg2wV8wRBGLn1hxqUWR7gTrt9R
 TPNGPOWafOEmJjuHUJzBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pSeCeTCKjHk=:ONHVbRIjccX74KKrouQ2f7
 fIhO/Xqjp9kH4U3+xnCEmlHRhV9UwB8DHkoNzk+08S8Thb2dRWiwwT1KlnWdz74WnhJh4DIw2
 i2omdcxQsjRSJqzi03tBdSQbjrUIuINBJ7eOTLkOnTxqiPC5+DqDV7d3Rhiq6OIk8GeR56p5C
 n9Syhsp/CVcxpd96uLYpIdibv3cq/6NVSkgNmGbVCBeYkOZ6+D1cZkYrx1v+fZ5eXsnnn/BlT
 xbIQNphsMYssjAzTmEqBcWD3DMkbJQr7+9IL26s7IW7Po494CBFmBTV7U18bYJEOUoObkqRQ9
 c7wlWGdDdGfrk5svg700eeSOMyqkMzIjo9P5AFCfGprawAmvEfBh5Qxm/jxqBivr/nz6Bvb6c
 KYS5iMEEZ8cLwLz5KoGtfDQ55lM3VMGoc1Z7cmRh/Ljem6lme1hHLfNZ7q9O/KvXvYLELf3s7
 iWLMnb+qU7t7YT9XzdMG0jnnIGzzz6CgzyjFotRl3hbNxDlcmz7YemyFMWf26jkoXo27WNcDs
 b2LE8ETnzwp+PAMdCQ2vZC0pPYnboOuCn4J7OyF+aPB5K9JBy+rm2NbEU4vFj0nyuQrcFdhTF
 28d7SJcBeWZQ5lU/Dptd0Lgg6FwRa48kk9B+sIK8t9BwapnmU+YL1V1/vzPP+Krdxsd/+HOW9
 /pYerV5cSGZ5FYTfKqqK7FwszmYE5JRtvFOUesFrZzJAmgNzn9OZvEw7qV1oUiQx/RjJomcP+
 MZRAiiXvgAxBN6o3PKT32vYZYHBSsdG06jRkKEeYrSFQGA74ebyD2rhI8oQrHD9B14PxbP71c
 xYUWSop
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 14 Nov 2016, Junio C Hamano wrote:

> Dscho's mention of 'still times out' may be an indiciation that
> something unspecified on 'pu' is not ready to be merged to 'next',
> but blocking all of 'pu' with a blanket statement is not useful,
> and that was where my response comes from.

Until the time when the test suite takes less than the insane three hours
to run, I am afraid that a blanket statement on `pu` is the best I can do.

Ciao,
Johannes
