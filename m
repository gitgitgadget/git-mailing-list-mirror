Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CCCC43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 06:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiGLG6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 02:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGLG6i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 02:58:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C50611145
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 23:58:36 -0700 (PDT)
Received: (qmail 10456 invoked by uid 109); 12 Jul 2022 06:58:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jul 2022 06:58:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27694 invoked by uid 111); 12 Jul 2022 06:58:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jul 2022 02:58:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jul 2022 02:58:35 -0400
From:   Jeff King <peff@peff.net>
To:     Han Xin <hanxin.hx@bytedance.com>
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, git@grubix.eu, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>, ps@pks.im
Subject: Re: [PATCH v5 0/1] no lazy fetch in lookup_commit_in_graph()
Message-ID: <Ys0bmytqz9nra+AB@coredump.intra.peff.net>
References: <cover.1656593279.git.hanxin.hx@bytedance.com>
 <cover.1657604799.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1657604799.git.hanxin.hx@bytedance.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 12, 2022 at 02:50:46PM +0800, Han Xin wrote:

> Changes since v4:
> 
> * Remove run_with_limited_processses() as it can be catched by CI
>   settings and developer workstation. Keeping it will make a trouble
>   when there are too many prcesses or stress is used.

Your v4 is already in 'next', so I think rather than replacing the
patch, we'd want a commit on top to remove run_with_limited_processes().

-Peff
