Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADE5C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 09:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136FC61039
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 09:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239925AbhJ0JI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 05:08:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:47828 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241157AbhJ0JIz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 05:08:55 -0400
Received: (qmail 12929 invoked by uid 109); 27 Oct 2021 09:06:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Oct 2021 09:06:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20335 invoked by uid 111); 27 Oct 2021 09:06:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Oct 2021 05:06:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Oct 2021 05:06:28 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix "commit-msg" hook unexpectedly called for "git
 pull --no-verify"
Message-ID: <YXkWlKVVUM9guAhe@coredump.intra.peff.net>
References: <YXfwanz3MynCLDmn@pflmari>
 <YXhwGQOTfD+ypbo8@coredump.intra.peff.net>
 <YXjzGzcXS/zPgk0W@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXjzGzcXS/zPgk0W@pflmari>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 27, 2021 at 08:35:07AM +0200, Alex Riesen wrote:

> The option is incorrectly translated to "--no-verify-signatures",
> which causes the unexpected effect of the hook being called.
> And an even more unexpected effect of disabling verification
> of signatures.
> 
> The manual page describes the option to behave same as the similarly
> named option of "git merge", which seems to be the original intention
> of this option in the "pull" command.

Thanks, this looks good to me.

-Peff
