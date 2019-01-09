Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E80F1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 07:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfAIHh2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 02:37:28 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:34238 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbfAIHh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 02:37:28 -0500
Received: by mail-lj1-f173.google.com with SMTP id u89-v6so5633237lje.1
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 23:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGMZ9tMogdMx6kWH95OJf1Seya0GKWwqIGnwqWXnkFw=;
        b=bE98KoPxqwCiJKyCkc6+PCyfvXvsAFp5+/I5fw6U9SFELtnGdcd99qrUrVCkZyApKY
         JG8lHyeI9WBxDuIGhHMnhn5MUfqxEs3JUQ+RjzCRAR/9QlDvd12D2WtL6gHkqyNFFoB4
         h3jwSjY6mBJ3NqhIjTST1f/XVI2bLhaUryFylcDT28n1WK2HHwkTTPoPN5RySlQ13f96
         a7h/f24jQf5p4kEjn4qxkvZDNKv8PgC5Om+Ms2E02yKCJzi0c5MLdLeMO3hjRDr7EZkz
         pq+1ih4i82KtJGPr+WgVZnLQ4ftpzET3fSQpMxl+3QNgKGm+5pTLdNU1Rp10zsHG99rE
         2v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGMZ9tMogdMx6kWH95OJf1Seya0GKWwqIGnwqWXnkFw=;
        b=tWp1SPE90UTqrvoEZAsQVOcXWHSgEpk2U/+qdQ9ETZQIaASlBtsCzS6ZNgIfcml+6O
         4DZvlnI7asBdPN9/2g6UcqGnM/aywuQsb0qvIzGsS49uqqUG+XfsMDwil24mN6K6WGt3
         lds5hvikJxSuayKp71P3a9ndDDiUJ0DioeJi3wE4Y20kC6RWpOudIBHUAz5dQHqzjvIT
         ApT118Ldxa87c6FnA6W8AsCjOuQXE+ReWS82l8EkwDlOZDsH6HTa4wX1aux03svfdUYx
         HIMyzP2PF+IX9HS4wmHgjWTH6XA+5pYPPRQ1Kp7yvTrQid5PHnJ5ZJAXYkAID+aXhsU0
         D5nQ==
X-Gm-Message-State: AJcUukel3Yvp3l3RjcojC58W82ul2L25Aq1Vo5EvH88o/UMEl1XuMKyA
        qcoojZxZIpTwR9aP/F50i9v5e9v97JtiWw/WATw=
X-Google-Smtp-Source: ALg8bN72rM7gaIdVgrmR+m1bJLE4UsHFyooeFeP7dZ6f9rpYj+LdT6T37L4zM+ae/bU3kpljLrAj5ugkh5qbFfCNk5A=
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr2593728ljd.137.1547019445052;
 Tue, 08 Jan 2019 23:37:25 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 9 Jan 2019 08:37:13 +0100
Message-ID: <CAN0heSoRYYS3-UAamE9nibhORPoD+_TRHu5-ZTeYxYMS4BAnrA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2019, #01; Mon, 7)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 8 Jan 2019 at 00:34, Junio C Hamano <gitster@pobox.com> wrote:
> * bc/sha-256 (2018-11-14) 12 commits
>  - hash: add an SHA-256 implementation using OpenSSL
>  - sha256: add an SHA-256 implementation using libgcrypt
>  - Add a base implementation of SHA-256 support
>  - commit-graph: convert to using the_hash_algo
>  - t/helper: add a test helper to compute hash speed
>  - sha1-file: add a constant for hash block size
>  - t: make the sha1 test-tool helper generic
>  - t: add basic tests for our SHA-1 implementation
>  - cache: make hashcmp and hasheq work with larger hashes
>  - hex: introduce functions to print arbitrary hashes
>  - sha1-file: provide functions to look up hash algorithms
>  - sha1-file: rename algorithm to "sha1"
>
>  Add sha-256 hash and plug it through the code to allow building Git
>  with the "NewHash".

AddressSanitizer barks at current pu (855f98be272f19d16564e) for a
handful of tests.

One example is t5702-protocol-v2.sh. I've tracked this one down to
ce1a82c251 ("Merge branch 'bc/sha-256' into jch", 2019-01-08).
Reverting that merge makes the problem go away, at least in t5702.
Notably bc/sha-256 on its own has no problems with t5702, possibly
because there has been quite some work done on the test script itself
in bc/sha-256..pu.

There are a few failing tests with AddressSanitizer on pu and they might
be caused by different topics. I've got to run, but thought I'd just
mention this one for now. Here's AddressSanitizer's first complaint for
t5702:

==1691823==ERROR: AddressSanitizer: heap-buffer-overflow on address
0x6040000004f2 at pc 0x0000004ea0fd bp 0x7ffc53082590 sp
0x7ffc53081d40
READ of size 32 at 0x6040000004f2 thread T0
    #0 0x4ea0fc in __asan_memcpy
llvm/projects/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cc:23
    #1 0x8603ec in oidset_insert oidset.c
    #2 0x86c977 in add_promisor_object packfile.c:2129:4
    #3 0x86c07a in for_each_object_in_pack packfile.c:2070:7
    #4 0x86c535 in for_each_packed_object packfile.c:2095:7
    #5 0x86c651 in is_promisor_object packfile.c:2151:4
    #6 0x5ae77d in mark_object builtin/fsck.c:173:6
    #7 0x5b0824 in mark_object_reachable builtin/fsck.c:200:2
    #8 0x5b0824 in fsck_handle_ref builtin/fsck.c:509
    #9 0x8e6987 in do_for_each_repo_ref_iterator refs/iterator.c:418:12
    #10 0x8cb84f in do_for_each_ref refs.c:1466:9
    #11 0x8cb84f in refs_for_each_rawref refs.c:1532
    #12 0x8cb84f in for_each_rawref refs.c:1538
    #13 0x5acd1f in get_default_heads builtin/fsck.c:524:2
    #14 0x5acd1f in cmd_fsck builtin/fsck.c:846
    #15 0x52f022 in run_builtin git.c:422:11
    #16 0x52d583 in handle_builtin git.c:655:8
    #17 0x52c00b in run_argv git.c:709:4
    #18 0x52c00b in cmd_main git.c:806
    #19 0x6c4569 in main common-main.c:45:9
    #20 0x7f5fd6c23b96 in __libc_start_main
/build/glibc-OTsEL5/glibc-2.27/csu/../csu/libc-start.c:310
    #21 0x41c799 in _start (git+0x41c799)

0x6040000004f2 is located 0 bytes to the right of 34-byte region
[0x6040000004d0,0x6040000004f2)
allocated by thread T0 here:
    #0 0x4eb4cf in malloc
llvm/projects/compiler-rt/lib/asan/asan_malloc_linux.cc:146
    #1 0x9fa1db in do_xmalloc wrapper.c:60:8
    #2 0x9fa2fd in do_xmallocz wrapper.c:100:8
    #3 0x9fa2fd in xmallocz_gently wrapper.c:113
    #4 0x86a877 in unpack_compressed_entry packfile.c:1588:11
    #5 0x86a02e in unpack_entry packfile.c:1737:11
    #6 0x867431 in cache_or_unpack_entry packfile.c:1439:10
    #7 0x867431 in packed_object_info packfile.c:1506
    #8 0x96b7be in oid_object_info_extended sha1-file.c:1394:10
    #9 0x96d7d0 in read_object sha1-file.c:1434:6
    #10 0x96d7d0 in read_object_file_extended sha1-file.c:1476
    #11 0x85cf40 in repo_read_object_file ./object-store.h:174:9
    #12 0x85cf40 in parse_object object.c:273
    #13 0x86c752 in add_promisor_object packfile.c:2108:23
    #14 0x86c07a in for_each_object_in_pack packfile.c:2070:7
    #15 0x86c535 in for_each_packed_object packfile.c:2095:7
    #16 0x86c651 in is_promisor_object packfile.c:2151:4
    #17 0x5ae77d in mark_object builtin/fsck.c:173:6
    #18 0x5b0824 in mark_object_reachable builtin/fsck.c:200:2
    #19 0x5b0824 in fsck_handle_ref builtin/fsck.c:509
    #20 0x8e6987 in do_for_each_repo_ref_iterator refs/iterator.c:418:12
    #21 0x8cb84f in do_for_each_ref refs.c:1466:9
    #22 0x8cb84f in refs_for_each_rawref refs.c:1532
    #23 0x8cb84f in for_each_rawref refs.c:1538
    #24 0x5acd1f in get_default_heads builtin/fsck.c:524:2
    #25 0x5acd1f in cmd_fsck builtin/fsck.c:846
    #26 0x52f022 in run_builtin git.c:422:11
    #27 0x52d583 in handle_builtin git.c:655:8
    #28 0x52c00b in run_argv git.c:709:4
    #29 0x52c00b in cmd_main git.c:806
    #30 0x6c4569 in main common-main.c:45:9
    #31 0x7f5fd6c23b96 in __libc_start_main
/build/glibc-OTsEL5/glibc-2.27/csu/../csu/libc-start.c:310
