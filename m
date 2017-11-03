Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 090B920450
	for <e@80x24.org>; Fri,  3 Nov 2017 23:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753178AbdKCXQJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 19:16:09 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:55482 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751942AbdKCXQI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 19:16:08 -0400
Received: by mail-qk0-f194.google.com with SMTP id i5so382248qki.12
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 16:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jeancarlomachado-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=BCUhp2gggCiKDfAdqS57eJP+4K/UiE+MP6BwfzaYwww=;
        b=RpT9RZ3gGeLAlkVU7lrym+sujCBtDcoI9+PDGF83hmgpTHABrNc7j50xu9lyYfyWve
         9xeetdqCLd0qTKCTP8I+rw+b4k+XRvcH7ENPloz/GEQnodmakqJwAetK0TfSdBK8Zghf
         0XSFWEJXAPm3PG1GgeCNyDO2e6pR/3S1OJ2jc/Ms29/MU8Sqf7Hu4FC/dW6j+XPRFSlx
         WNxU91wnC35LHUxNfaEd+qUQLnlePEBImCNrTzCedhZ4P+peqHbs+93o/kGNzw6LYjWi
         CvDi7CJC3o4EJiVZRQdy9wmjhvbqFy+5APbzRodespSlLkoVnb2M2MMh9ALIB8G+WwMP
         YV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BCUhp2gggCiKDfAdqS57eJP+4K/UiE+MP6BwfzaYwww=;
        b=XC2IW2/Q+EljJ9grgk/ZYOecjeAzwZjj+T3GSWL2oCURLqBrTAGCZJIU/R2z6IWXzs
         HXCYMjW+d5UodCjwzxIr8YHN3Ebi3//OA44J23UDYy30VZ57M+EDNJcuoT79Rl+d+lxW
         vOfqfbfBb83eo3qpNwKPM2wPAj0KhDqeehCYFm01C+cy3lVW2e0U3RNLX1n31j9lydzx
         80AmDKu3XKFPyxNS4nun8E5POXxSjYUPHIIh8Bcnx5YMXGTAqzF1ZjSKp4kHLodXnaoZ
         i9jsh1xs4KFNXZ8ALEQ1VYeN3Sc/f3wFHtvMX+OQ1uOvBroqFmPJbQmcA4eZ8xy/kZ2C
         Uhkw==
X-Gm-Message-State: AMCzsaUKlLdjBSV1ajdRvP850M1u0tNawApxxHY4s10KEN6zTZ6MSYax
        QWffUcCmAF5IxVHaQUXVzhMIfUZe22bd5A==
X-Google-Smtp-Source: ABhQp+S1HMURDt3QEP+W1q8qH8FHvxwMb2DNf6dNc17s+uY9OGMP4HQMk5NyyvbSsuI8AgsznnHZqg==
X-Received: by 10.55.113.70 with SMTP id m67mr12574402qkc.23.1509750967363;
        Fri, 03 Nov 2017 16:16:07 -0700 (PDT)
Received: from localhost.localdomain ([200.18.122.31])
        by smtp.gmail.com with ESMTPSA id l207sm4409490qke.97.2017.11.03.16.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Nov 2017 16:16:06 -0700 (PDT)
From:   Jean Carlo Machado <contato@jeancarlomachado.com.br>
To:     git@vger.kernel.org
Cc:     Jean Carlo Machado <contato@jeancarlomachado.com.br>
Subject: [PATCH] fix typos in 2.15.0 release notes
Date:   Fri,  3 Nov 2017 21:15:49 -0200
Message-Id: <20171103231549.9140-1-contato@jeancarlomachado.com.br>
X-Mailer: git-send-email 2.15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Documentation/RelNotes/2.15.0.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RelNotes/2.15.0.txt b/Documentation/RelNotes/2.15.0.txt
index 248ba70c3..cdd761bcc 100644
--- a/Documentation/RelNotes/2.15.0.txt
+++ b/Documentation/RelNotes/2.15.0.txt
@@ -65,7 +65,7 @@ UI, Workflows & Features
    learned to take the 'unfold' and 'only' modifiers to normalize its
    output, e.g. "git log --format=%(trailers:only,unfold)".
 
- * "gitweb" shows a link to visit the 'raw' contents of blbos in the
+ * "gitweb" shows a link to visit the 'raw' contents of blobs in the
    history overview page.
 
  * "[gc] rerereResolved = 5.days" used to be invalid, as the variable
@@ -109,13 +109,13 @@ Performance, Internal Implementation, Development Support etc.
  * Conversion from uchar[20] to struct object_id continues.
 
  * Start using selected c99 constructs in small, stable and
-   essentialpart of the system to catch people who care about
+   essential part of the system to catch people who care about
    older compilers that do not grok them.
 
  * The filter-process interface learned to allow a process with long
    latency give a "delayed" response.
 
- * Many uses of comparision callback function the hashmap API uses
+ * Many uses of comparison callback function the hashmap API uses
    cast the callback function type when registering it to
    hashmap_init(), which defeats the compile time type checking when
    the callback interface changes (e.g. gaining more parameters).
-- 
2.15.0

