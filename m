Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19060C77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 08:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjDLIA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 04:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLIAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 04:00:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304C55FDC
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 01:00:21 -0700 (PDT)
Received: (qmail 18508 invoked by uid 109); 12 Apr 2023 08:00:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Apr 2023 08:00:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17694 invoked by uid 111); 12 Apr 2023 08:00:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Apr 2023 04:00:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Apr 2023 04:00:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: criteria for linking to binaries from git-scm.com?
Message-ID: <20230412080019.GA2172825@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's an interesting question raised in an issue in the git-scm.com
repo that I think would benefit from input from community folks here.

The link is:

  https://github.com/git/git-scm.com/issues/1774#issuecomment-1504829495

but the tl;dr is:

  From a supply chain perspective, what are our criteria for linking to
  a third party's pre-built binaries from git-scm.com?

Obviously we don't want to point people at malicious or trojaned
binaries. But we probably also bear some responsibility for making sure
the third party has reasonable security practices themselves.

I don't have a strong opinion myself, and this is probably a giant can
of worms. But it seemed like the kind of thing that should be getting
attention from the greater community, and not just languishing in that
repo (both to set a policy for new requests, but also maybe to evaluate
existing binaries we point to).

-Peff
