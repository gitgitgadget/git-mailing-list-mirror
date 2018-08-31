Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEEB71F404
	for <e@80x24.org>; Fri, 31 Aug 2018 16:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeHaU61 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 16:58:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43872 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbeHaU61 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 16:58:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id x6-v6so5717771plv.10
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UMkQ8KdGUXXrYDJJw9s3rhgZl2giu0wohYyJNTzKn4w=;
        b=Z9a/37m66maiixI+HX4CBo0ZkwaXxf4ZYXBK7OMAOAVz3Qdjst0U3fDrEEFhZJOhSG
         WybIxI3Cc1zxbq5a0AGFac15pfsyRvRqcB4uxC9u28Uz2wXqmgn3nfb8TCXL7+3O6Qn1
         ltgjniFZJejmrbp0kx3CVnA4WtOoLgeTp3qi8F4qxuDStWLEKM9i0Gv/oYn4/1WCS8+F
         h8KQmLzkofYENBU7+132tPcyl2WPOThIWp0SUMFBgqyjGFNFYcr9SgmkGEFOsJ/U9xO1
         NHnOJl6IYg37RCt3cSOX+e2XhUwVxfIufQBo04cDV5e3b0t/+af6Qp/eIbk0Yq1adXuL
         XqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UMkQ8KdGUXXrYDJJw9s3rhgZl2giu0wohYyJNTzKn4w=;
        b=m2+O70Nfvsfm2+uEubP14xYSi0wo1/j9liRjh466vu0UwukjonnrE07A9g4EP+GI8I
         W0U4wQajQSgIDHgoBRv+6926aPAYafWKbngCm6RL/4pBc7TBn5h89BKGRkO3e+jeu48F
         a46y5ts3L97Yg6LJmLNLJQbl76BEPqBxeJSj6nEe3IsnnyKXibmveutqbmOSO43YvwPc
         nVucOF8/HTdj+Ixp6nVgzpNvgcD0OTZphq4rLeiBzLF5M4/V5XcEOeVxt533Qyv1JYFW
         lTA41/xIdPOBEqy6U12ID23oR/P4NheZ95IQ+xRYk8DNaPa0T7BLwNJ7Bz5fH3laKLng
         vhFg==
X-Gm-Message-State: APzg51DTS+3IO6m5shjHIp0VkF/FrWEZ8zvJq3tGU+29Ugsue5GzEOin
        8s/h96SPiqw/yB9eFBhoeR6xbXJh
X-Google-Smtp-Source: ANB0Vdb1NAT/I9kN2WRWt3WG6VRfxiGTqYAkdBI/r8YhvXY4cZCGGe3T19XifsvxVJ6sTdX7S6JoNQ==
X-Received: by 2002:a17:902:a987:: with SMTP id bh7-v6mr16719060plb.182.1535734205755;
        Fri, 31 Aug 2018 09:50:05 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id p1-v6sm13514981pfn.53.2018.08.31.09.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 09:50:05 -0700 (PDT)
Date:   Fri, 31 Aug 2018 09:50:05 -0700 (PDT)
X-Google-Original-Date: Fri, 31 Aug 2018 16:49:51 GMT
Message-Id: <cb64de09f3d857de448c27245693311bf7c7e5b0.1535734192.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.29.git.gitgitgadget@gmail.com>
References: <pull.29.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 8/8] trace2: demonstrate use of regions in
 read_directory_recursive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add trace2_region_enter() and _leave() calls inside read_directory_recursive()
to show nesting and per-level timing.

TODO Drop this commit or ifdef the calls.  It generates too much data to
be in the production version.  It is included in this patch series for
illustration purposes only.  It is typical of what a developer might do
during a perf investigation.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dir.c b/dir.c
index aceb0d4869..c7c0654da5 100644
--- a/dir.c
+++ b/dir.c
@@ -1951,6 +1951,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 
 	strbuf_add(&path, base, baselen);
 
+	trace2_region_enter("read_directory_recursive:%.*s", baselen, base);
+
 	if (open_cached_dir(&cdir, dir, untracked, istate, &path, check_only))
 		goto out;
 
@@ -2042,6 +2044,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	close_cached_dir(&cdir);
  out:
 	strbuf_release(&path);
+	trace2_region_leave("read_directory_recursive:%.*s", baselen, base);
 
 	return dir_state;
 }
-- 
gitgitgadget
