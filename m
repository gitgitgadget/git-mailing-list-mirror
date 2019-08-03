Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 662971F732
	for <e@80x24.org>; Sat,  3 Aug 2019 05:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfHCFdy (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 01:33:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51225 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfHCFdy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 01:33:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so69870430wma.1
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 22:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ciPGmmjY9eE0FOFFzchxj88Phx4Ii0EVThr2h/Ujiss=;
        b=T8yxK3HC4TbEVpA+uOUcsyfJ2IEZCEps8rNCZWbvxdYlLcvgTSgVmWMmGL5HsJg/2/
         cTeChzbiPmdKGw/du8VHUKhia4RMSStWNkyEZ/35xJaZXD6gHKTiKo2lnqO++kjyJOll
         Oq9SP3pur1N8QS5XBlyag2fXrfPpQy7Zm8xMDK2r+c99MHrr0ebP6RwFEwtIy08XzJy+
         yQGZ/kmVwQEzlcQzjiegXPujr+9lqmZPl8ovWlp2A9xF8HnUxvzaMH9g3g5hYIgMhCux
         MKpN0f+xxAAmNirmWmM9VV2MiLK+47MUdAX/pkcsLq7G+Z9SALC1DdbbZfvudlc1tr5T
         NNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ciPGmmjY9eE0FOFFzchxj88Phx4Ii0EVThr2h/Ujiss=;
        b=ZR/Lf/nWV7hnAZA0nH7u/GxdHQcuhk9E5YaEkbL8pNkNoMryRaj1Gwb2YxsxINqfh1
         //LFSPkvhBfhHb4gaGQbvIc1EBaM1p5DrMbrZbEUbNTyjjLu3HZ1gmCdxGzDtETyBVp0
         xfGaLlakTqdxzsJ7eefJM59Ut+p61sV6A7O2vCYfP3akuLPRMDYNOibwyVLQ05mzFL86
         A8wIo1l7Ab0Nyn1o4nYjBDzOUpdbAUh+ozzmtKK4/9Y36X1zcqVUBU23KkgQwjQNUhWU
         uy7/1Q6NhUi2kvEwlXZgCtFGSRucoYOvLJgfFfugx2JlJIoLVrwg1F34/yavUroXdmhM
         4mVw==
X-Gm-Message-State: APjAAAXGVyijDK5wZUJkWhD5/WtkA5ouVs7yw2+MTxTjaOAP66YMB5cl
        ZMVQcM7HJvliFkpnO8ay64Vlz72Z
X-Google-Smtp-Source: APXvYqz9b/kB4LOi1LK6+putysL1EPvZxnCjhhThi+Y7BzUQhI3SIFSC/FqyMxuNgD1aGgGFkpYGXg==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr7659357wma.78.1564810432134;
        Fri, 02 Aug 2019 22:33:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z25sm81502704wmf.38.2019.08.02.22.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 22:33:51 -0700 (PDT)
Date:   Fri, 02 Aug 2019 22:33:51 -0700 (PDT)
X-Google-Original-Date: Sat, 03 Aug 2019 05:33:49 GMT
Message-Id: <e33755d2346e519b95ab57cdd1aef7d4d41d65ce.1564810429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.304.git.gitgitgadget@gmail.com>
References: <pull.304.git.gitgitgadget@gmail.com>
From:   "Mark Rushakoff via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] doc: typo: s/can not/cannot/ and s/is does/does/
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Mark Rushakoff <mark.rushakoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mark Rushakoff <mark.rushakoff@gmail.com>

"Can not" suggests one has the option to not do something, whereas
"cannot" more strongly suggests something is disallowed or impossible.

Noticed "can not", mistakenly used instead of "cannot" in git help
glossary, then ran git grep 'can not' and found many other instances.
Only files in the Documentation folder were modified.

'Can not' also occurs in some source code comments and some test
assertion messages, and there is an error message and translation "can
not move directory into itself" which I may fix and submit separately
from the documentation change.

Also noticed and fixed "is does" in git help fetch, but there are no
other occurrences of that typo according to git grep.

Signed-off-by: Mark Rushakoff <mark.rushakoff@gmail.com>
---
 Documentation/config/transfer.txt             | 2 +-
 Documentation/git-cvsserver.txt               | 2 +-
 Documentation/git-fetch.txt                   | 4 ++--
 Documentation/git-pull.txt                    | 2 +-
 Documentation/glossary-content.txt            | 2 +-
 Documentation/technical/api-ref-iteration.txt | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index 4a5dfe2fc1..f5b6245270 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -17,7 +17,7 @@ linkgit:git-receive-pack[1]. On the fetch side, malformed objects will
 instead be left unreferenced in the repository.
 +
 Due to the non-quarantine nature of the `fetch.fsckObjects`
-implementation it can not be relied upon to leave the object store
+implementation it cannot be relied upon to leave the object store
 clean like `receive.fsckObjects` can.
 +
 As objects are unpacked they're written to the object store, so there
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index f98b7c6ed7..79e22b1f3a 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -232,7 +232,7 @@ write so it might not be enough to grant the users using
 'git-cvsserver' write access to the database file without granting
 them write access to the directory, too.
 
-The database can not be reliably regenerated in a
+The database cannot be reliably regenerated in a
 consistent form after the branch it is tracking has changed.
 Example: For merged branches, 'git-cvsserver' only tracks
 one branch of development, and after a 'git merge' an
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 266d63cf11..5b1909fdf4 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -262,7 +262,7 @@ This updates (or creates, as necessary) branches `pu` and `tmp` in
 the local repository by fetching from the branches (respectively)
 `pu` and `maint` from the remote repository.
 +
-The `pu` branch will be updated even if it is does not fast-forward,
+The `pu` branch will be updated even if it does not fast-forward,
 because it is prefixed with a plus sign; `tmp` will not be.
 
 * Peek at a remote's branch, without configuring the remote in your local
@@ -285,7 +285,7 @@ BUGS
 ----
 Using --recurse-submodules can only fetch new commits in already checked
 out submodules right now. When e.g. upstream added a new submodule in the
-just fetched commits of the superproject the submodule itself can not be
+just fetched commits of the superproject the submodule itself cannot be
 fetched, making it impossible to check out that submodule later without
 having to do a fetch again. This is expected to be fixed in a future Git
 version.
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index a5e9501a0a..dfb901f8b8 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -249,7 +249,7 @@ BUGS
 ----
 Using --recurse-submodules can only fetch new commits in already checked
 out submodules right now. When e.g. upstream added a new submodule in the
-just fetched commits of the superproject the submodule itself can not be
+just fetched commits of the superproject the submodule itself cannot be
 fetched, making it impossible to check out that submodule later without
 having to do a fetch again. This is expected to be fixed in a future Git
 version.
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 8d38ae6010..090c888335 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -255,7 +255,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 [[def_object]]object::
 	The unit of storage in Git. It is uniquely identified by the
 	<<def_SHA1,SHA-1>> of its contents. Consequently, an
-	object can not be changed.
+	object cannot be changed.
 
 [[def_object_database]]object database::
 	Stores a set of "objects", and an individual <<def_object,object>> is
diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentation/technical/api-ref-iteration.txt
index 46c3d5c355..ad9d019ff9 100644
--- a/Documentation/technical/api-ref-iteration.txt
+++ b/Documentation/technical/api-ref-iteration.txt
@@ -54,7 +54,7 @@ this:
 do not do this you will get an error for each ref that it does not point
 to a valid object.
 
-Note: As a side-effect of this you can not safely assume that all
+Note: As a side-effect of this you cannot safely assume that all
 objects you lookup are available in superproject. All submodule objects
 will be available the same way as the superprojects objects.
 
-- 
gitgitgadget
