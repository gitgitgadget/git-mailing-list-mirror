Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC71C12002
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C780613D0
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhGQCG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 22:06:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:52548 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230176AbhGQCG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 22:06:26 -0400
Received: (qmail 22552 invoked by uid 109); 17 Jul 2021 02:03:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Jul 2021 02:03:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16345 invoked by uid 111); 17 Jul 2021 02:03:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 22:03:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 22:03:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 02/11] refs/files: remove unused REF_DELETING in
 lock_ref_oid_basic()
Message-ID: <YPI6cVCmvBDwyubT@coredump.intra.peff.net>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
 <patch-02.11-033c0cec33d-20210716T140631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-02.11-033c0cec33d-20210716T140631Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 04:12:58PM +0200, Ævar Arnfjörð Bjarmason wrote:

> The lock_ref_oid_basic() function has gradually been replaced by use
> of the file transaction API, there are only 4 remaining callers of
> it.

Should this be "ref transaction API"? Ditto in the next patch.

Other than that small nit, the both look like very nice cleanups.

-Peff
