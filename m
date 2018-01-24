Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AD9F1FADF
	for <e@80x24.org>; Wed, 24 Jan 2018 12:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933500AbeAXMet (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 07:34:49 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:18945 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933444AbeAXMes (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 07:34:48 -0500
Received: from lindisfarne.localdomain ([92.22.6.159])
        by smtp.talktalk.net with SMTP
        id eKGDelQgfmITaeKGNe9R5h; Wed, 24 Jan 2018 12:34:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1516797287;
        bh=uWVtuLchMSsMXr3cOUqb/wDrtrBCvMDXNzdxChQXoP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=lF4l4bbzgpqwKNubANM/77R9eIChPjIEMOn38wey10RtR0C0sX9FGyq1Qwa31/kVF
         p1bGfJlf5xa5T+Pl22oDMpj2ROeGAw1FwlbH6S/caSHiMiExSqHNOquAtbHy5Sg8iN
         wu8TOdce01MxZJ0Ux9N+D1bS3pU8aYpeJou1L7Hw=
X-Originating-IP: [92.22.6.159]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=zHCrIP3pJrCm+L4FAUKT3Q==:117
 a=zHCrIP3pJrCm+L4FAUKT3Q==:17 a=evINK-nbAAAA:8 a=wGzPIfb9dUZNL1OS7kUA:9
 a=W2Py5Ku_vR-dFUrH:21 a=_89uDXUPH7OW83Sw:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 1/3] t7505: style fixes
Date:   Wed, 24 Jan 2018 12:34:20 +0000
Message-Id: <20180124123422.10637-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180124123422.10637-1-phillip.wood@talktalk.net>
References: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
 <20180124123422.10637-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfKE3F3m0UwNxDODH5H6+WzMFvE5y/DShFgYiNSNYnKFkjGXCunH8Xlny+SkFTdg5I+3f9bxNAZrP4xE2GqKMqSq7o/I/GO/UmiNea1f0qllH6+kvsTys
 Whe1s2qtC0976RW5+cjwGlM9BFuS2SzG2+1EirSI9K+wTEBwdGNW69rYrv7f0KWP8ofnLVEZoxCn4cUeC80lHFUhqMn381i1kw/3rYc5ys73CJNk9kBsLI+r
 ykr8BK68ZKLmTBl/prXKfgpI89x6eNyxp7GMX/Lvwqsn7G3VyOhuyWnQ4WpYQ30pmxKmHcu6uEyCGVgcmnbt4uwBIWJMmcMVi04DHbZgKr6sLYRL+Bwzkg7b
 1oWiimQlZEXWPLxpmdsDB6UnpFIWnjIkjEFfcwLw3GFFZWyQDHx4KAv5gvIN5urpinRFLlf4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Fix the indentation and style of the hook script in preparation for
further changes.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t7505-prepare-commit-msg-hook.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index b13f72975ecce17887c4c8275c6935d78d4b09a0..cef709555eb9c3e3dec0016909a17ce7cf32650a 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -31,15 +31,17 @@ mkdir -p "$HOOKDIR"
 echo "#!$SHELL_PATH" > "$HOOK"
 cat >> "$HOOK" <<'EOF'
 
-if test "$2" = commit; then
-  source=$(git rev-parse "$3")
+if test "$2" = commit
+then
+	source=$(git rev-parse "$3")
 else
-  source=${2-default}
+	source=${2-default}
 fi
-if test "$GIT_EDITOR" = :; then
-  sed -e "1s/.*/$source (no editor)/" "$1" > msg.tmp
+if test "$GIT_EDITOR" = :
+then
+	sed -e "1s/.*/$source (no editor)/" "$1" >msg.tmp
 else
-  sed -e "1s/.*/$source/" "$1" > msg.tmp
+	sed -e "1s/.*/$source/" "$1" >msg.tmp
 fi
 mv msg.tmp "$1"
 exit 0
-- 
2.15.1

