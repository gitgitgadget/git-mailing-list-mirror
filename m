Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A2561F453
	for <e@80x24.org>; Sat, 27 Apr 2019 12:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfD0MQH (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 08:16:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44814 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0MQH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 08:16:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id l2so62117plt.11
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 05:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tePlataQsOxfarWLjHHzz+Gynn8IcVdvbrJWlwdEVcg=;
        b=DFQe8aLh1p3cW9Qmx0WCWmsJTkg4GMA5hT1iADhBKCxC5+WNxLjeqWJFyRZO0A/VjH
         ldNMyqcJyTP56CEKamrarXN+jC9lHP52Oo9jYv/ZZOy5o3ftys2NSAy0crUCOFtB9yr4
         s87AeAafjWWn8QmGeDnyFeyri68vZBRnj31ZUNcTSEG3XONyZrJZcMzJ0l+JHPUDTg/u
         ImXE4yIXsiUV5OHCT6KGLjiFGA+l0gyQpvOu6QvNGTn9g4YWQh8d2QG9OPMxUh4bmR5w
         jTX0PHQORT+QZq9Ww3CObNk7hYz4xozHy/oSkTg91Zmr+MV4nxNnFlhdW5VX7Rx985HE
         9Q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tePlataQsOxfarWLjHHzz+Gynn8IcVdvbrJWlwdEVcg=;
        b=t8bdJs9QChmJPBBjBKBBOKJuL9DY7ZomX2kBWDNlMWB3Wk2luMlcqEJ7eNcZ7pLFQ3
         lv9JV62EwQVwzk4Nlsr6L0hnn/8e2bJYTvc3TBfgwzFu0sBGNdxgn7c4wspIGpcN4JX/
         TBachUvV+pUzdaehpersBJqCjmbRYkpFmawIabG9de+dlObbXZiCxEbKFn7KcthlSXze
         kmWmMUKp2SVqYD77aHwBstF36eI/NCeEaQvhJbieyyOtJcCc6iiCCm9Xoej+RI0rlD/s
         q4VCOrUvlujHzuoSav+wmM71Sa3LHO4/nIkUPh9LuUb1PVwmj7skBmqHG2pieSOI+1E1
         k0Ow==
X-Gm-Message-State: APjAAAUt13h7vZSNlW9Gu//scSQOXWsd0UgEb6eoX/wuaTd2YlipYQ8h
        jUu7i4zz+lru7h96CYyYQTEmgYJT
X-Google-Smtp-Source: APXvYqzsMtwjWjeknTTv2O8hgQwLQNJWz3P3H4DshypvFLiNwm6uiuPBX3FmPAnKzo9gqWSeCBOw/w==
X-Received: by 2002:a17:902:2b88:: with SMTP id l8mr51237627plb.262.1556367366225;
        Sat, 27 Apr 2019 05:16:06 -0700 (PDT)
Received: from archbookpro.localdomain ([216.9.110.9])
        by smtp.gmail.com with ESMTPSA id a6sm62875648pgd.67.2019.04.27.05.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 05:16:05 -0700 (PDT)
Date:   Sat, 27 Apr 2019 05:15:58 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] revisions.txt: change "rev" to "<rev>"
Message-ID: <e5b6d69eec80acab5b4b4c702011fc82a7367a79.1556367012.git.liu.denton@gmail.com>
References: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
 <cover.1556367012.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556367012.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In revisions.txt, there were some instances of a rev argument being
written as "rev". However, since they didn't mean the string literal,
write "<rev>", instead.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/revisions.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 2337a995ec..e5f11691b1 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -159,12 +159,12 @@ thing no matter the case.
   '<rev>{caret}0'
   is a short-hand for '<rev>{caret}\{commit\}'.
 +
-'rev{caret}\{object\}' can be used to make sure 'rev' names an
-object that exists, without requiring 'rev' to be a tag, and
-without dereferencing 'rev'; because a tag is already an object,
+'<rev>{caret}\{object\}' can be used to make sure '<rev>' names an
+object that exists, without requiring '<rev>' to be a tag, and
+without dereferencing '<rev>'; because a tag is already an object,
 it does not have to be dereferenced even once to get to an object.
 +
-'rev{caret}\{tag\}' can be used to ensure that 'rev' identifies an
+'<rev>{caret}\{tag\}' can be used to ensure that '<rev>' identifies an
 existing tag object.
 
 '<rev>{caret}{}', e.g. 'v0.99.8{caret}{}'::
-- 
2.21.0.1000.g11cd861522

