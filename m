Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03631C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 11:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4F3206F6
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 11:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="eavsjAfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgC3L4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:56:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36776 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729941AbgC3L4n (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Mar 2020 07:56:43 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B773360732;
        Mon, 30 Mar 2020 11:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1585569402;
        bh=sOKf4rknpxdv/BzbXW7StgemDCdUoxcW0JAI2EpTR+E=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=eavsjAfajx5MPE/0OVmiDBpstKrQy/gcsUHE86Zw1zCHOdfGZlJpB1uq9fRKv0xnz
         zfrvN5xGGUotOu0qIkTvKgUnIzifvvdTRhC4Pb4sIxsn3oLxin53/uuyNZ385o/3VQ
         yCkHFK69/cISn5pX9PKbJKw5gZbQvSChetPk7xYCtDKTik8K2Qj3O/QTY6SdhpFUlD
         54QSCjH3tfZGjo8zPRnHzhHjNNKvS2YB1X36AlMvi3XL98AhNYRyTP1O10OZNuRvqs
         S9eQsdijG7mpwvHW4zsJTDuWFVGMO0FduYQOkviy/JeKzbKICtE4o4OhojIjID0L6/
         91S6MfbXjWE21avzAp8v11PbcXHs4kLqDwK9KJ5bwLupcuUgHm6tk+EFnKCbUl3E4P
         TY54KSIBQgdAfWrgTUPuCSNXVr7Of7qWUpGs/qK6Bog8pfW1ya79J6gisJ7vHYxamw
         1+ECVZxsj1Ue2mporCDa34WbJCrhO8qgyWzdip1FlINu9WNci9b
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 0/1] FAQ for common user questions
Date:   Mon, 30 Mar 2020 11:55:17 +0000
Message-Id: <20200330115518.121528-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git is an enormously flexible and powerful piece of software, but many
people find it confusing and hard to use.  This patch introduces a FAQ
to address some common user questions and hopefully make it easier.

Changes from v2:
* Suggest that the user might prefer a different editor as an additional
  reason for not choosing vi.
* Avoid needless use of the past subjunctive.
* Use a introductory clause that draws contrast when discouraging people
  from putting passwords in their URLs.
* Mention the file into which the user should place their OpenSSH
  configuration.
* Rephrase question to avoid a misplaced modifier.
* Fix section level.
* Fix several typographical errors.

Changes from v1:
* Fix various indentation issues.
* Avoid using "some people", except to state that "some people find `vi`
  difficult to use", preferring to use language addressing
  misconceptions more directly.
* Add "erroneously" to "This is often suggested" to avoid users
  accidentally doing what we recommend against.
* Attempt to come up with a better way to describe a personal name,
  using Junio as an example.

brian m. carlson (1):
  docs: add a FAQ

 Documentation/Makefile   |   1 +
 Documentation/gitfaq.txt | 337 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 338 insertions(+)
 create mode 100644 Documentation/gitfaq.txt

Range-diff against v2:
1:  e5d6363d4a ! 1:  56d75e7b57 docs: add a FAQ
    @@ Documentation/gitfaq.txt (new)
     +
     +[[configure-editor]]
     +How do I configure a different editor?::
    -+	If you haven't specified an editor specifically for Git, it will by
    -+	default use the editor you've configured using the `VISUAL` or `EDITOR`
    -+	environment variables, or if neither is specified, the system default
    -+	(which is usually `vi`).  Since some people find `vi` difficult to use,
    -+	it may be desirable to change the editor used.
    ++	If you haven't specified an editor specifically for Git, it will by default
    ++	use the editor you've configured using the `VISUAL` or `EDITOR` environment
    ++	variables, or if neither is specified, the system default (which is usually
    ++	`vi`).  Since some people find `vi` difficult to use or prefer a different
    ++	editor, it may be desirable to change the editor used.
     ++
     +If you want to configure a general editor for most programs which need one, you
     +can edit your shell configuration (e.g., `~/.bashrc` or `~/.zshenv`) to contain
     +a line setting the `EDITOR` or `VISUAL` environment variable to an appropriate
    -+value.  For example, if you preferred the editor `nano`, then you could write
    -+the following:
    ++value.  For example, if you prefer the editor `nano`, then you could write the
    ++following:
     ++
     +----
     +export VISUAL=nano
    @@ Documentation/gitfaq.txt (new)
     +permanently store your credentials, but does prevent you from being prompted for
     +them for a certain period of time.
     ++
    -+You can also just enter your password when prompted, or you can place the
    -+password (which must be percent-encoded) in the URL.  The latter option is not
    ++You can also just enter your password when prompted.  While it is possible to
    ++place the password (which must be percent-encoded) in the URL, this is not
     +particularly secure and can lead to accidental exposure of credentials, so it is
     +not recommended.
     +
    @@ Documentation/gitfaq.txt (new)
     +Most hosting providers use a single SSH account for pushing; that is, all users
     +push to the `git` account (e.g., `git@git.example.org`).  If that's the case for
     +your provider, you can set up multiple aliases in SSH to make it clear which key
    -+pair to use.  For example, you could write something like the following,
    -+substituting the proper private key file:
    ++pair to use.  For example, you could write something like the following in
    ++`~/.ssh/config`, substituting the proper private key file:
     ++
     +----
     +# This is the account for author on git.example.org.
    @@ Documentation/gitfaq.txt (new)
     +	# This is the key pair registered for author with git.example.org.
     +	IdentityFile ~/.ssh/id_author
     +	IdentitiesOnly yes
    -+# This is the committer for author on git.example.org.
    ++# This is the account for committer on git.example.org.
     +Host example_committer
     +	HostName git.example.org
     +	User git
    @@ Documentation/gitfaq.txt (new)
     +[[last-commit-amend]]
     +I've made a mistake in the last commit.  How do I change it?::
     +	You can make the appropriate change to your working tree, run `git add
    -+	<file>` or `git rm <file>`, as approrpiate, to stage it, and then `git
    ++	<file>` or `git rm <file>`, as appropriate, to stage it, and then `git
     +	commit --amend`.  Your change will be included in the commit, and you'll
     +	be prompted to edit the commit message again; if you wish to use the
     +	original message verbatim, you can use the `--no-edit` option to `git
    @@ Documentation/gitfaq.txt (new)
     +-----
     +
     +[[restrict-with-hooks]]
    -+How do I prevent users from making certain changes with hooks?::
    ++How do I use hooks to prevent users from making certain changes?::
     +	The only safe place to make these changes is on the remote repository
     +	(i.e., the Git server), usually in the `pre-receive` hook or in a
     +	continuous integration (CI) system.  These are the locations in which
    @@ Documentation/gitfaq.txt (new)
     +anyway.
     +
     +Cross-Platform Issues
    -+~~~~~~~~~~~~~~~~~~~~~
    ++---------------------
     +
     +[[windows-text-binary]]
     +I'm on Windows and my text files are detected as binary.::
    @@ Documentation/gitfaq.txt (new)
     +	linkgit:git-diff[1] to work as expected, while still allowing your tools
     +	to work.
     ++
    -+To do so, you can specify a linkgit:gitattributes[5] pattern with with the
    ++To do so, you can specify a linkgit:gitattributes[5] pattern with the
     +`working-tree-encoding` attribute.  For example, the following pattern sets all
     +C files to use UTF-16LE-BOM, which is a common encoding on Windows:
     ++
    @@ Documentation/gitfaq.txt (new)
     +
     +[[windows-diff-control-m]]
     +I'm on Windows and git diff shows my files as having a `^M` at the end.::
    -+	By default, Git expects files to be stored with Unix line endings.  As
    -+	such, the carriage return (`^M`) that is part of a Windows line ending
    -+	results is show because it is considered to be trailing whitespace.  Git
    -+	defaults to showing trailing whitespace only on new lines, not existing
    -+	ones.
    ++	By default, Git expects files to be stored with Unix line endings.  As such,
    ++	the carriage return (`^M`) that is part of a Windows line ending is shown
    ++	because it is considered to be trailing whitespace.  Git defaults to showing
    ++	trailing whitespace only on new lines, not existing ones.
     ++
     +You can store the files in the repository with Unix line endings and convert
     +them automatically to your platform's line endings.  To do that, set the
    @@ Documentation/gitfaq.txt (new)
     +build products are best stored on an artifact or package server with only
     +references, URLs, and hashes stored in the repository.
     ++
    -+We also recommend setting a link:gitattributes[5] file to explicitly mark which
    -+files are text and which are binary.  If you want Git to guess, you can set the
    -+attribute `text=auto`.  For example, the following might be appropriate in some
    -+projects:
    ++We also recommend setting a linkgit:gitattributes[5] file to explicitly mark
    ++which files are text and which are binary.  If you want Git to guess, you can
    ++set the attribute `text=auto`.  For example, the following might be appropriate
    ++in some projects:
     ++
     +----
     +# By default, guess.
