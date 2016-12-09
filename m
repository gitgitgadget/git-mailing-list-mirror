Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DD291FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 15:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933544AbcLIPxG (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 10:53:06 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34412 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932427AbcLIPxD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 10:53:03 -0500
Received: by mail-lf0-f65.google.com with SMTP id x143so364940lfd.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 07:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WNFqov1ZR6a+aTixpvPAsDnWjooHx/Ep+DsH0Ie0M5k=;
        b=JA2MNW70/Nv7F+ctJlMucpOK2s5NPuOB7FomHfCGERhcg9F0tCHrHlUn4Sm8Aj7lBe
         SFtquJICAy3nibJPCntgemLG2uj1vp5kfYL+h4WVhDxZ/pc1SYrTsAmwKw39oTk89v0f
         CfQlDozU5DvKikdJULc+86ZrpKfzuahRLLMcFYtu2yQgm1Gkna3/D35yNUKjEFyQlyUk
         qT5geDFdUElfXPeg+7p181cZdYlAo6hhD6A6+nhMIi59mNd0Wtnz2uy5DOLocfnLa3zW
         VV77wv3CAVBxxfzfr0rK4HixtI6jMMdUKJpCQbS7FbegznO9t7Ctzu/6Sf3TDzFCzXU5
         elxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WNFqov1ZR6a+aTixpvPAsDnWjooHx/Ep+DsH0Ie0M5k=;
        b=YzcwnU5GQ+d1p6kdt721SQewhKV6z/Y0GeKe3TnHvNS9FBDCmkiyaI0Hc3rCwg8sSi
         wc9cHje8Xo+R5cbf/8skAdRvhC0wbhLHwzcWOFaVGqBmyrMToN57fqff1oFkzVPn0URI
         y2KGLzh3pFFtPehtW97MymXcOMeF2p+cHQvIr5ZLqv5QK1IJ+YR52w+3BUwMty88ySe3
         iFcQF6y4vJO/MpCPtgu4WFuwl9mNoF0tKIA8WWZTv5pwFdPAy6O7cZIECu0PFP/pqhfz
         Jb9ZEPBIyU6bMhMog/2ezjFll2jLduQso9x7sxcn+RdC1FUZv368T3IbXvgHx2IG//+5
         Xsxw==
X-Gm-Message-State: AKaTC00tbEJ0+QlA6dqfFujM5JjEtGeDLpGr/rcmSLSRCS/Ze3TUrBX5RpsbBvW7+IGb9Q==
X-Received: by 10.25.221.213 with SMTP id w82mr24638851lfi.141.1481298781955;
        Fri, 09 Dec 2016 07:53:01 -0800 (PST)
Received: from kristoffer-SZ68R2.privnett.uib.no (uib-guest.uib.no. [129.177.138.114])
        by smtp.gmail.com with ESMTPSA id r204sm6646500lfr.19.2016.12.09.07.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 07:53:01 -0800 (PST)
From:   Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
Subject: [PATCH 3/4] doc: make the intent of sentence clearer
Date:   Fri,  9 Dec 2016 16:51:11 +0100
Message-Id: <20161209155112.2112-4-kristoffer.haugsbakk@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com>
References: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By adding the word "just", which might have been accidentally omitted.

Adding the word "just" makes it clear that the point is to *not* do an
octopus merge simply because you *can* do it.  In other words, you
should have a reason for doing it beyond simply having two (seemingly)
independent commits that you need to merge into another branch, since
it's not always the best approach.

The previous sentence made it look more like it was trying to say that
you shouldn't do an octopus merge *because* you can do an octopus merge.
Although this interpretation doesn't make sense and the rest of the
paragraph makes the intended meaning clear, this adjustment should make
the intent of the sentence more immediately clear to the reader.

Signed-off-by: Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
---
 Documentation/gitcore-tutorial.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 72ed90ca3..72ca9c1ef 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1635,7 +1635,7 @@ $ git show-branch
 ++* [master~2] Pretty-print messages.
 ------------
 
-Note that you should not do Octopus because you can.  An octopus
+Note that you should not do Octopus just because you can.  An octopus
 is a valid thing to do and often makes it easier to view the
 commit history if you are merging more than two independent
 changes at the same time.  However, if you have merge conflicts
-- 
2.11.0

