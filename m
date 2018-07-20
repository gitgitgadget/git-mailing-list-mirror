Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B6261F597
	for <e@80x24.org>; Fri, 20 Jul 2018 13:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbeGTOak (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 10:30:40 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:34923 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731314AbeGTOak (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 10:30:40 -0400
Received: by mail-qt0-f175.google.com with SMTP id a5-v6so10269438qtp.2
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=6TO6Ffi1lUG3AANUGuzVFXO5xLfG0PGB8+86PhP8DiI=;
        b=cjlY2WgJSJQSeUtzwuVM8FQnAtA9enYpBF+CQDSY2/v/tCV4YflwRlTd+K5Oiw4u8F
         ChWXLVSb/1lUcudR6YDa/RT9iYmGRNiFmdst6PN6xRaoc7DhR+ubwdvOYOl1/TwiIsSX
         BpJVmRMQizkIPd0KN/A5WrwAq0ztl1sbekfsVgChKTlu7JA0nUJm8n2i0MNxetIuyWM+
         C5p4YgQoF6xdlKaI+ottIxgvlVO8QLekqEBj3yKOl0mTP6MXeYyCX2Tv6I3d9KYHmS+Y
         DPCJlfeJ4hJvc8RnNO3LjlWGvXF6V0VH1VrFDLvc8wYG/IBnjs7qRqoP2rct3W8veC4f
         ySZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6TO6Ffi1lUG3AANUGuzVFXO5xLfG0PGB8+86PhP8DiI=;
        b=fMxkqeYAFdWygu8L1g8nMtK+JWoovLfhCnlwkp5o7QJ+zLuO479A5xi77nca/nl1bB
         dXQKWZX/oQJvCkPxh52QAwMtmA9iPncro2Gk/2cAeTSyQBYsBnb3g27sD5WsqZacAJ6u
         M4aSfd//iJeXSvCHUip6E3WfKn1Xs5EnwJ3piq9uDAJjy/M0imVynoQ+Sp+LvFbaBJCl
         nNFI56hn3sN+vq81vt35W2lyNvev2ChdBwoDTYhZTdL9JI6iztuhYzyAFWsxs4huyhLI
         FqkdyqfmrVhEf4zqvEB2xgnEBLehjtoUCPqazM8xqcr37nWueqYuMqEMz60QaT8Fj6Ap
         6Icw==
X-Gm-Message-State: AOUpUlGQ03h5qApuMqqEG7S5/YnA38UV10zZRucLvWbYZpW3qUOth13/
        YR5aKCVvRdQ2YPx3DdHlpSppyV2e
X-Google-Smtp-Source: AAOMgpfZTdUyvDApsnn8myB3wMU5mDHSsi7ZefrQaw2y4ifQlXMPobo8HvPibxm90R2JOoII5tDKJw==
X-Received: by 2002:ac8:302:: with SMTP id q2-v6mr1995946qtg.338.1532094136915;
        Fri, 20 Jul 2018 06:42:16 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id l22-v6sm1544861qkh.72.2018.07.20.06.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 06:42:16 -0700 (PDT)
Subject: ds/multi-pack-index (was Re: What's cooking in git.git (Jul 2018,
 #02; Wed, 18))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "avarab@gmail.com" <avarab@gmail.com>
References: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c1a697ed-a060-1901-073f-7c8d5d5d0f10@gmail.com>
Date:   Fri, 20 Jul 2018 09:42:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/18/2018 6:03 PM, Junio C Hamano wrote:
> * ds/multi-pack-index (2018-07-12) 23 commits
>   - midx: clear midx on repack
>   - packfile: skip loading index if in multi-pack-index
>   - midx: prevent duplicate packfile loads
>   - midx: use midx in approximate_object_count
>   - midx: use existing midx when writing new one
>   - midx: use midx in abbreviation calculations
>   - midx: read objects from multi-pack-index
>   - config: create core.multiPackIndex setting
>   - midx: write object offsets
>   - midx: write object id fanout chunk
>   - midx: write object ids in a chunk
>   - midx: sort and deduplicate objects from packfiles
>   - midx: read pack names into array
>   - multi-pack-index: write pack names in chunk
>   - multi-pack-index: read packfile list
>   - packfile: generalize pack directory list
>   - t5319: expand test data
>   - multi-pack-index: load into memory
>   - midx: write header information to lockfile
>   - multi-pack-index: add 'write' verb
>   - multi-pack-index: add builtin
>   - multi-pack-index: add format details
>   - multi-pack-index: add design document
>
>   When there are too many packfiles in a repository (which is not
>   recommended), looking up an object in these would require
>   consulting many pack .idx files; a new mechanism to have a single
>   file that consolidates all of these .idx files is introduced.
>
>   What's the doneness of this one?  I vaguely recall that there was
>   an objection against the concept as a whole (i.e. there is a way
>   with less damage to gain the same object-abbrev performance); has
>   it (and if anything else, they) been resolved in satisfactory
>   fashion?

I believe you're talking about Ævar's patch series [1] on unconditional 
abbreviation lengths. His patch gets similar speedups by completely 
eliminating the abbreviation computation in favor of a relative increase 
that is very likely to avoid collisions. While abbreviation speedups are 
the most dramatic measurable improvement by the multi-pack-index 
feature, it is not the only important feature.

Lookup speeds improve in a multi-pack environment. While only the 
largest of largest repos have trouble repacking into a single pack, 
there are many scenarios where users disable auto-gc and do not repack 
frequently. On-premise build machines are the ones I know about the 
most: these machines are run 24/7 to perform incremental fetches against 
a remote and kick off a build. Admins frequently turn off GC so the 
build times are not impacted. Eventually, their performance does degrade 
due to the number of packfiles. The answer we give to them is to set up 
scheduled maintenance to repack. These users don't need the space 
savings of a repack, but just need consistent performance and high 
up-time. The multi-pack-index could assist here (as long as we set up 
auto-computing the multi-pack-index after a fetch).

That's the best I can do to sell the feature as it stands now (plus the 
'fsck' integration that would follow after this series is accepted).

I have mentioned the potential for the multi-pack-index to do the following:

* Store metadata about the packfiles, possibly replacing the .keep and 
.promisor files, and allowing other extensions to inform repack algorithms.

* Store a stable object order, allowing the reachability bitmap to be 
computed at a different cadence from repacking the packfiles.

I'm interested in these applications, but I will admit that they are not 
on the top of my priority list at the moment. Right now, I'm focused on 
reaching feature parity with the version of the MIDX we have in our GVFS 
fork of Git, and then extending the feature to have incremental 
multi-pack-index files to solve the "big write" problem.

Thanks,

-Stolee

[1] 
https://public-inbox.org/git/20180608224136.20220-1-avarab@gmail.com/T/#u

      [PATCH 00/20] unconditional O(1) SHA-1 abbreviation

