Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D48420954
	for <e@80x24.org>; Sat, 25 Nov 2017 17:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbdKYRcs (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 12:32:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62900 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751277AbdKYRcr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 12:32:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 362C0A7BD7;
        Sat, 25 Nov 2017 12:32:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=x5T5lssrK1VRhwD/i7gDFLcrUyo
        =; b=Jtc+CB4d163zxMWQQEMt5eRLl2LfkirE3mhb+U2dF+2FvKhGSsHGV2xQBkL
        yFppEs6PEwBPj8qnaeGWItdTotv6rLnMxz1c1L0U8hLsHGKlSXExvoNKR1ioc+rO
        4G0uSbpTM8IcVPfZJ+gBbGHDh7I5jbLc+Vt1sHXMpM+2zp5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id; q=dns; s=sasl; b=Xrl0/rLybrguI2hb0lCpb
        mPIyPF2dDsyHyh6Pa/iHWVJTUvoOMn21hRD2goCYhraVRzVXb9FW77wQN5vdUDtj
        2822t7Cqiyi/gA9ZVDeYGZwhcRh0He4dprDGa6jkrcyXe2D6zdlfU707/EIXTNGg
        s3XNWAq80vpxb6llj/JWGc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E6BFA7BD6;
        Sat, 25 Nov 2017 12:32:42 -0500 (EST)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.94.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90189A7BD5;
        Sat, 25 Nov 2017 12:32:41 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] RelNotes: minor typo fixes in 2.15.1 draft
Date:   Sat, 25 Nov 2017 12:32:40 -0500
Message-Id: <20171125173240.17322-1-tmz@pobox.com>
X-Mailer: git-send-email 2.15.0
X-Pobox-Relay-ID: A3BE7C50-D206-11E7-945E-575F0C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/RelNotes/2.15.1.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RelNotes/2.15.1.txt b/Documentation/RelNotes/2.15.1.txt
index 47f23b56fe..81dd64b4ad 100644
--- a/Documentation/RelNotes/2.15.1.txt
+++ b/Documentation/RelNotes/2.15.1.txt
@@ -13,7 +13,7 @@ Fixes since v2.15
    latter, which has been fixed.
 
  * The experimental "color moved lines differently in diff output"
-   feature was buggy around "ignore whitespace changes" edges, whihch
+   feature was buggy around "ignore whitespace changes" edges, which
    has been corrected.
 
  * Instead of using custom line comparison and hashing functions to
@@ -24,7 +24,7 @@ Fixes since v2.15
    HEAD points at, which have been fixed.
 
  * "git commit", after making a commit, did not check for errors when
-   asking on what branch it made the commit, which has been correted.
+   asking on what branch it made the commit, which has been corrected.
 
  * "git status --ignored -u" did not stop at a working tree of a
    separate project that is embedded in an ignored directory and
@@ -35,7 +35,7 @@ Fixes since v2.15
    --recurse-submodules" has been fixed.
 
  * A recent regression in "git rebase -i" that broke execution of git
-   commands from subdirectories via "exec" insn has been fixed.
+   commands from subdirectories via "exec" instruction has been fixed.
 
  * "git check-ref-format --branch @{-1}" bit a "BUG()" when run
    outside a repository for obvious reasons; clarify the documentation
-- 
2.15.0

