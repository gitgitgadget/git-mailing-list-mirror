Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C00BC433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 20:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20DDB64DA1
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 20:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhBRT7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:59:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:38030 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230283AbhBRT5c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 14:57:32 -0500
Received: (qmail 28539 invoked by uid 109); 18 Feb 2021 19:56:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Feb 2021 19:56:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23910 invoked by uid 111); 18 Feb 2021 19:56:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Feb 2021 14:56:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Feb 2021 14:56:50 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 09/10] fsck.c: give "FOREACH_MSG_ID" a more specific
 name
Message-ID: <YC7GgoVre3hFF1Se@coredump.intra.peff.net>
References: <20210217194246.25342-1-avarab@gmail.com>
 <20210218105840.11989-10-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210218105840.11989-10-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 18, 2021 at 11:58:39AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Rename the FOREACH_MSG_ID macro to FOREACH_FSCK_MSG_ID in preparation
> for moving it over to fsck.h. It's good convention to name macros
> in *.h files in such a way as to clearly not clash with any other
> names in other files.

The patch to move it is not in this v2 of the series, so arguably this
is less interesting. However, I think the resulting code is equally or
more readable, so I don't mind it standing on its own.

-Peff
