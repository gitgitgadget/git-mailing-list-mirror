Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCD8EE49A6
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 17:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbjHURH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 13:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbjHURH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 13:07:27 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3806E103
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 10:07:25 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id B8F87241CE;
        Mon, 21 Aug 2023 13:07:21 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qY8N6-QKQ-00; Mon, 21 Aug 2023 19:07:20 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver <linusa@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v4 2/2] git-revert.txt: add discussion
Date:   Mon, 21 Aug 2023 19:07:20 +0200
Message-Id: <20230821170720.577850-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230821170720.577850-1-oswald.buddenhagen@gmx.de>
References: <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
 <20230821170720.577850-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The section is inspired by git-commit.txt.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
v4:
- adjusted summary prefix & payload wording

Cc: Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver <linusa@google.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-revert.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index d2e10d3dce..cbe0208834 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -142,6 +142,16 @@ EXAMPLES
 	changes. The revert only modifies the working tree and the
 	index.
 
+DISCUSSION
+----------
+
+While git creates a basic commit message automatically, it is
+_strongly_ recommended to explain why the original commit is being
+reverted.
+In addition, repeatedly reverting reverts will result in increasingly
+unwieldy subject lines, for example 'Reapply "Reapply "<original subject>""'.
+Please consider rewording these to be shorter and more unique.
+
 CONFIGURATION
 -------------
 
-- 
2.40.0.152.g15d061e6df

