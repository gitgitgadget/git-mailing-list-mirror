Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687A0C4332F
	for <git@archiver.kernel.org>; Mon, 26 Dec 2022 16:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiLZQzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Dec 2022 11:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbiLZQza (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2022 11:55:30 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4335B6405
        for <git@vger.kernel.org>; Mon, 26 Dec 2022 08:55:00 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyleam.com; s=key1;
        t=1672073698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JJ16fJa/YLzhKEOENupZ+ClV6i9V//ja8EndSWqYtfA=;
        b=lTuc3yy9wOUsfOWXj5Q3jCXxVByteOkgK5MLQavDIJ/EGQs3Llo4xYPl1prGIxtTA7oWyM
        EgQ+oQuOJ8WiPs8EGXMOG/8yQdwFQc8bz7IEpZyjZsCT/bOqOZLOmpUlsCR3OLATcHSTOm
        iBjcQ4XkGLMm7Jl3OI0GkMbKW2tHOOBzcY4tsI31hTTf2aKMVSjAYcNIzvh9LWSY+AibpC
        DKoVOWo/9x2c3NPjNNa8laHZLUSRdSuY14ucHI6fymGS6Fa8RmSFkPFkpIRL3av4mn1dEO
        TZlep9GrFns7QOWp2tTU40JlzgkeQoUysKKaO5ls937Cd2wqD7bRfZrXOuaAZw==
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Subject: [PATCH] doc/git-branch: fix --force description typo
Date:   Mon, 26 Dec 2022 11:54:41 -0500
Message-Id: <20221226165441.126625-1-kyle@kyleam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the description of --force to use '<start-point>' rather than
'<startpoint>' to match the spelling used everywhere else in the
git-branch documentation.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 Documentation/git-branch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 12c5f84e3b..aa2f78c4c2 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -116,7 +116,7 @@ OPTIONS
 
 -f::
 --force::
-	Reset <branchname> to <startpoint>, even if <branchname> exists
+	Reset <branchname> to <start-point>, even if <branchname> exists
 	already. Without `-f`, 'git branch' refuses to change an existing branch.
 	In combination with `-d` (or `--delete`), allow deleting the
 	branch irrespective of its merged status, or whether it even
-- 
2.38.1

