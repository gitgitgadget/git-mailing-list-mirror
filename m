Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3FC01F461
	for <e@80x24.org>; Tue,  2 Jul 2019 14:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfGBOho (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 10:37:44 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:35150 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBOhn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 10:37:43 -0400
Received: by mail-ed1-f49.google.com with SMTP id w20so27543239edd.2
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 07:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E9TEE/loUb4wUtr+pcp/3dczXcJEgvMEGYVRVCwsPkE=;
        b=eanT8qxzw+Fya6ZdQc9wk1AOMfglH5klwXAbrWhTBA78IZ0fuyFrOW3B1xWNWnqsW2
         KDqTa41VpwGsIpMxqF7sM/9tRqfQimKeiJo6rif6caJPvxrIz1C1B0vtui/fdQTV9PW9
         8jbx3tZZnN73PR5ng4MH+SFMIq+lmDn7bRs4CwUDwl75OYU/4XLIu9faiVY/LI7NbbpX
         m1eiCesAXO3cnRLdD4eyTbZOtcG+Wgaa2TLM+iWR/CBFzyMI/1cOcDMIqtfpKW0ESiM2
         SbFM3no0ZVaqs8Vhb4cRiGWb3YCnbpRfTeD9XztfYcxngPhGGh3YEiSDhhHF8HJ3Jy6V
         v6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E9TEE/loUb4wUtr+pcp/3dczXcJEgvMEGYVRVCwsPkE=;
        b=rlclLybLmvykX3DPkOfTqSqJ4eR6yDPWuxDHR5alAAf6GTnNV+PgrxxicJJlANBygR
         05EPtRYdtccXBt+4WBejTwfot+l1HktxpIJCJTxK2aIXumapONIW2WQxmL+hqQWvzeWP
         vVVgjPCrOkn4+i4nM6P/PMBTq7heWvyB4/KZ0FSeEdqsqUyKG2xwHvCezRv45x5Se3VV
         i+H8tSICrkwWE3MWSXAv27sFsisnvNEwmdASoOwGyoccT78sAMyyLx4sYlAW6ZC0UCsA
         b1AWHZydynIc12ZgA9ExZO7Gf+1eZpCmXsvPq39ffivLhE7xRSUdSCl97NxElKPkOGca
         +dVQ==
X-Gm-Message-State: APjAAAVR1fhru7qbIsDur2q+O2sNsAnfI9QAZoPjk0AWPiEgYI14B3ny
        i5gi6hy8smyOpv7txiQCZVKQlyRz
X-Google-Smtp-Source: APXvYqx/72XEXbc5HvjFCivphrsYwzc7ZPu/pq96dbzl7Xu0bCzlRl/8XHkZe8BiJ7cb8gFwKkbtVQ==
X-Received: by 2002:aa7:d297:: with SMTP id w23mr35605966edq.128.1562078261735;
        Tue, 02 Jul 2019 07:37:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 9sm2808152ejg.49.2019.07.02.07.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 07:37:41 -0700 (PDT)
Date:   Tue, 02 Jul 2019 07:37:41 -0700 (PDT)
X-Google-Original-Date: Tue, 02 Jul 2019 14:37:39 GMT
Message-Id: <c562cf681f5c1c47cd77eead30ec9ae1eb7ca9e0.1562078259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.277.v2.git.gitgitgadget@gmail.com>
References: <pull.277.git.gitgitgadget@gmail.com>
        <pull.277.v2.git.gitgitgadget@gmail.com>
From:   "Quentin Nerden via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/2] docs: git-clone: list short form of options first
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Quentin Nerden <quentin.nerden@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Quentin Nerden <quentin.nerden@intel.com>

List the short form of options (e.g.: '-l') before the long form (e.g.
'--local').
This is to match the doc of git-add, git-commit, git-clean, git-branch...

Signed-off-by: Quentin Nerden <quentin.nerden@gmail.com>
---
 Documentation/git-clone.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index cb3cf7a0fb..34011c2940 100644
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
@@ -116,13 +116,13 @@ objects from the source repository into a pack in the cloned repository.
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
 
@@ -140,8 +140,8 @@ objects from the source repository into a pack in the cloned repository.
 	When multiple `--server-option=<option>` are given, they are all
 	sent to the other side in the order listed on the command line.
 
---no-checkout::
 -n::
+--no-checkout::
 	No checkout of HEAD is performed after the clone is complete.
 
 --bare::
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
-- 
gitgitgadget
