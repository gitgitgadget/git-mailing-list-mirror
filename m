Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98DE61F404
	for <e@80x24.org>; Wed,  4 Apr 2018 18:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeDDS4J (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 14:56:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:53500 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751367AbeDDS4I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 14:56:08 -0400
Received: (qmail 17019 invoked by uid 109); 4 Apr 2018 18:56:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Apr 2018 18:56:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7064 invoked by uid 111); 4 Apr 2018 18:57:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 04 Apr 2018 14:57:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Apr 2018 14:56:06 -0400
Date:   Wed, 4 Apr 2018 14:56:06 -0400
From:   Jeff King <peff@peff.net>
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7] ls-remote: create '--sort' option
Message-ID: <20180404185606.GE9055@sigill.intra.peff.net>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
 <20180404171153.4126-1-haraldnordgren@gmail.com>
 <CAHwyqnXtc-WgynCmE+EEVYtg6RRVweK8vwfBQS5VL4ygaFumKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHwyqnXtc-WgynCmE+EEVYtg6RRVweK8vwfBQS5VL4ygaFumKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 04, 2018 at 07:18:42PM +0200, Harald Nordgren wrote:

> Jeff, you are right that 'git ls-remote --sort=committerdate' will not
> work. Do you think we need to do something about this, or it's fine
> that it fails the way you showed?

It's a reasonable-sized footgun, but one that I think most people would
be unlikely to trigger. I think it's probably OK as long as we warn the
user in the documentation (see my other response).

-Peff
