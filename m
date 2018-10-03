Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0A781F453
	for <e@80x24.org>; Wed,  3 Oct 2018 17:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeJDABh (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 20:01:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34148 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDABg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 20:01:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id f18-v6so3778412plr.1
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 10:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VuotZzHgDMRiVrQhM09A8eBcul7JL+o4OMz5phJz6yc=;
        b=AHP9e16/dT7bCgIGciuk7kWowsGCTSfnZsRlOU0r+fL6tcGHLeJ1SScKmCGSFlZV2P
         dJRsM4KuLieJwq3IDfnnLenHTXnyPyPgjk+WEs3u2t858VgZVrcrYG8ICKgjkX11WLuj
         wConWT2itKSvn9qgVC3eBy/aS3kbxLNRu7CorOiUrjD3MD4zNYokrR6Qy7Fw9CR7dYVI
         sAIsTa4af5gLsgfZineR3xcorJ3KX609ALd9mqbZ1FPKVlba9j8U+Y4RGZgzZwTjjiSH
         8r0cGGKPF/Zx4az1YtWlbDz/eBiCvq0MaHbBVd+809qTrvTX71HjVv6tN4KKRIKu3V7F
         2yYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VuotZzHgDMRiVrQhM09A8eBcul7JL+o4OMz5phJz6yc=;
        b=CTylfgA6j2AaTrMyon4INDz4B4H3yBo3bHGvuaj0ILbDNWDxvwqDVdlsVWEAdtyln2
         OkTR3wm3QmhJHtsyPZKfKmIiwCzX5A7I+R/RQaEGEsZBFQZky9RSph9E5mH/ukJ5LLAW
         ISvFwWwnkfX3DnHOyXybsN3ZKikDrqbDXe6mjjuP9V6WEag4m0EC40Ld27J/FgJRQer+
         DkwMP2MdkntOeNt4V4pFDLStYx9R37oZqTqyZ18HEE/KOs9zuSBWrWsan7Opy02HBp+6
         3tDL3QTKhysI+vOqwqeY+pmFarPPIFbpGMVdPBkbBah7+RYYcAoqZvmK/z36xY8MzS/6
         5Xvg==
X-Gm-Message-State: ABuFfoh4v/+SaSSjIb+vDJVK43grzNUbB5KGiB2HoDFvv0jTRgao9fEV
        0Lz8ERUxGj4d/8z3Y6RJajvryO3G
X-Google-Smtp-Source: ACcGV60MnCHe6eH35Swu40YPxTpz91yPq7g2MifRahqulowuNr+3HhWcNrqYSVs4v1coptpuuxmehQ==
X-Received: by 2002:a17:902:447:: with SMTP id 65-v6mr2556605ple.325.1538586740047;
        Wed, 03 Oct 2018 10:12:20 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id g17-v6sm3437090pfe.37.2018.10.03.10.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 10:12:19 -0700 (PDT)
Date:   Wed, 03 Oct 2018 10:12:19 -0700 (PDT)
X-Google-Original-Date: Wed, 03 Oct 2018 17:12:12 GMT
Message-Id: <1002fd34fc57e929265d07ad6e6010116b27b7a9.1538586732.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.42.v2.git.gitgitgadget@gmail.com>
References: <pull.42.git.gitgitgadget@gmail.com>
        <pull.42.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/3] commit-graph: reduce initial oid allocation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

While writing a commit-graph file, we store the full list of
commits in a flat list. We use this list for sorting and ensuring
we are closed under reachability.

The initial allocation assumed that (at most) one in four objects
is a commit. This is a dramatic over-count for many repos,
especially large ones. Since we grow the repo dynamically, reduce
this count by a factor of eight. We still set it to a minimum of
1024 before allocating.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index ceca6026b0..e773703e1d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -720,7 +720,7 @@ void write_commit_graph(const char *obj_dir,
 	struct progress *progress = NULL;
 
 	oids.nr = 0;
-	oids.alloc = approximate_object_count() / 4;
+	oids.alloc = approximate_object_count() / 32;
 	oids.progress = NULL;
 	oids.progress_done = 0;
 
-- 
gitgitgadget
