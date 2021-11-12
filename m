Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E3BC433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 19:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4758A6102A
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 19:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhKLTU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 14:20:59 -0500
Received: from mail-02.1984.is ([185.112.145.70]:46358 "EHLO mail-02.1984.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230137AbhKLTU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 14:20:58 -0500
X-Greylist: delayed 2638 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Nov 2021 14:20:58 EST
Received: from localhost
        by mail-02.1984.is with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gilmagno@gilmagno.com>)
        id 1mlbN8-00089o-N5; Fri, 12 Nov 2021 18:33:59 +0000
From:   Gil Magno <gilmagno@gilmagno.com>
To:     git@vger.kernel.org
Cc:     Gil Magno <gilmagno@gilmagno.com>
Subject: [PATCH] gitk: fix information in the key bindings dialog
Date:   Fri, 12 Nov 2021 15:31:17 -0300
Message-Id: <20211112183117.3560-1-gilmagno@gilmagno.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the explaination of what the "b" key does in gitk. It does not
scroll the diff view up one page, but scroll it to previous file.

Signed-off-by: Gil Magno <gilmagno@gilmagno.com>
---
 gitk-git/gitk | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 23d9dd1fe0..6bf3c4d6bb 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3106,7 +3106,7 @@ proc keys {} {
 [mc "<%s-PageDown>	Scroll commit list down one page" $M1T]
 [mc "<Shift-Up>	Find backwards (upwards, later commits)"]
 [mc "<Shift-Down>	Find forwards (downwards, earlier commits)"]
-[mc "<Delete>, b	Scroll diff view up one page"]
+[mc "<Delete>	Scroll diff view up one page"]
 [mc "<Backspace>	Scroll diff view up one page"]
 [mc "<Space>		Scroll diff view down one page"]
 [mc "u		Scroll diff view up 18 lines"]
@@ -3118,6 +3118,7 @@ proc keys {} {
 [mc "/		Focus the search box"]
 [mc "?		Move to previous find hit"]
 [mc "f		Scroll diff view to next file"]
+[mc "b		Scroll diff view to previous file"]
 [mc "<%s-S>		Search for next hit in diff view" $M1T]
 [mc "<%s-R>		Search for previous hit in diff view" $M1T]
 [mc "<%s-KP+>	Increase font size" $M1T]
-- 
2.20.1

