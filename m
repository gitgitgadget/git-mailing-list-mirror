Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AC431F4C0
	for <e@80x24.org>; Wed,  6 Nov 2019 09:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbfKFJ7y (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 04:59:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34152 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731035AbfKFJ7y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 04:59:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id e6so23110973wrw.1
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 01:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fdbTCI+pomsEV4qMtue7Vi0cNuWX7qHz7PlGSBNTYR4=;
        b=RjH6IpgKWxhEGMT3Ug/eUPWVz04I+91PK16KCBHMU9/iPmOGo+ArD0EPejK5f9nRFk
         3BTdDE9KJSNL126WxklwiMRfVxYp+ZjbXk3S0YW7hsgBwNTe+xkeyVFK/F8PRmiZMQYH
         ZNceuTcFILizYmjdhNzZy/jTn8ATH1aH6mVZCumKWmTEkKnx/QVKDwLmovulXFdQ7vSi
         j/wN3gvoRu8NJhznZfNe5gOiaNfk6hqUbW2BJE1aO9DAlH2ILpq8AiIkJ0ZJ0C3PrbF6
         oPhd1O5OmjALQOLRW22p5Y8xoIkp1COtzBSd+Jy+0cRadiy4DqBDlDY8IAtAZX7D2CHP
         Jm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fdbTCI+pomsEV4qMtue7Vi0cNuWX7qHz7PlGSBNTYR4=;
        b=SaJm7MHtE69rGC8h2l1ffvtdbpPljhd230qB2fP5jZQfdN74fMHZfuhBIhBbppTOvV
         UT/G/Z+okp04b5mmhd+EKxA9VCj7f2VzV/AArG70hI43AtTE+9QTG2tqNOOBSNxhwvs5
         p869Q4hrfYgppfH2m39RsTZTkd7iZYHa5u6AiOYDcZgROUZKQilcHCOUDqxkTfjPDdbn
         iH0GdAth178NMJf6LVpTluv2GwIjd0By6dDXGXhvN/VLsMGqZLbgUq5kzLAS6xYsEqea
         nik9EWmipS6Tp4o80ZCu/KPF6xLT8BWKB6TWv1mt1G0OLdpPfNZsZf/xGMwx63AuQU6W
         9IyA==
X-Gm-Message-State: APjAAAXeY0OOtLjPEhd8/9iXor1e4ZxiRBO9Kr2xe4AFBVEMQGllR3mz
        Y2oaYjOEr0npgj6n89DdMmIL8Dg9
X-Google-Smtp-Source: APXvYqxC1GU0N426AOSyBSmyhpJ2aUZUneLsABMGShhkUn8NikRMT9YpQqQKb5JlmQNpVnXipOX17g==
X-Received: by 2002:a5d:4403:: with SMTP id z3mr1732877wrq.44.1573034388873;
        Wed, 06 Nov 2019 01:59:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h205sm2436210wmf.35.2019.11.06.01.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:59:48 -0800 (PST)
Message-Id: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.git.1572343246.gitgitgadget@gmail.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 09:59:27 +0000
Subject: [PATCH v2 00/20] [Outreachy] Move doc to header files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the documentation from Documentation/technical/api-*.txt to the
corresponding header file, as it's easier for the developers to find the
usage information beside the code instead of looking for it in another doc
file.

Also documentation/technical/api-*.txt is removed because the information it
has is will be redundant and it'll be hard to keep it up to date and
synchronized with the documentation in the header files.

api-trace2.txt is not removed because it has lots of valuable information
that seems more appropriate to be in a separate doc file not in the trace2.h
although the functions documentation is moved to the trace2.h

api-error-handling.txt is not removed as well because no other file seemed
to be more suitable for the doc it contains. I'm open to suggestions though.

The ll-merge related doc was removed from api-merge.txt to ll-merge.h, while
the rest of the file is left as is.

Signed-off-by: Heba Waly heba.waly@gmail.com

Heba Waly (20):
  diff: move doc to diff.h and diffcore.h
  dir: move doc to dir.h
  graph: move doc to graph.h and graph.c
  merge: move doc to ll-merge.h
  sha1-array: move doc to sha1-array.h
  remote: move doc to remote.h and refspec.h
  refs: move doc to refs.h
  attr: move doc to attr.h
  revision: move doc to revision.h
  pathspec: move doc to pathspec.h
  sigchain: move doc to sigchain.h
  cache: move doc to cache.h
  argv-array: move doc to argv-array.h
  credential: move doc to credential.h
  parse-options: move doc to parse-options.h
  run-command: move doc to run-command.h
  trace: move doc to trace.h
  tree-walk: move doc to tree-walk.h
  submodule-config: move doc to submodule-config.h
  trace2: move doc to trace2.h

 Documentation/MyFirstContribution.txt         |   2 +-
 Documentation/git-credential.txt              |   3 +-
 Documentation/gitcredentials.txt              |   3 +-
 .../technical/api-allocation-growing.txt      |  39 ---
 Documentation/technical/api-argv-array.txt    |  65 ----
 Documentation/technical/api-credentials.txt   | 271 ---------------
 Documentation/technical/api-diff.txt          | 174 ---------
 .../technical/api-directory-listing.txt       | 130 -------
 Documentation/technical/api-gitattributes.txt | 154 --------
 Documentation/technical/api-history-graph.txt | 173 ---------
 Documentation/technical/api-merge.txt         |  72 +---
 Documentation/technical/api-oid-array.txt     |  90 -----
 Documentation/technical/api-parse-options.txt | 313 -----------------
 Documentation/technical/api-ref-iteration.txt |  78 -----
 Documentation/technical/api-remote.txt        | 127 -------
 .../technical/api-revision-walking.txt        |  72 ----
 Documentation/technical/api-run-command.txt   | 264 --------------
 Documentation/technical/api-setup.txt         |  47 ---
 Documentation/technical/api-sigchain.txt      |  41 ---
 .../technical/api-submodule-config.txt        |  66 ----
 Documentation/technical/api-trace.txt         | 140 --------
 Documentation/technical/api-trace2.txt        | 262 +-------------
 Documentation/technical/api-tree-walking.txt  | 149 --------
 argv-array.h                                  |  62 ++++
 attr.h                                        | 141 +++++++-
 cache.h                                       |  41 ++-
 credential.h                                  | 236 +++++++++++++
 diff.h                                        | 127 +++++++
 diffcore.h                                    |  32 ++
 dir.h                                         | 118 ++++++-
 graph.c                                       |   1 +
 graph.h                                       | 121 +++++++
 ll-merge.h                                    |  73 +++-
 parse-options.h                               | 329 ++++++++++++++++++
 pathspec.h                                    |  34 +-
 refs.h                                        |  51 +++
 refspec.h                                     |  16 +
 remote.h                                      |  57 ++-
 revision.h                                    |  59 ++++
 run-command.h                                 | 254 +++++++++++++-
 sha1-array.h                                  |  80 +++++
 sigchain.h                                    |  42 +++
 submodule-config.h                            |  38 +-
 trace.h                                       | 133 ++++++-
 trace2.h                                      | 146 ++++++--
 tree-walk.h                                   | 122 ++++++-
 46 files changed, 2263 insertions(+), 2785 deletions(-)
 delete mode 100644 Documentation/technical/api-allocation-growing.txt
 delete mode 100644 Documentation/technical/api-argv-array.txt
 delete mode 100644 Documentation/technical/api-credentials.txt
 delete mode 100644 Documentation/technical/api-diff.txt
 delete mode 100644 Documentation/technical/api-directory-listing.txt
 delete mode 100644 Documentation/technical/api-gitattributes.txt
 delete mode 100644 Documentation/technical/api-history-graph.txt
 delete mode 100644 Documentation/technical/api-oid-array.txt
 delete mode 100644 Documentation/technical/api-parse-options.txt
 delete mode 100644 Documentation/technical/api-ref-iteration.txt
 delete mode 100644 Documentation/technical/api-remote.txt
 delete mode 100644 Documentation/technical/api-revision-walking.txt
 delete mode 100644 Documentation/technical/api-run-command.txt
 delete mode 100644 Documentation/technical/api-setup.txt
 delete mode 100644 Documentation/technical/api-sigchain.txt
 delete mode 100644 Documentation/technical/api-submodule-config.txt
 delete mode 100644 Documentation/technical/api-trace.txt
 delete mode 100644 Documentation/technical/api-tree-walking.txt


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-434%2FHebaWaly%2Fmove-doc-to-header-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-434/HebaWaly/move-doc-to-header-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/434

Range-diff vs v1:

  1:  1796c119be =  1:  6cd5f75315 diff: move doc to diff.h and diffcore.h
  2:  290935e846 =  2:  cdb32c159a dir: move doc to dir.h
  3:  dabfe5e60b =  3:  fd89383a46 graph: move doc to graph.h and graph.c
  4:  504f1f7c89 !  4:  a70ed4b79b merge: move doc to ll-merge.h
     @@ -2,51 +2,24 @@
      
          merge: move doc to ll-merge.h
      
     -    Move the documentation from Documentation/technical/api-merge.txt to
     -    ll-merge.h as it's easier for the developers to find the usage
     +    Move the related documentation from Documentation/technical/api-merge.txt
     +    to ll-merge.h as it's easier for the developers to find the usage
          information beside the code instead of looking for it in another doc file.
      
     -    Also documentation/technical/api-merge.txt is removed because the
     -    information it has is now redundant and it'll be hard to keep it up to
     -    date and synchronized with the documentation in the header file.
     +    Only the ll-merge related doc is removed from
     +    documentation/technical/api-merge.txt because this information will be
     +    redundant and it'll be hard to keep it up to date and synchronized with
     +    the documentation in ll-merge.h.
      
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
      
       diff --git a/Documentation/technical/api-merge.txt b/Documentation/technical/api-merge.txt
     - deleted file mode 100644
       --- a/Documentation/technical/api-merge.txt
     - +++ /dev/null
     + +++ b/Documentation/technical/api-merge.txt
      @@
     --merge API
     --=========
     --
     --The merge API helps a program to reconcile two competing sets of
     --improvements to some files (e.g., unregistered changes from the work
     --tree versus changes involved in switching to a new branch), reporting
     --conflicts if found.  The library called through this API is
     --responsible for a few things.
     --
     -- * determining which trees to merge (recursive ancestor consolidation);
     --
     -- * lining up corresponding files in the trees to be merged (rename
     --   detection, subtree shifting), reporting edge cases like add/add
     --   and rename/rename conflicts to the user;
     --
     -- * performing a three-way merge of corresponding files, taking
     --   path-specific merge drivers (specified in `.gitattributes`)
     --   into account.
     --
     --Data structures
     -----------------
     --
     --* `mmbuffer_t`, `mmfile_t`
     --
     --These store data usable for use by the xdiff backend, for writing and
     --for reading, respectively.  See `xdiff/xdiff.h` for the definitions
     --and `diff.c` for examples.
     --
     --* `struct ll_merge_options`
     --
     + 
     + * `struct ll_merge_options`
     + 
      -This describes the set of options the calling program wants to affect
      -the operation of a low-level (single file) merge.  Some options:
      -
     @@ -69,10 +42,11 @@
      -	before merging.  Use this when the merge is likely to have
      -	overlapped with a change in smudge/clean or end-of-line
      -	normalization rules.
     --
     --Low-level (single file) merge
     -------------------------------
     --
     ++Check ll-merge.h for details.
     + 
     + Low-level (single file) merge
     + -----------------------------
     + 
      -`ll_merge`::
      -
      -	Perform a three-way single-file merge in core.  This is
     @@ -121,6 +95,7 @@
      - - merge options
      -
      -(Daniel, Miklos, Stephan, JC)
     ++Check ll-merge.h for details.
      
       diff --git a/ll-merge.h b/ll-merge.h
       --- a/ll-merge.h
     @@ -130,21 +105,6 @@
       #include "xdiff/xdiff.h"
       
      +/**
     -+ * The merge API helps a program to reconcile two competing sets of
     -+ * improvements to some files (e.g., unregistered changes from the work
     -+ * tree versus changes involved in switching to a new branch), reporting
     -+ * conflicts if found.  The library called through this API is
     -+ * responsible for a few things.
     -+ *
     -+ *  - determining which trees to merge (recursive ancestor consolidation);
     -+ *
     -+ *  - lining up corresponding files in the trees to be merged (rename
     -+ *    detection, subtree shifting), reporting edge cases like add/add
     -+ *    and rename/rename conflicts to the user;
     -+ *
     -+ *  - performing a three-way merge of corresponding files, taking
     -+ *    path-specific merge drivers (specified in `.gitattributes`)
     -+ *    into account.
      + *
      + * Calling sequence:
      + * ----------------
     @@ -187,8 +147,10 @@
      +
      +    /**
      +     * Behave as though this were part of a merge between common ancestors in
     -+     * a recursive merge. If a helper program is specified by the
     -+	 * `[merge "<driver>"] recursive` configuration, it will be used.
     ++     * a recursive merge (merges of binary files may need to be handled
     ++     * differently in such cases, for example). If a helper program is
     ++     * specified by the `[merge "<driver>"] recursive` configuration, it will
     ++     * be used.
      +     */
       	unsigned virtual_ancestor : 1;
      -	unsigned variant : 2;	/* favor ours, favor theirs, or union merge */
     @@ -208,7 +170,13 @@
      +	 */
       	unsigned renormalize : 1;
      +
     ++	/**
     ++	 * Increase the length of conflict markers so that nested conflicts
     ++     * can be differentiated.
     ++	 */
       	unsigned extra_marker_size;
     ++
     ++    /* Extra xpparam_t flags as defined in xdiff/xdiff.h. */
       	long xdl_opts;
       };
       
  5:  4302bdd13f =  5:  fc81758644 sha1-array: move doc to sha1-array.h
  6:  e16f5b25e9 =  6:  eb7adbcbcc remote: move doc to remote.h and refspec.h
  7:  9c900c58a2 =  7:  24d0765df9 refs: move doc to refs.h
  8:  052d4e5e56 =  8:  4ea49f76c7 attr: move doc to attr.h
  9:  afab6d5f4e =  9:  acd6287ced revision: move doc to revision.h
 10:  5757216949 = 10:  dcb78b6708 pathspec: move doc to pathspec.h
  -:  ---------- > 11:  3499b99538 sigchain: move doc to sigchain.h
  -:  ---------- > 12:  a280cf7f90 cache: move doc to cache.h
  -:  ---------- > 13:  314864e42c argv-array: move doc to argv-array.h
  -:  ---------- > 14:  8fd1fa98a8 credential: move doc to credential.h
  -:  ---------- > 15:  3d1e7e72ef parse-options: move doc to parse-options.h
  -:  ---------- > 16:  5d93cab5d9 run-command: move doc to run-command.h
  -:  ---------- > 17:  9b02b44cc8 trace: move doc to trace.h
  -:  ---------- > 18:  9c8f5c1cbe tree-walk: move doc to tree-walk.h
  -:  ---------- > 19:  7fa5cdf83f submodule-config: move doc to submodule-config.h
  -:  ---------- > 20:  4c3215e92b trace2: move doc to trace2.h

-- 
gitgitgadget
