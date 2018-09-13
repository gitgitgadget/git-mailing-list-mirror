Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F84A1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 14:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeIMUGg (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 16:06:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46787 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeIMUGg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 16:06:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so2775995pfn.13
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gyVi7DpT8o1qHRnMKLSLr/HHfRv7z5l8PZb7Snf0ZGc=;
        b=LpYa+9zTjgdDIapTPbkpbwGbxm1kipavExt4ZhHvrw8w4bcTsfCX2biVLyg5OGGC+p
         6nCxMx+BFmBgx1U2Hq77Jeg4dJzZMyirsqyRvai++5AMzEoCSPgKlmp2ja2KljMHwAyO
         YOaLWbVRxf61hO2YSfT3AIjkYkrKrTTKgtI3cGQmOfhoNo89bXWCSkhWx6aDbN5TNdp4
         Qn+Xk5OgBdHGX4lAV4ghDLEvVs6NIOPVjyTRc1NnnbzJdaDHn/UrBBzdk9h0kXlxlFYn
         SLm0zy7FJZ1TLAEZS1THns4D6SegMCGDhPKobIDWAPvVRfqm4bxwphtnTMb+pQ43as0g
         0O6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gyVi7DpT8o1qHRnMKLSLr/HHfRv7z5l8PZb7Snf0ZGc=;
        b=PnjIW0p4VW/Ut8a8xT9vCBG0KcXlr7Je484CHhySN9q1jtR1n24GHzaCp6vWZU27j3
         OPSi8Oc9CztvRkoYxYo2Z3rTFnMlqnebQ2DexjW4KP5laYCDLyYZA0BJ++LgLNG8rHLg
         v3zYatiqkL5Tt9oJQF2pn6MGaxEek1aY75qJfnNjEQNmZ+Bgxd3WfxbPYBfGxdBpzO9i
         pe44rWTEW1OqYKusq464iB2L9bE9u3MLazzZo4nZ7QdqcCqYMkjf48AUgwon7FEgD5r1
         zmF/Dp+F2AWVs7o4ie2b5HpwfA0q6nZ54bQ1FI2IvP6WC/r6fU1rupyYk5wx6djyrNY5
         k2Gw==
X-Gm-Message-State: APzg51Dr1Zv+Gh2E4uhXZOQDa2j/RHbRFl4rljZ7KQyiuUT51ZsS0BnP
        sjd2IRkiYHVGnW139p3PRmb2BQFn
X-Google-Smtp-Source: ANB0VdZEVccaPUv95/8dTE7LpGNabw+HS9hsPiAMKNRTM+KKj9eWT7mh18cGGEoIVNQuBlH9AkCZug==
X-Received: by 2002:a62:6948:: with SMTP id e69-v6mr7877468pfc.166.1536850603583;
        Thu, 13 Sep 2018 07:56:43 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id h190-v6sm7380543pge.18.2018.09.13.07.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 07:56:42 -0700 (PDT)
Date:   Thu, 13 Sep 2018 07:56:42 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Sep 2018 14:56:39 GMT
Message-Id: <pull.40.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.40.git.gitgitgadget@gmail.com>
References: <pull.40.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] contrib: Add script to show uncovered "new" lines
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have coverage targets in our Makefile for using gcov to display line
coverage based on our test suite. The way I like to do it is to run:

make coverage-test
make coverage-report

This leaves the repo in a state where every X.c file that was covered has an
X.c.gcov file containing the coverage counts for every line, and "#####" at
every uncovered line.

There have been a few bugs in recent patches what would have been caught if
the test suite covered those blocks (including a few of mine). I want to
work towards a "sensible" amount of coverage on new topics. In my opinion,
this means that any logic should be covered, but the 'die()' blocks in error
cases do not need to be covered.

It is important to not measure the coverage of the codebase by what old code
is not covered. To help, I created the 'contrib/coverage-diff.sh' script.
After creating the coverage statistics at a version (say, 'topic') you can
then run

contrib/coverage-diff.sh base topic

to see the lines added between 'base' and 'topic' that are not covered by
the test suite. For example, I ran this against the 'jch' branch (d3c0046)
versus 'next' (dd90340) and got the following output:

builtin/commit.c
859fdc0c3cf     (Derrick Stolee 2018-08-29 05:49:04 -0700       1657)           write_commit_graph_reachable(get_object_directory(), 0);
builtin/rev-list.c
250edfa8c87     (Harald Nordgren        2018-04-18 23:05:35 +0200       431)                    bisect_flags |= BISECT_FIND_ALL;
builtin/worktree.c
e5353bef550     (Eric Sunshine  2018-08-28 17:20:19 -0400       60)             error_errno(_("failed to delete '%s'"), sb.buf);
e19831c94f9     (Eric Sunshine  2018-08-28 17:20:23 -0400       251)                die(_("unable to re-add worktree '%s'"), path);
68a6b3a1bd4     (Eric Sunshine  2018-08-28 17:20:24 -0400       793)                    die(_("cannot move a locked working tree, lock reason: %s\nuse 'move -f -f' to override or unlock first"),
f4143101cbb     (Eric Sunshine  2018-08-28 17:20:25 -0400       906)                    die(_("cannot remove a locked working tree, lock reason: %s\nuse 'remove -f -f' to override or unlock first"),
read-cache.c
67922abbbb3     (Nguyễn Thái Ngọc Duy   2018-09-02 15:19:33 +0200       1754)           const unsigned char *cp = (const unsigned char *)name;
67922abbbb3     (Nguyễn Thái Ngọc Duy   2018-09-02 15:19:33 +0200       1757)           previous_len = previous_ce ? previous_ce->ce_namelen : 0;
67922abbbb3     (Nguyễn Thái Ngọc Duy   2018-09-02 15:19:33 +0200       1758)           strip_len = decode_varint(&cp);
67922abbbb3     (Nguyễn Thái Ngọc Duy   2018-09-02 15:19:33 +0200       1759)           if (previous_len < strip_len) {
67922abbbb3     (Nguyễn Thái Ngọc Duy   2018-09-02 15:19:33 +0200       1760)                   if (previous_ce)
67922abbbb3     (Nguyễn Thái Ngọc Duy   2018-09-02 15:19:33 +0200       1761)                           die(_("malformed name field in the index, near path '%s'"),
67922abbbb3     (Nguyễn Thái Ngọc Duy   2018-09-02 15:19:33 +0200       1762)                               previous_ce->name);
67922abbbb3     (Nguyễn Thái Ngọc Duy   2018-09-02 15:19:33 +0200       1764)                           die(_("malformed name field in the index in the first path"));
67922abbbb3     (Nguyễn Thái Ngọc Duy   2018-09-02 15:19:33 +0200       1766)           copy_len = previous_len - strip_len;
67922abbbb3     (Nguyễn Thái Ngọc Duy   2018-09-02 15:19:33 +0200       1767)           name = (const char *)cp;
67922abbbb3     (Nguyễn Thái Ngọc Duy   2018-09-02 15:19:33 +0200       1773)                   len += copy_len;
67922abbbb3     (Nguyễn Thái Ngọc Duy   2018-09-02 15:19:33 +0200       1794)           if (copy_len)
67922abbbb3     (Nguyễn Thái Ngọc Duy   2018-09-02 15:19:33 +0200       1795)                   memcpy(ce->name, previous_ce->name, copy_len);
67922abbbb3     (Nguyễn Thái Ngọc Duy   2018-09-02 15:19:33 +0200       1796)           memcpy(ce->name + copy_len, name, len + 1 - copy_len);
67922abbbb3     (Nguyễn Thái Ngọc Duy   2018-09-02 15:19:33 +0200       1797)           *ent_size = (name - ((char *)ondisk)) + len + 1 - copy_len;
remote-curl.c
c3b9bc94b9b     (Elijah Newren  2018-09-05 10:03:07 -0700       181)            options.filter = xstrdup(value);

Using this 'git blame' output, we can quickly inspect whether the uncovered
lines are appropriate. For instance:

 1. The line in builtin/commit.c is due to writing the commit-graph file
    when GIT_TEST_COMMIT_GRAPH is enabled, which is not on by default in the
    test suite. Being uncovered is expected here.
    
    
 2. The lines in builtin/worktree.c are all related to error conditions.
    This is acceptable.
    
    
 3. The line in builtin/rev-list.c is a flag replacement in a block that is
    otherwise unchanged. It must not be covered by the test suite normally.
    This could be worth adding a test to ensure the new logic maintains old
    behavior.
    
    
 4. The lines in read-cache.c are part of a new block for the condition "if
    (expand_name_field)" as part of an optimization. These lines should
    probably be covered before that series is merged to 'next'. I understand
    that Ben and Duy are continuing work in this direction [1].
    
    

I used this approach for 'next' over 'master' and got a larger list, some of
which I have already submitted tests to increase coverage [2] or will be
covered by topics not in 'next' [3].

Thanks, -Stolee

CHANGES IN V2: I converted the script from bash to sh (there may still be
POSIX-compliance issues with the new script, I don't know a lot when it
comes to that area). I also streamlined the machinery to add line numbers to
the diff. One downside is that the script runs a little slower with all of
the grep process invocations.

[1] 
https://public-inbox.org/git/20180912161832.55324-1-benpeart@microsoft.com/T/#u

[2] https://public-inbox.org/git/pull.37.git.gitgitgadget@gmail.com/

[3] https://public-inbox.org/git/pull.34.git.gitgitgadget@gmail.com/

Derrick Stolee (1):
  contrib: add coverage-diff script

 contrib/coverage-diff.sh | 63 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100755 contrib/coverage-diff.sh


base-commit: 1d4361b0f344188ab5eec6dcea01f61a3a3a1670
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-40%2Fderrickstolee%2Fcoverage-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-40/derrickstolee/coverage-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/40

Range-diff vs v1:

 1:  e4124471e5 < -:  ---------- contrib: add coverage-diff script
 -:  ---------- > 1:  7714b0659e contrib: add coverage-diff script

-- 
gitgitgadget
