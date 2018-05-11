Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D33661F42D
	for <e@80x24.org>; Fri, 11 May 2018 09:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbeEKJcD (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 05:32:03 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:49635 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752165AbeEKJcB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 May 2018 05:32:01 -0400
X-AuditID: 12074414-a91ff700000073ca-d1-5af563109e34
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C2.7B.29642.01365FA5; Fri, 11 May 2018 05:32:00 -0400 (EDT)
Received: from mail-lf0-f51.google.com (mail-lf0-f51.google.com [209.85.215.51])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w4B9Vwha003874
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Fri, 11 May 2018 05:32:00 -0400
Received: by mail-lf0-f51.google.com with SMTP id b18-v6so6277231lfa.9
        for <git@vger.kernel.org>; Fri, 11 May 2018 02:31:59 -0700 (PDT)
X-Gm-Message-State: ALKqPwc0MaBYRcBai3gvHYAI0QF73Etx539ru7dsrI9H8R1iKXNYdxco
        ofg4f+tK8ttvPMyajRZtmFfIxxiAxBSJM/9FVsM=
X-Google-Smtp-Source: AB8JxZqDiNBpU9AErXEBGxbJ2gSv4pZFhm8SZOSnk6tCvzjI4ozMzuW6J0zEd/GxTuaJZIDqsqVvgv0qKn5VB/zjPO0=
X-Received: by 2002:a2e:9b4a:: with SMTP id o10-v6mr3470343ljj.49.1526031118167;
 Fri, 11 May 2018 02:31:58 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.46.58.26 with HTTP; Fri, 11 May 2018 02:31:57 -0700 (PDT)
In-Reply-To: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
References: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Fri, 11 May 2018 11:31:57 +0200
X-Gmail-Original-Message-ID: <CAMy9T_H=_+9Z=CpX85Ma4gCyUuvNAPR7fSBHi2J=4nC1XzF2sg@mail.gmail.com>
Message-ID: <CAMy9T_H=_+9Z=CpX85Ma4gCyUuvNAPR7fSBHi2J=4nC1XzF2sg@mail.gmail.com>
Subject: Re: Implementing reftable in Git
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqCuQ/DXKYPI2RYuuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGW038wsuK5Ycf3VReYGxv/SXYycHBICJhITjsxnArGFBHYwScx4
        W9nFyAVkP2KSWHCwiRXCmcAoMXnSP6AqDqCOconta1wgzCKJd69sIeZUSHR/2gQ2h1dAUOLk
        zCcsEDPlJF5tuMEIYXtK3Px2lRmklVMgUOLA0VKIcIDEyuk9rCA2m4CuxKKeZrAxLAKqEm/+
        3WODGJ8osftUDxvE+ACJTbt2g40UFtCU2LL7MjOILSJgKDHn9xJ2kIuZBU4xSZxf0gR2AzNQ
        Uev23+wTGEVmITlvFpLUAkamVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Fnq5mSV6qSmlmxgh
        YS2yg/HISblDjAIcjEo8vBVuX6OEWBPLiitzDzFKcjApifJecwAK8SXlp1RmJBZnxBeV5qQW
        H2KU4GBWEuHdt+JLlBBvSmJlVWpRPkxKmoNFSZyX2WRvlJBAemJJanZqakFqEUxWhoNDSYKX
        OwloqGBRanpqRVpmTglCmomDE2Q4D9BwdpAa3uKCxNzizHSI/ClGS44lT7t7mDk+tfUAyQVb
        JvUwC7Hk5eelSonz3ksEahAAacgozYObCUtTrxjFgV4UhhjLA0xxcFNfAS1kAlp48OpnkIUl
        iQgpqQZGpeOvDuVt2cP2+E1xgoCp6MRN+7gFnivxdC7orMq7zcLUwbF+wc0wmyUx2cvZ1XP0
        LoVHbLpkLN8ptzVYwGVNw7zVit/2b3s90TFCWaP0ZG+izr+lvyKeik0WDpWN6syz/nqLxWPP
        jnkunKl9e+b86Ob/vHJWkELP36PqIlvbvMPC9XsXPZJTYinOSDTUYi4qTgQAVQ/68y4DAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 9, 2018 at 4:33 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> I might start working on implementing reftable in Git soon.
> [...]

Nice. It'll be great to have a reftable implementation in git core
(and ideally libgit2, as well). It seems to me that it could someday
become the new default reference storage method. The file format is
considerably more complicated than the current loose/packed scheme,
which is definitely a disadvantage (for example, for other Git
implementations). But implementing it *with good performance and
without races* might be no more complicated than the current scheme.

Testing will be important. There are already many tests specifically
about testing loose/packed reference storage. These will always have
to run against repositories that are forced to use that reference
scheme. And there will need to be new tests specifically about the
reftable scheme. Both classes of tests should be run every time. That
much is pretty obvious.

But currently, there are a lot of tests that assume the loose/packed
reference format on disk even though the tests are not really related
to references at all. ISTM that these should be converted to work at a
higher level, for example using `for-each-ref`, `rev-parse`, etc. to
examine references rather than reading reference files directly. That
way the tests should run correctly regardless of which scheme is in
use.

And since it's too expensive to run the whole test suite with both
reference storage schemes, it seems to me that the reference storage
scheme that is used while running the scheme-neutral tests should be
easy to choose at runtime.

David Turner did some analogous work for wiring up and testing his
proposed LMDB ref storage backend that might be useful [1]. I'm CCing
him, since he might have thoughts on this topic.

Regarding the reftable spec itself:

I recently gave a little internal talk about it, and while preparing
the talk I noticed a couple of things that should maybe be tweaked:

* The spec proposes to change `$GIT_DIR/refs`, which is currently a
directory that holds the loose refs, into a file that holds the table
of contents of reftable files comprising the full set of references.
This was my suggestion. I was thinking that this would prevent old
refs code from being used accidentally on a reftable-enabled
repository, while still enabling old versions of Git recognize this as
a git directory [2]. I think that the latter is important to make
things like `git rev-parse --git-dir` work correctly, even if the
installed version of git can't actually *read* the repository.

  The problem is that `is_git_directory()` checks not only whether
`$GIT_DIR/refs` exists, but also whether it is executable (i.e., since
it is normally a directory, that it is searchable). It would be silly
to make the reftable table of contents executable, so this doesn't
seem like a good approach after all.

  So probably `$GIT_DIR/refs` should continue to be a directory. If
it's there, it would probably make sense to place the reftable files
and maybe the ToC inside of it. We would have to rely on older Git
versions refusing to work in the directory because its `config` file
has an unrecognized `core.repositoryFormatVersion`, but that should be
OK I think.

* The scheme for naming reftable files [3] is, I believe, just a
suggestion as far as the spec is concerned (except for the use of
`.ref`/`.log` file extensions). It might be more less unwieldy to use
`%d` rather than `%08d`, and more convenient to name compacted files
to `${min_update_index}-${max_update_index}_${n}.{ref,log}` to make it
clearer to see by inspection what each file contains. That would also
make it unnecessary, in most cases, to insert a `_${n}` to make the
filename unique.

Michael

[1] https://github.com/dturner-tw/git/tree/dturner/pluggable-backends
[2] https://github.com/git/git/blob/ccdcbd54c4475c2238b310f7113ab3075b5abc9c/setup.c#L309-L347
[3] https://github.com/eclipse/jgit/blob/master/Documentation/technical/reftable.md#layout
    https://github.com/eclipse/jgit/blob/master/Documentation/technical/reftable.md#compaction
[4] https://github.com/eclipse/jgit/blob/master/Documentation/technical/reftable.md#footer
