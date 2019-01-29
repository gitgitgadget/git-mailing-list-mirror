Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315F81F453
	for <e@80x24.org>; Tue, 29 Jan 2019 13:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfA2NMq (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 08:12:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:52992 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725355AbfA2NMp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 08:12:45 -0500
Received: (qmail 26550 invoked by uid 109); 29 Jan 2019 13:12:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Jan 2019 13:12:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6279 invoked by uid 111); 29 Jan 2019 13:12:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 Jan 2019 08:12:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2019 08:12:43 -0500
Date:   Tue, 29 Jan 2019 08:12:43 -0500
From:   Jeff King <peff@peff.net>
To:     Sebastian Staudt <koraktor@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 3/3] Add test for describe with a bare repository
Message-ID: <20190129131243.GC22211@sigill.intra.peff.net>
References: <20190129051859.12830-1-koraktor@gmail.com>
 <20190129051859.12830-3-koraktor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190129051859.12830-3-koraktor@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 06:18:59AM +0100, Sebastian Staudt wrote:

> This ensures that nothing breaks the basic functionality of describe for
> bare repositories. Please note that --broken and --dirty need a working
> tree.

Makes sense.

> +test_expect_success 'describe works from outside repo using --git-dir' "
> +  git clone --bare '$TRASH_DIRECTORY' '$TRASH_DIRECTORY/bare' &&
> +  git --git-dir '$TRASH_DIRECTORY/bare' describe
> +"

What the test is doing seems sane, but the same quoting comments from
the earlier patch apply.

-Peff
