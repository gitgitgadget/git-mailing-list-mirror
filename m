Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9940E20188
	for <e@80x24.org>; Sun, 14 May 2017 04:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbdENEGD (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:06:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:51400 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbdENEGC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:06:02 -0400
Received: (qmail 7350 invoked by uid 109); 14 May 2017 04:06:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 May 2017 04:06:03 +0000
Received: (qmail 7463 invoked by uid 111); 14 May 2017 04:06:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 May 2017 00:06:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 May 2017 00:06:00 -0400
Date:   Sun, 14 May 2017 00:06:00 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com
Subject: Re: [PATCH 18/19] diff: buffer all output if asked to
Message-ID: <20170514040559.uvs6c2dnd6aelrln@sigill.intra.peff.net>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170514040117.25865-19-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170514040117.25865-19-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 13, 2017 at 09:01:16PM -0700, Stefan Beller wrote:

> +		for (i = 0; i < o->line_buffer_nr; i++);
> +			free((void*)o->line_buffer[i].line);

I haven't looked at the patches yet, but this ";" on the for line is
almost certainly a typo (gcc catches it due to the misleading
indentation of the next line).

-Peff
