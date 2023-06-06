Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F935C7EE24
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 01:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjFFB5n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 21:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjFFB5m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 21:57:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DEE10D
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 18:57:40 -0700 (PDT)
Received: (qmail 23943 invoked by uid 109); 6 Jun 2023 01:57:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Jun 2023 01:57:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1938 invoked by uid 111); 6 Jun 2023 01:57:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Jun 2023 21:57:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Jun 2023 21:57:39 -0400
From:   Jeff King <peff@peff.net>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/2] notes: update documentation for
 `use_default_notes`
Message-ID: <20230606015739.GB89456@coredump.intra.peff.net>
References: <b3829cb0d1e36a5ebb44a315fe32037f2a3f6c7a.1685526558.git.code@khaugsbakk.name>
 <cover.1685958731.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1685958731.git.code@khaugsbakk.name>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 05, 2023 at 12:05:21PM +0200, Kristoffer Haugsbakk wrote:

> While I was working on [1] I found that the doc for the struct
> `display_notes_opt` hadn’t been updated when one of the members were
> renamed. I chose to post a separate patch/series.
> 
> [1] https://lore.kernel.org/git/cover.1685441207.git.code@khaugsbakk.name
> 
> § Changes in v4 by patch
> 
> • 2: Document the struct members directly

Thanks, this version looks great to me!

-Peff
