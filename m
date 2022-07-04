Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DD1C433EF
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 19:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiGDTgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 15:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiGDTgs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 15:36:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F659FCB
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 12:36:48 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so6401188pjo.3
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 12:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j/ApqcUG2zjukOpUcGO0tWODgHcVr1h9p1q5SCM/fkg=;
        b=QensHeYz+DzqM4YAnVlHBecCELRVopAf/w5DmUfCJ+CjZDTbXs2x0hPI7iyYFrqZvb
         AHn7kM90FgmMY4pOu6oF1Lxll8ehsAxmmtlVV8TfDantYnZ8RwEBNy4xXMOkJ6Ta2PFb
         xu99tF76uE8+2SDWStS+vBjoy7OCF35BO5Ka6XD+txTSfmeB1+Jg4HgAJ8UJ5iZzBoYi
         NMbcBXpPMaW9WMTN6bv4a2/74nWm/+RAZjMax2BUMxoaw+rWKeZmfAkYaqzlsJWo9wbT
         haeuZcR9OzKK69FsDITZyrB6Up5tZzBK9PSsWgl9F9Q7RrdCEvan9vFYZL/LVqGUIO2+
         nnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j/ApqcUG2zjukOpUcGO0tWODgHcVr1h9p1q5SCM/fkg=;
        b=v+76pfRNT+zYgBNwzyk8Kz79UpkYFp/8SPxLNZwxy9UMn89fHRZLkuIo5dg7r30F/e
         OXMnaLIZHCIRFCtcCLqHLu1mp9Et+ctrEmVANE2RtA9T+XTs9RUe0I1frt1E2daycMtq
         fTMoegamYwCpvIPWXcY3sMI6qa/Nbmb+qZ7TpXAamyS46vMOyqcCRkkRUJD+bx2MgYzi
         ZMSqXDt/bZAp+ZlGYqsABzrU+OyZaooE8c/tcDd0FCWeoR8hhc0dudmo3uOlXBj1RMGZ
         vYp8zj7cZiD3QgaJMdqK3xHFR4cGB/mVNqx7sCmDm+YA7qJ8L5WzPUhQJBx/B0IzDkA0
         XcAQ==
X-Gm-Message-State: AJIora/qWxcKuysn0NiQvANYYJJktCSaHcR5Hm1IcXxWi+OOeIUtiYqc
        4W1+6UnjExBajDLbRavtPYyuUL+mics=
X-Google-Smtp-Source: AGRyM1us4GfPLXKov1NTFpSQZmb6JSfmN4FhMu5d5KRoUQfd27czRjt6AI07O5xdxRlgMF/F+Vvmnw==
X-Received: by 2002:a17:902:b186:b0:16b:d762:6d81 with SMTP id s6-20020a170902b18600b0016bd7626d81mr12807509plr.88.1656963407084;
        Mon, 04 Jul 2022 12:36:47 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.65])
        by smtp.gmail.com with ESMTPSA id k78-20020a628451000000b0052840f73ce1sm5810031pfd.201.2022.07.04.12.36.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Jul 2022 12:36:46 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Git <git@vger.kernel.org>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [GSoC] Abhradeep's GSoC blogs (5 Jul, 2022 IST)
Date:   Tue,  5 Jul 2022 01:06:28 +0530
Message-Id: <20220704193628.76595-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello developers, this is the thread where you can know about
my weekly GSoC blog links.

My Project - Reachability bitmap improvements

Blog update
------------

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


Previous blogs 
---------------

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
