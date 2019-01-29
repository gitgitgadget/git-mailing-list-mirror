Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BA9D1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 18:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfA2SWk (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 13:22:40 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42077 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfA2SWj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 13:22:39 -0500
Received: by mail-qt1-f193.google.com with SMTP id d19so23338397qtq.9
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 10:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ca5uUAD+bpaSh4malro82NNNoR0mT1/F892rw45DM+4=;
        b=J+Khgc6uOGuCw2mn9gAfxKby4FFSAd3mPpEq1NNwJbqzAuqgWxeak4w/1H9lmKQipi
         2mKnjOdjWwsVG8gSo8egfbMHc81qbR0Q2MyL5ew4qs7dezj0I5hg0MD53Kng2sWNZeGB
         Le7vJKgcJoaQNniUza/MV5EQWZUS6UkKRQ/cbWFJt7Nj2t/mXSrGm65ORMhYJprw+S+P
         HOqw/+Nioygsf8LGl/2kpjzuTv6lIQT5cSTBRkMZiD2vAnpxTZMREw0eCpr104ksllEd
         HI8TpxDJXfLKtK3+vdrFjrYAfs1Blpr2fi/Lmev3GU5rpKQF38w9pCd6fHZW7JcCAMzN
         Ldyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ca5uUAD+bpaSh4malro82NNNoR0mT1/F892rw45DM+4=;
        b=FaGu74+d5ULWY+yD6CMC1LI7iYnIRJX6kJgEuANn2SyyVkeZxStBizQTFbFKXvU05K
         D0lNVQ1x8fI0aiqme89nspxfzB0i/5aSyt5lcMv8/8uFFyBSp9WbHlgtc1yYh7eFWlI3
         H5AQFbbo5jiG1+Nf3bCcS3dQICCWEAZcSUVqlZkBofDyqDl5IrWlwzB1z4XaRoJGrbuK
         RLyvyfQULSh4b5ii8u2o8ox2Nzc+1hrgbeDX3zMJkb05YIraX/S9DxdcWlDg6cVY8NJA
         tCzbhy4ds8jvugCt9CIPsEARYldLHC+ZwnRQUu28TSR34vIMLhnZ6aR7mmjQ2Biqtx1M
         Y00w==
X-Gm-Message-State: AJcUukfAK0lEFquJJE4BjDdn0tkrgbjshOweCRpgFVyI6z8223uQw4/y
        rguig2DHrY01eR4j9c7oWmFqtIIx
X-Google-Smtp-Source: ALg8bN4qqPFgBNFf4FHe/bnoCCBaS/55yXtv9mRGJOpyltl6iZ3GXIuHvUkhlM+FP5zJ4mz543hJVw==
X-Received: by 2002:ac8:7153:: with SMTP id h19mr25575225qtp.92.1548786157787;
        Tue, 29 Jan 2019 10:22:37 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:788a:444c:e16b:27e? ([2001:4898:8010:2:61be:444c:e16b:27e])
        by smtp.gmail.com with ESMTPSA id x202sm71676134qka.67.2019.01.29.10.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 10:22:37 -0800 (PST)
Subject: Re: Contributor Summit Topics and Logistics
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20190122075027.GA29441@sigill.intra.peff.net>
 <4dbbdd75-e71b-d6e4-123d-dddc7a9d8a67@gmail.com>
 <87bm464elm.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6d0dc2a2-120c-0d42-1910-14ffed7adaf1@gmail.com>
Date:   Tue, 29 Jan 2019 13:22:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <87bm464elm.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was hoping to attend the contributors' summit remotely, but now my leave is
starting before then. This email contains a summary of what I would have
added to the discussion.

Thanks,
-Stolee


Commit-Graph Status Report
==========================

I'm really happy with the progress in this area, especially with the number of
other contributors working on the feature! Thanks Ævar, Jonathan, Josh, Stefan,
and Szeder in particular.

Here are some directions to take the feature in the near future:

File Format v2
--------------

The new format version [1] specifically fixes some shortcomings in v1:

* Uses the 4-byte format id for the hash algorithm.
* Creates a separate version byte for the reachability index.
* Enforces that the unused byte is zero until we use it for incremental writes.

Hopefully, this is the last time we need to update the file header.

[1] https://public-inbox.org/git/pull.112.git.gitgitgadget@gmail.com/
    [PATCH 0/6] Create commit-graph file format v2

Reachability Index
------------------

As discussed on-list [2], we want to replace generation numbers with a different
(negative-cut) reachability index. I used the term "corrected commit date". The
definition is:

* If a commit has no parents, then its corrected commit date is its commit date.

* If a commit has parents, then its corrected commit date is the maximum of:
    - its commit date
    - one more than the maximum corrected commit date of its parents

The benefits of this definition were discussed already, but to summarize:

* This definition will work _at least as well_ as the commit date heuristic,
  with the added bonus of being absolutely sure our results are right. We can
  update algorithms like paint_down_to_common() to use this reachability index
  without performance problems in some cases.

* If someone creates a terrible commit with a date that is far in the future,
  this definition is no worse than existing generation numbers (because we
  enforce that the corrected commit date is strictly larger than the parents'
  corrected commit date).

To implement this index, we can re-use the 30 bits per commit in the
commit-graph file that are used for generation numbers, but use them instead
for the difference between the corrected commit date and the actual commit
date. File format v2 gives us a version value that can be incremented to signal
the change in meaning.

Some work is required to adjust the existing generation-number-aware algorithms
to care about an "arbitrary" reachability index. It could be as easy as a
helper function that returns a function pointer to the proper compare function.

If someone wants to move forward on this topic while I'm gone, please
volunteer. Otherwise, this will be among my first items to work on when I
return from leave.

[2] https://public-inbox.org/git/6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com/
    [RFC] Generation Number v2

Incremental Writes
------------------

Similar to the split index, an incremental commit-graph file can be implemented
to reduce the write time when adding commits to an existing (large)
commit-graph. In this case, the .git/objects/info/commit-graph file would
be small, and have a pointer to a base file, say "cgraph-<hash>.cgraph", that
contains the majority of the commits.

The important thing to keep in mind here is that we use integers to refer to
a commit's parents. This integer would need to refer to the order of commits
when you concatenate the orderd lists from each file. When doing this, we
can point into the base file as well as the tip file. Since the base
commit-graph file would be closed under reachability, it only needs to care
about commits in its file.

It is also possible to have multiple base files, and we can use the unused
byte in the commit-graph file format v2 to store the number of base files.
We can then store a list of file names in a new chunk, presenting the ordered
list of base files. We still want to keep this list short, but there may be
benefits to a variable number. I expect the first version would limit the
construction to one base file for simplicity's sake.

When this is implemented, we can use it to write the commit-graph at fetch
time. A config setting, say 'fetch.writeCommitGraph', could enable this write.
Since most writes would add a small number of commits compared to the large
base file, this would be a more reasonable cost to add to a fetch. Since we
verify the pack upon download, the commits it contained will already be in
the memory cache and we won't need to re-parse those commits.

Volunteers welcome.

Bloom Filters
-------------

Using bloom filters to speed up file history has been discussed and prototyped
on-list (see [12] and the thread before it). Thanks for lots of contributions
in this area! A lot of people have shown an interest in this feature, and it
is particularly helpful with server-side queries.

Any implementation here should check that it is helping 'git blame' as much as
it can [13]. It's entirely possible that the performance problem mentioned
there is more about the size of the file and not finding the commits that
changed the file, but it's worth digging in here.

A few people have mentioned that they are interested in pursuing this
implementation, so it would be good to declare intentions during the summit.

[12] https://public-inbox.org/git/61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com/

[13] https://public-inbox.org/git/CABXAcUzoNJ6s3=2xZfWYQUZ_AUefwP=5UVUgMnafKHHtufzbSA@mail.gmail.com/

Enabled by Default?
-------------------

I proposed turning on the feature by default [3], but that had some
resistance [4] and I never followed up to that remark. (It involved the
hope that we could consolidate commit walks during a gc/repack. I'm unsure
this is a goal worth pursuing.) Since there has been more interest recently [5]
I think it would be good to discuss what concerns we may have in turning this
on by default. Specifically, make 'core.commitGraph' and 'gc.writeCommitGraph'
default to 'true'. Users could still opt-out.

[3] https://public-inbox.org/git/pull.50.git.gitgitgadget@gmail.com/
[4] https://public-inbox.org/git/xmqqlg6vvrur.fsf@gitster-ct.c.googlers.com/
[5] https://public-inbox.org/git/87bm464elm.fsf@evledraar.gmail.com/


Multi-Pack-Index Status Report
==============================

The multi-pack-index feature shipped with Git 2.20! We've been using this
feature (or, a similar implementation as it changed a lot with review) in
VFS for Git for a year now. It's been critical to solving the many-packs
problem we have with our prefetch packs model. Our next version ships with
Git 2.20 and the upstream implementation.

We are now able to start tackling our space problem with these many packs.
Our solution includes the 'expire' and 'repack' subcommands [6]. We will run
these in the background [7] to slowly reduce the space we are using. Since
Git references the multi-pack-index, we are able to delete packs that have
no referenced objects from the multi-pack-index without interrupting user
commands (I don't think the same holds for 'git repack'). This "highly
available" model makes me think that this could be useful to other scenarios.

We are looking for interest from other users or groups in this feature. We
want this feature to be adopted, and that means the future of the feature 
should depend on more scenarios than our specific case.

Here are some ideas to make this more useful for others:

1. Incremental writes. See the commit-graph section for details. This would
   allow writing the multi-pack-index on fetch, helping users who have set
   gc.auto=0 keep performance high even though they have packs piling up.

2. Stable object order and bitmaps. This is discussed in the design
   document [8]. This is more useful for server environments.

[6] https://public-inbox.org/git/pull.92.git.gitgitgadget@gmail.com/
    [PATCH 0/5] Create 'expire' and 'repack' verbs for git-multi-pack-index

[7] https://github.com/Microsoft/VFSForGit/blob/9cad154293456a41bef593a75e1ad2cb840c8524/GVFS/GVFS.Common/Maintenance/PackfileMaintenanceStep.cs#L141-L158
    The use of 'expire' and 'repack' in VFS for Git

[8] https://github.com/git/git/blob/master/Documentation/technical/multi-pack-index.txt#L77-L84
    multi-pack-index and stable object order


Test Coverage Report
====================

My intentions creating the test coverage report were to avoid bugs by double-
checking that we are testing all logic that was both (1) non-trivial, and
(2) new. The report does tend to be noisy with a lot of trivial blocks (error
cases) or code that was not covered before but was updated with a mechanical
refactoring. I'm hoping to attack these issues by using a new approach when
generating the reports.

I've created a GitHub repo [9] that contains new logic for generating the test
coverage report. In particular, it will now generate a text report that will
be sent to the list, but also an HTML report that will be posted online (see
[10] for an example).

In addition, the repo has an 'ignored' directory. This directory will be filled
with files that mirror their corresponding files in the Git repo, but contain
line numbers and contents for lines that have been deemed "unimportant". For
instance, I didn't want to just ignore all lines that say simply "return;" but
we can check that line 302 of builtin/checkout.c says "return;" and ignore that
line in the report [11].

I'll try to review the test report and add ignored lines before generating the
next report. I'll also accept PRs that add ignored lines (with justification).

I think this will help the usefulness significantly, especially as topics merge
down into 'next' and 'master'. If we track the ignored lines throughout a cycle,
then the report for 'maint' versus 'master' near release time may actually be
reasonable to read.

Any other feedback on the reports is greatly appreciated!

[9] https://github.com/derrickstolee/git-test-coverage

[10] https://derrickstolee.github.io/git-test-coverage/reports/2019-01-29.htm

[11] https://github.com/derrickstolee/git-test-coverage/blob/master/ignored/builtin/checkout.c
