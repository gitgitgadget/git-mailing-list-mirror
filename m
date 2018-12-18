Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B969D1F405
	for <e@80x24.org>; Tue, 18 Dec 2018 12:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeLRMsy (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 07:48:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:44768 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726419AbeLRMsy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 07:48:54 -0500
Received: (qmail 15769 invoked by uid 109); 18 Dec 2018 12:48:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Dec 2018 12:48:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12771 invoked by uid 111); 18 Dec 2018 12:48:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Dec 2018 07:48:26 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2018 07:48:52 -0500
Date:   Tue, 18 Dec 2018 07:48:52 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 0/4] protocol v2 fixes
Message-ID: <20181218124852.GD30471@sigill.intra.peff.net>
References: <20181213155817.27666-1-avarab@gmail.com>
 <20181217224054.4376-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181217224054.4376-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 17, 2018 at 11:40:50PM +0100, Ævar Arnfjörð Bjarmason wrote:

> No changes to Jeff's patches since v2, for Jonathan's no changes to
> the C code, but I added a test which I extracted from the
> GIT_TEST_PROTOCOL_VERSION=2 work.
> 
> Jeff King (3):
>   serve: pass "config context" through to individual commands
>   parse_hide_refs_config: handle NULL section
>   upload-pack: support hidden refs with protocol v2

These should be dropped in favor of:

  https://public-inbox.org/git/20181218124750.GC30471@sigill.intra.peff.net/

that I just sent (I tweaked the commit message to address the questions
you had in push for patch 3).

-Peff
