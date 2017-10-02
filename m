Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0A40202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750962AbdJBFZj (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:25:39 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:46628 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbdJBFZg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:25:36 -0400
Received: by mail-pf0-f172.google.com with SMTP id r68so2400074pfj.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 22:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SEvZjNCvS3UQzCOJdkC8R3DQVzOPFIBa4qYJqHIyhso=;
        b=cFqaNz9w5hP1XsczryvU5NMUte0e9pZ+2eNNJKYq0hIg5tZRoJMz+Il7ipnD2f4eIk
         Hx5fjde9mRX2qIryk802WaT6bRa3khlbRXJiFYzFN6oNesi34KaXwVYYoUTv0b85keYo
         lDAmtIysVUl/U4qtWS8Io/qE+zyorHUf65pNEN/r4n8ZVuWjRgQTX56Cl3vNLv7vkeL5
         KE+f3IbzkKvWJh+WHIQxZQWR7SWCS6lU/sZCINkeVxwVxd3hXfOsFlhjjT96QQ6Yc7XY
         55RgXmyh1iTKTALUsBMq3K2dIY9mRma19yu3dXQ9MtS/t69hTi5a9obTJqz/q1Z5YMQB
         9kTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SEvZjNCvS3UQzCOJdkC8R3DQVzOPFIBa4qYJqHIyhso=;
        b=jCyqlz+CPve3WAHladtQ+wJD4u/ltMFV4hWXshphW42JGDd1u8kAdepy6c90HLBv9j
         2xVkJEMqOERIs1M4p0ufOt2kYKNKX5i+RUwm9a5RYv7AsnJOVVzy1N/2lv6gQvZ6ZlEd
         nP6xcnjZHp+vQT2y0C9XQN0nItly5heyUEz8RPGDbF59Ti2dVSqlwTLfFDVxkvT5IpaH
         iCTZHu8yCI+K8OYsi6n2Qj6qN1nGTQv/6cgTdOIHped9ersD9f7r/6KJ8by9BFpN72Gx
         kc9tWZwiS6ke8WnPL/fdCDVL+fcoc+iNgmPZ1hQkj9tD+0U9781cD0fwY5xYX0wMp2IH
         TFqw==
X-Gm-Message-State: AMCzsaXqWGDXF7Hse2r7NAty3J3WLhfHh+xQNnUN0sxKul0GRf+xzp/i
        MzHDbkDfN03X3tC4nh2ioz97m7Wl5Ts=
X-Google-Smtp-Source: AOwi7QDaIIxiaxxN4/gVzXWMhX6OPW47NftARaGg2Rv+hO/zjw+A1aNDIUJoyyp4eM8T835XrZE9tA==
X-Received: by 10.98.112.7 with SMTP id l7mr4538852pfc.126.1506921935411;
        Sun, 01 Oct 2017 22:25:35 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id k25sm13522249pgf.13.2017.10.01.22.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 22:25:34 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v6 4/7] doc: use modern "`"-style code quoting
Date:   Sun,  1 Oct 2017 22:25:21 -0700
Message-Id: <20171002052524.12627-4-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171002052524.12627-1-me@ttaylorr.com>
References: <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
 <20171002052524.12627-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"'"- (single-quote) styled code quoting is no longer considered modern
within the "Documentation/" subtree.

In preparation for adding additional information to this section of
git-for-each-ref(1)'s documentation, update old-style code quoting to
use "`"-style quoting instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-for-each-ref.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 323ce07de..1279b9733 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -213,12 +213,12 @@ and `date` to extract the named component.
 The complete message in a commit and tag object is `contents`.
 Its first line is `contents:subject`, where subject is the concatenation
 of all lines of the commit message up to the first blank line.  The next
-line is 'contents:body', where body is all of the lines after the first
+line is `contents:body`, where body is all of the lines after the first
 blank line.  The optional GPG signature is `contents:signature`.  The
 first `N` lines of the message is obtained using `contents:lines=N`.
 Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
-are obtained as 'trailers' (or by using the historical alias
-'contents:trailers').
+are obtained as `trailers` (or by using the historical alias
+`contents:trailers`).
 
 For sorting purposes, fields with numeric values sort in numeric order
 (`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
-- 
2.14.1.145.gb3622a4ee

