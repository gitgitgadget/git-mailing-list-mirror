Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 133191F803
	for <e@80x24.org>; Wed,  9 Jan 2019 21:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfAIVGW (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 16:06:22 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:40851 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAIVGW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 16:06:22 -0500
Received: by mail-lj1-f176.google.com with SMTP id n18-v6so7745266lji.7
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 13:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EnOlPSj0UP6tAuWiUVkqETzcU//UWLyE6lwark3CiOg=;
        b=WemBL+oU5jsUit4p361jQjRMdTKJjZaonDSb7FYxvrPOhotz0dlrTCs2s2cI7sDNZS
         GVUMDGNuIBsxfPkg+N49XpN8yAtjzKRN6BlKJo07lTA5w5ET60BLCg5S/oNqAxyvXiw4
         2+CbJ5unXgoer52WcTrkWWz+mDFGmWOFZhXee1jnmYFfMdaf8Le6Xn43LjNUAxA2/SjR
         RSbVqDp9vedejJ7u2IzDUXrQsUAJjqVPNN+G0s6gKm1CJUvya8dRElJPxB0JcddTWYNj
         1NBODg1T8oXxMpuL8MZD05+c9PMtMq/BVC6yJB1Fpl1P9I0+C2kQgh4HfV8kq8sEe6kJ
         C/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EnOlPSj0UP6tAuWiUVkqETzcU//UWLyE6lwark3CiOg=;
        b=iL2VFMqI9+6zTH4mwD6Q9/8fkwuJ8A2RFfnBclMMcAseoxxoILn9kpZaa4WPq4nob9
         vLEzb3tek6M85PK8gUB111gJo0p6I4F2Clm6P+q8vvEaozfpFO5yTFF0nrh1CV96hzR2
         yG9vazKNYcu2PWu8rljRrtevDEgfZs5LaUpn26+eN0wbeABpNiDfzw90slE7siRT2zWx
         vLnon0Ubru+5SNgdHLvnZsZywGvvfsHHAUSt+EibsHMVPnuC/L11USUwD9e3Lss0Z7+c
         tPQoXvr/k49EpWPEmrwe2GZRUO0kHV52up1yOfUGrbiWBa0LmsCNVJf7nfZpoJmJtmOY
         hzbQ==
X-Gm-Message-State: AJcUukc/k0183F7Ma76enIHR6j73/3XLVtdanzmNuOS9Aw+XSGNrVPYF
        nnisE0GqGSkDfBMsicHaKF2ra2j/cAVeeIWyXteFx6wQ
X-Google-Smtp-Source: ALg8bN7d8ijBNj1O5afA5ACyA2WXBlC1UE10ls2q/xWJ1O5Ac/UFYPEYsoojkgtIT/QFAxN9P82nZNCcfFejx0NGKcI=
X-Received: by 2002:a2e:5703:: with SMTP id l3-v6mr4822677ljb.106.1547067979618;
 Wed, 09 Jan 2019 13:06:19 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com> <CAN0heSoRYYS3-UAamE9nibhORPoD+_TRHu5-ZTeYxYMS4BAnrA@mail.gmail.com>
In-Reply-To: <CAN0heSoRYYS3-UAamE9nibhORPoD+_TRHu5-ZTeYxYMS4BAnrA@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 9 Jan 2019 22:06:08 +0100
Message-ID: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2019, #01; Mon, 7)
To:     Git Mailing List <git@vger.kernel.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 9 Jan 2019 at 08:37, Martin =C3=85gren <martin.agren@gmail.com> wro=
te:
>
> On Tue, 8 Jan 2019 at 00:34, Junio C Hamano <gitster@pobox.com> wrote:
> > * bc/sha-256 (2018-11-14) 12 commits
> >  - hash: add an SHA-256 implementation using OpenSSL
> >  - sha256: add an SHA-256 implementation using libgcrypt
> >  - Add a base implementation of SHA-256 support
> >  - commit-graph: convert to using the_hash_algo
> >  - t/helper: add a test helper to compute hash speed
> >  - sha1-file: add a constant for hash block size
> >  - t: make the sha1 test-tool helper generic
> >  - t: add basic tests for our SHA-1 implementation
> >  - cache: make hashcmp and hasheq work with larger hashes
> >  - hex: introduce functions to print arbitrary hashes
> >  - sha1-file: provide functions to look up hash algorithms
> >  - sha1-file: rename algorithm to "sha1"
> >
> >  Add sha-256 hash and plug it through the code to allow building Git
> >  with the "NewHash".
>
> AddressSanitizer barks at current pu (855f98be272f19d16564e) for a
> handful of tests.
>
> One example is t5702-protocol-v2.sh. [...]
>
> =3D=3D1691823=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on addre=
ss
> 0x6040000004f2 at pc 0x0000004ea0fd bp 0x7ffc53082590 sp
> 0x7ffc53081d40
> READ of size 32 at 0x6040000004f2 thread T0
>     #0 0x4ea0fc in __asan_memcpy
> llvm/projects/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cc:23
>     #1 0x8603ec in oidset_insert oidset.c
>     #2 0x86c977 in add_promisor_object packfile.c:2129:4
>     #3 0x86c07a in for_each_object_in_pack packfile.c:2070:7
>     #4 0x86c535 in for_each_packed_object packfile.c:2095:7
>     #5 0x86c651 in is_promisor_object packfile.c:2151:4

> 0x6040000004f2 is located 0 bytes to the right of 34-byte region
> [0x6040000004d0,0x6040000004f2)
> allocated by thread T0 here:
>     #0 0x4eb4cf in malloc
> llvm/projects/compiler-rt/lib/asan/asan_malloc_linux.cc:146
>     #1 0x9fa1db in do_xmalloc wrapper.c:60:8
>     #2 0x9fa2fd in do_xmallocz wrapper.c:100:8
>     #3 0x9fa2fd in xmallocz_gently wrapper.c:113
>     #4 0x86a877 in unpack_compressed_entry packfile.c:1588:11
>     #5 0x86a02e in unpack_entry packfile.c:1737:11
>     #6 0x867431 in cache_or_unpack_entry packfile.c:1439:10
>     #7 0x867431 in packed_object_info packfile.c:1506
>     #8 0x96b7be in oid_object_info_extended sha1-file.c:1394:10
>     #9 0x96d7d0 in read_object sha1-file.c:1434:6
>     #10 0x96d7d0 in read_object_file_extended sha1-file.c:1476
>     #11 0x85cf40 in repo_read_object_file ./object-store.h:174:9
>     #12 0x85cf40 in parse_object object.c:273
>     #13 0x86c752 in add_promisor_object packfile.c:2108:23
>     #14 0x86c07a in for_each_object_in_pack packfile.c:2070:7
>     #15 0x86c535 in for_each_packed_object packfile.c:2095:7
>     #16 0x86c651 in is_promisor_object packfile.c:2151:4

I found some more time to look into this.

It seems we have a buffer with raw data and we set up a `struct
object_id *` pointing into it, at a (supposed) OID value. Then
`update_tree_entry_internal()` verifies that the buffer contains
sufficiently many bytes, i.e., at least `the_hash_algo->rawsz` (=3D20).
We immediately call `oidset_insert()` which copies an entire struct,
i.e., we copy sizeof(struct object_id) (=3D32) bytes. Which is 12 more
than what is known to be safe. For this particular input data, we read
outside allocated memory.

I can think of three possible approaches:

* Allocate with a margin (GIT_MAX_RAWSZ - the_hash_algo->rawsz) where
  "necessary" (TM). Maybe not so maintainable.

* Teach `oidset_insert()` (i.e., khash) to only copy
  `the_hash_algo->rawsz` bytes. Maybe not so good for performance.

* Ignore.

I wonder which of these is the least awful, or if there are other ideas.

Martin
