Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712261F462
	for <e@80x24.org>; Wed, 12 Jun 2019 13:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbfFLN3o (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 09:29:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43850 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732419AbfFLN3l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 09:29:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id w33so25743754edb.10
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 06:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sv5vmWbc5juRCAMsYYTWzW/PZHLWJqBOAvm+GWswM1Q=;
        b=oNHvOD7AijRbIU5xhYAIkZcFwN93Dt3kGZAHxo18ZHATLwc1xY37hDV0DFfoJ+f2zY
         /3QHMgnqNUY2ou+nA5ksLCN+dNm5fJ4AeDbXgexjOS3moAygM2sZLqXcxm69vc75D+ft
         21QOuhD3FaZgvHCvPUXq0rqwwuc49amvb2GrITJOdpnQlTznJ3hdo/2r0fgbxHA1RUwq
         bkpaw0zKF26e4FpR8psdfPdc6EbQiS3lZDhmb2b2VeRZohu+m9IboF0f0zno7F7Pda/l
         6tLxkMI4OCbUEZDff6k0Ptq3BSL//uyveEi7ax5rgLxsGiocUDthcvqSrHl+K427ahyJ
         rFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sv5vmWbc5juRCAMsYYTWzW/PZHLWJqBOAvm+GWswM1Q=;
        b=eaJigDUqoGynG+WigFGEeJZgsgiZIHVecIkI6VR5kqHU+hXealYkzUqb06mSx+Nv63
         NHmLF5nnGgAMdurNwB7qPk83w+rVCrthklG5lRZgoSioMIMVnhCibNv8PioVaiahLpzV
         sDY9PhTRIe/TkPij4U1VBS3ILjc669lOEd/edWoxkPOSxkZSmAEQHr4aVUasztWJe+oS
         dLRfQu1lrROMwo+3TdAGHiNgJ+FmW4xBAYDYlMdluFPgOyksPxhyz9cD7B9wmX/CYlFg
         VZvzUCpJQG8LhrRvI8cQvzK8ifCaDIMZzYUbeXsM4tUufIU3ESKnfshEuoqMWGzlXTpz
         sdNQ==
X-Gm-Message-State: APjAAAUpXu2ZnkF5UCe8Kp8CaDYc5y3xtprTwEM5Eudv8WGqP91fVY2k
        06V0JkUuuZBxAPiolKxSzkgEpv1/
X-Google-Smtp-Source: APXvYqySKPP0d4ufMRAxQGajz7CcXTU62IRzTIynR/FVXUazA0ctF3dj4U9OIKZ7Q12jgoMeqW0lHQ==
X-Received: by 2002:a17:906:f10d:: with SMTP id gv13mr36198580ejb.151.1560346179851;
        Wed, 12 Jun 2019 06:29:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12sm2847956ejj.52.2019.06.12.06.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:29:39 -0700 (PDT)
Date:   Wed, 12 Jun 2019 06:29:39 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2019 13:29:26 GMT
Message-Id: <a5223a37a9b6e705d3240b90d6a9226375f9b1a1.1560346174.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v5.git.gitgitgadget@gmail.com>
References: <pull.112.v4.git.gitgitgadget@gmail.com>
        <pull.112.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 04/11] commit-graph: remove Future Work section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The commit-graph feature began with a long list of planned
benefits, most of which are now complete. The future work
section has only a few items left.

As for making more algorithms aware of generation numbers,
some are only waiting for generation number v2 to ensure the
performance matches the existing behavior using commit date.

It is unlikely that we will ever send a commit-graph file
as part of the protocol, since we would need to verify the
data, and that is expensive. If we want to start trusting
remote content, then that item can be investigated again.

While there is more work to be done on the feature, having
a section of the docs devoted to a TODO list is wasteful and
hard to keep up-to-date.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index 7805b0968c..fb53341d5e 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -127,23 +127,6 @@ Design Details
   helpful for these clones, anyway. The commit-graph will not be read or
   written when shallow commits are present.
 
-Future Work
------------
-
-- After computing and storing generation numbers, we must make graph
-  walks aware of generation numbers to gain the performance benefits they
-  enable. This will mostly be accomplished by swapping a commit-date-ordered
-  priority queue with one ordered by generation number. The following
-  operations are important candidates:
-
-    - 'log --topo-order'
-    - 'tag --merged'
-
-- A server could provide a commit-graph file as part of the network protocol
-  to avoid extra calculations by clients. This feature is only of benefit if
-  the user is willing to trust the file, because verifying the file is correct
-  is as hard as computing it from scratch.
-
 Related Links
 -------------
 [0] https://bugs.chromium.org/p/git/issues/detail?id=8
-- 
gitgitgadget

