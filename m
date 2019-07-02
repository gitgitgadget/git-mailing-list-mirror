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
	by dcvr.yhbt.net (Postfix) with ESMTP id 12EC31F461
	for <e@80x24.org>; Tue,  2 Jul 2019 14:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfGBOhn (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 10:37:43 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:44075 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGBOhm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 10:37:42 -0400
Received: by mail-ed1-f46.google.com with SMTP id k8so27461951edr.11
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FNyWgcvL2lci6hrSMCPIrVeMtbbKQFKAONIxmmN9PCU=;
        b=qnZsk2mdWuToGoVcBNo5CzDTUkp0uLaSbFh9uY7p4DM5IO1mk/pVUM32aLFZApFvnQ
         faI3MrDTsio4y01e0YbsfVzpx6ZAZxZumOFhePvicDOTLIGq5yK0O9nk1zI1EvOYh/5P
         rNGsEgPd4lbjN7dds0ljvM83gNhzMY7zxkheWKfHq3XZ9Fv0udoiI+oWzIl/ceOEbs2O
         J9kA91tcOwCju913pa2xKk+spKQ8YK/1NzZBogBpn08BJwNWvatjnXRw9euxoBPa1eZH
         k/Xcd8FLqbMja+aups2F+mDg9Y0s/G6gb/YZe5DYkVaBL/9L8SCstQ3S0zEa5P/1bB7S
         o94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FNyWgcvL2lci6hrSMCPIrVeMtbbKQFKAONIxmmN9PCU=;
        b=IhMjAPMsJNdKr0ub0GRrz19HKxy0KoVBn2vReCt5Zd/pAJhZTHosa3KXLVu8S8M7ZB
         o1iWOaAoS7R6QzSXU9CElqX0UgV+nXCzpinkSoVMwdlxL7sbi0bjXz7ikr8r6kUCd6UW
         ccEX5kLJqOBjF+ZPFOeDNyfPQ7QkbWWVQqs7roaXmr/aQ3FXeslYvQFebklK51+IsWs1
         RQVnTRBqX10aSeLS3cpSJgyKnu7MJpBpO5C30EzKRz0ZvHepbzUHWaVv9IKps5S5xBM1
         f5Y5ov+VXFxuLz4cyEhnoRJrs6488sJ5wH/ywT9cQkFVKtxkvnH+vqlldPV9KIQ2iTA8
         C8mg==
X-Gm-Message-State: APjAAAXA/DWrIE4HidS+5i/9koqIALeUMLsytQ28BeWqHi4d/H7EZLZP
        XUPMga838RYnfUMS97cdSibaC16R
X-Google-Smtp-Source: APXvYqytHFSzJFcB+/UTpgPT3XiUx5y6OFOvcipPu5yauied9fdFKEVtasEtUH3/zQTTOLrYltUhjA==
X-Received: by 2002:a05:6402:1707:: with SMTP id y7mr22060355edu.223.1562078261051;
        Tue, 02 Jul 2019 07:37:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1sm2762917ejo.9.2019.07.02.07.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 07:37:40 -0700 (PDT)
Date:   Tue, 02 Jul 2019 07:37:40 -0700 (PDT)
X-Google-Original-Date: Tue, 02 Jul 2019 14:37:38 GMT
Message-Id: <d2f5540ea1b994a574d6ce2c300018a32d7cca73.1562078259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.277.v2.git.gitgitgadget@gmail.com>
References: <pull.277.git.gitgitgadget@gmail.com>
        <pull.277.v2.git.gitgitgadget@gmail.com>
From:   "Quentin Nerden via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/2] docs: git-clone: refer to long form of options
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

To make the doc of git-clone easier to read,
refer to the long form of the options
(it is easier to guess what '--verbose' is doing than '-v').

Signed-off-by: Quentin Nerden <quentin.nerden@gmail.com>
---
 Documentation/git-clone.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 5fc97f14de..cb3cf7a0fb 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -23,7 +23,7 @@ DESCRIPTION
 
 Clones a repository into a newly created directory, creates
 remote-tracking branches for each branch in the cloned repository
-(visible using `git branch -r`), and creates and checks out an
+(visible using `git branch --remotes`), and creates and checks out an
 initial branch that is forked from the cloned repository's
 currently active branch.
 
@@ -81,13 +81,13 @@ which automatically call `git gc --auto`. (See linkgit:git-gc[1].)
 If these objects are removed and were referenced by the cloned repository,
 then the cloned repository will become corrupt.
 +
-Note that running `git repack` without the `-l` option in a repository
-cloned with `-s` will copy objects from the source repository into a pack
-in the cloned repository, removing the disk space savings of `clone -s`.
-It is safe, however, to run `git gc`, which uses the `-l` option by
+Note that running `git repack` without the `--local` option in a repository
+cloned with `--shared` will copy objects from the source repository into a pack
+in the cloned repository, removing the disk space savings of `clone --shared`.
+It is safe, however, to run `git gc`, which uses the `--local` option by
 default.
 +
-If you want to break the dependency of a repository cloned with `-s` on
+If you want to break the dependency of a repository cloned with `--shared` on
 its source repository, you can simply run `git repack -a` to copy all
 objects from the source repository into a pack in the cloned repository.
 
@@ -128,7 +128,7 @@ objects from the source repository into a pack in the cloned repository.
 
 --progress::
 	Progress status is reported on the standard error stream
-	by default when it is attached to a terminal, unless -q
+	by default when it is attached to a terminal, unless `--quiet`
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
@@ -148,7 +148,7 @@ objects from the source repository into a pack in the cloned repository.
 	Make a 'bare' Git repository.  That is, instead of
 	creating `<directory>` and placing the administrative
 	files in `<directory>/.git`, make the `<directory>`
-	itself the `$GIT_DIR`. This obviously implies the `-n`
+	itself the `$GIT_DIR`. This obviously implies the `--no-checkout`
 	because there is nowhere to check out the working tree.
 	Also the branch heads at the remote are copied directly
 	to corresponding local branch heads, without mapping
-- 
gitgitgadget

