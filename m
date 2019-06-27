Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7FEF1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 19:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfF0TRD (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 15:17:03 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:46407 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfF0TRD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 15:17:03 -0400
Received: by mail-ed1-f45.google.com with SMTP id d4so8105132edr.13
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 12:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dvnLQ++ELQ7qKTG+uYWaSDQGLM55ImAaHccNDg7jid0=;
        b=UbsLftzsgFf9Am0Hh9gWCD7jMb1Ar0jawqn9NdV/fygaQwgfYvcUqPsgFVDOi/xqzl
         qcJH66yURdUdp48qkqdgIJojydwAi37bCveKaAje5GgQufd2hmLeJdoN5rHQp59Gy3EA
         hz/maAqm/nybSNm9qZqC5+yIvRfia6fKeMMIBidYjxPJ2s3dSv9/nDAKzIcyF639RChM
         r85lSiYQBGxvWXEp+AI20YVo606qSt6EDrFyFgLy/K166Tfe3/n7OdRQBnrk9ldBJQAa
         8jXjH9Y5cBlYUTZ3iJmiqqnwMXQoLZOZQkpzhE+zSXuEwe0vF6zUUI2zwG6fFHb5vk5y
         UXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dvnLQ++ELQ7qKTG+uYWaSDQGLM55ImAaHccNDg7jid0=;
        b=P8b1OmPAwIQfjtTRsufcUr3C4hhhwfHa9dVP5h2PB6FILpBHHfOMEIVmj+3FH4oAfh
         08KdXFJba1Z9mgxyj26jjNxlrvxIlIit/xspU1UwPckkw2jJiEBqRNhWNT3I7W7dAJD/
         Svt/d/zdatoNP+VeVAh7Z8bm4wwn0XeYQPRKJTQTHBQsBok6WURBP1qQ2wTd3oGmfj/e
         vNqt51CkqI890nNHef7tv/79hMh7N5Bd8lD1KatVp4acx63cE3En/bSVtzEkw0LlrpUc
         RjeG14D6VFwaHGD6+PBvlbK7sjYkoaUqqah7pAOfkG04eyZxOx8U83c4nTcdiG803SfM
         oojw==
X-Gm-Message-State: APjAAAVY2l6gIELgj0DKwulglZ5SiRrxqH/92Xjtbk0r+UF/2HKw3/xV
        7mp1gr+4u+QO/dfEcUoAcwTyhk3G
X-Google-Smtp-Source: APXvYqwFJ9tYfjMA3KgnGBk0SBEpjcMq3/maA3i/YXmNGJdmsghAqHOQyQPuVnmEcuRhtsawjDppTg==
X-Received: by 2002:a50:97c8:: with SMTP id f8mr6369329edb.176.1561663020943;
        Thu, 27 Jun 2019 12:17:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n22sm604277ejs.16.2019.06.27.12.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 12:17:00 -0700 (PDT)
Date:   Thu, 27 Jun 2019 12:17:00 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 19:16:59 GMT
Message-Id: <0dd1b017698dd9d15f291f1133eb40dac8d85a68.1561663019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.277.git.gitgitgadget@gmail.com>
References: <pull.277.git.gitgitgadget@gmail.com>
From:   "Quentin Nerden via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] docs: update git-clone doc: refer to long options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Quentin Nerden <quentin.nerden@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Quentin Nerden <quentin.nerden@gmail.com>

To make the doc of git-clone easier to read,
refer to the long version of the options
(it is easier to guess what --verbose is doing than -v).

Also:
put the short options first, to match the doc of git-add, git-commit, git-clean, git-branch...

Signed-off-by: Quentin Nerden <quentin.nerden@gmail.com>
---
 Documentation/git-clone.txt | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 5fc97f14de..4edc713a4b 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -41,8 +41,8 @@ configuration variables.
 
 OPTIONS
 -------
---local::
 -l::
+--local::
 	When the repository to clone from is on a local machine,
 	this flag bypasses the normal "Git aware" transport
 	mechanism and clones the repository by making a copy of
@@ -63,8 +63,8 @@ Git transport instead.
 	directory instead of using hardlinks. This may be desirable
 	if you are trying to make a back-up of your repository.
 
---shared::
 -s::
+--shared::
 	When the repository to clone is on the local machine,
 	instead of using hard links, automatically setup
 	`.git/objects/info/alternates` to share the objects
@@ -81,10 +81,10 @@ which automatically call `git gc --auto`. (See linkgit:git-gc[1].)
 If these objects are removed and were referenced by the cloned repository,
 then the cloned repository will become corrupt.
 +
-Note that running `git repack` without the `-l` option in a repository
+Note that running `git repack` without the `--local` option in a repository
 cloned with `-s` will copy objects from the source repository into a pack
 in the cloned repository, removing the disk space savings of `clone -s`.
-It is safe, however, to run `git gc`, which uses the `-l` option by
+It is safe, however, to run `git gc`, which uses the `--local` option by
 default.
 +
 If you want to break the dependency of a repository cloned with `-s` on
@@ -116,19 +116,19 @@ objects from the source repository into a pack in the cloned repository.
 	same repository, and this option can be used to stop the
 	borrowing.
 
---quiet::
 -q::
+--quiet::
 	Operate quietly.  Progress is not reported to the standard
 	error stream.
 
---verbose::
 -v::
+--verbose::
 	Run verbosely. Does not affect the reporting of progress status
 	to the standard error stream.
 
 --progress::
 	Progress status is reported on the standard error stream
-	by default when it is attached to a terminal, unless -q
+	by default when it is attached to a terminal, unless `--quiet`
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
@@ -140,15 +140,15 @@ objects from the source repository into a pack in the cloned repository.
 	When multiple `--server-option=<option>` are given, they are all
 	sent to the other side in the order listed on the command line.
 
---no-checkout::
 -n::
+--no-checkout::
 	No checkout of HEAD is performed after the clone is complete.
 
 --bare::
 	Make a 'bare' Git repository.  That is, instead of
 	creating `<directory>` and placing the administrative
 	files in `<directory>/.git`, make the `<directory>`
-	itself the `$GIT_DIR`. This obviously implies the `-n`
+	itself the `$GIT_DIR`. This obviously implies `--no-checkout`
 	because there is nowhere to check out the working tree.
 	Also the branch heads at the remote are copied directly
 	to corresponding local branch heads, without mapping
@@ -164,13 +164,13 @@ objects from the source repository into a pack in the cloned repository.
 	that all these refs are overwritten by a `git remote update` in the
 	target repository.
 
---origin <name>::
 -o <name>::
+--origin <name>::
 	Instead of using the remote name `origin` to keep track
 	of the upstream repository, use `<name>`.
 
---branch <name>::
 -b <name>::
+--branch <name>::
 	Instead of pointing the newly created HEAD to the branch pointed
 	to by the cloned repository's HEAD, point to `<name>` branch
 	instead. In a non-bare repository, this is the branch that will
@@ -178,8 +178,8 @@ objects from the source repository into a pack in the cloned repository.
 	`--branch` can also take tags and detaches the HEAD at that commit
 	in the resulting repository.
 
---upload-pack <upload-pack>::
 -u <upload-pack>::
+--upload-pack <upload-pack>::
 	When given, and the repository to clone from is accessed
 	via ssh, this specifies a non-default path for the command
 	run on the other end.
@@ -188,8 +188,8 @@ objects from the source repository into a pack in the cloned repository.
 	Specify the directory from which templates will be used;
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
 
---config <key>=<value>::
 -c <key>=<value>::
+--config <key>=<value>::
 	Set a configuration variable in the newly-created repository;
 	this takes effect immediately after the repository is
 	initialized, but before the remote history is fetched or any
@@ -274,8 +274,8 @@ or `--mirror` is given)
 	The result is Git repository can be separated from working
 	tree.
 
--j <n>::
 --jobs <n>::
+-j <n>::
 	The number of submodules fetched at the same time.
 	Defaults to the `submodule.fetchJobs` option.
 
-- 
gitgitgadget
