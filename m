Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46C051F404
	for <e@80x24.org>; Tue, 20 Mar 2018 15:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbeCTPmd (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 11:42:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:55615 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeCTPm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 11:42:27 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlpJU-1ePFdN1Ksa-00ZLiw; Tue, 20
 Mar 2018 16:42:21 +0100
Date:   Tue, 20 Mar 2018 16:42:05 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] rebase --recreate-merges --keep-empty: don't prune
 empty
In-Reply-To: <20180320101114.17663-1-phillip.wood@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1803201639540.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180320101114.17663-1-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IFuf9IA3juK+DMiehXiYYkyJUwq+veZQ6iSdgJTdvu1OS4Hho3m
 DNGR8WewSmag6Ai6m7YHoYzLKxYPIdJxpdyzVvb2V0QgJS9GWVCdRi/dLh0kvLNQi5jhWp1
 S1D0OHh4qnfIBjWmL+o4Al7dY5/njUdsOgJpAlJY/OHl2uFg1K38rLCUtSpxJ6mqkIG83oE
 V/JsYmEPqG+faOUZYpN8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rKcLjU/JhuI=:rBh0tg2vEPKGrCGW3rWhYa
 DnOfLJ4UXRl79cEH/LMdTjiSBUXv1sO0d7f8MK0teqcgFZk+uws+B/+mUqRfZuV1YEe0ZPQ2o
 KYuCQZ5op76JkuLDFetum9El5Dodl30vcIJyWPXkiCesERMHGLeLDqS31fnqpZlZkCsGD/UBL
 2rXG0clEIHM648V/o3HfMzVtCfQ29hmQtebLKptjknawdU/+MrgsEKAnAii2M9Cnrm2eoeZq2
 BRkuRT2RaI+IW8TTsNl3m5wBGzge1mJ1NRaZiuYV9Ee+eNsi+PrzGLlaZIHPArmXJ8HdsTY1Y
 kt+S9zbE73MpkoCuON3YV0Aw94pTJeQzkufZ7M0yzBqOtEtSlOcHTxt9RiH/7ky3zMajtVvN8
 L2mCJJzQh2AxghXrJqYbf4UD5oNnJijlIwaF9FeJ4ZdwQ/6M5Ut7INNFSrA6l6kehXB0oU76J
 xBZka3xf+dS8RFX+a6TMEjW7Abh37O8mLbay6Pdl2QH2wQlhd7X47o1uKEqyPQX5KG7++qgzj
 H/QMXCw1Um4HX3t/tHR6BEVRkMX36oIzoYPFYZ+6M/eYwu1asRxbKWObBvTGcfgdLzeThuZZo
 1uUPvVL3bVtm7tdAggHjhhYXh4D0PngQFmc4JjzOqpv+s1fT0Gdm9jambyJifdEp77M/ezGPs
 UevueGeRklCnDcO+Z6HYKbhgN5G7qbuB+5M7hXCNkvubhfk+gkthaYpBF/AnAnxiIZ4Syrarw
 itjBsW8oq4/r9wdRDJ6CaVaIiTJIeSAcfVocWkGoTjGKyOodFdfnaFD5/PIbWs84lfYRTxn/m
 +hGNrg1qKWpgLw9N5DwTtf5MEvjGAmMfeGAh146pWtHra3TOtA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 20 Mar 2018, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> These patches apply on top of js/rebase-recreate-merge. They extend
> the --keep-empty fix from maint [1] to work with --recreate-merges.

As indicated in another reply, I'd rather rebase the --recreate-merges
patches on top of your --keep-empty patch series. This obviously means
that I would fold essentially all of your 2/2 changes into my
"rebase-helper --make-script: introduce a flag to recreate merges"

The 1/2 (with s/failure/success/g) would then be added to the
--recreate-merges patch series at the end.

Would that be okay with you?

Ciao,
Dscho
