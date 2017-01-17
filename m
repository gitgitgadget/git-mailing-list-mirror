Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7508D20756
	for <e@80x24.org>; Tue, 17 Jan 2017 20:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751221AbdAQUqr (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 15:46:47 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34552 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbdAQUqq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 15:46:46 -0500
Received: by mail-pf0-f182.google.com with SMTP id e4so26127109pfg.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 12:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=svLUsdNLo9KEoJaNOa037UfpFRwlO+xczA6nX+gIMYo=;
        b=tFVzn0F1FOKXJ13u0yYxidYyKTo+zVdTM75SX6b3IMDOvz3n+v8N6tKcpQw1EkFHZt
         a/P+h5vKYeFhJDn2fzSIxPS7BxDLXkzTU1UoV+IDujY4zVAD27y8Stp4qphxApOL8jz4
         UGfSduyyhGjSqzJdBTK4c8dyFzwXzllBu177BYsuk4a5jfTmHzoqMH6ygrEtnyt0i2or
         ApPoItZ/60g9NsjzNrOTN4Q4AaP6KjTdPHiZjK4iDVc2fuudxJIMEFHMOPUYz/x+KQ+O
         egV5MRIZoMmpXFxDDYPZtsJ2gGmZCWm+ealNX9WnmhZTqQA69TcoEgdaBDNq8xL/46bU
         X+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=svLUsdNLo9KEoJaNOa037UfpFRwlO+xczA6nX+gIMYo=;
        b=uMUjvsAwri/4Z66bQuMot8g6hRCGQDM4ngV91sfskE/G8Dl7JqnQXb3my7lHer/Kjg
         Cq/23DJhTIwYhx0rEXvnbTsZ8SHZFdIrnqOAtAvBxyjG7EqeTft8MPetJMrMyeAVmHGs
         gIxXhs/1Uqy1Pa8BxrsR9S7ZXeFocattmaStBdH60pd+hAjJMXm1wTuZmSJ14mH81ZeU
         q6/b9g3AK2+GVOg+qxIbq6yWIYU6L+42moYB3T8ARxHZV14qMyPbRHwzoB+OED5fu4D6
         AQaVKPMucEU00FwKlvImfexG44PcvFCKhmTXDTkm3S/6M1ByDX+XvDLfAtXUWm43kyj+
         lJSw==
X-Gm-Message-State: AIkVDXJQb5+jmZ2yvWdluHaAagKf08AleMEKRCPYSMCuC1USJLg6zeSq8cj3pbauLmm8Qqsr
X-Received: by 10.98.31.18 with SMTP id f18mr45595655pff.36.1484686005498;
        Tue, 17 Jan 2017 12:46:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:871:ca27:8566:e7e])
        by smtp.gmail.com with ESMTPSA id c64sm57842757pfa.91.2017.01.17.12.46.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 17 Jan 2017 12:46:44 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] document index_name_pos
Date:   Tue, 17 Jan 2017 12:46:42 -0800
Message-Id: <20170117204642.31514-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.297.g298debce27
In-Reply-To: <xmqqpojle85c.fsf@gitster.mtv.corp.google.com>
References: <xmqqpojle85c.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

> These placeholders are meant to encourage those people who dove into
> the code to update it, so from that point of view, I think removing
> it is backwards.

Yes, I am currently understanding and writing up documentation for
index_name_pos. If I recall the latest discussion where we want to have
documentation, I think a quorum favored documentation in the header itself,
c.f. strbuf.h, string-list.h for the most desired state. (Although we do have
Documentation/technical/api-string-list.txt as well ...)

So maybe starting like this?

Thanks,
Stefan

 cache.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/cache.h b/cache.h
index 1b67f078dd..e168e4e073 100644
--- a/cache.h
+++ b/cache.h
@@ -575,7 +575,20 @@ extern int verify_path(const char *path);
 extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
 extern void adjust_dirname_case(struct index_state *istate, char *name);
 extern struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
+
+/*
+ * Searches for an entry defined by name and namelen in the given index.
+ * If the return value is positive (including 0) it is the position of an
+ * exact match. If the return value is negative, the negated value minus 1 is the
+ * position where the entry would be inserted.
+ * Example: In the current index we have the files a,c,d:
+ * index_name_pos(&index, "a", 1) ->  0
+ * index_name_pos(&index, "b", 1) -> -1
+ * index_name_pos(&index, "c", 1) ->  1
+ * index_name_pos(&index, "d", 1) ->  2
+ */
 extern int index_name_pos(const struct index_state *, const char *name, int namelen);
+
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
-- 
2.11.0.297.g298debce27

