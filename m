Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CB2C433E0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 23:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C9120722
	for <git@archiver.kernel.org>; Sat, 30 May 2020 23:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgE3XNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 19:13:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:32782 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729314AbgE3XNw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 19:13:52 -0400
Received: (qmail 14236 invoked by uid 109); 30 May 2020 23:13:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 30 May 2020 23:13:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3291 invoked by uid 111); 30 May 2020 23:13:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 30 May 2020 19:13:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 30 May 2020 19:13:51 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3] fast-import: add new --date-format=raw-permissive
 format
Message-ID: <20200530231351.GA1920649@coredump.intra.peff.net>
References: <pull.795.v2.git.git.1590698437607.gitgitgadget@gmail.com>
 <pull.795.v3.git.git.1590870357549.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.795.v3.git.git.1590870357549.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 30, 2020 at 08:25:57PM +0000, Elijah Newren via GitGitGadget wrote:

>     fast-import: accept invalid timezones so we can import existing repos
>     
>     Changes since v2:

Thanks, this version looks good to me.

-Peff
