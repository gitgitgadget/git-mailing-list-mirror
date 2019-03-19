Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDFD020248
	for <e@80x24.org>; Tue, 19 Mar 2019 06:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfCSGUh (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 02:20:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:56028 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726020AbfCSGUh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 02:20:37 -0400
Received: (qmail 6568 invoked by uid 109); 19 Mar 2019 06:20:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Mar 2019 06:20:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27068 invoked by uid 111); 19 Mar 2019 06:20:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 19 Mar 2019 02:20:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2019 02:20:35 -0400
Date:   Tue, 19 Mar 2019 02:20:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 6/8] reflog tests: assert lack of early exit with
 expiry="never"
Message-ID: <20190319062034.GA31801@sigill.intra.peff.net>
References: <20190314123439.4347-1-avarab@gmail.com>
 <20190315155959.12390-7-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190315155959.12390-7-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 15, 2019 at 04:59:57PM +0100, Ævar Arnfjörð Bjarmason wrote:

> When gc.reflogExpire and gc.reflogExpireUnreachable are set to "never"
> and --stale-fix isn't in effect (covered by the first part of the "if"
> statement being modified here) we *could* exit early without
> pointlessly looping over all the reflogs.

Er, which "if" statement are we modifying here? :)

I assume this is leftover from the earlier attempt which actually did
modify it.

-Peff
