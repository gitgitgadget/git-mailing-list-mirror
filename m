Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98D131F404
	for <e@80x24.org>; Thu, 15 Mar 2018 16:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbeCOQon (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 12:44:43 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35066 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeCOQol (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 12:44:41 -0400
Received: by mail-lf0-f65.google.com with SMTP id t132-v6so11182744lfe.2
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Z0F1EHr3bb1xbw++WUnOS9hDWnn39mSobE2A0RuhUQ=;
        b=nUs7+HZyg6XDf9m5c+dC2YT0lAW8cdYsV0+l+FeDIDd5HTqiK8riFTY4tCMAMj1SQV
         q7mq/F8OVV4IunRldyUegR+BprQPW9NxPrla74h4aXxnRIeDWDOburP3iSj7J7BOTV9v
         NEZUg5SRYCtSwWcnyexQBOyYRn/YIJ1k1S8SbxuVlsv3KEPkHcyAES1C62YPU1gCRk/a
         2/rK1JplsoXYTt7Uc13wZvciYXjM43tb69WpsHKYyTnIM2NjJ88ky3rKtxxxMFmy1xz0
         TCln1KTcS/Qf8QWmtd3PcutTaC4XyY3ywx4CHGiCJGVc2xpcXdPY8yiGTx6tDjmLt8CG
         80mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Z0F1EHr3bb1xbw++WUnOS9hDWnn39mSobE2A0RuhUQ=;
        b=b4vQVx/Zd/3XK/I5XWbwN+v1cA0UEhPUcfFVMqv7n4btp1Q9n3KfOS5uYm3gJlTVVK
         /FM4450jKvXp4H7hDxraZybOchg3Axr6S3djeQ7gGjgsZpQLaWUnE/7FF75I24SXGSjJ
         n5/VxS/A8PGtDfr3ULdU/lsCxdph2QRYtFsjwkGaG0nKntPlChB0HkR3Os+SsML06es1
         ArYuTAfyDSRk+r3ZAKxz4m3MyqoOspxlZkv3RlWtxa/AndllUos+hk/SNlj7LIubcUKU
         lMT3GNl1+lOhCBSJQZp2M07clrimVO/G+JuxZuUzhD26jrAb0ekz5yu4yL4OP0KI+tw2
         IMmw==
X-Gm-Message-State: AElRT7HmhJVosIt4CvuZ4i/Wi4KI047JikfLKGyxCI/QD/2nHJFeSE3t
        juhmn5PClcy5RrQtociBhTY=
X-Google-Smtp-Source: AG47ELsju23Rjk0TTjTEH6SBGj4TBPfW1uOAqMLbdyp+01Jus1oEZVX29w3F4Hvxl+cZLno+oFhhLQ==
X-Received: by 2002:a19:911a:: with SMTP id t26-v6mr1008548lfd.101.1521132280151;
        Thu, 15 Mar 2018 09:44:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u24sm1037406lju.32.2018.03.15.09.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Mar 2018 09:44:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] gc.txt: more details about what gc does
Date:   Thu, 15 Mar 2018 17:44:10 +0100
Message-Id: <20180315164412.14697-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180315164412.14697-1-pclouds@gmail.com>
References: <20180303033918.15751-1-pclouds@gmail.com>
 <20180315164412.14697-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-gc.txt | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 571b5a7e3c..3126e0dd00 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -15,8 +15,9 @@ DESCRIPTION
 -----------
 Runs a number of housekeeping tasks within the current repository,
 such as compressing file revisions (to reduce disk space and increase
-performance) and removing unreachable objects which may have been
-created from prior invocations of 'git add'.
+performance), removing unreachable objects which may have been
+created from prior invocations of 'git add', packing refs, pruning
+reflog, rerere metadata or stale working trees.
 
 Users are encouraged to run this task on a regular basis within
 each repository to maintain good disk space utilization and good
@@ -45,20 +46,25 @@ OPTIONS
 	With this option, 'git gc' checks whether any housekeeping is
 	required; if not, it exits without performing any work.
 	Some git commands run `git gc --auto` after performing
-	operations that could create many loose objects.
+	operations that could create many loose objects. Housekeeping
+	is required if there are too many loose objects or too many
+	packs in the repository.
 +
-Housekeeping is required if there are too many loose objects or
-too many packs in the repository. If the number of loose objects
-exceeds the value of the `gc.auto` configuration variable, then
-all loose objects are combined into a single pack using
-`git repack -d -l`.  Setting the value of `gc.auto` to 0
-disables automatic packing of loose objects.
+If the number of loose objects exceeds the value of the `gc.auto`
+configuration variable, then all loose objects are combined into a
+single pack using `git repack -d -l`.  Setting the value of `gc.auto`
+to 0 disables automatic packing of loose objects.
 +
 If the number of packs exceeds the value of `gc.autoPackLimit`,
 then existing packs (except those marked with a `.keep` file)
 are consolidated into a single pack by using the `-A` option of
 'git repack'. Setting `gc.autoPackLimit` to 0 disables
 automatic consolidation of packs.
++
+If houskeeping is required due to many loose objects or packs, all
+other housekeeping tasks (e.g. rerere, working trees, reflog...) will
+be performed as well.
+
 
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
@@ -133,6 +139,10 @@ The optional configuration variable `gc.pruneExpire` controls how old
 the unreferenced loose objects have to be before they are pruned.  The
 default is "2 weeks ago".
 
+Optional configuration variable `gc.worktreePruneExpire` controls how
+old a stale working tree should be before `git worktree prune` deletes
+it. Default is "3 months ago".
+
 
 Notes
 -----
-- 
2.16.2.903.gd04caf5039

