Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC55420986
	for <e@80x24.org>; Fri,  7 Oct 2016 23:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932849AbcJGX6L (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 19:58:11 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36415 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbcJGX6K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 19:58:10 -0400
Received: by mail-pf0-f194.google.com with SMTP id 128so1969322pfz.3
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 16:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=g+Yy+BURvi2rnoCzTVWgUYMILZiJIehhra6MIUQkjr4=;
        b=ZQ6+BUA8xzYFZ5aVs54vfFIUM46kqpxYlfS1cjF9ds669VE65hNSxF2rztEaKpSO4N
         dAlPNXHdhw6anokw+xtk0tLI7DY4hqP/PKHHcjsBlQq3Ui/8DoPf894O6GpUsqoS/dzj
         hSI66r4CKN/xGaZSZSyw2shkqDucXsdt9GJfzMRS7Hdv4YluR7Q8vJI5UkS/DISB5sy/
         KazaI8jdUY46xy2lzVwnm5MtsOv+MFGFbRHdjf6pPP2S5fXJlxjggnTwMaxWxZhLqniq
         Z6lL8a8Lz4wzyKrDRvG70mAHIefVzLQEuwQKZT3HM1ZuA9D66HNM3yviFtF3jKL24nTd
         f7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g+Yy+BURvi2rnoCzTVWgUYMILZiJIehhra6MIUQkjr4=;
        b=cAJNEN3ZbXEnNOy8CA0pXYRosWBXK6x5mHHcZmp72jS2O9EBZ/CyPMKDXS1vUHe/vc
         ILMj56mF05JLs/HSpCm/mVIsQ9uyEJsBrHrsocassQZH5t50Z2y0BRevMQj86m14KIjS
         BRmXhr6bR9016Cf7C64rPzXLPgunpfuvtJVVIZo0Z7Gj8bD4x4u6BwVI1LZlk03fBX0t
         eyjdewQT8oMu5ITGytJOO+fGTGhmhckUNSy5p1BRR+ZHapq4x2QnhuUjfXfAolnP7OcY
         Ku8A4NRRo+NzISZRtIAnPJ6mU1p3AX/kamV9AE7DPI7uBylxwt8Bp0VutcLu+ukBn/V7
         jObQ==
X-Gm-Message-State: AA6/9RkyeDfV0/n8F32IsDJ7J6ajfjc99iQXi213em5VbrQMS6fpvny9JJpddz+FML98Kg==
X-Received: by 10.98.200.153 with SMTP id i25mr23314531pfk.156.1475884689594;
        Fri, 07 Oct 2016 16:58:09 -0700 (PDT)
Received: from raptor.fas.fa.disney.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by smtp.gmail.com with ESMTPSA id c27sm16662890pfe.6.2016.10.07.16.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 16:58:08 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Luis Gutierrez <luisgutz@gmail.com>
Subject: [PATCH v3 1/4] mergetool: add copyright
Date:   Fri,  7 Oct 2016 16:58:03 -0700
Message-Id: <20161007235806.22247-1-davvid@gmail.com>
X-Mailer: git-send-email 2.10.1.386.g8ee99a0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Unchanged since v1; included for completeness.

 git-mergetool.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index bf86270..300ce7f 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -3,6 +3,7 @@
 # This program resolves merge conflicts in git
 #
 # Copyright (c) 2006 Theodore Y. Ts'o
+# Copyright (c) 2009-2016 David Aguilar
 #
 # This file is licensed under the GPL v2, or a later version
 # at the discretion of Junio C Hamano.
-- 
2.10.1.386.g8ee99a0

