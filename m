Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328AA1F45F
	for <e@80x24.org>; Sun,  5 May 2019 16:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfEEQHF (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 12:07:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33616 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEEQHE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 12:07:04 -0400
Received: by mail-io1-f66.google.com with SMTP id z4so2462387iol.0
        for <git@vger.kernel.org>; Sun, 05 May 2019 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E3hpcE86jhWw+YfjQjyjHNhsDPyY5cckhBJ0imZ+5oo=;
        b=E/j/++Q5O9KS7Zk5lDrrOX/erQJ6OyT/x5WipzDvAMYQ0DfZYLYSHD7gzq8eyO7m3Y
         Koz2wuTcZdh8jVldKH8N86B6qZYXsb+/vYa0lXXgQimsqn7CptxdzMtI1kFIjI4pDVrv
         KXu5d0/yS6tqEgYFuAswXddm+FRwaBszSLZj8IjmLpZ61TbSRLw2SAJO+y7o+HXnMVPy
         0Ol924u23abrPtpcpuv2nyIgAjwmX6C4Wp6kcvRrlFzIMmRW+L3H2DIwsOx7f33Q+3oo
         hllVtQpw4iTq40mj/+DrvJnWk4LxnS42p05OzSWTYsO10XFD20kQcy9lLE69u7hMQ/zY
         jUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E3hpcE86jhWw+YfjQjyjHNhsDPyY5cckhBJ0imZ+5oo=;
        b=GrxJPthHCdkTYt7nrtaxEP901Rl+EZVqXnkQAwKfCK0vzgDVAPzwJ2ce/f0lnXZdjr
         JGTSSaKsBVcnwQ3E9Xq1E1jRSzJbLxsBs4bykuXgDmeR2FVLe1Djzn15aECZ71krhnHA
         mAITQwjxhtQ/5DL6hqU9UAXyYeELKnw9xC8OgKH7gwo4o/fUST/Ue1ZJxRWeWppWj7Af
         4LtMyhNOebN8DTNTmziM+VI5xZsj9uWZfwEKxaFza5hcB4FwovleeFOq4GTX8X2WzZ5j
         KgHcbej0ziRUaAXs8rJ3eoYTsWGEGuf5gd1jS+N762WSEyeaSBwmtIv1/Z8R6gTVXDX0
         Frtw==
X-Gm-Message-State: APjAAAUdR58F0w7G0PBIUUtvGh8id4Jn4hc17UkcCbKjeZYeXvJ5puzx
        RNZ9S/I+Ps6lxehx2Ib+0RaShk2w
X-Google-Smtp-Source: APXvYqw/IBmcqcmmai/LKQA2vlME15wBUPlge5yy23jiby6HUMDqu+91l3tXZIfh96uraW8IjsGLVw==
X-Received: by 2002:a5e:9901:: with SMTP id t1mr6524454ioj.150.1557072423743;
        Sun, 05 May 2019 09:07:03 -0700 (PDT)
Received: from archbookpro.localdomain ([199.119.233.193])
        by smtp.gmail.com with ESMTPSA id a21sm2761857ioo.68.2019.05.05.09.07.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 05 May 2019 09:07:03 -0700 (PDT)
Date:   Sun, 5 May 2019 12:06:59 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/4] revisions.txt: change "rev" to "<rev>"
Message-ID: <e5b6d69eec80acab5b4b4c702011fc82a7367a79.1557072286.git.liu.denton@gmail.com>
References: <cover.1557071877.git.liu.denton@gmail.com>
 <cover.1557072286.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557072286.git.liu.denton@gmail.com>
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
2.21.0.1049.geb646f7864

