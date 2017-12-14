Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BCC81F407
	for <e@80x24.org>; Thu, 14 Dec 2017 02:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbdLNCmv (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 21:42:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58606 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751101AbdLNCmv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 21:42:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32D09BCFFF;
        Wed, 13 Dec 2017 21:42:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=NKCt0tYA5fejeAnMf9rbBy8AikU
        =; b=pEnG7lD7ZzNK1dMNGHVJASJ8tRMPJxYzwZfBEnetTwmWIIaciOhKG61Mr5k
        TnrIr5H/tMT9ViXoE/HYDoWPsPjID4Lru0pw9GcCxF0Y6YNtPMpnAYlALWBogE3j
        ER9FMOUgeG8E62iVzZKBsp2koKsdtHKFqFhDvAe4UWhqDAe0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id; q=dns; s=sasl; b=eUIROBW4rogW5dW3xlW6e
        7kiXeKs9a+sol6hbk3vGHMG8gv8LJycw1dGmfkyohdnwETyxmvkjHgHZs1qgiAoP
        LCuFKZ6I3yxuYKKczR7VtCqQPUH89f/ycXompohsTt5EQ8UJSTIZ2CO8JtLKJCwD
        nuAFuAxENbijBJ5c8hiWjU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 291DBBCFFE;
        Wed, 13 Dec 2017 21:42:48 -0500 (EST)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.94.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 609C3BCFFD;
        Wed, 13 Dec 2017 21:42:47 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] RelNotes: minor typo fixes in 2.16.0 draft
Date:   Wed, 13 Dec 2017 21:42:44 -0500
Message-Id: <20171214024244.29714-1-tmz@pobox.com>
X-Mailer: git-send-email 2.15.1
X-Pobox-Relay-ID: 783AF8C6-E078-11E7-A174-8EF31968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/RelNotes/2.16.0.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.16.0.txt b/Documentation/RelNotes/2.16.0.txt
index 3eeeb83674..f7fca7123f 100644
--- a/Documentation/RelNotes/2.16.0.txt
+++ b/Documentation/RelNotes/2.16.0.txt
@@ -304,10 +304,10 @@ Fixes since v2.15
  * "git branch --set-upstream" has been deprecated and (sort of)
    removed, as "--set-upstream-to" is the preferred one these days.
    The documentation still had "--set-upstream" listed on its
-   synopsys section, which has been corrected.
+   synopsis section, which has been corrected.
    (merge a060f3d3d8 tz/branch-doc-remove-set-upstream later to maint).
 
- * Internaly we use 0{40} as a placeholder object name to signal the
+ * Internally we use 0{40} as a placeholder object name to signal the
    codepath that there is no such object (e.g. the fast-forward check
    while "git fetch" stores a new remote-tracking ref says "we know
    there is no 'old' thing pointed at by the ref, as we are creating
-- 
2.15.1

