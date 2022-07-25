Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B56C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 15:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbiGYPYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 11:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbiGYPX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 11:23:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E30FDED3
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 08:23:53 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h132so10650860pgc.10
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 08:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2bXhsdGRNa/RRRpDzxUn64GStFxYaehOTrWTrOIBXc=;
        b=S6Vh2RxkadfOZXjWLgh74zTbz39md+PS6rzCnpLxgDXr+08oNJKhrndgM93IaLxAu3
         bq7Y7jRsBvOkiER5YmPRtsr847l9kzP/yZQI6roLE5gFtKKHbSfcrU5xiK0+dYfB37W8
         BFYv8y8g4/P3O44imth3dSRfr6eaiPmJ2JkML4vrdHDoEtvr0wdtUTh23rDxCzGrlDVA
         Irh6Crgh0P2EttqQFAFU12UOqy7GJoHHPHJS/FcKSp6CZ5GBaQVtj/EK2g8OpccTMWWz
         Ht1AD+IgyEDIoq4cZZDT4omsytOHoTAcYSnkdBS+wa9/iBgorkIsIukFHpfOpX4m8dPV
         Wt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2bXhsdGRNa/RRRpDzxUn64GStFxYaehOTrWTrOIBXc=;
        b=ft0RRb81FthLYuA7Co6dArFWNnnLckgf5Ok7ZkvlEwERDpiSBuYLCtQJacz5n2kqoh
         5T6Xkwctm/kpOGzA3WXH+SbkZHRVy1moI2Tb3ZzVPghslfruKnxkRPuzANKV2y1auRiC
         lTpAbMPUC0zZcLEBuJE3Rb+5iMIpGXWikhd1L/+UNxA/t7MzIpTFIsWvDNPzHq89sI+4
         6zM5LEx1IHfzn4DGXTfynFevAFxLinCmoxKG+C4ZDc3izWtXUUBgeNyU08hbyDDTBWvf
         F/qpMMSQImu8HZ9eCw5iFj9JOnYfjAowpfXif5mBNOGy9JNtGoMcx/kco9Kf4/8jLINT
         sqHg==
X-Gm-Message-State: AJIora9fCg05Jt+frnyo0AWvmstbG954JtW25RVoHt7dUpsXiu2Mgbp/
        mExe8a2lL9HkCGy/y+teGPcMMgCM9CQAxA==
X-Google-Smtp-Source: AGRyM1t8UK1ckDQP1rPgHiPkbWOR8Z8Am1gT+o9Ym/ZlRWeQb3ArAckyuvodE/ve4+vugcYgIbAfaA==
X-Received: by 2002:a05:6a00:1948:b0:525:45e3:2eb7 with SMTP id s8-20020a056a00194800b0052545e32eb7mr13419928pfk.77.1658762632164;
        Mon, 25 Jul 2022 08:23:52 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.21])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090341cc00b0016a111c83cdsm9509739ple.119.2022.07.25.08.23.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Jul 2022 08:23:51 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     git@vger.kernel.org
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC] Abhradeep's GSoC blogs (25 Jul, 2022 IST)
Date:   Mon, 25 Jul 2022 20:53:26 +0530
Message-Id: <20220725152326.60497-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello developers, this is the thread where you can know about
my weekly GSoC blog links.

My Project - Reachability bitmap improvements

Blog update
------------

Title - GSoC Week 6: using CRoaring library
Blog link - https://medium.com/@abhra303/gsoc-week-6-using-croaring-library-be309cfa89f5

Summary -

I missed the week 5 blog update. So this blog covers both
week 5 and week 6 work updates. I submitted my latest version
Of `lookup-table-extension` patch series. There are some issues
with CRoaring e.g. it do not store in network byte order (which I
confirmed in Roaringbitmap's google group[1]). So, I need to make
some changes to fix it. I have already finished implementing
`roaring_portable_network_serialize` and `..._deserialize`. My
next step is to use its functions in Git's codebase. I will
submit the patch series soon.

Previous blogs 
---------------

-------------------------------------------------------

Title - GSoC Week 4: diving into roaring bitmaps
Blog link - https://medium.com/@abhra303/gsoc-week-4-diving-into-roaring-bitmaps-f028f931d873

Summary -

I am thinking of submitting a patch to explain the workings
of bitmaps. I will be creating a new file 'technical/reachability-
bitmaps.txt` for that. This week I spent my time on diving more into
Croaring[1]. I tried to understand how they work internally, the
available functions they offer, their serializing format etc.
The serialisation format[2] seems fine to me but still I want to
know Kaartic and Taylor’s opinions. Another thing I noticed here is
that each roaring bitmaps are designed to store sets of 32-bit
(unsigned) integers. Thus a Roaring bitmap can contain up to 4294967296
integers. I am not sure if this is sufficient for us.
My next step is to make the new bitmap format version 2(with roaring
bitmaps) and modify rest of the code so that those code can accept
the new bitmap format version.

-------------------------------------------------------
Title - GSoC Week 3: working on further improvements
Blog link - https://medium.com/@abhra303/gsoc-week-3-working-on-further-improvements-13a27db64cd5

Summary -

In this week, I continued to work on further improvements of 
The bitmap-lookup-table patch series. Some of the requested
changes are (1) Improve the documentation and fix typos (2) add
comments (3) Disable `pack.writeBitmapLookupTable` by default
(4) Fix alignment issues (5) Make a `bitmap_lookup_table_triple`
struct (6) Subtract the table_size from index_end irrespective of
the value of GIT_TEST_READ_COMMIT_TABLE.

After implementing all the requested changes, I started working
on the idea I mentioned in my previous blog as my next step. The
idea is to stop the xor stack filling loop if the current xor
bitmap is already stored and assign `xor_bitmap` to it. As this
bitmap is already stored, we don't need to iterate further as we
know all the other bitmaps that are needed to parse this bitmap
has already been stored.

My next step is to roughly implement roaring run bitmaps and
run performance tests to check if it's really worth it.

-------------------------------------------------------
Title - GSoC Week 2: redesign the table format
Blog link - https://medium.com/@abhra303/gsoc-week-2-redesign-the-table-format-829dae755a5

Summary - 

In the last week, I worked on the reviews. Some major requested
changes are (1) Use commit positions instead of commit oids in
the table. (2) Use 8 byte offset positions instead of 4 bytes
(3) use iterative approach for parsing xor bitmaps (4) Use
`<commit_pos, offset, xor_pos>` triplets.

While implementing these changes, I discovered some bugs in the
previous version. I faced errors during this time. But finally
managed to fixed those errors. Taylor helped me to get rid of
some errors.

I think that we can optimise the parsing of xor bitmaps further
by stopping stack filling loop when we get an already parsed
bitmap since we know that bitmaps having xor relations with it
has already been stored/parsed.

------------------------------------------------------- 
Title - GSoC Week 1: Let's Get started
Blog link - https://medium.com/@abhra303/gsoc-week-1-lets-get-started-fad78ec34dcf

Summary -

This is the first blog that I wrote for GSoC. Taylor
suggested that I should work on "integrating a lookup table
extension" first as it is smaller compared to other sub-projects.

The idea is to have a table at the end of .bitmap file which
will contain the offsets (and xor-offsets) of the bitmaps of
selected commits. Whenever git try to get the bitmap of a
particular commit, instead of loading each bitmaps one by one,
git will parse only the desired bitmap by using the offset and
xor-offset of the table. This will reduce the overhead of
loading each and every bitmap.
-------------------------------------------------------
