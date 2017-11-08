Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9D91F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 13:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752551AbdKHNs0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 08:48:26 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:56207 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752426AbdKHNs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 08:48:26 -0500
Received: by mail-wr0-f195.google.com with SMTP id l8so2452301wre.12
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 05:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=14gjKgidss8RlnqwGIlrwdhy6OFpbEIWbWS2woB/+bU=;
        b=S8jSnVwQVjy0omQlk6hYi/WK/oE4qhabzSpxYWKvU6YYFshgh0tpZm2myU6cSz23ax
         NvIxitixLPu/QF4dSIPosvpBfdelfT0YyXJsAkuHomoe9QgK56mLil67ML5cNzjwfsyO
         Mls+npshvLG2MP07TEGu/QBQZi/XDKo9HADVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=14gjKgidss8RlnqwGIlrwdhy6OFpbEIWbWS2woB/+bU=;
        b=EjRpQdmiCyOwfea53eWtrylqrBLLU/RkPK5XC6Bl3MTdxGzBut8zm7EsLmt23LsCDN
         Ay4QPXjZiPYCGIK6Aw+1d4N7Gc1SwAjtjn7Cml9Q+IPlLhklamPf8Rv+oTPXBQBr6r+g
         ZYiVpADXBoE56NyyBPkYNVRE7uP1uTxqjYHytrIZE/Nwdb1S349LxlMLyvUuN7wiFk/v
         Z/BEXojWlPddj35hRKE0HrGlIUFREjtbd3OxlVYHYaq30fXFhjfdXFlNk4P2j+EdLfcb
         l5wCqsBGYCUZC9SkSHtyFD0pe16SuV5C/KCbHZ7tT0SZsN4zzOwtBaXIvD61nXcXeTis
         4QTg==
X-Gm-Message-State: AJaThX7eGoI/u6gn6fQxtuCho3U56PBBL6kR9gdvdWSc2JsXRGTeiVR4
        GNtyjj2o6DZrdCWWbckzJRKDhcTX6Ak=
X-Google-Smtp-Source: ABhQp+SGNh79vTVT4EaaBsVbkdsRQpDHl/VATz3pomzr5dElWIZr9OUEYeWEh94P6EoBVWQw1p2xgQ==
X-Received: by 10.223.199.137 with SMTP id l9mr563629wrg.113.1510148904602;
        Wed, 08 Nov 2017 05:48:24 -0800 (PST)
Received: from PC5175.ad.datcon.co.uk ([2620:104:4001:73:a407:552d:75e4:4516])
        by smtp.gmail.com with ESMTPSA id q74sm5757300wrb.51.2017.11.08.05.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Nov 2017 05:48:23 -0800 (PST)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH v2] doc/SubmittingPatches: correct subject guidance
Date:   Wed,  8 Nov 2017 13:47:52 +0000
Message-Id: <20171108134752.214056-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171108131601.280992-1-adam@dinwoodie.org>
References: <20171108131601.280992-1-adam@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The examples and common practice for adding markers such as "RFC" or
"v2" to the subject of patch emails is to have them within the same
brackets as the "PATCH" text, not after the closing bracket.  Further,
the practice of `git format-patch` and the like, as well as what appears
to be the more common pratice on the mailing list, is to use "[RFC
PATCH]", not "[PATCH/RFC]".

Update the SubmittingPatches article to match.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---

I'm re-rolling this patch with some more substantive changes, as a bit
more research points to (a) "RFC PATCH" being more common on this
mailing list than "PATCH/RFC", at least in recent usage, and (b) so the
instructions match the best practice according to `git format-patch` and
friends.

 Documentation/SubmittingPatches | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 558d465b6..95abf6084 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -184,12 +184,14 @@ lose tabs that way if you are not careful.
 
 It is a common convention to prefix your subject line with
 [PATCH].  This lets people easily distinguish patches from other
-e-mail discussions.  Use of additional markers after PATCH and
-the closing bracket to mark the nature of the patch is also
-encouraged.  E.g. [PATCH/RFC] is often used when the patch is
-not ready to be applied but it is for discussion, [PATCH v2],
-[PATCH v3] etc. are often seen when you are sending an update to
-what you have previously sent.
+e-mail discussions.  Use of markers in addition to PATCH within
+the brackets to describe the nature of the patch is also
+encouraged.  E.g. [RFC PATCH] is often used when the patch is not
+ready to be applied but it is for discussion, and can be added
+with the `--rfc` argument to `git format-patch` or `git
+send-email`, while [PATCH v2], [PATCH v3] etc.  are often seen
+when you are sending an update to what you have previously sent,
+and can be added with the `-v <n>` arguments to the same commands.
 
 "git format-patch" command follows the best current practice to
 format the body of an e-mail message.  At the beginning of the
-- 
2.14.3

