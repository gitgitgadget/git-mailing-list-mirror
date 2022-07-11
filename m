Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03861C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 14:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiGKOdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 10:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiGKOdl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 10:33:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171C25F59
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 07:33:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p9so4987021pjd.3
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 07:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PItGbf9M7/AKVTTWgnidCZFDJJ6M+mcnjIsmijM9WTg=;
        b=aAYCg6CU82myDNLjqDkTEHWrIJBfqnEduT33zRyogqXdoP67GruyZQ53LSTYHQ8Urh
         rU14cPU2PJC3yoUUz4hXoS/NqQfgvHlYwtxeUvJfMdV10B6AF4gj25Oyq9oYib1ZMmXj
         WSeQCKTp8XBheVJ7pOK+RTXxkcGfpUD1kNol05G+rt/J+odEKPGKzI9rUguMMhwdMy1D
         ZWskqyATDRP0xmg8nC5Mya503kR4MztMKaQ4GLYhaI/N+7TYwRu5lAbVFCFELWTyTuuF
         9C5eZssTB3D2VzSn7Xp0OZXiInW5LVu+6xamtinQ7CqVPE/HGUaf0dCIRlo/GVXdkpP/
         dOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PItGbf9M7/AKVTTWgnidCZFDJJ6M+mcnjIsmijM9WTg=;
        b=lVYPedTaSJUZBsJNyHF/ahTuFQHmNrfr3gSmEwMH4WnlTP78wDKvDQl4OxcRmZxa+f
         GpMHP2Wj6yNkfrwYqwtTZLd4o3iaBJxlEYt1ZDp2C1XZXNxGf7AP8i6mlZk3Fh3nr4Xt
         NY41xaXRUv53XxPyh0QemI1nFIEY1zG2oWgGdYnBbWJEuNoEhSFHp0JXIqaDGrdX7/v8
         jEOxffhj7ozAj9jIzI7FGUWZQ4ES7DCm+jq7x2+eITw1+yZ0F/CYDnjzVqpgSLQrpvbs
         F7yYyQSt1D3AkBexRWSyjsAIOyBbJrotDB6OBvKCD+YhXiCAZEiH8JnSrUuflPAmZFnZ
         gBxg==
X-Gm-Message-State: AJIora+xKRo4eosD4F+hPkmLGTiLtXn+DxmlA5GONn3lqROBXA2WmSba
        iPLXvYcPz86V3L2RM/46QsHP46HN1OT8ag==
X-Google-Smtp-Source: AGRyM1uljR+FhqAyOOL+IBe+ejw96Wnj/U2ONZkzrHJZME47QkMoeSsJ+MeejyrTlmBJT12W4ygQpg==
X-Received: by 2002:a17:902:e552:b0:16c:571d:fc08 with SMTP id n18-20020a170902e55200b0016c571dfc08mr604558plf.151.1657550018963;
        Mon, 11 Jul 2022 07:33:38 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.40])
        by smtp.gmail.com with ESMTPSA id r29-20020aa79edd000000b0051b9ecb53e6sm4799224pfq.105.2022.07.11.07.33.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 Jul 2022 07:33:38 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Git <git@vger.kernel.org>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC] Abhradeep's GSoC blogs (11 Jul, 2022 IST)
Date:   Mon, 11 Jul 2022 20:02:43 +0530
Message-Id: <20220711143243.88697-1-chakrabortyabhradeep79@gmail.com>
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


Previous blogs 
---------------

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
