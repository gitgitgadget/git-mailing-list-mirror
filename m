Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A061E2021E
	for <e@80x24.org>; Thu,  3 Nov 2016 17:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933083AbcKCRqV (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 13:46:21 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34893 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754788AbcKCRqU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 13:46:20 -0400
Received: by mail-pf0-f179.google.com with SMTP id i88so35071650pfk.2
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UusqBTwUsuJFtS0t+ZqcggS26QmmzbsRhiH/PMXmbks=;
        b=SFGN+wplf1/OgRnncOpKA3xXVig7kH2649JiiCjoH88uz0g/LYnirZhIdpRmYbyiUR
         nFFhCZB0rUiqSOUAbyg8BeHDsWvA7C/0IIi15LmuTg2X3x9g1AHSavJfguSe3Lb+4pvs
         BSkAY98dGL05sPS8BwMJRuzqzbr9IFM6yj8mjloydARK2RlRy/B1t8nO4q/8+abZXs11
         ujaREXVx/uKX6+IoVze2tMtLDcqL+ZCaa/AhwM2FXNF56zjIlaS/5j0ibt24gIahqoA8
         XvSn6rhdfG1s1S6VPsoO8+vwr2BSccIdbuWKabKV7gXeqtAS7sbYmvZvFDRWDW+LkOGW
         srtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UusqBTwUsuJFtS0t+ZqcggS26QmmzbsRhiH/PMXmbks=;
        b=HjQExxFCfSd/0N0UVt/xC0Hq5c5I8s4ntndU3f248MbclcIQqkRD7esoqDguLV21yb
         IrkSS9nZj1uExaeN0gcCD9CChHYnSMqlrfqAzehWg5kWCHrZpJS682V2a1QOFJy4CSpN
         8//zQljrm+ywCQIzo6vstgDHo70N/xdBucQY8I4eyBfj01eUpeDlsX9hJin0L+xk9ber
         fOB6PFReUiQt7eqUQ6BfPpWM/ms3D83+oJfHEA4SfRed52b2KUEWoIQmyXr3iog2EaFm
         S9nIt29OX7govDl0QDPuXD9LJCxWlenAVBwUSBYkrT/UCPDKSE6KH9wkB2/ueeD5pQmL
         ZCRg==
X-Gm-Message-State: ABUngveK8gPnZq8OJsl6DkVLwgwZwK6WEyQvrsN1cVfDnvyashRePquq58r3d1WzBKPQj8ls
X-Received: by 10.98.36.195 with SMTP id k64mr18706658pfk.126.1478195180110;
        Thu, 03 Nov 2016 10:46:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4def:4049:79e6:a652])
        by smtp.gmail.com with ESMTPSA id t20sm14232414pfk.48.2016.11.03.10.46.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 03 Nov 2016 10:46:19 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] SQUASH to: submodule update: add `--init-default-path` switch
Date:   Thu,  3 Nov 2016 10:46:12 -0700
Message-Id: <20161103174612.15778-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.2.621.g399b625.dirty
In-Reply-To: <20161028185502.8789-35-sbeller@google.com>
References: <20161028185502.8789-35-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

I discovered this, when going over this series myself once again, as
I am thinking about how this setting may affect the
"git checkout --recurse-submodules" that I am currently working on.

I'll include this in a resend, if a resend is needed (i.e. more changes
are asked for by reviewers)

Thanks,
Stefan

 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 72901ef90e..0f13e75e52 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2888,7 +2888,7 @@ submodule.alternateErrorStrategy
 
 submodule.defaultUpdatePath::
 	Specifies a set of submodules to initialize when calling
-	`git submodule --init-default-group` by using the pathspec
+	`git submodule --init-default-path` by using the pathspec
 	syntax.
 
 tag.forceSignAnnotated::
-- 
2.10.2.621.g399b625.dirty

