Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A847C433EF
	for <git@archiver.kernel.org>; Sun, 24 Apr 2022 11:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbiDXLbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Apr 2022 07:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiDXLbj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Apr 2022 07:31:39 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387314D271
        for <git@vger.kernel.org>; Sun, 24 Apr 2022 04:28:38 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laumann.xyz; s=key1;
        t=1650799716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+f3dr/XK+ziCwRE5oXWMUXI7xIefKYjy/owceffRy5M=;
        b=z6xH3D1t74Px7BnSiMXn0vr9f0XZX4JdR2ZudWcqE8m93AXTzbLIu63meKNhvaZH3/25Xx
        wSQIExpqJIJ+2aSi3+ydg8q1F+73mHjzutfNMWhz/k0dGsoZQ1IQ0puA5DGFBc/0tY3I22
        hQORqyMUZJGpKS/Usnq1qTaAuFa9doV1Gx2Qd56fNz2tmHEW1i2t7D0PI5JxSgLqrMpZ92
        mF/gFtfxOy0dy3NxjLIo8kzVV1XgT7/NtZQH2XXUM+t2GhlLO1Qc0jPa5YpC81O6CLsxhV
        +7qS+k73K7OzNmVOoaYedKK48zhvOz1318DiV8k6q+6PwVlk+mxRY4ICRKieSA==
From:   Thomas Bracht Laumann Jespersen <t@laumann.xyz>
To:     git@vger.kernel.org
Cc:     Thomas Bracht Laumann Jespersen <t@laumann.xyz>
Subject: [PATCH] Documentation: git-log: Capitalize references to sections
Date:   Sun, 24 Apr 2022 13:28:26 +0200
Message-Id: <20220424112826.6577-1-t@laumann.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: laumann.xyz
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Minor inconsistency, in git-log(1) there's another reference to the
PRETTY FORMATS section.

Signed-off-by: Thomas Bracht Laumann Jespersen <t@laumann.xyz>
---
 Documentation/git-log.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 20e87cecf4..49620710dc 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -191,11 +191,11 @@ See linkgit:git-config[1] for core variables and linkgit:git-diff[1]
 for settings related to diff generation.
 
 format.pretty::
-	Default for the `--format` option.  (See 'Pretty Formats' above.)
+	Default for the `--format` option.  (See 'PRETTY FORMATS' above.)
 	Defaults to `medium`.
 
 i18n.logOutputEncoding::
-	Encoding to use when displaying logs.  (See 'Discussion' above.)
+	Encoding to use when displaying logs.  (See 'DISCUSSION' above.)
 	Defaults to the value of `i18n.commitEncoding` if set, and UTF-8
 	otherwise.
 
-- 
2.35.1

