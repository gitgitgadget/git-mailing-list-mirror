Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557C0C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 14:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbiHBOIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 10:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbiHBOIG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 10:08:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BED28E38
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 07:08:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so15453917pjk.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 07:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=cqhpm3VKE0vaOQkxouKt6UYlE9Ah9tmUZvCFwhH/Zx8=;
        b=XdouRBaLGNbXkFGxQ1kkBZjPVuLa0qMdFPLHHyT4jR2SH/ERtg5fepzB3YXSIoobxW
         2kLdMOTM8OhJmRcDFyNG46m9q+h11CaGYGJiyCeuGvAFjJjMCb+33woCoHNc9jAOlnHI
         3yMao3h2Pkv7RsX5PsbAW9jtKpuBWn3+R/WnasPOAXy2HTIwJ7NlteQRQcpr5zb3v64w
         9wi67GyxOECecYOHOE69WIGCXUX+MYEbbr+wR7j3z+Wz1DpcoNy5rm1Px7SD6p02eflP
         +9V1/Vu3NnTUtMZMLMagv0uUB+HcLwWLEQC30kLRi89OfnAh2PKM1mjgCasWYRS3Mydr
         64vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=cqhpm3VKE0vaOQkxouKt6UYlE9Ah9tmUZvCFwhH/Zx8=;
        b=k0Kr92zEyMT599D+D2fZJjcN9NPKkzgarnEOjcJYhQuGlzWjhSUMVpzNrkUdyHh2dy
         TVx2dq8Y9Ze7sMyuFRFE8OLPYOd2G4Ox5BGEAJ/BwaDktyxvX0jn+MreOw4qstutICTE
         nn6sNllbl3G5xKjUvHJPFN1eiFUGt4ebWZDdFu3QcV4PEHnY7f4yCdd4qfQ9H5iy0BPA
         dnISSlKvzcE7RIY1o8d8xmtEVcFv+Wk97saEsb9hVhjd9f1H7nxw+J+KxUL9HyVY/GHz
         q3tiPxGlnmaTw2j8CJ/43ou/qycQFO/QDiJK+/fTNYVjer2DSkc4J5LgGBUFJl8TMBw3
         3Hxw==
X-Gm-Message-State: ACgBeo2NXF9EDikKtBycKy70goo1jWbkvhzaQjZcWQJ8U0x3Xv0Yi3it
        i1H3ewirQfdmGPynS+uQxY249iUr7xb55Q==
X-Google-Smtp-Source: AA6agR5I5vjBfVvjEYfGDiZu0x/SgXizbJANH6PSnz1LmgjmFLtnmamhUAHhsPektT63WQiVEo43CA==
X-Received: by 2002:a17:90b:3b48:b0:1f5:330a:3a0f with SMTP id ot8-20020a17090b3b4800b001f5330a3a0fmr1897882pjb.93.1659449284053;
        Tue, 02 Aug 2022 07:08:04 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.59])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902e14c00b0016be368fb30sm11639658pla.212.2022.08.02.07.08.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Aug 2022 07:08:03 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Git <git@vger.kernel.org>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC] Abhradeep's GSoC blogs (2 Aug, 2022 IST)
Date:   Tue,  2 Aug 2022 19:37:45 +0530
Message-Id: <20220802140745.44594-1-chakrabortyabhradeep79@gmail.com>
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

Title - GSoC Week 7: improving Performance tests
Blog link - https://medium.com/@abhra303/gsoc-week-7-improving-performance-tests-ea9bfa180775

Summary - 

In this week I work further on Git specific CRoaring fixtures.
Besides, there were another round of review on my bitmap-lookup-table
patch series.

For now I wrote all Git specific functions in roaring.c functions.
As Taylor told me — we first need to check whether roaring bitmaps
really create an impact in performance. With these functions roaring
bitmaps can now be stored in network byte order which means it can
work in big-endian systems also.

Performance tests that I wrote previously were not accurate. Because
the second call to test_bitmap is always working on the previously
repacked repo, causing the the performance of the second call much
faster than the previous one. My solution is to create a new file for
each cases (i.e. with lookup table enabled and with lookup table disabled).

There is another problem which is mysterious in nature. A test case under
`t5327-multi-pack-bitmaps.sh` (and under `t5327-multi-pack-bitmaps-rev.sh`
is failing when `GIT_TEST_DEFAULT_HASH=sha256`. It is passing in every other
scenario. I found that this issue is related to the test script itself (and
not related to the implementation code). I didn't get enough time to look
into it though. I hope that I will be able to figure out the problem soon.


Previous blogs 
---------------

-------------------------------------------------------

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
