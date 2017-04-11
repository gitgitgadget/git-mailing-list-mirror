Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FCEF20970
	for <e@80x24.org>; Tue, 11 Apr 2017 14:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbdDKOkE (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 10:40:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36197 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdDKOkC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 10:40:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id q125so631661wmd.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y9ee1I83RsLyXj42smd7TydMMGNlRc89AzxLKSXUcWw=;
        b=IA40ATIQMWZ+WZJA95Q7Y8FeuGlr1nZFo3n/kWwy++I5RI9uS5PNcfI0WpXaX477Qg
         dv21KrFQ79L0pLK3oFX0s6Xj96z4Ht1n52YcDBLOTHLoCUlY+nFMBiq4qftmc5Iq0mS1
         B82pU99tDjabq299B5mLr8qbPFSvWiub0rNoewhlVd9QYcGJ97R/oxNBSOZphnZvf5PT
         d1c+pLIJHvlTaQ7cQjQrUgeix+yAcQnwQHlDzjHso4u7bHY720LxjQbPU4HfvtdLpAnY
         BzRsbbXfDrllal8oxMNlEg/fSR+7uyEKK6EXBobZBvkmcrKtUDtohemwTncPkgqxymND
         DH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y9ee1I83RsLyXj42smd7TydMMGNlRc89AzxLKSXUcWw=;
        b=oBVGE00apuujYn1bjUSVu4pBsEsxaNoJ/Mmv8bzdkTR0XI4L6CAW9hWTZTzhKx22/k
         9yMXMdCahsQwgSvYWNcAKpjcyhMPiCWhCOgZYdpHsP5QiuZtslr4G5Nore4XbVSOEASV
         Z83MjrQuV7pv8YXlGaImEkF4KOn2Fx60cPnW35wbUP4keE5XSsEEZeT9cNNljk1atQaB
         WAMY9oxOCeSnQUpr9T+xLMiKe0kUZXtB73i9pG50zlMvD6fovFTT/4w0KvMfdUyqAi3P
         /QiB6Bxkde7JvmSjDQKgdwq6zqe+MbuwB+iSskA5yyYCREWcOIWKzapGDhtnH4kK/m3Y
         EAyg==
X-Gm-Message-State: AN3rC/4uTzta/v3XeBSgsfJW8do9dBS7XHW6qDkQGs27/LGxE3QbKfFNedR5WZIVoJy3Bg==
X-Received: by 10.28.236.210 with SMTP id h79mr12117185wmi.92.1491921601434;
        Tue, 11 Apr 2017 07:40:01 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:3408:4800:24fc:63da:a8f3:677])
        by smtp.gmail.com with ESMTPSA id k26sm13478546wre.9.2017.04.11.07.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 07:40:00 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH v2] Docs: Add some missing options to git-diff.txt
Date:   Tue, 11 Apr 2017 16:39:50 +0200
Message-Id: <20170411143950.31207-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <xmqqinmq34d3.fsf@gitster.mtv.corp.google.com>
References: <xmqqinmq34d3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

New attempt due to whitespace fixes after EndOfSenctence.

Junio C Hamano writes:
> This is probably a shared issue with the original text for
> "diff-files", but I think we must stress that these options make
> sense only when you are in the middle of conflict resolution.  
>
> In addition, unlike "diff-files", if these were to appear in the
> general "git diff" documentation, it also must stress that these
> options are only about comparing the index and the working tree
> files, e.g. "git diff --ours HEAD^ HEAD" does not make sense.

Well, this wording picks up your points but I won't call it "stress
it" :-) However this should do the job.


------- 8< -------------------------- >8 -------------
git-diff understands "--ours", "--theirs" and "--base" for files with
conflicts. But so far they were not documented for the central diff
command but only for diff-files.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-diff.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index bbab35fca..b0c1bb95c 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -97,6 +97,20 @@ OPTIONS
 :git-diff: 1
 include::diff-options.txt[]
 
+-1 --base::
+-2 --ours::
+-3 --theirs::
+	Compare the working tree with the "base" version (stage #1),
+	"our branch" (stage #2) or "their branch" (stage #3).  The
+	index contains these stages only for unmerged entries i.e.
+	while resolving conflicts.  See linkgit:git-read-tree[1]
+	section "3-Way Merge" for detailed information.
+
+-0::
+	Omit diff output for unmerged entries and just show
+	"Unmerged".  Can be used only when comparing the working tree
+	with the index.
+
 <path>...::
 	The <paths> parameters, when given, are used to limit
 	the diff to the named paths (you can give directory
-- 
2.12.2

