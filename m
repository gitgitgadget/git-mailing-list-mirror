Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C00C7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 04:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjFLEG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 00:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFLEGy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 00:06:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E629C
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 21:06:52 -0700 (PDT)
Received: (qmail 24927 invoked by uid 109); 12 Jun 2023 04:06:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jun 2023 04:06:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11873 invoked by uid 111); 12 Jun 2023 04:06:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Jun 2023 00:06:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Jun 2023 00:06:51 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: tests: mark as passing with SANITIZE=leak
Message-ID: <20230612040651.GK306352@coredump.intra.peff.net>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 11, 2023 at 08:29:09PM +0200, Rubén Justo wrote:

> Each of the commits (except 11/11) fixes a leak.  They have no
> dependencies on each other.  As a result, they can be reordered.

Thanks for a pleasant read. I think each case is correct, though I left
a few minor comments. Some of them are things I think are worth
including in a re-roll. Others are things that we _could_ go further to
refactor for clarity, but I am OK if you want to stay focused on the
minimal leak-fixes.

-Peff
