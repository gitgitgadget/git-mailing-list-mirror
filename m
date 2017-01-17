Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2393D20756
	for <e@80x24.org>; Tue, 17 Jan 2017 20:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751156AbdAQUJk (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 15:09:40 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36329 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdAQUJX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 15:09:23 -0500
Received: by mail-pg0-f53.google.com with SMTP id t6so21876021pgt.3
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 12:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XzcNe0qQ48ZSYvEfcDbSbxxewhbgtwNITSEXCj0DNYQ=;
        b=Dq6zDFahY7aC/r4v0hT/APwVzWP4tvSl20aYTxLxH0ljmNWdl5eizDgDcjLlz1ChTG
         jqF0lwFQg8MrMsoiT98XoBpKs4QCq/5Ib2LMPbbFQS703XQ7y2vT+1brsRzXYJHoJaWC
         Fv0Ro3YmwnaIe4Hid9t42EhOjuqFEwbShqK4q67PhBtReEkxDzDuuK8cAeOeSetoulyJ
         OoKO669fnwJ3GALhuVZ3PcB6V7xDHPOV2vuo3LdcN8HRRsaeL9b+smdjYFAB4ComxWyP
         By4V9oh9OKcmUguagSXbwtPenbXs3znv11Io+E7NlBki4+z09GTBo+QZtqmILzJSH/0K
         e1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XzcNe0qQ48ZSYvEfcDbSbxxewhbgtwNITSEXCj0DNYQ=;
        b=UogsjA+vjabAn6vDQqXYpbOT/i3FqmifQJMFPRjESUejikAT67jUYLNV/s6r4/LA01
         r27dF+wLVXOppWqBCD+z32qd20VJgCWYyHVMijQTABRGUjMLRDuTQIQjTAYjvjxNc0My
         6s+t+1/2EUaeHtu1NuaGa1zJuxhOwLasU7Dda/vLUZaQCM5Axc1leGcXtb+rGotVB/vM
         J3XMgkMSGTRpbtz5zyzLH877doIPhn3R7W47C5MbwErz7OrSJ+Hfr/S8rIdSiMVtEWXZ
         HNbn45bbIQ8cwNUJvNGr4Ew2lA1PFpslW6yaeu9Nv0dMpDUgn7yAySPKKmQ3Mp28rCAd
         JMrg==
X-Gm-Message-State: AIkVDXK0iT8w3HuaZNv9t0jhFdr5PvOTUWYCW9+ED6rgK8c3yXLc2bViousesGfEbjZAvHHl
X-Received: by 10.84.224.133 with SMTP id s5mr62060044plj.130.1484683315735;
        Tue, 17 Jan 2017 12:01:55 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:871:ca27:8566:e7e])
        by smtp.gmail.com with ESMTPSA id b69sm48566660pfd.90.2017.01.17.12.01.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 17 Jan 2017 12:01:55 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] documentation: remove unfinished documentation
Date:   Tue, 17 Jan 2017 12:01:47 -0800
Message-Id: <20170117200147.25425-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.297.g298debce27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When looking for documentation for a specific function, you may be tempted
to run

  git -C Documentation grep index_name_pos

only to find the file technical/api-in-core-index.txt, which doesn't
help for understanding the given function. It would be better to not find
these functions in the documentation, such that people directly dive into
the code instead.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

I run into this a couple of times now, so I put this out tentatively.

Thanks,
Stefan

 Documentation/technical/api-in-core-index.txt | 21 ---------------------
 1 file changed, 21 deletions(-)
 delete mode 100644 Documentation/technical/api-in-core-index.txt

diff --git a/Documentation/technical/api-in-core-index.txt b/Documentation/technical/api-in-core-index.txt
deleted file mode 100644
index adbdbf5d75..0000000000
--- a/Documentation/technical/api-in-core-index.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-in-core index API
-=================
-
-Talk about <read-cache.c> and <cache-tree.c>, things like:
-
-* cache -> the_index macros
-* read_index()
-* write_index()
-* ie_match_stat() and ie_modified(); how they are different and when to
-  use which.
-* index_name_pos()
-* remove_index_entry_at()
-* remove_file_from_index()
-* add_file_to_index()
-* add_index_entry()
-* refresh_index()
-* discard_index()
-* cache_tree_invalidate_path()
-* cache_tree_update()
-
-(JC, Linus)
-- 
2.11.0.297.g298debce27

