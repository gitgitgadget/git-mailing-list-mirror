Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0753C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF65611C0
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbhKFSwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 14:52:38 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:1640 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234863AbhKFSwg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 14:52:36 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        by smtp4-g21.free.fr (Postfix) with ESMTP id ECE8419F593;
        Sat,  6 Nov 2021 19:49:50 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/10] doc: git-http-push: describe the refs as pattern pairs
Date:   Sat,  6 Nov 2021 19:48:56 +0100
Message-Id: <20211106184858.11500-9-jn.avila@free.fr>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211106184858.11500-1-jn.avila@free.fr>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
 <20211106184858.11500-1-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Each member of the pair is explained but they are not defined
beforehand.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-http-push.txt | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 78f2bb7552..7c6a6dd7f6 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -63,16 +63,15 @@ of such patterns separated by a colon ":" (this means that a ref name
 cannot have a colon in it).  A single pattern '<name>' is just a
 shorthand for '<name>:<name>'.
 
-Each pattern pair consists of the source side (before the colon)
-and the destination side (after the colon).  The ref to be
-pushed is determined by finding a match that matches the source
-side, and where it is pushed is determined by using the
-destination side.
+Each pattern pair '<src>:<dst>' consists of the source side (before
+the colon) and the destination side (after the colon).  The ref to be
+pushed is determined by finding a match that matches the source side,
+and where it is pushed is determined by using the destination side.
 
- - It is an error if <src> does not match exactly one of the
+ - It is an error if '<src>' does not match exactly one of the
    local refs.
 
- - If <dst> does not match any remote ref, either
+ - If '<dst>' does not match any remote ref, either
 
    * it has to start with "refs/"; <dst> is used as the
      destination literally in this case.
-- 
2.33.1

