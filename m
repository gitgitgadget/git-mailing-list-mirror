Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62511F4C0
	for <e@80x24.org>; Sun, 20 Oct 2019 01:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfJTBKW (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 21:10:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:53222 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726036AbfJTBKW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 21:10:22 -0400
Received: (qmail 22082 invoked by uid 109); 20 Oct 2019 01:10:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Oct 2019 01:10:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27817 invoked by uid 111); 20 Oct 2019 01:13:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Oct 2019 21:13:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 19 Oct 2019 21:10:21 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Doc: Bundle file usage
Message-ID: <20191020011020.GA2980@sigill.intra.peff.net>
References: <68ef6ca5-0baf-fa30-ce0d-138a41620da6@iee.email>
 <20191018203052.2451-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018203052.2451-1-philipoakley@iee.email>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 09:30:52PM +0100, Philip Oakley wrote:

> +`git clone` can use any bundle created without negative refspecs
> +(e.g., `new`, but not `old..new`).
> +If you want to match `git clone --mirror`, which would clone other
> +refs such as `refs/remotes/*`, use `--all`.
> +If you want to provide the same set of refs that a clone directly
> +from the source repository would get, use `--branches --tags` for
> +the `<git-rev-list-args>`.

Since you swapped the order here of "--mirror" versus non-mirror, saying
"other refs such as..." in the first part is confusing. We haven't
introduced the thing they're "other" from.

Maybe say "clone all refs (including ones which would be omitted by a
non-mirror clone, like refs/remotes/*)" or something?

Other than that, this version looks OK to me.

-Peff
