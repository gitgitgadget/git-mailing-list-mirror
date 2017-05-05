Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D722A207D6
	for <e@80x24.org>; Fri,  5 May 2017 05:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbdEEF1l (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 01:27:41 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33339 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752531AbdEEF1i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 01:27:38 -0400
Received: by mail-io0-f196.google.com with SMTP id l196so8640489ioe.0
        for <git@vger.kernel.org>; Thu, 04 May 2017 22:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lxXg2NyVtflstO206uJI4aEOUGvQYXOZX3umJbKP0cE=;
        b=PoZ0aOXqmUnWNHJtZhGccxVpt0k+OJBRXy31VPHtBCLlU7MRj03XPt9mz2tkqXsxvs
         qLCvEACFRGH0NhRS8ws7XcMd0UwzdZ3vfJkaWt+grKJlnx2lhgJV3/7uEP4+YHMpdgv/
         esg9EiuMwOFsk/xZJdzU913QoUO1qmO++CMaWfgkHl0Ma7mfnti7Kiep2WbKwNDnIs3s
         YKNB8BfcLMAnHJ56HAFfyD5z/bNSvYLrJFV96zbGvv1axTkyglbqPsTf2ilAtbDDzKLM
         IB0hUyGiXKrOl9F2auNbZEHuAZHkWrL9XbnowmQRpd4ct6UI8n3Nu7sWDu8810prUl1i
         oF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lxXg2NyVtflstO206uJI4aEOUGvQYXOZX3umJbKP0cE=;
        b=aCckoC7uRedPqFKCpAKAUb0L0LOxDrcAUPK6Cxx0OOtXg9gCTTfvr0nMwUAk6ZPyq+
         4TJrIQdIqRfL532ztaamE7e0ZkFlv3RYgbK/75o+EWdg9mWE6zhKcWl9yYwT813B3MET
         vXx5U2EPzQ3WKpvWGBShn//pq36u6Z6fWFxxQBO/tOaj5gO9Q4aN19cqeKiB2AKnUWw6
         gucIE+z1/Gg77ud6uGbr05zoAzTcIwbbeRSFA97ys24ZT6s7VPhgVceg83hc2z/tQlvl
         sqSClJ9LltMo8vIMcKRaa1iMuZ/R/OtU0r14Oaea8C5BFxSDQMoAkuWgDJz3LRxJdg0B
         E6Tw==
X-Gm-Message-State: AN3rC/6+tpn12qB/PXQLxnAvU/t70Tjo9yFZgXBeKfMp5XGboPRyOx9v
        i0Df7Dfmu8RFxg==
X-Received: by 10.202.190.84 with SMTP id o81mr3746290oif.116.1493962057772;
        Thu, 04 May 2017 22:27:37 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 2sm2179586ota.46.2017.05.04.22.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 22:27:36 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH 03/10] Add some missing definitions to header files
Date:   Fri,  5 May 2017 00:27:22 -0500
Message-Id: <20170505052729.7576-4-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170505052729.7576-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 object.h    | 2 ++
 pathspec.h  | 4 ++++
 refs.h      | 3 +++
 tree-walk.h | 2 ++
 4 files changed, 11 insertions(+)

diff --git a/object.h b/object.h
index f52957d..9737582 100644
--- a/object.h
+++ b/object.h
@@ -1,6 +1,8 @@
 #ifndef OBJECT_H
 #define OBJECT_H
 
+#include "cache.h"
+
 struct object_list {
 	struct object *item;
 	struct object_list *next;
diff --git a/pathspec.h b/pathspec.h
index 55e9769..ea18e24 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -1,6 +1,10 @@
 #ifndef PATHSPEC_H
 #define PATHSPEC_H
 
+#include <stddef.h>
+#include <string.h>
+#include <strings.h>
+
 /* Pathspec magic */
 #define PATHSPEC_FROMTOP	(1<<0)
 #define PATHSPEC_MAXDEPTH	(1<<1)
diff --git a/refs.h b/refs.h
index 07cf4cd..e9d19fd 100644
--- a/refs.h
+++ b/refs.h
@@ -1,6 +1,9 @@
 #ifndef REFS_H
 #define REFS_H
 
+#include <stdio.h>
+#include <string.h>
+
 struct object_id;
 struct ref_store;
 struct strbuf;
diff --git a/tree-walk.h b/tree-walk.h
index 68bb78b..8b0fccd 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -1,6 +1,8 @@
 #ifndef TREE_WALK_H
 #define TREE_WALK_H
 
+struct strbuf;
+
 struct name_entry {
 	const struct object_id *oid;
 	const char *path;
-- 
2.9.3

