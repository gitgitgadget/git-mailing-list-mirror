Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F288CC4332D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 06:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC15B20774
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 06:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgCVGIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 02:08:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:46834 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725881AbgCVGIB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 02:08:01 -0400
Received: (qmail 23803 invoked by uid 109); 22 Mar 2020 06:08:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Mar 2020 06:08:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29868 invoked by uid 111); 22 Mar 2020 06:17:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Mar 2020 02:17:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Mar 2020 02:08:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
Subject: Re: [PATCH v2 0/8] fix test failure with busybox
Message-ID: <20200322060800.GE578498@coredump.intra.peff.net>
References: <cover.1584838148.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1584838148.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 07:55:09AM +0700, Đoàn Trần Công Danh wrote:

> Đoàn Trần Công Danh (8):
>   t4061: use POSIX compliant regex(7)
>   test-lib-functions: test_cmp: eval $GIT_TEST_CMP
>   t5003: drop the subshell in test_lazy_prereq
>   t5003: skip conversion test if unzip -a is unavailable
>   t5616: use rev-parse instead to get HEAD's object_id
>   t7063: drop non-POSIX argument "-ls" from find(1)
>   t4124: fix test for non-compliant diff(1)
>   t5703: feed raw data into test-tool unpack-sideband

These all look OK to me. Thanks for the extra discussion on BRE vs ERE
in the commit message of the first one.

-Peff
