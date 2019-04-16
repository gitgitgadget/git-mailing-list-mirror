Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4080920248
	for <e@80x24.org>; Tue, 16 Apr 2019 20:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfDPU0S (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 16:26:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34243 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPU0S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 16:26:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id a6so7798530edv.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 13:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4ylhEd4I8RmFtGgfIaGhygVkU65gfYlC1HsSy1HR97I=;
        b=YURUNgf9Eu3qEWVU4KZ7ghS1eoZ2rjiP+qsmoL7Avhefd5sAuFHltEydGw+ae6uOCv
         S6pVwvoHHvLTA5Fm2+J1epwWcJwOexVZP/w00lsTeB3QLMASrZh7GE1K3/IpFoCh5VdB
         poGr6mrVVOBD1q8YmmNFoveVwDWyhF6wvYtBIu9UPgMK26FTjwSgbbwCiikCVpiwa2fk
         dIDA3XxLtKaxNVtbHPkMQCcmFAlHOv+mQyzSNcGIlaw81JGbwwFQb5nCtQxLP3V9TFSE
         ybqfHUp2722Ot145kDHGRAxbebQizyJO6n0yVmpBFf8AWbhQcDfiOwgp0UKpsZYt+fAf
         FBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4ylhEd4I8RmFtGgfIaGhygVkU65gfYlC1HsSy1HR97I=;
        b=n53m/CeKtn3sno+nWslgrCE7OGkC84k0QbLIOu7bBY0asLKZqHnlPRZRMPgdgjHsQX
         o+n72Jq4tfEkjW4HHMJh0JHaEANIukqgpxNEnIZf1/vQl9P3SRuBKfj+O20GgoIRV4GY
         lBzxthCaOWa51HOzug2tKKS4fPOXl51InXR2R+LacrKNIEqxYnxK+6CLOtU/aAuX3e0r
         q3z0ZfPKXnQMISs/hnEQ63mwgCTSfM1EvLjTrzlI2V6gXU6XCqKzC8pK1B2Lc7S7LjQv
         hq12VBdLyQ6LlqVvzOf+Ee5l6Znb2ui4ypg19DQXSyaMpYHKKT+iCOe+3RY1/qTmlHp9
         6hzA==
X-Gm-Message-State: APjAAAUyfsE2BnxiyQ0F021zK39tKl31OBRs/YxZ8TKxLO+c6nNUiED9
        yOyCB1aasuWcnrQsC4Q05/ebwWQn
X-Google-Smtp-Source: APXvYqzUnYc4i2YgHWCn5mWsA30k78mXCgAxWt2Z2riEiuM9+u3JcjZqPzZIDmaoAmrt2Qt1o3mTOQ==
X-Received: by 2002:a17:906:a889:: with SMTP id ha9mr44226422ejb.171.1555446374117;
        Tue, 16 Apr 2019 13:26:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2sm3872696eds.15.2019.04.16.13.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 13:26:13 -0700 (PDT)
Date:   Tue, 16 Apr 2019 13:26:13 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Apr 2019 20:26:11 GMT
Message-Id: <pull.177.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.177.git.gitgitgadget@gmail.com>
References: <pull.177.git.gitgitgadget@gmail.com>
From:   "Emily Shaffer via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] documentation: add lab for first contribution
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

RFC. I am still working on adding a section on handling refs and objects.

A tutorial for beginners explaining how to commit to git/git from clone to
push. This tutorial attempts to explain the GitGitGadget workflow; with the
review I'm hoping to understand whether it's worth the effort to detail how
to use git send-email as well. The linked implementation is present in my
personal fork and I'd be happy for any comments people wish to give against
that implementation, too, although it obviously isn't destined for git/git.
I wrote this guide in order to learn the process myself, so I welcome all
feedback.

Additionally, if there are skills around working with the codebase that
should really be included in the "Implementation" section I'd be happy to
add them.

Emily Shaffer (1):
  documentation: add lab for first contribution

 Documentation/.gitignore          |   1 +
 Documentation/Makefile            |   5 +
 Documentation/MyFirstContribution | 887 ++++++++++++++++++++++++++++++
 3 files changed, 893 insertions(+)
 create mode 100644 Documentation/MyFirstContribution


base-commit: e35b8cb8e212e3557efc565157ceb5cbaaf0d87f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-177%2Fnasamuffin%2Fmyfirstcontrib-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-177/nasamuffin/myfirstcontrib-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/177

Range-diff vs v1:

 1:  8b71fe7871 ! 1:  71d5ab539c documentation: add lab for first contribution
     @@ -10,27 +10,67 @@
      
          Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
      
     + diff --git a/Documentation/.gitignore b/Documentation/.gitignore
     + --- a/Documentation/.gitignore
     + +++ b/Documentation/.gitignore
     +@@
     + mergetools-*.txt
     + manpage-base-url.xsl
     + SubmittingPatches.txt
     ++MyFirstContribution.txt
     + tmp-doc-diff/
     +
     + diff --git a/Documentation/Makefile b/Documentation/Makefile
     + --- a/Documentation/Makefile
     + +++ b/Documentation/Makefile
     +@@
     + SP_ARTICLES += $(API_DOCS)
     + 
     + TECH_DOCS += SubmittingPatches
     ++TECH_DOCS += MyFirstContribution
     + TECH_DOCS += technical/hash-function-transition
     + TECH_DOCS += technical/http-protocol
     + TECH_DOCS += technical/index-format
     +@@
     + 	$(RM) howto-index.txt howto/*.html doc.dep
     + 	$(RM) technical/*.html technical/api-index.txt
     + 	$(RM) SubmittingPatches.txt
     ++	$(RM) MyFirstContribution.txt
     + 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
     + 	$(RM) manpage-base-url.xsl
     + 
     +@@
     + SubmittingPatches.txt: SubmittingPatches
     + 	$(QUIET_GEN) cp $< $@
     + 
     ++MyFirstContribution.txt: MyFirstContribution
     ++	$(QUIET_GEN) cp $< $@
     ++
     + XSLT = docbook.xsl
     + XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
     + 
     +
       diff --git a/Documentation/MyFirstContribution b/Documentation/MyFirstContribution
       new file mode 100644
       --- /dev/null
       +++ b/Documentation/MyFirstContribution
      @@
     -+My First Contribution
     -+=====================
     ++My First Contribution to the Git Project
     ++========================================
      +
      +== Summary
      +
     -+This is a codelab demonstrating the end-to-end workflow of creating a change to
     ++This is a tutorial demonstrating the end-to-end workflow of creating a change to
      +the Git tree, sending it for review, and making changes based on comments.
      +
      +=== Prerequisites
      +
     -+This codelab assumes you're already fairly familiar with using Git to manage
     ++This tutorial assumes you're already fairly familiar with using Git to manage
      +source code.  The Git workflow steps will largely remain unexplained.
      +
      +=== Related Reading
      +
     -+This codelab aims to summarize the following documents, but the reader may find
     ++This tutorial aims to summarize the following documents, but the reader may find
      +useful additional context:
      +
      +- Documentation/SubmittingPatches
     @@ -49,7 +89,7 @@
      +
      +=== Identify Problem to Solve
      +
     -+In this codelab, we will add a new command, `git psuh`, short for "Pony Saying
     ++In this tutorial, we will add a new command, `git psuh`, short for "Pony Saying
      +`Um, Hello'" - a feature which has gone unimplemented despite a high frequency
      +of invocation during users' typical daily workflow.
      +
     @@ -63,12 +103,12 @@
      +it's fine to base your work on `master`. However, in the future for bugfixes,
      +etc., you should check that doc and base it on the appropriate branch.
      +
     -+For the purposes of this doc, we will base all our work on `master`. Before
     -+running the command below, ensure that you are on `master` first so your
     -+branch diverges at the right point.
     ++For the purposes of this doc, we will base all our work on the `master` branch
     ++of the upstream project. Create the `psuh` branch you will use for development
     ++like so:
      +
      +----
     -+git checkout -b psuh
     ++git checkout -b psuh origin/master
      +----
      +
      +We'll make a number of commits here in order to demonstrate how to send many
     @@ -77,17 +117,19 @@
      +== Code It Up!
      +
      +NOTE: A reference implementation can be found at
     -+https://github.com/nasamuffin/git/tree/codelab.
     ++https://github.com/nasamuffin/git/tree/psuh.
      +
      +=== Adding a new command
      +
      +Lots of the main useful commands are written as builtins, which means they are
     -+implemented in C and compiled into the main `git` executable.. So it is
     -+informative to implement `git psuh` as a builtin.
     ++implemented in C and compiled into the main `git` executable. Since they are so
     ++common, it is a useful exercise to implement `git psuh` as a builtin subcommand.
      +
     -+Create a new file in `builtin/` called `psuh.c`.
     -+
     -+The entry point of your new command needs to match a certain signature:
     ++Built-in subcommands are typically implemented in a function named "cmd_"
     ++followed by the name of the subcommand, in a source file named after the
     ++subcommand and contained within `builtin/`. So it makes sense to implement your
     ++command in `builtin/psuh.c`. Create that file, and within, write the entry point
     ++for your command in a function matching the style and signature:
      +
      +----
      +int cmd_psuh(int argc, const char **argv, const char *prefix)
     @@ -102,7 +144,7 @@
      +
      +Be sure to `#include "builtin.h"` in your `psuh.c`.
      +
     -+Go ahead and add some throwaway printf to that method. This is a decent
     ++Go ahead and add some throwaway printf to that function. This is a decent
      +starting point as we can now add build rules and register the command.
      +
      +NOTE: Your throwaway text, as well as much of the text you will be adding over
     @@ -111,16 +153,32 @@
      +the lab, we will mark strings for translation as necessary; you should also do
      +so when writing your user-facing commands in the future.
      +
     ++----
     ++int cmd_psuh(int argc, const char **argv, const char *prefix)
     ++{
     ++	printf(_("Pony saying hello goes here.\n"));
     ++	return 0;
     ++}
     ++----
     ++
      +Let's try to build it.  Open Makefile, find where `builtin/push.o` is added
     -+to BUILTIN_OBJS, and add `builtin/psuh.o` in the same way. Once you've done so,
     -+move to the root directory and build simply with `make -j$(nproc)`. Optionally, add
     -+the DEVELOPER=1 variable to turn on some additional warnings:
     ++to BUILTIN_OBJS, and add `builtin/psuh.o` in the same way next to it in
     ++alphabetical order.. Once you've done so, move to the top-level directory and
     ++build simply with `make`. Also add the DEVELOPER=1 variable to turn on
     ++some additional warnings:
      +
      +----
     -+echo DEVELOPER=1 > config.mak
     -+make -j$(nproc)
     ++echo DEVELOPER=1 >config.mak
     ++make
      +----
      +
     ++NOTE: When you are developing the Git project, it's preferred that you use the
     ++DEVELOPER flag; if there's some reason it doesn't work for you, you can turn it
     ++off, but it's a good idea to mention the problem to the mailing list.
     ++
     ++NOTE: The Git build is parallelizable. `-j#` is not included above but you can
     ++use it as you prefer, here and elsewhere.
     ++
      +Great, now your new command builds happily on its own. But nobody invokes it.
      +Let's change that.
      +
     @@ -128,7 +186,8 @@
      +a cmd_struct to the commands[] array. struct cmd_struct takes a string with the
      +command name, a function pointer to the command implementation, and a setup
      +option flag. For now, let's keep cheating off of push. Find the line where
     -+cmd_push is registered, copy it, and modify it for cmd_psuh. 
     ++cmd_push is registered, copy it, and modify it for cmd_psuh, placing the new
     ++line in alphabetical order.
      +
      +The options are documented in `builtin.h` under "Adding a new built-in." Since
      +we hope to print some data about the user's current workspace context later,
     @@ -165,10 +224,13 @@
      +or, a Pony Saying "Um, Hello" (PSUH).
      +
      +This commit message is intentionally formatted to 72 columns per line,
     -+starts with a single line as "commit message subject" that uses the
     -+imperative present tense, and is designed to add information about the
     ++starts with a single line as "commit message subject" that is written as
     ++if to command the codebase to do something (add this, teach a command
     ++that). The body of the message is designed to add information about the
      +commit that is not readily deduced from reading the associated diff,
      +such as answering the question "why?".
     ++
     ++Signed-off-by: A U Thor <author@example.com>
      +----
      +
      +Go ahead and inspect your new commit with `git show`. "psuh:" indicates you
     @@ -226,7 +288,7 @@
      +git_config(...) will grab the configuration from config files known to Git and
      +apply standard precedence rules. git_config_get_string_const(...) will look up
      +a specific key ("user.name") and give you the value. There are a number of
     -+single-key lookup methods like this one; you can see them all (and more info
     ++single-key lookup functions like this one; you can see them all (and more info
      +about how to use git_config()) in `Documentation/technical/api-config.txt`.
      +
      +You should see that the name printed matches the one you see when you run:
     @@ -284,7 +346,55 @@
      +git commit -sm "psuh: print the current branch"
      +----
      +
     -+TODO: ref & object read
     ++Now let's see if we can get some info about a specific commit.
     ++
     ++Luckily, there are some helpers for us here. `commit.h` has a function called
     ++`lookup_commit_reference_by_name` to which we can simply provide a hardcoded
     ++string; `pretty.h` has an extremely handy `pp_commit_easy()` call which doesn't
     ++require a full format object to be passed.
     ++
     ++Add the following:
     ++
     ++----
     ++#include "commit.h"
     ++#include "pretty.h"
     ++
     ++...
     ++
     ++struct commit *c = NULL;
     ++struct strbuf commitline;
     ++strbuf_init(&commitline, 0);
     ++
     ++...
     ++
     ++c = lookup_commit_reference_by_name("origin/master");
     ++
     ++if (c != NULL)
     ++{
     ++	pp_commit_easy(CMIT_FMT_ONELINE, c, &commitline);
     ++	printf(_("Current commit: %s\n"), commitline.buf);
     ++}
     ++----
     ++
     ++The `struct strbuf` provides some safety belts to your basic `char*`, one of
     ++which is a length member to prevent buffer overruns. It needs to be initialized
     ++nicely with `strbuf_init`. Keep it in mind when you need to pass around `char*`.
     ++
     ++`lookup_commit_reference_by_name` resolves the name you pass it, so you can play
     ++with the value there and see what kind of things you can come up with.
     ++
     ++`pp_commit_easy` is a convenience wrapper in `pretty.h` that takes a single
     ++format enum shorthand, rather than an entire format struct. It then prints the
     ++commit according to that shorthand. These are similar to the formats available
     ++with `--pretty=FOO` in many Git commands.
     ++
     ++Build it and run, and if you're using the same name in the example, you should
     ++see the subject line of the most recent commit in `origin/master` that you know
     ++about. Neat! Let's commit that as well.
     ++
     ++----
     ++git commit -sm "psuh: display the top of origin/master"
     ++----
      +
      +=== Adding documentation
      +
     @@ -314,7 +424,7 @@
      +
      +NAME
      +----
     -+git-psuh - Chastise users' typo with a shy horse
     ++git-psuh - Delight users' typo with a shy horse
      +
      +
      +SYNOPSIS
     @@ -364,6 +474,10 @@
      +While this isn't as satisfying as running through `git help`, you can at least
      +check that your help page looks right.
      +
     ++You can also check that the documentation coverage is good (that is, the project
     ++sees that your command has been implemented as well as documented) by running
     ++`make check-docs` from the top-level.
     ++
      +Go ahead and commit your new documentation change.
      +
      +=== Adding usage text
     @@ -424,7 +538,8 @@
      +== Testing
      +
      +It's important to test your code - even for a little toy command like this one.
     -+So let's add some tests.
     ++Moreover, your patch won't be accepted into the Git tree without tests to
     ++demonstrate that it does what it's supposed to do. So let's add some tests.
      +
      +Related reading: `t/README`
      +
     @@ -580,11 +695,11 @@
      +
      +Now you should be able to go and check out your newly created branch on GitHub.
      +
     -+////
     -+TODO: The next few bullets describe testing and pushing your change with
     -+GitGitGadget. It may be useful to describe a workflow using git send-email as
     -+well.
     -+////
     ++== Sending Patches via GitGitGadget
     ++
     ++One option for sending patches is to follow a typical pull request workflow and
     ++send your patches out via GitGitGadget. This section outlines the steps for this
     ++workflow; if you'd rather use `git send-email` skip ahead.
      +
      +=== Sending a PR to GitGitGadget
      +
     @@ -625,7 +740,7 @@
      +TODO https://github.com/gitgitgadget/gitgitgadget/issues/83
      +It'd be nice to be able to verify that the patch looks good before sending it
      +to everyone on Git mailing list.
     -+=== Check Your Work 
     ++=== Check Your Work
      +////
      +
      +=== Sending Your Patches
     @@ -644,24 +759,162 @@
      +https://www.oreilly.com/library/view/git-pocket-guide/9781449327507/ch10.html
      +[overview] from O'Reilly.
      +
     ++== Sending Patches with `git send-email`
     ++
     ++There are a couple reasons you may not want to use GitGitGadget, such as needing
     ++to send an RFC patch, wanting to check your work before mailing, or not having a
     ++GitHub account. Luckily, you can use Git to mail your patches instead!
     ++
      +////
     -+This is the path for git send-email. Do we want to cover that approach as well?
     ++It seems like a lot of work to set up Travis to point to your own fork, and it
     ++obviates the big reason not to use GGG - not having a GitHub account. For now,
     ++we'll skip covering Travis with personal fork.
      +=== Running with Travis On Your Fork
     ++////
     ++
     ++=== Prerequisite: Setting Up `git send-email`
      +
     -+== Sending For Review
     ++Configuration for `send-email` can vary based on your operating system and email
     ++provider, and so will not be covered in this lab, beyond stating that in many
     ++distributions of Linux, `git-send-email` is not packaged alongside the typical
     ++`git` install. You may need to install this additional package; there are a
     ++number of resources online to help you do so.
      +
      +=== Preparing initial patchset
      +
     ++Sending emails with Git is a two-part process; before you can prepare the emails
     ++themselves, you'll need to prepare the patches. Luckily, this is pretty simple:
     ++
     ++----
     ++git format-patch -o psuh/ master..psuh
     ++----
     ++
     ++The `-o psuh/` parameter tells `format-patch` to place the patch files into a
     ++directory. This is useful because `git send-email` can take a directory and
     ++send out all the patches from there.
     ++
     ++`master..psuh` tells `format-patch` to generate patches for the difference
     ++between `master` and `psuh`. It will make one patch file per commit. After you
     ++run, you can go have a look at each of the patches with your favorite text
     ++editor and make sure everything looks alright; however, it's not recommended to
     ++make code fixups via the patch file. It's a better idea to make the change the
     ++normal way using `git rebase -i` or by adding a new commit than by modifying a
     ++patch.
     ++
     ++Check and make sure that your patches exist in the directory you specified -
     ++you're nearly ready to send out your review!
     ++
      +=== Preparing email
      +
     ++In addition to an email per patch, the Git community also expects your patches
     ++to come with a cover letter, typically with a subject line [PATCH 0/x] (where
     ++x is the number of patches you're sending).  You'll need to add some extra
     ++parameters when you invoke `git send-email` to add the cover letter.
     ++
     ++----
     ++git send-email \
     ++	--to=target@server.tld \
     ++	--from=me@server.tld \
     ++	--subject="[PATCH 0/7] adding the 'psuh' command" \
     ++	--compose \
     ++	psuh/
     ++----
     ++
     ++The `--to` and `--from` fields are pretty obvious. `--subject` should indicate
     ++that it's a cover letter with the [PATCH 0/x] tag (check how many patches you
     ++are about to send so you can indicate the size of the thread correctly).
     ++`--compose` indicates that you want to open an editor to write the cover letter
     ++before sending the rest of the mails. Finally, `psuh/` attaches your directory
     ++full of commit patches, prompting `send-email` to send one email per patch.
     ++
     ++When you run this, you'll get an editor so you have a chance to fill out your
     ++cover letter. This is an important component of change submission as it explains
     ++to the community from a high level what you're trying to do, and why, in a way
     ++that's more apparent than just looking at your diff. Be sure to explain anything
     ++your diff doesn't make clear on its own.
     ++
     ++It's also good practice to include a diffstat, which you can generate like so:
     ++
     ++----
     ++git diff --stat=72 master..psuh
     ++----
     ++
     ++The argument to `--stat` bounds the column width of the output, which is handy
     ++as emails to Git shouldn't exceed 72 columns of width.
     ++
     ++Here's an example of a cover letter for `git psuh`:
     ++
     ++----
     ++Our internal metrics indicate widespread interest in the command
     ++git-psuh - that is, many users are trying to use it, but finding it is
     ++unavailable, using some unknown workaround instead.
     ++
     ++The following handful of patches add the psuh command and implement some
     ++handy features on top of it.
     ++
     ++This patchset is part of the MyFirstContribution codelab and should not
     ++be merged.
     ++
     ++ Documentation/git-psuh.txt | 40 +++++++++++++++++++
     ++ Makefile                   |  1 +
     ++ builtin.h                  |  1 +
     ++ builtin/psuh.c             | 78 ++++++++++++++++++++++++++++++++++++++
     ++ git.c                      |  1 +
     ++ t/t9999-psuh-codelab.sh    | 12 ++++++
     ++ 6 files changed, 133 insertions(+)
     ++----
     ++
     ++NOTE: When you've got a real change to send, you'll use `git@vger.kernel.org`
     ++in the `--to` field. For now, though, don't spam the list with the codelab -
     ++send it to yourself and check if it looks right.
     ++
      +=== Sending email
      +
     ++After you finish running the command above and editing your cover letter, you
     ++will be presented with an interactive prompt for each patch that's about to go
     ++out. This gives you one last chance to edit or quit sending something (but
     ++again, don't edit code this way). Once you press `y` or `a` at these prompts
     ++your emails will go out!
     ++
     ++Awesome, now the community will drop everything and review your changes. (Just
     ++kidding - be patient!)
     ++
      +=== Applying Changes
      +
     -+=== Sending v2
     ++Once you do have some review comments, you should make changes if necessary, or
     ++push back on the changes by replying to the emails. (Make sure your mail client
     ++has a plaintext email mode; the Git list rejects HTML email.) Please also follow
     ++the mailing list etiquette outlined in the 
     ++https://kernel.googlesource.com/pub/scm/git/git/+/todo/MaintNotes[Maintainer's
     ++Note], which are similar to etiquette rules in most open source communities
     ++surrounding bottom-posting and inline replies.
      +
     -+End of path for git send-email
      +////
     ++TODO - mail list etiquette
     ++////
     ++
     ++You should apply changes using interactive rebase, or by adding new commits if
     ++the changes seem to require it.
     ++
     ++NOTE: Interactive rebase can be tricky; check out this handy
     ++https://www.oreilly.com/library/view/git-pocket-guide/9781449327507/ch10.html
     ++[overview] from O'Reilly.
     ++
     ++=== Sending v2
     ++
     ++When you're ready with the next iteration of your patch, the process is pretty
     ++much the same, with a few differences:
     ++
     ++* When you run `format-patch`, include the argument `-v2` to add a "v2" tag to
     ++the subject lins given.
     ++* When you run `send-email`, include the argument `--in-reply-to=<message-id>`
     ++with the Message-Id of the cover letter of the previous version. (You can find
     ++that Message-Id on https://public-inbox.org/git/.) Also, change the subject line
     ++on your cover letter to include "v2" to match the subjects of your patches.
     ++
     ++When it's time for v3 or beyond, simply change the number above, but make sure
     ++your v2 cover letter is in reply to your v1 cover letter, and your v3 cover
     ++letter is in reply to your v2 cover letter, and so on.
      +
      +== Now What?
      +
     @@ -680,12 +933,12 @@
      +will pull your patchset into `next` and life is good.
      +
      +However, if it isn't so perfect, once it is in `next`, you can no longer modify
     -+your commits in GitGitGadget. Consider that PR "closed" - you will need to
     -+repeat the entire process for any bug fix commits you need to send, basing your
     -+changes on the maintainer's topic branch for your work instead of `master`.
     -+These topic branches are typically detailed in https://github.com/gitster/git
     -+and are mirrored by GitGitGadget. Since they're mirrored, you can still  use
     -+GitGitGadget to send email patches, as long as you've based your PR against the
     -+appropriate GitGitGadget/Git branch.
     -+
     -+(TODO - does that mean that GGG will Just Work for those branches?)
     ++your commits in GitGitGadget or the email thread. Consider that review "closed" 
     ++- you will need to repeat the entire process for any bug fix commits you need
     ++to send, basing your changes on the maintainer's topic branch for your work
     ++instead of `master`. These topic branches are typically detailed in
     ++https://github.com/gitster/git and are mirrored by GitGitGadget. Since they're
     ++mirrored, you can still  use GitGitGadget to send email patches, as long as
     ++you've based your PR against the appropriate GitGitGadget/Git branch. Or, you
     ++can use `git send-email` just the same as before, except you will generate diffs
     ++from `<topic>..<mybranch>` and base your work on `<topic>` instead of `master`.

-- 
gitgitgadget
