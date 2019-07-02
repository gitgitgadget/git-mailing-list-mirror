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
	by dcvr.yhbt.net (Postfix) with ESMTP id 22B731F461
	for <e@80x24.org>; Tue,  2 Jul 2019 14:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfGBOhn (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 10:37:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45523 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfGBOhn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 10:37:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id a14so27504861edv.12
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=imkaCsd+yNx1b3RiTftq8426o77yODewxlEKAq67y2E=;
        b=doGskoAbrq3AVaz7zcmaHNtrwfhF4p+kM2BxKo9f185I+CoJz9lzE4/3fP/6eYLNAu
         p+fiEBMuL0zy6yvIWBdCabIhkEVrbQAyrheYXAR+BYZMcVkxWDYG+hfS6Cs7wjVoC3E/
         ECTKI3DBQ5kog128PksQ9AbZSbZUzBhScKarDiggw18TJ5QMABBwbiJK98TjAg0Jz/N2
         RD2z4joJd2CooRaNT8spp6yqfMFrLtNCwpbK6JL4AbY5qjgr9NyWAeJfrFYSgVxhNJgi
         6s3NrkT1ruk/SVtyaYoinxvXo07Uciw84DNe9VptlIAaCWItIHnjJA46ZOK0slhAvftg
         lEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=imkaCsd+yNx1b3RiTftq8426o77yODewxlEKAq67y2E=;
        b=qhfmYbX9pK77i2l1sAkS8RiZSHgx8crxl8INbtj0vYTP0VVLgN+RokdtTZuDkudkou
         uFB1hBjMveZYRhrsnnuuTjmmXN8UzozOKZZH1GDE8F3IkdcXsHt8O1vluTHT6SMix8n9
         MAJFkx88Y5Ftb/XX9Thid2BUT4DUjogIgoeqd914gCOlp9/qZIlsL//46pJ7sveio8b7
         JTN8MwsdEzO8BzHzLHBYx8OCUr3cWPOXNUZzCwdp8tBjLPkUZfJtCuCTmJ/zvz1016hz
         D6nGU4K97XebFrEMO6D34wH6FUf8oVHCIx7QBj7oaNj6kVVR2mFY4bgWCI0Onp9H5S6z
         9duQ==
X-Gm-Message-State: APjAAAUKP/Fgi/VuzgptRpZ7XLHsJvWLhbPOWg/nWsWgpmHMaj3++Yi2
        +HLpRbNV0VM9Lj8eQFOFZpE+Iz9e
X-Google-Smtp-Source: APXvYqxeyvZMw0NxSNrSm6FbsACEGLA2IdbDewZyWxMGeR2gBh9EKSMHSoq9V1Hz2tZEjLvLBf/qbg==
X-Received: by 2002:a17:906:f0cd:: with SMTP id dk13mr28957074ejb.84.1562078260371;
        Tue, 02 Jul 2019 07:37:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13sm4448544eds.35.2019.07.02.07.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 07:37:39 -0700 (PDT)
Date:   Tue, 02 Jul 2019 07:37:39 -0700 (PDT)
X-Google-Original-Date: Tue, 02 Jul 2019 14:37:37 GMT
Message-Id: <pull.277.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.277.git.gitgitgadget@gmail.com>
References: <pull.277.git.gitgitgadget@gmail.com>
From:   "Quentin Nerden via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/2] Update git-clone doc: refer to long form of the options and list short form
 of the options first
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make doc of git-clone easier to read, refer to the long version of the
options (it is easier to guess what --verbose is doing than -v).

Also: put the short options first, to match the doc of git-add, git-commit,
git-clean, git-branch...

Quentin Nerden (2):
  docs: git-clone: refer to long form of options
  docs: git-clone: list short form of options first

 Documentation/git-clone.txt | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)


base-commit: 8dca754b1e874719a732bc9ab7b0e14b21b1bc10
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-277%2Fkenden%2Fpatch-1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-277/kenden/patch-1-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/277

Range-diff vs v1:

 -:  ---------- > 1:  d2f5540ea1 docs: git-clone: refer to long form of options
 1:  0dd1b01769 ! 2:  c562cf681f docs: update git-clone doc: refer to long options
     @@ -1,13 +1,10 @@
     -Author: Quentin Nerden <quentin.nerden@gmail.com>
     +Author: Quentin Nerden <quentin.nerden@intel.com>
      
     -    docs: update git-clone doc: refer to long options
     +    docs: git-clone: list short form of options first
      
     -    To make the doc of git-clone easier to read,
     -    refer to the long version of the options
     -    (it is easier to guess what --verbose is doing than -v).
     -
     -    Also:
     -    put the short options first, to match the doc of git-add, git-commit, git-clean, git-branch...
     +    List the short form of options (e.g.: '-l') before the long form (e.g.
     +    '--local').
     +    This is to match the doc of git-add, git-commit, git-clean, git-branch...
      
          Signed-off-by: Quentin Nerden <quentin.nerden@gmail.com>
      
     @@ -34,19 +31,6 @@
       	When the repository to clone is on the local machine,
       	instead of using hard links, automatically setup
       	`.git/objects/info/alternates` to share the objects
     -@@
     - If these objects are removed and were referenced by the cloned repository,
     - then the cloned repository will become corrupt.
     - +
     --Note that running `git repack` without the `-l` option in a repository
     -+Note that running `git repack` without the `--local` option in a repository
     - cloned with `-s` will copy objects from the source repository into a pack
     - in the cloned repository, removing the disk space savings of `clone -s`.
     --It is safe, however, to run `git gc`, which uses the `-l` option by
     -+It is safe, however, to run `git gc`, which uses the `--local` option by
     - default.
     - +
     - If you want to break the dependency of a repository cloned with `-s` on
      @@
       	same repository, and this option can be used to stop the
       	borrowing.
     @@ -63,13 +47,6 @@
       	Run verbosely. Does not affect the reporting of progress status
       	to the standard error stream.
       
     - --progress::
     - 	Progress status is reported on the standard error stream
     --	by default when it is attached to a terminal, unless -q
     -+	by default when it is attached to a terminal, unless `--quiet`
     - 	is specified. This flag forces progress status even if the
     - 	standard error stream is not directed to a terminal.
     - 
      @@
       	When multiple `--server-option=<option>` are given, they are all
       	sent to the other side in the order listed on the command line.
     @@ -80,14 +57,6 @@
       	No checkout of HEAD is performed after the clone is complete.
       
       --bare::
     - 	Make a 'bare' Git repository.  That is, instead of
     - 	creating `<directory>` and placing the administrative
     - 	files in `<directory>/.git`, make the `<directory>`
     --	itself the `$GIT_DIR`. This obviously implies the `-n`
     -+	itself the `$GIT_DIR`. This obviously implies `--no-checkout`
     - 	because there is nowhere to check out the working tree.
     - 	Also the branch heads at the remote are copied directly
     - 	to corresponding local branch heads, without mapping
      @@
       	that all these refs are overwritten by a `git remote update` in the
       	target repository.
     @@ -124,13 +93,3 @@
       	Set a configuration variable in the newly-created repository;
       	this takes effect immediately after the repository is
       	initialized, but before the remote history is fetched or any
     -@@
     - 	The result is Git repository can be separated from working
     - 	tree.
     - 
     ---j <n>::
     - --jobs <n>::
     -+-j <n>::
     - 	The number of submodules fetched at the same time.
     - 	Defaults to the `submodule.fetchJobs` option.
     - 

-- 
gitgitgadget
