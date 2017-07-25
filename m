Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF431F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 20:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbdGYUxx (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 16:53:53 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35870 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbdGYUxv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 16:53:51 -0400
Received: by mail-wr0-f194.google.com with SMTP id y67so19901151wrb.3
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 13:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=idO6SBH9rvgBcAiHLxOW/ExSqnM+Nl2kYeor93iQ5Hw=;
        b=P7Xc5z2yzbw5ChvxuuT4Mg515o+NfRqQm1hCvr1yZXCVYnC1QQDxKyYh2eBIqrior5
         froriaQTQ5v9m1Rcc/kGcmlHkzglM2py1uSQ6uO3f51YERoZRJVgUBi8nQlXhWRWCTum
         a9wUJeYURwUKkvCdhBlVBFGmtF85JXdp8a2rX/SLRPU+UwHvoNhN+ZALG/J1K5Ud8IS5
         Rv5MBmbNpkA7Dl3KfgcjalrJ4qgA/jhCJXYwZL69uaVtQLaoFSUwho+uxAw4RueUVuVY
         JcZ0B/ICylbzaPH+OpLl9GSSeFtVhwWYTzBOQY4QQbhTrsnOJwQprpWFF05NhUu7ZAt2
         yOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=idO6SBH9rvgBcAiHLxOW/ExSqnM+Nl2kYeor93iQ5Hw=;
        b=FH7fbaWZdK3g66yJxlrRTYmAsdFabnvrzI2PZVPqy8VcmIzHtx/hNQG3tmQStLDvVX
         5z2iErBxd3oZSaYXf0twbcbieRKxuSBcRdq61Ajt9RWLDSiynXCVvB/+VXLrVoampl1s
         jWxKRyL+78sJwYsvhGvnq3Z5J7RpgsHVWnCjadCjOc/FlRXJbcD8mfNK6NDwzFhFOB5k
         3SwruYKLZhEfDTJqgRijMbuPs2PTPVBKOKMAHuva9dVHZE+6g8OpBm9Owu4GoDOP/EpA
         nXIWco2bftFB0FdkZAOFy0yGuYktGRQSwc3QtDxZEEJK5T0QIp93a+E97c86qUGk9Ag4
         7uoQ==
X-Gm-Message-State: AIVw1136qeKdTkTOS/iau6HMogguEpp1UbFOgi9hgLclZqJmhOE0AKx8
        Wqof7FavijCU9lvKs+I=
X-Received: by 10.223.128.163 with SMTP id 32mr7148769wrl.99.1501016029780;
        Tue, 25 Jul 2017 13:53:49 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:3421:5800:cd28:a33e:5f3f:ef7])
        by smtp.gmail.com with ESMTPSA id 63sm7190156wrj.33.2017.07.25.13.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 13:53:49 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH v2] doc: add missing values "none" and "default" for diff.wsErrorHighlight
Date:   Tue, 25 Jul 2017 22:53:15 +0200
Message-Id: <20170725205315.12030-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <xmqqa83sbamf.fsf@gitster.mtv.corp.google.com>
References: <xmqqa83sbamf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The values have eluded documentation so far. While at it streamline
the wording by grouping relevant parts together.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/diff-config.txt  | 11 +++++++----
 Documentation/diff-options.txt | 17 ++++++++---------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index cbce8ec63..5ca942ab5 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -200,7 +200,10 @@ diff.algorithm::
 +
 
 diff.wsErrorHighlight::
-	A comma separated list of `old`, `new`, `context`, that
-	specifies how whitespace errors on lines are highlighted
-	with `color.diff.whitespace`.  Can be overridden by the
-	command line option `--ws-error-highlight=<kind>`
+	Highlight whitespace errors in the `context`, `old` or `new`
+	lines of the diff.  Multiple values are separated by comma,
+	`none` resets previous values, `default` reset the list to
+	`new` and `all` is a shorthand for `old,new,context`.  The
+	whitespace errors are colored with `color.diff.whitespace`.
+	The command line option `--ws-error-highlight=<kind>`
+	overrides this setting.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 89cc0f48d..d60f61ad4 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -300,15 +300,14 @@ ifndef::git-format-patch[]
 	with --exit-code.
 
 --ws-error-highlight=<kind>::
-	Highlight whitespace errors on lines specified by <kind>
-	in the color specified by `color.diff.whitespace`.  <kind>
-	is a comma separated list of `old`, `new`, `context`.  When
-	this option is not given, only whitespace errors in `new`
-	lines are highlighted.  E.g. `--ws-error-highlight=new,old`
-	highlights whitespace errors on both deleted and added lines.
-	`all` can be used as a short-hand for `old,new,context`.
-	The `diff.wsErrorHighlight` configuration variable can be
-	used to specify the default behaviour.
+	Highlight whitespace errors in the `context`, `old` or `new`
+	lines of the diff.  Multiple values are separated by comma,
+	`none` resets previous values, `default` reset the list to
+	`new` and `all` is a shorthand for `old,new,context`.  When
+	this option is not given, and the configuration variable
+	`diff.wsErrorHighlight` is not set, only whitespace errors in
+	`new` lines are highlighted. The whitespace errors are colored
+	whith `color.diff.whitespace`.
 
 endif::git-format-patch[]
 
-- 
2.13.3

