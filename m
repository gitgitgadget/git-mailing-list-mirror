Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D9AE20365
	for <e@80x24.org>; Fri, 14 Jul 2017 19:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbdGNTfj (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 15:35:39 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35731 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbdGNTfi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 15:35:38 -0400
Received: by mail-pf0-f182.google.com with SMTP id c73so49842070pfk.2
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 12:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rhnsWTcVrd57j2s4UB3iaFsfiDbKoXNf1R+kAJPBRsA=;
        b=fP2uWHehbVAn7yMzJRyYgQNqEX15uwZV8ISoPXO7RdMVOJFaS9vG6TPNieuA8Z1aaD
         zwZZBtD+4fgN442+LmKhTtzDlrqast/+gyufrCumjdaRnWSpLwfRZR2CxrUJzgmvUXPh
         RqaQwjlLuFE1UKKruLoouaVC5O4+MdKKNd+udW8fy81kHgEzPbtH9b/oZXlM6gdb2KrT
         zgJGXBtNSd64jgu2MB4Nhj8Ex7pIG9YOVw7Sr5q21GdoDLVzNzztWEeQCcPHGCqgKpJI
         U7wPBBwFKnu0wOBp4PYgSZaXgCB0guIROqM8MLw92N3i/l6uxKihQpa/g6FvlHo4a9na
         MBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rhnsWTcVrd57j2s4UB3iaFsfiDbKoXNf1R+kAJPBRsA=;
        b=GPcUF7lju2V6/UMS2OK7y63wHwTJceGN7jq2LNxLKtTSL5cnIyLKPWSzl8zD0G2YIL
         a72yzC73QB1w6A1J6BvToX4Bz5Mp5KM/XVuuVWh/O3qnscY6FHvxELTtZ+X8nDtpHzNU
         l9Thxc0PTs7KJ7ltUS85USY+ILCZuVxMRKu4FssNMceciXRCMoEIHgm4q9uUCbvvrhGB
         YNGBoSX72ndgtQksbRgob3LAGgSA1Enl8Tp/7oC0NugYVzplbNCO4uAy0GabDf3gMmg6
         V9cSe+dZA8OCVd4GEami+P4ToiDb5hCH6MzDgiiKLH/81mDQww3cRKsFDhkNRAIUbnTY
         42HQ==
X-Gm-Message-State: AIVw110xCAB97eSkyaXLKaPCpMNS9GoIHXyyPR9glif+SZwFM8oGxxug
        EBCxfwHb9qf1me3MM+wzNA==
X-Received: by 10.99.171.67 with SMTP id k3mr16470950pgp.128.1500060937675;
        Fri, 14 Jul 2017 12:35:37 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c565:3d46:ed5:e0fb])
        by smtp.gmail.com with ESMTPSA id u194sm15416967pgb.24.2017.07.14.12.35.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 12:35:36 -0700 (PDT)
Date:   Fri, 14 Jul 2017 12:35:35 -0700
From:   Brandon Williams <bmwill@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/13] object_id part 9
Message-ID: <20170714193535.GA50015@google.com>
References: <20170713234930.949612-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170713234930.949612-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/13, brian m. carlson wrote:
> This is the ninth in a series of series to convert Git to use struct
> object_id.  This series converts the remaining callers of get_sha1 and
> friends to take and use struct object_id, and in doing so, renames them
> to get_oid and friends.
> 
> This patch should probably be based Stefan Beller's series, in which case
> patch 9 can be dropped.
> 
> Changes from v1:
> * Restore the check for length in get_sha1_basic.
> * Add a patch converting some uses of 40 to GIT_SHA1_HEXSZ as suggested.  This
>   is a separate patch because I wanted to minimize the non-automated portions of
>   the patch in question.
> 

I've looked through v2 and it looks good to me as nothing crazy stood
out to me.

Thanks!

> brian m. carlson (13):
>   builtin/fsck: convert remaining caller of get_sha1 to object_id
>   builtin/merge-tree: convert remaining caller of get_sha1 to object_id
>   submodule: convert submodule config lookup to use object_id
>   remote: convert struct push_cas to struct object_id
>   sequencer: convert to struct object_id
>   builtin/update_ref: convert to struct object_id
>   bisect: convert bisect_checkout to struct object_id
>   builtin/unpack-file: convert to struct object_id
>   builtin/verify-tag: convert to struct object_id
>   Convert remaining callers of get_sha1 to get_oid.
>   sha1_name: convert get_sha1* to get_oid*
>   sha1_name: convert GET_SHA1* flags to GET_OID*
>   sha1_name: convert uses of 40 to GIT_SHA1_HEXSZ
> 
>  apply.c                          |   4 +-
>  archive.c                        |   2 +-
>  bisect.c                         |  18 +--
>  builtin/am.c                     |   6 +-
>  builtin/cat-file.c               |   8 +-
>  builtin/commit-tree.c            |   4 +-
>  builtin/commit.c                 |   8 +-
>  builtin/fsck.c                   |   8 +-
>  builtin/grep.c                   |   8 +-
>  builtin/log.c                    |   4 +-
>  builtin/merge-tree.c             |   6 +-
>  builtin/receive-pack.c           |   4 +-
>  builtin/replace.c                |   4 +-
>  builtin/reset.c                  |  10 +-
>  builtin/rev-parse.c              |   8 +-
>  builtin/show-branch.c            |   8 +-
>  builtin/submodule--helper.c      |   8 +-
>  builtin/unpack-file.c            |  12 +-
>  builtin/update-ref.c             |  69 ++++++-----
>  builtin/verify-tag.c             |   8 +-
>  cache.h                          |  45 ++++----
>  commit.c                         |   4 +-
>  config.c                         |  12 +-
>  config.h                         |   4 +-
>  mailmap.c                        |   6 +-
>  notes.c                          |   2 +-
>  refs.c                           |   2 +-
>  remote.c                         |   8 +-
>  remote.h                         |   2 +-
>  repository.c                     |   2 +-
>  revision.c                       |  16 +--
>  sequencer.c                      |  65 +++++------
>  sha1_name.c                      | 240 +++++++++++++++++++--------------------
>  submodule-config.c               |  38 +++----
>  submodule-config.h               |  12 +-
>  submodule.c                      |  32 +++---
>  submodule.h                      |   2 +-
>  t/helper/test-submodule-config.c |  10 +-
>  transport-helper.c               |   2 +-
>  39 files changed, 351 insertions(+), 360 deletions(-)
> 

-- 
Brandon Williams
