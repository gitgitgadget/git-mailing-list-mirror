Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09A2320A40
	for <e@80x24.org>; Sun, 26 Nov 2017 20:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbdKZUTj (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 15:19:39 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40916 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbdKZUTh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 15:19:37 -0500
Received: by mail-wr0-f195.google.com with SMTP id s41so19097224wrc.7
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 12:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gl5xpM9E+aDibzN9BW7nBoO3/OZ9xikJIut41Z6xEy8=;
        b=VksNaGGe9Az3vxYQf2Z+9VX9ZVIUoAHsR3rUnnHyUtYrOB1OseLYricMvoOfEskyIM
         wGe0HFYLU4+/kEWR5dlm8MJH3TCEMSh6z0ow22dJTIKdcS7oHdj/xhIEG4+VqMjbZ6dW
         p0k+pA/fqCqDujN818/IB/4A74lIASXfPJRNlWtEtl/ilgzfIIp+rLzgztm5OK1unKy9
         L4dKPyNs6e5y421XTvBjxMkLwASk6LMuAI2zp2NCqaiFpCMC/k2k3oKS/KoOs4SCvh11
         Ny+i+cWXGk6L3deP7ntCtgSnTrCgREeuboW3NH7yYjelG+fQARJIo9fJJUMfNzgqPytv
         l9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gl5xpM9E+aDibzN9BW7nBoO3/OZ9xikJIut41Z6xEy8=;
        b=cHUVeYRmAi+u/C+fe4LjCPwk3Zf1HJHUyRXBSjtvNo6nyFRGAbQAileoDbSNhJBFNO
         xBekhcU0kIJzWYL5Q/M4J8Ng64u/PhVjwMjkZotwXUmp6/IWq+Pq2qCg38F9JyblXdvk
         /fxxNWcY6njmQx5mPSMaL/JLmyxsIr8zuh9sBIVi9RYVrAcIGxqOyQhgfPQ+7CM6F4ms
         EAO/jj/ZdpfZp6ghCeKgXYjMusaOsGhvi1TZXW+JC/vMeVFnFutt+uViLixD90jgvY/l
         7mL9EzIYJFWZaYFIoSINV/AsXjAPyOWYSGEYwzxN7VruWD85O3VZB5Ciluaw33CSfs8C
         x4LQ==
X-Gm-Message-State: AJaThX47RJ56DrDMhx8rUWOUCqVUtaOFzs9LE/CF/+C4HrFWYTTAhct3
        sFb9ZsFkenKMuOqRQ/pvrMVMLw9R
X-Google-Smtp-Source: AGs4zMYUfRMF0bsFSEyVoDe9QkcMJOeh2V8NosS52LCVEN5Ke7gEhqcBpfeZqXmo22hNX9VX50dtcQ==
X-Received: by 10.223.157.138 with SMTP id p10mr32028010wre.28.1511727576562;
        Sun, 26 Nov 2017 12:19:36 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id f10sm24929322wrg.20.2017.11.26.12.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Nov 2017 12:19:35 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v1 2/2] t/README: document test_cmp_rev
Date:   Sun, 26 Nov 2017 20:21:00 +0000
Message-Id: <20171126202100.1658-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.426.gb06021eeb
In-Reply-To: <20171126202100.1658-1-t.gummerer@gmail.com>
References: <20171126202100.1658-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test_cmp_rev is a useful function that's used in quite a few test
scripts.  It is however not documented in t/README.  Document it.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/README | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/README b/t/README
index 448569b60e..e867d1f8bd 100644
--- a/t/README
+++ b/t/README
@@ -674,6 +674,11 @@ library for your script to use.
    <expected> file.  This behaves like "cmp" but produces more
    helpful output when the test is run with "-v" option.
 
+ - test_cmp_rev <expected> <actual>
+
+   Check whether the <expected> rev points to the same commit as the
+   <actual> rev.
+
  - test_line_count (= | -lt | -ge | ...) <length> <file>
 
    Check whether a file has the length it is expected to.
-- 
2.15.0.426.gb06021eeb

