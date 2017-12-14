Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BB2D1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 21:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753863AbdLNVTp (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 16:19:45 -0500
Received: from siwi.pair.com ([209.68.5.199]:48979 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753844AbdLNVTk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 16:19:40 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A17C684517;
        Thu, 14 Dec 2017 16:19:39 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 283B784512;
        Thu, 14 Dec 2017 16:19:39 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v7] fixup: rev-list-options text
Date:   Thu, 14 Dec 2017 21:19:09 +0000
Message-Id: <20171214211909.55868-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171214211909.55868-1-git@jeffhostetler.com>
References: <20171214211909.55868-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/rev-list-options.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 8d8b7f4..b7237b9 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -714,9 +714,9 @@ ifdef::git-rev-list[]
 +
 The form '--filter=blob:none' omits all blobs.
 +
-The form '--filter=blob:limit=<n>[kmg]' omits blobs larger than n bytes
-or units.  n may be zero.  The suffixes k, m, and g can be used to name
-units in KiB, MiB, or GiB.  For example, 'blob:limit=1k' is the same
+The form '--filter=blob:limit=<n>[kmg]' omits blobs larger than n bytes or
+units.  '<n>' may be zero.  The suffixes 'k', 'm', and 'g' can be used to
+name units in KiB, MiB, or GiB.  For example, 'blob:limit=1k' is the same
 as 'blob:limit=1024'.
 +
 The form '--filter=sparse:oid=<blob-ish>' uses a sparse-checkout
@@ -725,7 +725,7 @@ to omit blobs that would not be not required for a sparse checkout on
 the requested refs.
 +
 The form '--filter=sparse:path=<path>' similarly uses a sparse-checkout
-specification contained in <path>.
+specification contained in '<path>'.
 
 --no-filter::
 	Turn off any previous `--filter=` argument.
-- 
2.9.3

