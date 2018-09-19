Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6E091F453
	for <e@80x24.org>; Wed, 19 Sep 2018 16:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbeISWXH (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 18:23:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40542 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeISWXH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 18:23:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19-v6so5680610ljc.7
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G+OP+4C8Tk7ula56VLJ2V0MVlfpwPsicVqH4Mer/GAA=;
        b=ouptf7aZwXZ37JiZLSU1quk6oe8/ceL8anso+QhevjY3Jo9qDlR4J2fja5IfPur5xN
         mYAqiCxRj1Z3dnyRJFBqOpAkNcO1GgYltdw8UM6QtF8X5Bm9imSPffUayNFbQ/L5ExhC
         28U9eObxUgnLZeq93DdcuHVgXcVLQ8gv1atSQAvO+fsl+PCOgTN5Yd/hA6EmqljbEz+z
         RdwZckdOilClpRu1ZDyYX7sSJiEoaKPWhd2Cpm1Z8gQltBWdPZmsY1DarQ1R+SCZAhSa
         93dpII+TPMiI8/GYNrHpfFMSMVOFOSgLXflixsXuZMPNsl2cbpZTTLfuzwcCkSKSpjTy
         7HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G+OP+4C8Tk7ula56VLJ2V0MVlfpwPsicVqH4Mer/GAA=;
        b=s+awU3JN0typS5kWRYmXFzRPuJBjNEG7TvGSWDofCzGAryJHKN5VyiwLXwDGnA97BS
         8+hd3CtSSqZKXZw7m8ffxmYVkf1UZKMw996dHDIsLA7CQop/oNE98VO1+efdvoXFrLKt
         RndmHKXESs9tnvab8Sxbt2cqexV3guLvNJSAn7EZfd04cVe19qte1M9JevSO4B8MDvBd
         jFCgQ4+ansrbFdoaJHII7mOdG+R6qhfJB3VM23qVV3KlspDcAlN/bG4CaApeiPaGCC1z
         OOTJAQCOFrreHpcSLQ4Ype/ZZCKw4MbLKwTgFiFTSUjig7L+mEt9hoEO7xS3i3vyRoBb
         GqVQ==
X-Gm-Message-State: APzg51C2Otpa17Z7Z9P0CHUB18+QQfsMcBkhgYJj3eIsB5t/L4J3SIWQ
        dOyfNT9Gr+An/R9nYKf9qUeRQv+U
X-Google-Smtp-Source: ANB0VdacJcF1T15JscSQxW0k4kYPFEIn5vU9Dh4x2gYgYx994vTVVz24fruW5WqdFhVJAJlUaFCwjg==
X-Received: by 2002:a2e:870b:: with SMTP id m11-v6mr24327280lji.2.1537375462174;
        Wed, 19 Sep 2018 09:44:22 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id m15-v6sm3901358ljb.87.2018.09.19.09.44.21
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 09:44:21 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] git.txt: mention mailing list archive
Date:   Wed, 19 Sep 2018 18:43:00 +0200
Message-Id: <6319b34fc808ff6d8948e59f381cc5342b9ef17d.1537375332.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.0.216.g2d3b1c576c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the "Reporting Bugs" section of git(1), we refer to the mailing list,
but we do not give any hint about where the archives might be found.
Copy the text from README.md on this to give potential reporters an
honest chance of finding out whether their bug has already been
reported.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 74a9d7edb4..40eaccafb2 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -858,7 +858,9 @@ Reporting Bugs
 
 Report bugs to the Git mailing list <git@vger.kernel.org> where the
 development and maintenance is primarily done.  You do not have to be
-subscribed to the list to send a message there.
+subscribed to the list to send a message there. The mailing list archives
+are available at <https://public-inbox.org/git/>,
+<http://marc.info/?l=git> and other archival sites.
 
 Issues which are security relevant should be disclosed privately to
 the Git Security mailing list <git-security@googlegroups.com>.
-- 
2.19.0.216.g2d3b1c576c

