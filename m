Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B87CC1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 17:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbfJCRxe (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 13:53:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34066 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfJCRxe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 13:53:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id a11so3738791wrx.1
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dSYzULpKCB90awZYkWbVLofve282VSy1jgL9ORwkR+0=;
        b=naf8dXZSpDiTijrLJ2zkLQ2FSBgWg5+kqXlfYmlkQnBAO9qw5vcM+wRhU/sr+cAh0F
         +b+H2q6pZki7CkPhGXw/DJBTxK1MHk69Z1hwkkVkXhFZVEVUzCeg6Jq17g6YoFSFsAj5
         3iXdDuesIlxM7ERu89hI6YWUd7PnEOJHgO8vlSFUmN3ilhhUqUBjqaxNP/S2xuQnMiCx
         1k4xXVG9SY8kQSEjttC5JOJicSOb0nBUAf1k8bzU5L9dMGdwbb27CrzAgLSq9HCdQbuQ
         Lbp+XpG3ZOf4VlBxbdxHqnISgNvmOMUZGzXnQ7GCPPnT5e8ox7KSUnS+jMMdv/6LDNQE
         LjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dSYzULpKCB90awZYkWbVLofve282VSy1jgL9ORwkR+0=;
        b=NIoqxS7kDvqaObcDwOdQ7PVmm8a0DG9pKD8FA/b6VpKwpkTbcpkfoaBkLephyrP+NE
         ewcH3oi9phwbHV3nCTXh825dsiq9yP2G/oP45Ti5QZy4pP1P60IgaPxM2+0CQVtlbpf+
         RC5Fk0htrmIRNj4CAFN5c5TA/8cnJh7Iq90Fdn7RiCImgTtCaT3QcE+CA/+/WGpOTqTe
         Ms3x8pqCR7vsm2BxnJP0w0oTkmyDouCP57BmaPLCXm4s0qx4DjQSmyUb4kSZnRT7kxhG
         bE6K+R8XUWoNdtzc5swnhFib9j9Um5kfOihcG5ZEvZOM33dgHV/wPrAD950Dj0tsV2f9
         vnjw==
X-Gm-Message-State: APjAAAVNz5RRspPA5gVuBwxn0EJXOr8gdcNgj4eKPyK/vmd+YAchCf/A
        1D/oPWGagjY2MdJqg9wFROGdlKaZ
X-Google-Smtp-Source: APXvYqzkQuQb0iOrqvrFp+kxIqyaS15H/rF7tLzq5xeJ1Nzk/LYmmhUa1HiHR2ElC0y9IZZLZH0DDg==
X-Received: by 2002:adf:f34c:: with SMTP id e12mr8056638wrp.320.1570125211679;
        Thu, 03 Oct 2019 10:53:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6sm4035403wrr.85.2019.10.03.10.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 10:53:31 -0700 (PDT)
Date:   Thu, 03 Oct 2019 10:53:31 -0700 (PDT)
X-Google-Original-Date: Thu, 03 Oct 2019 17:53:23 GMT
Message-Id: <pull.337.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.v2.git.gitgitgadget@gmail.com>
References: <pull.337.v2.git.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/6] multi-pack-index: add --no-progress
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, stolee@gmail.com,
        jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git contributors,

This is the third iteration of changes for adding support for
--[no-]progress to multi-pack-index, and it includes the following updates
for the feedback I received on v2:

 * Fixed commit message formatting
 * Updated 'pack_paths_checked' from u32 to unsigned

Thanks, William

William Baker (6):
  midx: add MIDX_PROGRESS flag
  midx: add progress to write_midx_file
  midx: add progress to expire_midx_packs
  midx: honor the MIDX_PROGRESS flag in verify_midx_file
  midx: honor the MIDX_PROGRESS flag in midx_repack
  multi-pack-index: add [--[no-]progress] option.

 Documentation/git-multi-pack-index.txt |  6 ++-
 builtin/multi-pack-index.c             | 18 +++++--
 builtin/repack.c                       |  2 +-
 midx.c                                 | 71 ++++++++++++++++++++------
 midx.h                                 | 10 ++--
 t/t5319-multi-pack-index.sh            | 69 +++++++++++++++++++++++++
 6 files changed, 149 insertions(+), 27 deletions(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-337%2Fwilbaker%2Fmulti-pack-index-progress-toggle-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-337/wilbaker/multi-pack-index-progress-toggle-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/337

Range-diff vs v2:

 1:  6badd9ceaf ! 1:  cd041107de midx: add MIDX_PROGRESS flag Add the MIDX_PROGRESS flag and update the write|verify|expire|repack functions in midx.h to accept a flags parameter.  The MIDX_PROGRESS flag indicates whether the caller of the function would like progress information to be displayed. This patch only changes the method prototypes and does not change the functionality. The functionality change will be handled by a later patch.
     @@ -1,6 +1,7 @@
      Author: William Baker <William.Baker@microsoft.com>
      
          midx: add MIDX_PROGRESS flag
     +
          Add the MIDX_PROGRESS flag and update the
          write|verify|expire|repack functions in midx.h
          to accept a flags parameter.  The MIDX_PROGRESS
 2:  3bc8677ea7 ! 2:  0117f55c9d midx: add progress to write_midx_file Add progress to write_midx_file.  Progress is displayed when the MIDX_PROGRESS flag is set.
     @@ -1,6 +1,7 @@
      Author: William Baker <William.Baker@microsoft.com>
      
          midx: add progress to write_midx_file
     +
          Add progress to write_midx_file.  Progress is displayed
          when the MIDX_PROGRESS flag is set.
      
     @@ -14,7 +15,7 @@
       	uint32_t alloc;
       	struct multi_pack_index *m;
      +	struct progress *progress;
     -+	uint32_t pack_paths_checked;
     ++	unsigned pack_paths_checked;
       };
       
       static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 3:  3374574001 ! 3:  d741dc60bc midx: add progress to expire_midx_packs Add progress to expire_midx_packs.  Progress is displayed when the MIDX_PROGRESS flag is set.
     @@ -1,6 +1,7 @@
      Author: William Baker <William.Baker@microsoft.com>
      
          midx: add progress to expire_midx_packs
     +
          Add progress to expire_midx_packs.  Progress is
          displayed when the MIDX_PROGRESS flag is set.
      
 4:  29d03771c0 ! 4:  f208c09639 midx: honor the MIDX_PROGRESS flag in verify_midx_file Update verify_midx_file to only display progress when the MIDX_PROGRESS flag is set.
     @@ -1,6 +1,7 @@
      Author: William Baker <William.Baker@microsoft.com>
      
          midx: honor the MIDX_PROGRESS flag in verify_midx_file
     +
          Update verify_midx_file to only display progress when
          the MIDX_PROGRESS flag is set.
      
 5:  57f6742f09 ! 5:  7566090769 midx: honor the MIDX_PROGRESS flag in midx_repack Update midx_repack to only display progress when the MIDX_PROGRESS flag is set.
     @@ -1,6 +1,7 @@
      Author: William Baker <William.Baker@microsoft.com>
      
          midx: honor the MIDX_PROGRESS flag in midx_repack
     +
          Update midx_repack to only display progress when
          the MIDX_PROGRESS flag is set.
      
 6:  5b933ab744 ! 6:  a3c50948d9 multi-pack-index: add [--[no-]progress] option. Add the --[no-]progress option to git multi-pack-index. Pass the MIDX_PROGRESS flag to the subcommand functions when progress should be displayed by multi-pack-index. The progress feature was added to 'verify' in 144d703 ("multi-pack-index: report progress during 'verify'", 2018-09-13) but some subcommands were not updated to display progress, and the ability to opt-out was overlooked.
     @@ -1,6 +1,7 @@
      Author: William Baker <William.Baker@microsoft.com>
      
          multi-pack-index: add [--[no-]progress] option.
     +
          Add the --[no-]progress option to git multi-pack-index.
          Pass the MIDX_PROGRESS flag to the subcommand functions
          when progress should be displayed by multi-pack-index.

-- 
gitgitgadget
