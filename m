Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 080E020248
	for <e@80x24.org>; Sun, 17 Mar 2019 20:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfCQUUA (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 16:20:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39635 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQUUA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 16:20:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id t124so10641656wma.4
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 13:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/ZwyFoEW1cVJCAcuRnIRnPgZErH0Si0OUEeRnQtJHEE=;
        b=dGMKwl7Wubxnj8XDU6UosqwhbpKYdQ0IEBsxnmkEHl+9jgCS6t9D2aHJcWahBQKTGu
         lwbp2OFuZbzyIEvJiTJdhhPSBImCSe59NiKNbX5C/rEGinQ+2q9lQkARGCFzn1hw/13c
         U/e9aH91iUh2ZYVu7P5cVAg4JPc9tohjE+ktF7IRq3zOgDjJc/xkISsSF3Nc5Dx7BR3C
         d+dBbg4iKipjy1BG8tLl1h2BD2eVSYntDilrAZ+JZnU7gMnWyXnMZMcOoNEjx59y+3Xb
         3dioxLkj6K6WkTC6DdmF1Pu3VCsjxfGFexGqfb/d2PwCgupHk7EsQMkUTblcaTG3totx
         +BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ZwyFoEW1cVJCAcuRnIRnPgZErH0Si0OUEeRnQtJHEE=;
        b=n9iQeNt+WfnGitl+c651oqz7dd/17HfDm8YrzcR2LnQK4AXblGW2C1pK3XGg/uK4R0
         zlJK5slLH7PGCfXP1Ja2M9XtLimiLauQmOs6+a+JyopWN/2rJpADqi1lGYTmXWUr44To
         uK0ByBiRylqKpOomKdSgEqXKjIeZGvx0d5mGVBxQIuKjQQ0JbPnto5SYYqrru6fzKjl5
         DxdLnMD++ZmS3yd36GGyabqFOGgm+4wv2WqKj1OMW1dXy1fgDLM0H1bsDnE7TCKN5WRq
         sN/19pq5C1rrFVFaiU5LTuhM779QO8gCvyYaIdkz7w1pOCi0BpN2pax1O38KsEloqtHp
         81lw==
X-Gm-Message-State: APjAAAWTSdC13PpD328ScEJKuVEKswOgk3iQWUMADX3SaTJA1XoKISHZ
        Fyr1vGQTx99sJXALf+Wi+6Y=
X-Google-Smtp-Source: APXvYqy+DDNdP7AUNbTF36q287UfGiGuk4dikm6QZNjnCi2X/rJl5N5/iaXZgU6KniNSE8jBwGKpFQ==
X-Received: by 2002:a1c:9c02:: with SMTP id f2mr8502788wme.91.1552853998673;
        Sun, 17 Mar 2019 13:19:58 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id y192sm6532525wmc.6.2019.03.17.13.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 13:19:57 -0700 (PDT)
Date:   Sun, 17 Mar 2019 20:19:56 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3] glossary: add definition for overlay
Message-ID: <20190317201956.GB1216@hank.intra.tgummerer.com>
Reply-To: 20190312233040.GE16414@hank.intra.tgummerer.com
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
 <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
 <f6052ac6-60c4-1e70-b3f4-571885ba9e8d@iee.org>
 <CACsJy8D48YiWYkuLW8BbeYvRz=yMmb=XWoMJroPXFAcSV2VjHw@mail.gmail.com>
 <20190309172733.GC31533@hank.intra.tgummerer.com>
 <20190312233040.GE16414@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312233040.GE16414@hank.intra.tgummerer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a definition for what overlay means in the context of git, to
clarify the recently introduced overlay-mode in git checkout.

Helped-by: Elijah Newren <newren@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

v3 incorporates Junios suggestions from [*1*], and clarifies that this
only applies to checking out from the index or a tree-ish, and
clarifies that the files are updated like in the destination directory
of 'cp -R'.  I thought of making the same clarification for 'rsync
--delete' as well, however I think with it being explicitly specified
for 'cp -R', readers should be able to deduce that we are talking
about the destination directory there as well.

*1*: <xmqq5zsnh7my.fsf@gitster-ct.c.googlers.com>

 Documentation/glossary-content.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 023ca95e7c..0f29075551 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -287,6 +287,15 @@ This commit is referred to as a "merge commit", or sometimes just a
 	origin/name-of-upstream-branch, which you can see using
 	`git branch -r`.
 
+[[def_overlay]]overlay::
+	Only update and add files to the working directory, but don't
+	delete them, similar to how 'cp -R' would update the contents
+	in the destination directory.  This is the default mode in a
+	<<def_checkout,checkout>> when checking out files from the
+	<<def_index,index>> or a <<def_tree-ish,tree-ish>>.  In
+	contrast, no-overlay mode also deletes tracked files not
+	present in the source, similar to 'rsync --delete'.
+
 [[def_pack]]pack::
 	A set of objects which have been compressed into one file (to save space
 	or to transmit them efficiently).
-- 
2.21.0.225.g810b269d1a
