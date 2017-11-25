Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90EC920954
	for <e@80x24.org>; Sat, 25 Nov 2017 17:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbdKYRds (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 12:33:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61219 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751591AbdKYRds (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 12:33:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30853C210E;
        Sat, 25 Nov 2017 12:33:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=x5T5lssrK1VRhwD/i7gDFLcrUyo
        =; b=MVb2JU9PeLH0s7xVZ0oFGS4UazLsmQvdWlsuJCEhv36y2oOIWM9brp5D2Yj
        KA7Y8J53kBRKZr2d3WAonzFSWhKDA/ohmpykp2yuq/sbL7z28EBRhDTadTcB/AoY
        n70z0B/65OiTcDX2vH+1rn6tMH7TjFLkgQ+Gui5ghKbNw2d8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id; q=dns; s=sasl; b=qljSqntAiOxoJuQxmpXpi
        I64xMeq+tLpF+txgXk03ztiV+HU8UsWKBE/s1F9JFk2B00Dhu/1pVSvbTpb3qHGG
        OYWX4lZJjSvFEYQPb13HFLdkFOZtKcw/CBTG7LAeYZPW6fyrGAVF5p/gIfZ8P+GR
        ealnDUOiiG4GmfG48BeVfI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2735DC210D;
        Sat, 25 Nov 2017 12:33:47 -0500 (EST)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.94.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 922FEC210C;
        Sat, 25 Nov 2017 12:33:46 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] RelNotes: minor typo fixes in 2.15.1 draft
Date:   Sat, 25 Nov 2017 12:33:45 -0500
Message-Id: <20171125173345.17488-1-tmz@pobox.com>
X-Mailer: git-send-email 2.15.0
X-Pobox-Relay-ID: CA7E3682-D206-11E7-B5FB-8EF31968708C-09356542!pb-smtp1.pobox.com
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

