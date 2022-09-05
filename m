Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05942ECAAD3
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 11:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbiIELgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 07:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiIELf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 07:35:59 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAA81EC41
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 04:35:58 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q9so7880901pgq.6
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 04:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=5XAgwNA83krpW3rCx4qCaRwkTVGJMDiAyYC+Dk4rwMY=;
        b=dbe5G7NYUc8sGWRvB3oYIA5lXoGLqQM4++85r/vefT2utXivsz4dAQ5efXMl+Rmsf7
         lM0+sAB0HmLOW7v7uAOpjz/aRcCltSVIgTOXH2Z3X2leFCyPufqa2lY6q5XOZMATlrE4
         danR0a1sfLN1okGNC2LtuW0YjIX0g2FDD77aP/lfsXasMF4uk9GAxZHQkvuTcUczQxrS
         poENj1LcO0ITltYzbgbx+XErrI3vMg3D3vWWDwn3i5fWF5HenqFlf5Id3IbCv+h+bjM4
         glI8d6g1WT3YSuAoamOcRIWQaMPFDT6M35oSXh7BqomAREf6fW3vpFjD2gy0S3Qk4Vvt
         LIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=5XAgwNA83krpW3rCx4qCaRwkTVGJMDiAyYC+Dk4rwMY=;
        b=VQpZiVDRN/wJ5AJEZJ7dUFE8ZY7BVC430v8T7plJXf6NFQfIY9lHAGvoDIRrixm1Wz
         T02+xWV19uJuiQ2MDxp/Cw9nb6SQ07uKXZwfHH3W15AIYsutyTrK/GkT96OSbYZQerpr
         gZLwEciV9VcUAubChGQzZKGhPPy5AKOoQWfN3jrY3Y9D8x+INDrPuG7QyTv/rM25Fmr+
         kONvaXuSDtywm4lCO5FvIbSv+uxOov3dhwLn6mV+udHAwBAV9voTzYWw8VhLo1WNqmeX
         aQvw91bmnZSGaogNCFdhcVUvOpvHaVAtw5oevayL9/BSUU/HZe0fpyNiPgnWmYWW0PFB
         s6Xw==
X-Gm-Message-State: ACgBeo1bKcN7RTjD2OtFP2o7Uh/k1/eV1httG7a7cPN7eZO+8nrEsnQI
        NlNzaaUAl7K/C0KxQ6ei/m+slYtEXW8=
X-Google-Smtp-Source: AA6agR5VrPT86E1Gu8TtW/Yv4scZlFW8VDK9S+ADrwlVFwKqvy0R/+sGukSK5al/YFP4V9kOQ0w0XA==
X-Received: by 2002:a62:e217:0:b0:538:604:2dd0 with SMTP id a23-20020a62e217000000b0053806042dd0mr43336234pfi.70.1662377756923;
        Mon, 05 Sep 2022 04:35:56 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:293:5d0:8473:a983:febb:77f0])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902ce8600b001714e7608fdsm1778183plg.256.2022.09.05.04.35.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Sep 2022 04:35:56 -0700 (PDT)
From:   Abhra303 <chakrabortyabhradeep79@gmail.com>
To:     Git <git@vger.kernel.org>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC] Abhradeep's GSoC blogs (5 Sep, 2022 IST)
Date:   Mon,  5 Sep 2022 17:04:46 +0530
Message-Id: <20220905113446.24174-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Hello developers, this is the thread where you can know about
my weekly GSoC blog links.

My Project - Reachability bitmap improvements

Blog update
------------

Title - GSoC Week 11: enabling writing of roaring bitmaps
Blog link - https://medium.com/@abhra303/gsoc-week-11-enabling-writing-of-roaring-bitmaps-6b3bbe4e2cd7

Summary - 

I was busy for last two weeks for different reasons(see the blog). So
I wasn't able to work much on my GSoC project. I worked full-time last
sunday and finished implementing the "writing roaring bitmaps" part.
But before using the roaring library in our codebase I modified some
existing code. Some of these changes are - Renaming `struct bitmap`
functions to raw_bitmap functions, Introduce general functions for
all the bitmap types etc.

My next goal is to implement “reading roaring bitmaps”. However I have
to write tests before that.

Previous blogs 
---------------

-------------------------------------------------------

Title - GSoC week 9: finding the fix of the failing test case
Blog link - https://medium.com/@abhra303/gsoc-week-9-finding-the-fix-of-the-failing-test-case-30bc623cb4c

Summary -

This week I put most of the time on finding the root cause of a test
failure. I took my roaring bitmap integration a little further. I decided
to use Chunk-format API for the new `.bitmap` version. As midx also uses
Chunk format, we can maintain uniformity in designing file format.

I tried various ways to find the root cause but till now I am not able to
do so. I need to investigate further because I have to be sure whether
Calling `oe_map_new_pack()` function is causing the failure. As my exam
is starting from 18 Aug, I can't spend much time here. But I think we
are very near to solve the issue :)

-------------------------------------------------------
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
