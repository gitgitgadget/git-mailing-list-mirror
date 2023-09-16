Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906E2CD37B5
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 06:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbjIPGQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 02:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbjIPGQL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 02:16:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7527BA2
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 23:16:05 -0700 (PDT)
Received: (qmail 1829 invoked by uid 109); 16 Sep 2023 06:16:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 Sep 2023 06:16:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9287 invoked by uid 111); 16 Sep 2023 06:16:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 16 Sep 2023 02:16:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 16 Sep 2023 02:16:04 -0400
From:   Jeff King <peff@peff.net>
To:     Evan Gates <evan.gates@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-config: fix misworded --type=path explanation
Message-ID: <20230916061604.GA628367@coredump.intra.peff.net>
References: <20230915202610.21206-1-evan.gates@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230915202610.21206-1-evan.gates@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2023 at 02:24:59PM -0600, Evan Gates wrote:

> When `--type=<type>` was added as a prefered alias for `--<type>`
> the explanation for the path type was reworded.  Whereas the previous
> explanation said "expand a leading `~`" this was changed to "adding a
> leading `~`".  Change "adding" to "expanding" to correctly explain the
> canonicalization.

Yeah, the sentence as-is does not make any sense. Your suggested wording
looks good to me. Thanks.

-Peff
