Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D224E20248
	for <e@80x24.org>; Tue,  9 Apr 2019 14:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfDIOOv (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 10:14:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:52152 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726374AbfDIOOv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 10:14:51 -0400
Received: (qmail 6794 invoked by uid 109); 9 Apr 2019 14:14:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Apr 2019 14:14:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30088 invoked by uid 111); 9 Apr 2019 14:15:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 09 Apr 2019 10:15:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Apr 2019 10:14:45 -0400
Date:   Tue, 9 Apr 2019 10:14:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2] sha1-file: test the error behavior of alt_odb_usable()
Message-ID: <20190409141445.GA7371@sigill.intra.peff.net>
References: <20181204132716.19208-2-avarab@gmail.com>
 <20190328200456.29240-1-avarab@gmail.com>
 <20190329134603.GB21802@sigill.intra.peff.net>
 <87pnq9aipl.fsf@evledraar.gmail.com>
 <874l78a3rz.fsf@evledraar.gmail.com>
 <xmqqimvn7fnt.fsf@gitster-ct.c.googlers.com>
 <8736mra7nq.fsf@evledraar.gmail.com>
 <xmqq5zrn7bua.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5zrn7bua.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 09, 2019 at 06:43:41PM +0900, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > I'll leave it up to you if you want to queue just the test patch or drop
> 
> As I said in a separate message, I think it is good to make sure
> that fsck does not crash.  I do not think it is good to grep in its
> output.

FWIW, that approach (and your rationale below) makes a lot of sense to
me for this case.

-Peff
