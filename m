Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04884209FD
	for <e@80x24.org>; Sat,  3 Jun 2017 13:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbdFCNNR (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 09:13:17 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:43140 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750997AbdFCNNR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 09:13:17 -0400
Received: from a1i15.kph.uni-mainz.de (host2092.kph.uni-mainz.de [134.93.134.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ulm)
        by smtp.gentoo.org (Postfix) with ESMTPSA id E86F13417DC;
        Sat,  3 Jun 2017 13:13:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <22834.46566.700197.257204@a1i15.kph.uni-mainz.de>
Date:   Sat, 3 Jun 2017 15:13:10 +0200
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Ulrich Mueller <ulm@gentoo.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
In-Reply-To: <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
References: <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com>
        <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
        <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
        <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
        <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
        <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
        <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
        <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
        <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
        <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
        <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
        <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
X-Mailer: VM 8.2.0b under 24.3.1 (x86_64-pc-linux-gnu)
From:   Ulrich Mueller <ulm@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>>>> On Sat, 3 Jun 2017, René Scharfe wrote:

> +			case 'Z':
> +				strbuf_addstr(&munged_fmt, tz_name);

Is it guaranteed that tz_name cannot contain a percent sign itself?

Ulrich
