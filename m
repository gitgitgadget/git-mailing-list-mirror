Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B59B720401
	for <e@80x24.org>; Fri, 16 Jun 2017 04:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbdFPEbP (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 00:31:15 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34526 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdFPEbO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 00:31:14 -0400
Received: by mail-it0-f68.google.com with SMTP id 201so3656946itu.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 21:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wXEvE+N55IJRm3i1o7sAp86jfdNF1cqdflKySxQybLQ=;
        b=ho8jryL+ZfOI8R3HjQf2GqjFWXZuSCBt9o1MUcw9zPPrWQYSxYwpt/6REfWVRRyoAQ
         2GlhWyVn7QUbmWqAzgFC8Kq6+B214TQJKKBWDvfB3Ii9izVYMvDozohYqrHwhpt/n6/g
         08fNnXu6kOyrAjZt0hSDDKz2AhrKOuxrLQeGzV/3QJhd1bf4lk0qFBkEj/Cri2ahsBX+
         cr+odiH4QwX1Y5zqFC2OqoFIkS6NRPYVtbRnkYmjybxUf3a3mpkXvtD1JsB/Rb6J9yts
         uTohJzCzMEeTS6D8wqEIyY1OhODaJP/Eaquy9MmO8ZZtw1KTxxIhmpeEEehm7XUfqtPD
         Wq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wXEvE+N55IJRm3i1o7sAp86jfdNF1cqdflKySxQybLQ=;
        b=k70SFgbgR/1A8vA9OmlM7sq39/jlamk5a94XCl6xRjejZBgVNR/4Ol5Pc+oobzwKvp
         fCkkHJlRfLwsmh4wDp2ozMBvxpEdHoOsap0d7TV3M4re+s/+ELtL+nq7+GllYywmbYCT
         j4HRQrICiuHzgK98LpIq4lcBk+p2xve7RFNBPdb5KkwmH7TqaVJo7JzuM8A16LF+SXgu
         /scndJdDwzo05Phu2jFTMEguHbLGQpjehze4WTdsTeu322lkJoCVe81DBobbAakQ3tKU
         vaO8Yl91uGMggGJurl/fNy6bT8VEtcnAjKvCewJbPQyldUnPEiv2i6ccHRR9vP7f3I5U
         Qmuw==
X-Gm-Message-State: AKS2vOxvv+cmBmZGsEDNrm7BoYTuXBPvR9c7ncZqR88FWxZA8/NMXZgd
        J8qPnU3K6DTal10eyRA=
X-Received: by 10.36.13.16 with SMTP id 16mr8654704itx.22.1497587468712;
        Thu, 15 Jun 2017 21:31:08 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id p22sm627405iod.22.2017.06.15.21.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 21:31:08 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, houstonfortney@gmail.com, kostix+git@007spb.ru,
        peff@peff.net, sxlijin@gmail.com,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 3/3] glossary: define stash entries
Date:   Fri, 16 Jun 2017 00:30:50 -0400
Message-Id: <20170616043050.29192-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20170616043050.29192-1-liambeguin@gmail.com>
References: <20170616043050.29192-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add glossary entry for "stash entries".

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/glossary-content.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 6e991c246915..026f66e7240a 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -570,6 +570,10 @@ The most notable example is `HEAD`.
 	is created by giving the `--depth` option to linkgit:git-clone[1], and
 	its history can be later deepened with linkgit:git-fetch[1].
 
+[[def_stash]]stash entry::
+	An <<def_object,object>> used to temporarily store the content of a
+	<<def_dirty,dirty>> working directory for futur reuse.
+
 [[def_submodule]]submodule::
 	A <<def_repository,repository>> that holds the history of a
 	separate project inside another repository (the latter of
-- 
2.9.4

