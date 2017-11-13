Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD5671F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 14:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbdKMOPP (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 09:15:15 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39899 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdKMOPO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 09:15:14 -0500
Received: by mail-wm0-f68.google.com with SMTP id l8so9614706wmg.4
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 06:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cJpNZ4Bx8IVCHDeZ9NkfrfTo2xvGtCuiUR9G8jTTTuk=;
        b=eomOiqvk9Qs/7UupItA09XRpT2yDL31GIXCqc5foFsx0GQXeJBw+Iu81ajrujmMNry
         UtDikill+rdp3nj0GUqOB5zBVKMqNpraCyQXzZM/EGJdDkw2UvuEKvYN/w7VJBW6HSuK
         KSWYQkU9ez5WbqsHeCHY/Prv4m0dtBwcnFlJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cJpNZ4Bx8IVCHDeZ9NkfrfTo2xvGtCuiUR9G8jTTTuk=;
        b=nTAAlZR3kLZf4JYsQOOKIgplY7P/+i2WCEdRr5hd4kK7z6yjuvb+hwRtJvQhTljnAB
         idfJPaSCVAgWn+qFP1z2Qeq4Lx7DT6xBZoVz5S1IsHMkfX36hYduZQpRFsz7Duk4cccj
         9X0CDKWhsb+LlxgT9UDS6+temiQTRDtVFOcQHtN48Z92QhoETG1e33roub52Z87A7I7d
         FLAlIGoObBsWE2JHSXnKjARWKQGIg+pqHFUJZrpesCaxvNPKmF5LrrfzW4KdbcXAuu3v
         NyT6L4h6IabQyJ6AxCCalqSvcp9IKXH6JESNzEHGgkqs4IqckvBRmsjnZ65NBmeZLLoQ
         MkBA==
X-Gm-Message-State: AJaThX7EmYEnybTQl3QGlNR0brLYqDBom7RvoQhVdIdWWGSCeSDW40ak
        Y6B/EAWmlVLlRuTCFS9Qw7IJqw==
X-Google-Smtp-Source: AGs4zMYNgtdeIsIZS3d78XFo1vlxZNUNhzgVIxNejGLi8f1+598ZlL2Z8KQoLwrsPRHlBm+unhZ6VQ==
X-Received: by 10.28.105.142 with SMTP id z14mr7060313wmh.41.1510582513040;
        Mon, 13 Nov 2017 06:15:13 -0800 (PST)
Received: from wildmoose.dk ([2a01:488:66:1000:57e6:57d1:0:1])
        by smtp.gmail.com with ESMTPSA id k30sm18855993wrf.52.2017.11.13.06.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2017 06:15:12 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 1/2] Documentation/config: add sendemail.tocmd to list preceding "See git-send-email(1)"
Date:   Mon, 13 Nov 2017 15:14:42 +0100
Message-Id: <20171113141443.19141-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 Documentation/config.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 671fcbaa0..d88fc9f63 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3000,6 +3000,7 @@ sendemail.smtpPass::
 sendemail.suppresscc::
 sendemail.suppressFrom::
 sendemail.to::
+sendemail.tocmd::
 sendemail.smtpDomain::
 sendemail.smtpServer::
 sendemail.smtpServerPort::
-- 
2.11.0

