Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3918D1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 22:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754196AbcHZW1U (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 18:27:20 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33414 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbcHZW1T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 18:27:19 -0400
Received: by mail-pf0-f173.google.com with SMTP id y134so32457623pfg.0
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=A1AWi3B3VH5YKt51G4CkW1x5kPqReZnvMzMztHnRS8g=;
        b=VkKxG3a6HURsS662WwpBPdM4Q8Fx+CUIRK4vGPZAMv+Y/3IBvNfcPlYDJbgoVhJJFI
         Tk6zGXQgTPoPhBl8xpA6s8fu4Rh8W3yANT2Sh0BnfqEf3Cu35O3o/hOtyNic7yqMECXE
         neXFUAsYAx7tH/Emw988JEg1TlLPVJyCYwqhYf5cRXWM10IUjtZ3eChU0WqmqaEKQXSQ
         dR8mnXDUvcQPB78YrS3aU9w4u4fsAyu56W/l4RAtWghrasgrguFFFadNXG4Bn/Iq7Nxk
         QC56N9OPXI5WPDrsyoXXK8yFMnRMl3L8blTLJlhwoSRlqGf4UoaHD8Ow+JB9wFzd0+wd
         lzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A1AWi3B3VH5YKt51G4CkW1x5kPqReZnvMzMztHnRS8g=;
        b=GdlFp7LPsyH2GkFlvFsKylJ3n+VrrdiJoeG1dPIS3LdDIZ+B4UwlhsFqK23MeHRRcv
         VG6I6IlcABldxCbz4F1p7ry7rSKk6b5jjF+KtOxQHBB2MLjchT8b3F4emsc+R6aPRECN
         gxpv/RfPzOh0P/VsP7yN3YVmhATfSVl9zUJBBz0G4v1P/vAf7zGs07liFy91pGU/Q0Cs
         EPvpK9IO+4vfiILl1st341IDSmBGuMYNxzPwHdt/O62/ClTLhebF32BogirdZP6c1BRk
         PUDudiRyzSpJQhJkNANa8qFItE4P0Rw8FTlWLGBs+ujgPIKQCJeHj6wHtB68Pazj2iG4
         5Org==
X-Gm-Message-State: AE9vXwM/k8lg1B66x6aNiMUyNL5y8VirP5Xb+x2lMx3GHQwByQwvuomRhl7vaFFL58ka5ewQ
X-Received: by 10.98.157.12 with SMTP id i12mr10047296pfd.164.1472250438815;
        Fri, 26 Aug 2016 15:27:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:cdff:9b0a:fea6:f8e8])
        by smtp.gmail.com with ESMTPSA id 6sm31139635pab.11.2016.08.26.15.27.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Aug 2016 15:27:18 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net, dev+git@drbeat.li,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] Documentation/SubmittingPatches: add quotes to advised commit reference
Date:   Fri, 26 Aug 2016 15:27:14 -0700
Message-Id: <20160826222714.31459-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.rc1.1.g1ceb01a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio finds it is easier to read text when the commit subject is quoted.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 500230c..a591229 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -123,7 +123,7 @@ archive, summarize the relevant points of the discussion.
 
 If you want to reference a previous commit in the history of a stable
 branch use the format "abbreviated sha1 (subject, date)". So for example
-like this: "Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
+like this: "Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
 noticed [...]".
 
 
-- 
2.10.0.rc1.1.g1ceb01a

