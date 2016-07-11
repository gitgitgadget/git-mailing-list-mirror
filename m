Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B75552018E
	for <e@80x24.org>; Mon, 11 Jul 2016 06:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbcGKGHP (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 02:07:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:58295 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030247AbcGKGHM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 02:07:12 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LZynd-1azDmU48mD-00lmCG; Mon, 11 Jul 2016 08:07:04
 +0200
Date:	Mon, 11 Jul 2016 08:07:03 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	Josh Triplett <josh@joshtriplett.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
In-Reply-To: <CACsJy8AFYWsi1_f-Hw1odN3gmbfqayXuoBHo+K3Fh4XBwMA0Vw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607110804480.6426@virtualbox>
References: <20160708025948.GA3226@x> <xmqq1t34oiit.fsf@gitster.mtv.corp.google.com> <20160708064448.GA18043@x> <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607090928500.6426@virtualbox> <20160709140931.GA3185@x>
 <CACsJy8A6fiPUtNZow_oOEQSi64GMxA2Jy84h4OznaSxBMePtbQ@mail.gmail.com> <alpine.DEB.2.20.1607101255300.6426@virtualbox> <CACsJy8BWKrXqXnbEgSKJ9gKcAyvdZhExfgh5zBRisX8R3BkBLw@mail.gmail.com> <alpine.DEB.2.20.1607101602320.6426@virtualbox>
 <CACsJy8AFYWsi1_f-Hw1odN3gmbfqayXuoBHo+K3Fh4XBwMA0Vw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FM7Qy/cQbv7yeKFdqZcsz0PBasS0iAkh+iuMX2L1X7GLersrDBn
 dpt/kpNsTOwusaR8WLG/Qh18veqdKFsLlATZUiAy2gcXIcMTVL+0K2NemAovon8r6W3Lub+
 PbN6gtzXHXFXFMKJwPxjOWmahhJ4LK3S9UrqU21E8SqWUdcBVdfPACv7ev8x00tmJzswmSE
 Nsv8JIZw39Cxso+fC8aNg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:8+bSZ1Ddb7A=:O0fYgaZSzXRyAe4d6tyx+5
 VgASh5dT2k5Sy6fo3ZNDJkEX5mwi25g1ynDXo3iHc1KHMSp/5018ekREKjCJ4IaIFqPsz9ocl
 Zg+mrqzGUmDzBimw26mlCuRGabjDdabWYSFkkintF/T9GCqVVMaJZ5CnNQxiNeFfHPkkaa2pW
 SdbQuVFBXui3Z+NajZfsdpQD5QiYn5uO5Re24gr2WExI6yt5I0R/egkkTaFSAgfcJ4tgiogoO
 0BU38+KRBjmmePu9QyAa05m/1K40tJbMn+zuEWPt3XLNClgZ8N3b7taw9bl6yOz137krOBKqu
 x51A6ilmtfQXMwP5CQi4h0GHKNj4H7ysHJZVamIXUKvPs2nhLkpvAnHO2LMC/nm29jFSm32TK
 wnU393q86mlHNIgTDn22N3JuTkvjZZ5vYZqYFoIQz6Fi6QlXfDCrGmgcF/1AIKC9bqfK67yID
 niTa76ArGL/ENtq8w4WYjthm58sWAc23wX1za7b1zAKnC/Crs3LzTM5NbbqvdNK30JrpWFZo+
 cCX84wjfzy12HRrxJbqlv1KOC/M6vibzPFANEV7VTfqyAA0E2javeIOrT/KrwdkMupDRXusMx
 QyTm/iaY+Zrh9vEvMShakHkZVnC816wdf13olDi18SNyHRdyM396meQKSZ4XhcMVVzDITi1TN
 DtDuiB9BQ94tjvSYdvZnsM1uZCVzgTs+j2weql70NHO6T1p9vE2nKNDJH3vWooJWKmga6BTw/
 ce0RyZPLSD8GfIY8cRtFnmr0fEZzOIg+L80GX/Fvgq5KH9iQAaMaX1rNthWvRJLF5NSAMtKLl
 tn9Z6DL
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

On Sun, 10 Jul 2016, Duy Nguyen wrote:

> We will be able to see refs from all worktrees if we choose to.

What I tried to say is: even if we make it technically feasible to have
per-worktree refs or reflogs, the downsides are too prohibitive. We should
simply not introduce support for that (and resolve the per-worktree HEAD
issue accordingly).

Ciao,
Dscho
