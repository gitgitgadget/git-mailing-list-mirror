Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A54EC8750
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 18:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjIGSyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjIGSyh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 14:54:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D70C9D
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 11:54:12 -0700 (PDT)
Received: (qmail 26967 invoked by uid 109); 7 Sep 2023 07:47:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Sep 2023 07:47:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24315 invoked by uid 111); 7 Sep 2023 07:47:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Sep 2023 03:47:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Sep 2023 03:47:13 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] ci: allow branch selection through "vars"
Message-ID: <20230907074713.GA1260471@coredump.intra.peff.net>
References: <20230830194919.GA1709446@coredump.intra.peff.net>
 <20230830195113.GA1709824@coredump.intra.peff.net>
 <d000f469-2b7d-e037-c92e-013034490461@gmx.de>
 <20230905073013.GI199565@coredump.intra.peff.net>
 <44a5d2d4-a6f1-7259-504e-269ee389c8ea@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44a5d2d4-a6f1-7259-504e-269ee389c8ea@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2023 at 12:51:14PM +0200, Johannes Schindelin wrote:

> Thank you for asking my opinion. The `[no ci]` support described in
> https://github.blog/changelog/2021-02-08-github-actions-skip-pull-request-and-push-workflows-with-skip-ci/
> solves the problem adequately and with a lot less complexity than the
> current or the `vars.`-based solution. In my opinion.

Unfortunately that doesn't work well for the uses cases allow-ref was
meant to support, for the reasons given in e76eec3554 (ci: allow
per-branch config for GitHub Actions, 2020-05-07).

-Peff
