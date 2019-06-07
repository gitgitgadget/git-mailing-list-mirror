Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682BC1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 22:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbfFGW7Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 18:59:25 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:43021 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbfFGW7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 18:59:25 -0400
Received: by mail-pg1-f201.google.com with SMTP id k23so2364990pgh.10
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 15:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UnRxdc0tgxbri7msqvY0jDsk70V1J99BdT56c+LMq00=;
        b=Hc/wA2XawpZ/Nqmu3UJkecMhHlSpo5FI8+kih1koIomCORLIpWT9UWhuunkf1dV5J1
         zawQkQiWx36P4SdKvBXbsOzsjtDcGxCP0X0Mpoy4OkZRMZZHtZdrdHo1Sv0WrGaZWcj5
         x5QuWPVSR4AVQ2pTQDbnY3DN12j0pNX/6Gx4IA93eYdFAvEMONpdH17x8Ds9f2oOsjrq
         wjjzUn8eb95mxeKcRkhNhPGi82TZhWPq4t8jj564w95NVuTq+RKeI47YWuHjcvZOAT0E
         0zbg/Bj4grqbCoeB7tGDhUu6Monbr9sGIO7t0dQfiul5mQBHze3wE/7LtIRTF8hhO+0K
         d51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UnRxdc0tgxbri7msqvY0jDsk70V1J99BdT56c+LMq00=;
        b=H412iGmJx2cJ7i4nxId0PLEiARiYnDYUwRozH0r6s4sH/W37NcbzsEhQ3Lij9pD0Tz
         QsWGtNCnMwf+PWBP90ubdKXW2/yhai005kw2ge25tCGO8YfsZae18IBkuBgrSrrYGMEZ
         Yvbyk/BZ96+gKQMnFrrQOiSKrH9M2OZiVeVpSHxETeza93guFuuromBEr+8d8fvGSG5W
         KNDU0AP4Uh9Z52sF9/DW2tLK1Ll0E8z1DWH00dXYI58Jae2TLNVoIelISCwiQOcETQeR
         VAqheOxe1QNUIVdPOjmqWFL6KSuyZ0YC/F9VSMzCnbMbn39PsUnnlzxiSiCJRXfyez+2
         rw5g==
X-Gm-Message-State: APjAAAU+xfklv3KyaU3ox359T1LTteMXmztBIXpqZPUcxogvCNWJno16
        4IQFrZXOlggm1VYsmzYba85oE6r9lWNE06bCFupDPQ2QgX2DlBG2Uvsbur8Ha/JZzojYVvkLiwW
        iacxfj9eY2gZV6hTLFxKu3i23+uDkTkRkld8kQP4v34JPJUesvxsPWIe6gE+VX9vuRGT4HGujlA
        ==
X-Google-Smtp-Source: APXvYqzgR3hMy8HxjfYZ03uOB+hR+bnvRrsdFRtQ5nR2i9/zyg1xYF9tCFADDjArHuvqV28+VQ63NPxD/ExOuj1cfm4=
X-Received: by 2002:a63:c20c:: with SMTP id b12mr4918637pgd.3.1559948364173;
 Fri, 07 Jun 2019 15:59:24 -0700 (PDT)
Date:   Fri,  7 Jun 2019 15:59:00 -0700
Message-Id: <20190607225900.89299-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH] revision: remove stray whitespace when name empty
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach show_object_with_name() to avoid writing a space before a name
which is empty. Also teach tests for rev-list --objects --filter to not
require a space between the object ID and name.

show_object_with_name() inserts a space between an object's OID and name
regardless of whether the name is empty or not. This causes 'git
cat-file (--batch | --batch-check)' to fail to discover the type of root
directories:

  git rev-list --objects --filter=tree:1 --max-count=1 HEAD \
    | git cat-file --batch-check
  git rev-parse HEAD: | xargs -I% git cat-file -t %
  git rev-list --objects --filter=tree:1 --max-count=1 HEAD \
    | xargs -I% echo "AA%AA"
  git rev-list --objects --filter=tree:1 --max-count=1 HEAD \
    | cut -f 1 -d ' ' | git cat-file --batch-check

The extra space provided by 'show_object_with_name()' sticks to the
output of 'git rev-list' even if it's piped into a file.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
I don't see any reason _not_ to remove this stray whitespace at the end,
since it seems like it just gets in the way of easy scripting. I also
think this case will only present itself for root trees.

Not sure if making the whitespace optional is the right solution for the
test, although I couldn't come up with a cleaner approach. Maybe
something like this would be better, even though handling it in the
regex is shorter?

  if [[ -z "$name" ]] then
    grep "^$hash" actual
  else
    grep "^$hash $name" actual
  fi

 - Emily

 revision.c                          | 3 ++-
 t/t6112-rev-list-filters-objects.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index d4aaf0ef25..260258b371 100644
--- a/revision.c
+++ b/revision.c
@@ -40,7 +40,8 @@ void show_object_with_name(FILE *out, struct object *obj, const char *name)
 {
 	const char *p;
 
-	fprintf(out, "%s ", oid_to_hex(&obj->oid));
+	fprintf(out, "%s%s", oid_to_hex(&obj->oid),
+		strcmp(name, "") == 0 ? "" : " ");
 	for (p = name; *p && *p != '\n'; p++)
 		fputc(*p, out);
 	fputc('\n', out);
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index acd7f5ab80..e05faa7a67 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -288,7 +288,7 @@ expect_has () {
 	name=$2 &&
 
 	hash=$(git -C r3 rev-parse $commit:$name) &&
-	grep "^$hash $name$" actual
+	grep "^$hash \?$name$" actual
 }
 
 test_expect_success 'verify tree:1 includes root trees' '
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

