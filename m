Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7751F576
	for <e@80x24.org>; Fri, 16 Feb 2018 17:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162511AbeBPRzc (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:55:32 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35450 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162497AbeBPRz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:55:26 -0500
Received: by mail-wm0-f65.google.com with SMTP id x21so4548545wmh.0;
        Fri, 16 Feb 2018 09:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=GGDfF4aGOSSTY2S8sThkBL4qxagJNNFWzIm/lnVbA9k=;
        b=axskhzmSadziMjHFpdkBHALissOANHBBUk13MjOPgOpi2YrKy9bWFFTdKforaKEldD
         VcRhA9+EGktfkyk9J6wsTcIDVN3xaVqULtd84MVMgq4HtXfQcDDNYfrNOsuTRa8Bxe/S
         w6GHuQRHLVF7mG+pxnXgFEfnfZsg+fWVw/pl+sqGyeL9ZpdU7vm0S9bCk61Q02W9YD7b
         Xi18jW2imhdtU+PWSnSVbwIgJeU5/+j7pWcJ/k7NMEhr51RQbD5zneNLKPRYuiEsPhsn
         tapdWkpnigGO/DO0quAajnnXk7cIVJ0r/TiC/eTAs2xmsAo4u/I9G+lVuW+8cIiKQbRY
         yf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=GGDfF4aGOSSTY2S8sThkBL4qxagJNNFWzIm/lnVbA9k=;
        b=BYmEqHb+cWDiWEHTMZnjLu3sXgsYLEBivevXP4+JI3B/yQM4ONIY0muhOm9tuhKTdM
         okoeh1piyZfydGR6h3dmQ9KvMwJHR5otGCOn2OIDO1giSNh5k5XTHi/kxHSMpmpeph2m
         a1BnT4GRXTfiqIzQMQLSw1aWqk5/AzxH7KJtjnHRnUGmhrFt/jAlOXPYo3V3asfCKoJh
         hMOR3yGSQecAWCCJjlPJ3jUKchKORvCnt4fBKDA6IRINXKpEuu6s6L6DVyRdRfdY/CsX
         otFW8QLBbz7Z5DEem94HSFew0FoYCR31FHlXIaUXsrBEgiqeH8Dy9JEKRLJcFjBn1AoZ
         lYvA==
X-Gm-Message-State: APf1xPALYH7vXuBT4vYbx5dcDt4/vA/T61DBpHD44mG7YvEUPAmBaIrx
        Tr95Fj35NCK3yi+Y+iz5rzGqDgBr
X-Google-Smtp-Source: AH8x224RQDYr5rI1i2Dr5wlYNrUFoGDgL/p8CgtioVR7V+mWccn0zYh8WiqOqpgdQGj7pjBIIoaZUw==
X-Received: by 10.28.113.216 with SMTP id d85mr1774373wmi.3.1518803724676;
        Fri, 16 Feb 2018 09:55:24 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x203sm34744224wmd.11.2018.02.16.09.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 09:55:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.16.2
Date:   Fri, 16 Feb 2018 09:55:22 -0800
Message-ID: <xmqqinaw7rat.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.16.2 is now available at
the usual places, with small fixes that are already in the 
'master' front.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.16.2'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.16.2 Release Notes
=========================

Fixes since v2.16.1
-------------------

 * An old regression in "git describe --all $annotated_tag^0" has been
   fixed.

 * "git svn dcommit" did not take into account the fact that a
   svn+ssh:// URL with a username@ (typically used for pushing) refers
   to the same SVN repository without the username@ and failed when
   svn.pushmergeinfo option is set.

 * "git merge -Xours/-Xtheirs" learned to use our/their version when
   resolving a conflicting updates to a symbolic link.

 * "git clone $there $here" is allowed even when here directory exists
   as long as it is an empty directory, but the command incorrectly
   removed it upon a failure of the operation.

 * "git stash -- <pathspec>" incorrectly blew away untracked files in
   the directory that matched the pathspec, which has been corrected.

 * "git add -p" was taught to ignore local changes to submodules as
   they do not interfere with the partial addition of regular changes
   anyway.


Also contains various documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.16.1 are as follows:

Andreas G. Schacker (1):
      doc/read-tree: remove obsolete remark

Daniel Knittl-Frank (1):
      describe: prepend "tags/" when describing tags with embedded name

Jason Merrill (1):
      git-svn: fix svn.pushmergeinfo handling of svn+ssh usernames.

Jeff King (4):
      t5600: fix outdated comment about unborn HEAD
      t5600: modernize style
      clone: factor out dir_exists() helper
      clone: do not clean up directories we didn't create

Junio C Hamano (2):
      merge: teach -Xours/-Xtheirs to symbolic link merge
      Git 2.16.2

Nguyễn Thái Ngọc Duy (1):
      add--interactive: ignore submodule changes except HEAD

René Scharfe (9):
      commit: avoid allocation in clear_commit_marks_many()
      commit: use clear_commit_marks_many() in remove_redundant()
      ref-filter: use clear_commit_marks_many() in do_merge_filter()
      object: add clear_commit_marks_all()
      bisect: avoid using the rev_info flag leak_pending
      bundle: avoid using the rev_info flag leak_pending
      checkout: avoid using the rev_info flag leak_pending
      revision: remove the unused flag leak_pending
      commit: remove unused function clear_commit_marks_for_object_array()

Thomas Gummerer (1):
      stash: don't delete untracked files that match pathspec

Ævar Arnfjörð Bjarmason (2):
      perf: amend the grep tests to test grep.threads
      cat-file doc: document that -e will return some output

