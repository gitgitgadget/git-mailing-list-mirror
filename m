Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B1422027C
	for <e@80x24.org>; Fri,  2 Jun 2017 22:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbdFBWsG (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 18:48:06 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:54940 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbdFBWsF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 18:48:05 -0400
Received: from a1i15.kph.uni-mainz.de (host2092.kph.uni-mainz.de [134.93.134.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ulm)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 70DE3341729;
        Fri,  2 Jun 2017 22:48:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
Date:   Sat, 3 Jun 2017 00:47:59 +0200
To:     Jeff King <peff@peff.net>
Cc:     Ulrich Mueller <ulm@gentoo.org>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-2.13.0: log --date=format:%z not working
In-Reply-To: <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
References: <22824.29946.305300.380299@a1i15.kph.uni-mainz.de>
        <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com>
        <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
        <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
        <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
        <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
        <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
        <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
        <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
        <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
X-Mailer: VM 8.2.0b under 24.3.1 (x86_64-pc-linux-gnu)
From:   Ulrich Mueller <ulm@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>>>> On Fri, 2 Jun 2017, Jeff King wrote:

> The remaining question is whether we want to care about preserving the
> system %Z for the local-timezone case.

No strong preference here. Maybe go for consistency, and have %Z
always return the same format (either empty, or same as %z). That
would at least prevent surprises when users switch from format-local
to format.

Ulrich
