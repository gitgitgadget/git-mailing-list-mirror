Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB990205DF
	for <e@80x24.org>; Tue, 16 Apr 2019 20:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfDPU0U (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 16:26:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44797 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbfDPU0T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 16:26:19 -0400
Received: by mail-ed1-f66.google.com with SMTP id i13so8354880edf.11
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uVC7Q6hmYqVMl/NRo/hzbaxBz4RXbBZ8e4GRuJIojKg=;
        b=f8UUamr04YsKCuMWTcQ+4sS7k01rSsTeePlLAY1sTSW2bDmlp35lDbtF1GZrmweQht
         ZhIgsAlQ0pJrfCl+SN+lAQbPucgotl2yXdusWQzQ6vxawR2QHGBHMfkMZ+mjXWEyHiMD
         SAM++dsX6UbLjNB5/5MvhkeDbsL5CvqkdYOrtUcRlg1d5tCcWvzExZypQtbfaUXMq3pc
         u0tuhylOweo/+UeureVFY3roUzoWcGRs2GmNJaSN/BUOCqffgSW0ZuHnu6jTkhM2NVxm
         nr66oJ9JizvxoqMa/1/HHloN7zpAUVpYoviXYNRbZ4XBCRz/c2APBiEzyNp3PYDRSwPk
         5AJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uVC7Q6hmYqVMl/NRo/hzbaxBz4RXbBZ8e4GRuJIojKg=;
        b=Owtf8U78zpcnChzEqgG4E5PIiBv+EzFl14qAVCqaOd3GOX90bY9S43bX4iU3vdxeNr
         zm03J24p3D98ifgwLe/hoDx8K5nf+ts0r7Bt3jv/p1oi9IcdUXVP2TDLYQyjQjrHENqD
         odsIRlNWaGsh+qwIeeHKNOGPIR9Bn4SVD1oZkL9plGNHc8fA8uBsLvSKCwkCN0FTFqse
         xFceocbuRpyrr/TE+7l0mjIre22B/e+RRZElNDFyh/cJ0xUpk5+Im4mJTrxgYSJ3bKid
         gpxDmoazJ6f9cPGVOPk9p/l/uuFfxacclV39CsqC1sAMuDul3vDknZH0nE8hyUnGhFTI
         50FA==
X-Gm-Message-State: APjAAAXcQ1ZZv1AQAuYa0d+vDkBoS3e0WZAWPY9EsJEPQIy6xpXqhWjQ
        VNx06mi9CboAGL1/KKcubBHMZbMF
X-Google-Smtp-Source: APXvYqxIutpPBtnKEcEsVqB17vpj2alMzetLkqsoFE2BFPFGYpvckwXD34e6sn/VZ1mrT985b3w/4w==
X-Received: by 2002:a17:906:c348:: with SMTP id ci8mr44905552ejb.74.1555446375116;
        Tue, 16 Apr 2019 13:26:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m20sm8944827ejz.72.2019.04.16.13.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 13:26:14 -0700 (PDT)
Date:   Tue, 16 Apr 2019 13:26:14 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Apr 2019 20:26:12 GMT
Message-Id: <71d5ab539c8b47155f6a3c92e26c9224d8214298.1555446372.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.177.v2.git.gitgitgadget@gmail.com>
References: <pull.177.git.gitgitgadget@gmail.com>
        <pull.177.v2.git.gitgitgadget@gmail.com>
From:   "Emily Shaffer via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] documentation: add lab for first contribution
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

This code lab covers how to add a new command to Git and, in the
process, everything from cloning git/git to getting reviewed on the mail
list. It's meant for new contributors to go through interactively,
learning the techniques generally used by the git/git development
community.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/.gitignore          |   1 +
 Documentation/Makefile            |   5 +
 Documentation/MyFirstContribution | 887 ++++++++++++++++++++++++++++++
 3 files changed, 893 insertions(+)
 create mode 100644 Documentation/MyFirstContribution

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index 3ef54e0adb..c3643661bf 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -12,4 +12,5 @@ cmds-*.txt
 mergetools-*.txt
 manpage-base-url.xsl
 SubmittingPatches.txt
+MyFirstContribution.txt
 tmp-doc-diff/
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 26a2342bea..af303c2419 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -74,6 +74,7 @@ API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technica
 SP_ARTICLES += $(API_DOCS)
 
 TECH_DOCS += SubmittingPatches
+TECH_DOCS += MyFirstContribution
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/index-format
@@ -338,6 +339,7 @@ clean:
 	$(RM) howto-index.txt howto/*.html doc.dep
 	$(RM) technical/*.html technical/api-index.txt
 	$(RM) SubmittingPatches.txt
+	$(RM) MyFirstContribution.txt
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
 	$(RM) manpage-base-url.xsl
 
@@ -379,6 +381,9 @@ $(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.tx
 SubmittingPatches.txt: SubmittingPatches
 	$(QUIET_GEN) cp $< $@
 
+MyFirstContribution.txt: MyFirstContribution
+	$(QUIET_GEN) cp $< $@
+
 XSLT = docbook.xsl
 XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
 
diff --git a/Documentation/MyFirstContribution b/Documentation/MyFirstContribution
new file mode 100644
index 0000000000..40d1a3b8d7
--- /dev/null
+++ b/Documentation/MyFirstContribution
@@ -0,0 +1,887 @@
+My First Contribution to the Git Project
+========================================
+
+== Summary
+
+This is a tutorial demonstrating the end-to-end workflow of creating a change to
+the Git tree, sending it for review, and making changes based on comments.
+
+=== Prerequisites
+
+This tutorial assumes you're already fairly familiar with using Git to manage
+source code.  The Git workflow steps will largely remain unexplained.
+
+=== Related Reading
+
+This tutorial aims to summarize the following documents, but the reader may find
+useful additional context:
+
+- Documentation/SubmittingPatches
+- Documentation/howto/new-command.txt
+
+== Getting Started
+
+=== Pull the Git codebase
+
+Git is mirrored in a number of locations. https://git-scm.com/downloads
+suggests the best place to clone from is GitHub.
+
+----
+git clone https://github.com/git/git git
+----
+
+=== Identify Problem to Solve
+
+In this tutorial, we will add a new command, `git psuh`, short for "Pony Saying
+`Um, Hello'" - a feature which has gone unimplemented despite a high frequency
+of invocation during users' typical daily workflow.
+
+(We've seen some other effort in this space with the implementation of popular
+commands such as `sl`.)
+
+=== Set Up Your Workspace
+
+Let's start by making a development branch to work on our changes. Per
+`Documentation/SubmittingPatches`, since a brand new command is a new feature,
+it's fine to base your work on `master`. However, in the future for bugfixes,
+etc., you should check that doc and base it on the appropriate branch.
+
+For the purposes of this doc, we will base all our work on the `master` branch
+of the upstream project. Create the `psuh` branch you will use for development
+like so:
+
+----
+git checkout -b psuh origin/master
+----
+
+We'll make a number of commits here in order to demonstrate how to send many
+patches up for review simultaneously.
+
+== Code It Up!
+
+NOTE: A reference implementation can be found at
+https://github.com/nasamuffin/git/tree/psuh.
+
+=== Adding a new command
+
+Lots of the main useful commands are written as builtins, which means they are
+implemented in C and compiled into the main `git` executable. Since they are so
+common, it is a useful exercise to implement `git psuh` as a builtin subcommand.
+
+Built-in subcommands are typically implemented in a function named "cmd_"
+followed by the name of the subcommand, in a source file named after the
+subcommand and contained within `builtin/`. So it makes sense to implement your
+command in `builtin/psuh.c`. Create that file, and within, write the entry point
+for your command in a function matching the style and signature:
+
+----
+int cmd_psuh(int argc, const char **argv, const char *prefix)
+----
+
+We'll also need to add the extern declaration of psuh; open up `builtin.h`,
+find the declaration for cmd_push, and add a new line for psuh:
+
+----
+extern int cmd_psuh(int argc, const char **argv, const char *prefix);
+----
+
+Be sure to `#include "builtin.h"` in your `psuh.c`.
+
+Go ahead and add some throwaway printf to that function. This is a decent
+starting point as we can now add build rules and register the command.
+
+NOTE: Your throwaway text, as well as much of the text you will be adding over
+the course of this lab, is user-facing. That means it needs to be localizable.
+Take a look at `po/README` under "Marking strings for translation". Throughout
+the lab, we will mark strings for translation as necessary; you should also do
+so when writing your user-facing commands in the future.
+
+----
+int cmd_psuh(int argc, const char **argv, const char *prefix)
+{
+	printf(_("Pony saying hello goes here.\n"));
+	return 0;
+}
+----
+
+Let's try to build it.  Open Makefile, find where `builtin/push.o` is added
+to BUILTIN_OBJS, and add `builtin/psuh.o` in the same way next to it in
+alphabetical order.. Once you've done so, move to the top-level directory and
+build simply with `make`. Also add the DEVELOPER=1 variable to turn on
+some additional warnings:
+
+----
+echo DEVELOPER=1 >config.mak
+make
+----
+
+NOTE: When you are developing the Git project, it's preferred that you use the
+DEVELOPER flag; if there's some reason it doesn't work for you, you can turn it
+off, but it's a good idea to mention the problem to the mailing list.
+
+NOTE: The Git build is parallelizable. `-j#` is not included above but you can
+use it as you prefer, here and elsewhere.
+
+Great, now your new command builds happily on its own. But nobody invokes it.
+Let's change that.
+
+The list of commands lives in `git.c`. We can register a new command by adding
+a cmd_struct to the commands[] array. struct cmd_struct takes a string with the
+command name, a function pointer to the command implementation, and a setup
+option flag. For now, let's keep cheating off of push. Find the line where
+cmd_push is registered, copy it, and modify it for cmd_psuh, placing the new
+line in alphabetical order.
+
+The options are documented in `builtin.h` under "Adding a new built-in." Since
+we hope to print some data about the user's current workspace context later,
+we need a Git directory, so choose `RUN_SETUP` as your only option.
+
+Go ahead and build again. You should see a clean build, so let's kick the tires
+and see if it works. There's a binary you can use to test with in
+`./bin-wrappers`.
+
+----
+./bin-wrappers/git psuh
+----
+
+Check it out! You've got a command! Nice work! Let's commit this.
+
+----
+git add Makefile builtin.h builtin/psuh.c git.c
+git commit -s
+----
+
+Consider something like the following as your commit message. Start the commit
+with a 50-column or less subject line, including the name of the component
+you're working on. Remember to be explicit and provide the "Why" of your commit,
+especially if it couldn't easily be understood from your diff. When editing
+your commit message, don't remove the Signed-off-by line which was added by `-s`
+above.
+
+----
+psuh: add a new built-in by popular demand
+
+Internal metrics indicate this is a command many users expect to be
+present. So here's an implementation to help drive customer
+satisfaction and engagement: a pony which doubtfully greets the user,
+or, a Pony Saying "Um, Hello" (PSUH).
+
+This commit message is intentionally formatted to 72 columns per line,
+starts with a single line as "commit message subject" that is written as
+if to command the codebase to do something (add this, teach a command
+that). The body of the message is designed to add information about the
+commit that is not readily deduced from reading the associated diff,
+such as answering the question "why?".
+
+Signed-off-by: A U Thor <author@example.com>
+----
+
+Go ahead and inspect your new commit with `git show`. "psuh:" indicates you
+have modified mainly the `psuh` command. The subject line gives readers an idea
+of what you've changed. The signed-off line (-s) indicates that you agree to
+the Developer's Certificate of Origin 1.1 (see the SubmittingPatches [[dco]]
+header). If you wish to add some context to your change, go ahead with
+`git commit --amend`.
+
+For the remainder of the tutorial, the subject line only will be listed for the
+sake of brevity. However, fully-fleshed example commit messages are available
+on the reference implementation linked at the top of this document.
+
+=== Implementation
+
+It's probably useful to do at least something besides print out a string. Let's
+start by having a look at everything we get.
+
+Modify your `cmd_psuh` implementation to dump the args you're passed:
+
+----
+	printf(Q_("Your args (there is %i):\n",
+		  "Your args (there are %i):\n",
+		  argc),
+	       argc);
+	for (int i = 0; i < argc; i++) {
+		printf("%s\n", argv[i]);
+	}
+	printf(_("Your prefix:\n%s\n"), prefix);
+----
+
+As you may expect, there's pretty much just whatever we give on the command
+line, including the name of our command. (If `prefix` is empty for you, try
+`cd Documentation/ && ../bin-wrappers/git/ psuh`). That's not so helpful. So
+what other context can we get?
+
+Add a line to `#include "config.h"`. Then, add the following bits:
+
+----
+const char *cfg_name;
+
+...
+
+git_config(git_default_config, NULL)
+if (git_config_get_string_const("user.name", &cfg_name) > 0)
+{
+	printf(_("No name is found in config\n"));
+}
+else
+{
+	printf(_("Your name: %s\n"), cfg_name);
+}
+----
+
+git_config(...) will grab the configuration from config files known to Git and
+apply standard precedence rules. git_config_get_string_const(...) will look up
+a specific key ("user.name") and give you the value. There are a number of
+single-key lookup functions like this one; you can see them all (and more info
+about how to use git_config()) in `Documentation/technical/api-config.txt`.
+
+You should see that the name printed matches the one you see when you run:
+
+----
+git config --get user.name
+----
+
+Great! Now we know how to check for values in the git config. Let's commit this
+too, so we don't lose our progress.
+
+----
+git add builtin/psuh.c
+git commit -sm "psuh: show parameters & config opts"
+----
+
+Still, it'd be nice to know what the user's working context is like. Let's see
+if we can print the name of the user's current branch. We can cheat off of the
+`git status` implementation; the printer is located in `wt-status.c` and we can
+see that the branch is held in a `struct wt_status`.  `wt_status_print()` gets
+invoked by `cmd_status()` in `builtin/commit.c`. Looking at that implementation
+we see the status config being populated like so:
+
+----
+status_init_config(&s, git_status_config);
+----
+
+But as we drill down, we can find that `status_init_config()` wraps a call
+to `git_config()`. Let's modify the code we wrote in the previous commit.
+
+----
+#include "wt-status.h"
+
+...
+
+// Add a wt_status to fill at the top.
+struct wt_status status;
+
+...
+
+// modify the prior code:
+wt_status_prepare(the_repository, &status);
+git_config(git_default_config, &status);
+
+...
+
+printf(_("Your current branch: %s\n"), status.branch);
+----
+
+Run it again. Check it out - here's the (verbose) name of your current branch!
+
+Let's commit this as well.
+
+----
+git commit -sm "psuh: print the current branch"
+----
+
+Now let's see if we can get some info about a specific commit.
+
+Luckily, there are some helpers for us here. `commit.h` has a function called
+`lookup_commit_reference_by_name` to which we can simply provide a hardcoded
+string; `pretty.h` has an extremely handy `pp_commit_easy()` call which doesn't
+require a full format object to be passed.
+
+Add the following:
+
+----
+#include "commit.h"
+#include "pretty.h"
+
+...
+
+struct commit *c = NULL;
+struct strbuf commitline;
+strbuf_init(&commitline, 0);
+
+...
+
+c = lookup_commit_reference_by_name("origin/master");
+
+if (c != NULL)
+{
+	pp_commit_easy(CMIT_FMT_ONELINE, c, &commitline);
+	printf(_("Current commit: %s\n"), commitline.buf);
+}
+----
+
+The `struct strbuf` provides some safety belts to your basic `char*`, one of
+which is a length member to prevent buffer overruns. It needs to be initialized
+nicely with `strbuf_init`. Keep it in mind when you need to pass around `char*`.
+
+`lookup_commit_reference_by_name` resolves the name you pass it, so you can play
+with the value there and see what kind of things you can come up with.
+
+`pp_commit_easy` is a convenience wrapper in `pretty.h` that takes a single
+format enum shorthand, rather than an entire format struct. It then prints the
+commit according to that shorthand. These are similar to the formats available
+with `--pretty=FOO` in many Git commands.
+
+Build it and run, and if you're using the same name in the example, you should
+see the subject line of the most recent commit in `origin/master` that you know
+about. Neat! Let's commit that as well.
+
+----
+git commit -sm "psuh: display the top of origin/master"
+----
+
+=== Adding documentation
+
+Awesome! You've got a fantastic new command that you're ready to share with the
+community. But hang on just a minute - this isn't very user-friendly. Run the
+following:
+
+----
+./bin-wrappers/git help psuh
+----
+
+Your new command is undocumented! Let's fix that.
+
+Take a look at `Documentation/git-*.txt`. These are the manpages for the
+subcommands that Git knows about. You can open these up and take a look to get
+acquainted with the format, but then go ahead and make a new file
+`Documentation/git-psuh.txt`. Like with most of the documentation in the Git
+project, help pages are written with AsciiDoc (see CodingGuidelines, "Writing
+Documentation" section). Use the following template to fill out your own
+manpage:
+
+// Surprisingly difficult to embed AsciiDoc source within AsciiDoc.
+[listing]
+....
+git-psuh(1)
+===========
+
+NAME
+----
+git-psuh - Delight users' typo with a shy horse
+
+
+SYNOPSIS
+--------
+[verse]
+'git-psuh'
+
+DESCRIPTION
+-----------
+...
+
+OPTIONS[[OPTIONS]]
+------------------
+...
+
+OUTPUT
+------
+...
+
+
+GIT
+---
+Part of the linkgit:git[1] suite
+....
+
+The most important pieces of this to note are the file header, underlined by =,
+the NAME section, and the SYNOPSIS, which would normally contain the grammar if
+your command took arguments.  Feel free to add new headers if you wish.
+
+Now that you've written your manpage, you'll need to build it explicitly. We
+convert your AsciiDoc to troff which is man-readable like so:
+
+----
+make all doc
+man Documentation/git-psuh.1
+----
+
+or
+
+----
+make -C Documentation/git-psuh.1
+man Documentation/git-psuh.1
+----
+
+NOTE: You may need to install the package `asciidoc` to get this to work.
+
+While this isn't as satisfying as running through `git help`, you can at least
+check that your help page looks right.
+
+You can also check that the documentation coverage is good (that is, the project
+sees that your command has been implemented as well as documented) by running
+`make check-docs` from the top-level.
+
+Go ahead and commit your new documentation change.
+
+=== Adding usage text
+
+Try and run `./bin-wrappers/git psuh -h`. Your command should crash at the end.
+That's because `-h` is a special case which your command should handle by
+printing usage.
+
+Take a look at `Documentation/technical/api-parse-options.txt`. This is a handy
+tool for pulling out options you need to be able to handle, and it takes a
+usage string.
+
+In order to use it, we'll need to prepare a NULL-terminated usage string and a
+builtin_psuh_options array. Add a line to `#include "parse-options.h"`.
+
+At global scope, add your usage:
+
+----
+static const char * const psuh_usage[] = {
+	N_("git psuh"),
+	NULL,
+};
+----
+
+Then, within your cmd_psuh implementation, we can declare and populate our
+`option` struct. Ours is pretty boring but you can add more to it if you like:
+
+----
+	struct option options[] = {
+		OPT_END()
+	};
+----
+
+Finally, before you print your args and prefix, add the call to
+`parse-options()`:
+
+----
+	argc = parse_options(argc, argv, prefix, options, psuh_usage, 0);
+----
+
+This call will modify your `argv` and `options` parameters. It will strip
+options you specified in `options` from `argv` and populate them in `options`
+instead, if they were provided. Be sure to replace your `argc` with the result
+from `parse_options`, or you will be confused if you try to parse argv later.
+
+It's worth noting the special argument `--`. As you may be aware, many Unix
+commands use `--` to indicate "end of named parameters" - all parameters after
+the `--` are interpreted merely as positional arguments. (This can be handy if
+you want to pass as a parameter something which would usually be interpreted as
+a flag.) `parse_options` will terminate parsing when it reaches `--` and give
+you the rest of the options afterwards, untouched.
+
+Build again. Now, when you run with -h, you should see your usage printed and
+your command terminated before anything else interesting happens. Great!
+
+Go ahead and commit this one, too.
+
+== Testing
+
+It's important to test your code - even for a little toy command like this one.
+Moreover, your patch won't be accepted into the Git tree without tests to
+demonstrate that it does what it's supposed to do. So let's add some tests.
+
+Related reading: `t/README`
+
+=== Overview of Testing Structure
+
+The tests in Git live in t/ and are named with a 4-decimal digit, according to
+the schema shown in the Naming Tests section of `t/README`.
+
+=== Writing Your Test
+
+Since this a toy command, let's go ahead and name the test with t9999. However,
+as many of the family/subcmd combinations are full, best practice seems to be
+to find a command close enough to the one you've added and share its naming
+space.
+
+Create your test script and mark it executable:
+
+----
+touch t/t9999-psuh-codelab.sh
+chmod +x t/t9999-psuh-codelab.sh
+----
+
+Begin with the header as so (see
+"Writing Tests" and "Source 'test-lib.sh'" in `t/README`):
+
+----
+#!/bin/sh
+
+test_description='git-psuh test
+
+This test runs git-psuh and makes sure it does not crash.'
+
+. ./test-lib.sh
+----
+
+Tests are framed inside of a `test_expect_success` in order to output TAP
+formatted results. Begin your first test and set up the repo to test in:
+
+----
+test_expect_success 'runs correctly with no args' '
+	rm -rf workbench upstream &&
+	test_create_repo upstream &&
+----
+
+`test_create_repo` comes from `test-lib.sh`. Next, we'll modify the above to
+move into the new repo and run our new command:
+
+----
+test_expect_success 'runs correctly with no args' '
+	rm -rf workbench upstream &&
+	test_create_repo upstream &&
+	(
+		cd upstream &&
+		git psuh
+	)
+'
+----
+
+Indicate that you've run everything you wanted by adding the following at the
+bottom of your script:
+
+----
+test_done
+----
+
+You can get an idea of whether you created your new test script successfully
+by running `make -C t test-lint`, which will check for things like test number
+uniqueness, executable bit, and so on.
+
+=== Running Locally
+
+Let's try and run locally:
+
+----
+make -j$(nproc)
+cd t/ && prove t9999-psuh-codelab.sh
+----
+
+You can run the full test suite and ensure git-psuh didn't break anything:
+
+----
+cd t/
+prove -j$(nproc) --shuffle t[0-9]*.sh
+----
+
+(You can also do this with `make test` but `prove` can run concurrently.
+Shuffle randomizes the order the tests are run in, which makes them resilient
+against unwanted inter-test dependencies. `prove` also makes the output nicer.
+
+Go ahead and commit this change, as well.
+
+== Getting Ready to Share
+
+You may have noticed already that the Git project performs its code reviews via
+emailed patches, which are then applied by the maintainer when they are ready
+and approved by the community. The Git project does not accept patches from
+pull requests, and the patches emailed for review need to be formatted a
+specific way - more to come on that soon.
+
+Before you send your patch off to be reviewed by the wide world, it's a good
+idea to run the continuous integration build and test suites against your new
+changes. You can do this manually or by using GitGitGadget, but either way,
+you're going to need to fork. First thing - make sure you have a GitHub
+account.
+
+=== Forking git/git on GitHub
+
+Head to the https://github.com/git/git[GitHub mirror] and look for the Fork
+button. Place your fork wherever you deem appropriate and create it.
+
+=== Uploading To Your Own Fork
+
+To upload your branch to your own fork, you'll need to add the new fork as a
+remote. You can use `git remote -v` to show the remotes you have added already.
+From your new fork's page on GitHub, you can press "Clone or download" to get
+the URL; then you need to run the following to add, replacing your own URL and
+remote name for the examples provided:
+
+----
+git remote add remotename git@github.com:remotename/git.git
+----
+
+or to use the HTTPS URL:
+
+----
+git remote add remotename https://github.com/remotename/git/.git
+----
+
+Run `git remote -v` again and you should see the new remote showing up.
+`git fetch remotename` (with the real name of your remote replaced) in order to
+get ready to push.
+
+Next, double-check that you've been doing all your development in a new branch
+by running `git branch`. If you didn't, now is a good time to move your new
+commits to their own branch.
+
+As mentioned briefly at the beginning of this doc, we are basing our work on
+master, so go ahead and update as shown below, or using your preferred
+workflow.
+
+----
+git checkout master
+git pull -r
+git rebase master psuh
+----
+
+Finally, you're ready to push your new topic branch! (Due to our branch and
+command name choices, be careful when you type the command below.)
+
+----
+git push remotename psuh
+----
+
+Now you should be able to go and check out your newly created branch on GitHub.
+
+== Sending Patches via GitGitGadget
+
+One option for sending patches is to follow a typical pull request workflow and
+send your patches out via GitGitGadget. This section outlines the steps for this
+workflow; if you'd rather use `git send-email` skip ahead.
+
+=== Sending a PR to GitGitGadget
+
+GitGitGadget is a tool created by Johannes Schindelin to make life as a Git
+contributor easier for those used to the GitHub PR workflow. It allows
+contributors to open pull requests against its mirror of the Git project, and
+does some magic to turn the PR into a set of emails and sent them out for you.
+It's documented at gitgitgadget.github.io.
+
+In order to have your code tested and formatted for review, you need to start by
+opening a Pull Request against gitgitgadget/git. Head to
+https://github.com/gitgitgadget/git and open a PR either with the "New pull
+request" button or the convenient "Compare & pull request" button that may
+appear with the name of your newly pushed branch.
+
+Review the PR's title and description, as it's used by GitGitGadget as the cover
+letter for your change. When you're happy, submit your pull request.
+
+=== Getting CI to Run
+
+If it's your first time using GitGitGadget (which is likely, as you're using
+this tutorial) then someone will need to give you permission to use the tool.
+As mentioned in the GitGitGadget doc, you just need someone who already uses it
+to comment on your PR with `/allow <username>`. GitGitGadget will automatically
+run your PRs through the CI.
+
+If the CI fails, you can update your changes with `rebase -i` and push your
+branch again:
+
+----
+git push -f remotename psuh
+----
+
+In fact, you should continue to make changes this way up until the point when
+your patch is accepted into `next`.
+
+////
+TODO https://github.com/gitgitgadget/gitgitgadget/issues/83
+It'd be nice to be able to verify that the patch looks good before sending it
+to everyone on Git mailing list.
+=== Check Your Work
+////
+
+=== Sending Your Patches
+
+Now that your CI is passing and someone has granted you permission to use
+GitGitGadget with the `/allow` command,  sending out for review is as simple as
+commenting on your PR with `/submit`.
+
+=== Updating With Comments
+
+As documented on the GitGitGadget site, when a reviewer asks you for changes,
+you can make them using `git rebase -i`. When you're ready, force push to your
+fork's branch again, just like when you were getting the CI to pass above.
+
+NOTE: Interactive rebase can be tricky; check out this handy
+https://www.oreilly.com/library/view/git-pocket-guide/9781449327507/ch10.html
+[overview] from O'Reilly.
+
+== Sending Patches with `git send-email`
+
+There are a couple reasons you may not want to use GitGitGadget, such as needing
+to send an RFC patch, wanting to check your work before mailing, or not having a
+GitHub account. Luckily, you can use Git to mail your patches instead!
+
+////
+It seems like a lot of work to set up Travis to point to your own fork, and it
+obviates the big reason not to use GGG - not having a GitHub account. For now,
+we'll skip covering Travis with personal fork.
+=== Running with Travis On Your Fork
+////
+
+=== Prerequisite: Setting Up `git send-email`
+
+Configuration for `send-email` can vary based on your operating system and email
+provider, and so will not be covered in this lab, beyond stating that in many
+distributions of Linux, `git-send-email` is not packaged alongside the typical
+`git` install. You may need to install this additional package; there are a
+number of resources online to help you do so.
+
+=== Preparing initial patchset
+
+Sending emails with Git is a two-part process; before you can prepare the emails
+themselves, you'll need to prepare the patches. Luckily, this is pretty simple:
+
+----
+git format-patch -o psuh/ master..psuh
+----
+
+The `-o psuh/` parameter tells `format-patch` to place the patch files into a
+directory. This is useful because `git send-email` can take a directory and
+send out all the patches from there.
+
+`master..psuh` tells `format-patch` to generate patches for the difference
+between `master` and `psuh`. It will make one patch file per commit. After you
+run, you can go have a look at each of the patches with your favorite text
+editor and make sure everything looks alright; however, it's not recommended to
+make code fixups via the patch file. It's a better idea to make the change the
+normal way using `git rebase -i` or by adding a new commit than by modifying a
+patch.
+
+Check and make sure that your patches exist in the directory you specified -
+you're nearly ready to send out your review!
+
+=== Preparing email
+
+In addition to an email per patch, the Git community also expects your patches
+to come with a cover letter, typically with a subject line [PATCH 0/x] (where
+x is the number of patches you're sending).  You'll need to add some extra
+parameters when you invoke `git send-email` to add the cover letter.
+
+----
+git send-email \
+	--to=target@server.tld \
+	--from=me@server.tld \
+	--subject="[PATCH 0/7] adding the 'psuh' command" \
+	--compose \
+	psuh/
+----
+
+The `--to` and `--from` fields are pretty obvious. `--subject` should indicate
+that it's a cover letter with the [PATCH 0/x] tag (check how many patches you
+are about to send so you can indicate the size of the thread correctly).
+`--compose` indicates that you want to open an editor to write the cover letter
+before sending the rest of the mails. Finally, `psuh/` attaches your directory
+full of commit patches, prompting `send-email` to send one email per patch.
+
+When you run this, you'll get an editor so you have a chance to fill out your
+cover letter. This is an important component of change submission as it explains
+to the community from a high level what you're trying to do, and why, in a way
+that's more apparent than just looking at your diff. Be sure to explain anything
+your diff doesn't make clear on its own.
+
+It's also good practice to include a diffstat, which you can generate like so:
+
+----
+git diff --stat=72 master..psuh
+----
+
+The argument to `--stat` bounds the column width of the output, which is handy
+as emails to Git shouldn't exceed 72 columns of width.
+
+Here's an example of a cover letter for `git psuh`:
+
+----
+Our internal metrics indicate widespread interest in the command
+git-psuh - that is, many users are trying to use it, but finding it is
+unavailable, using some unknown workaround instead.
+
+The following handful of patches add the psuh command and implement some
+handy features on top of it.
+
+This patchset is part of the MyFirstContribution codelab and should not
+be merged.
+
+ Documentation/git-psuh.txt | 40 +++++++++++++++++++
+ Makefile                   |  1 +
+ builtin.h                  |  1 +
+ builtin/psuh.c             | 78 ++++++++++++++++++++++++++++++++++++++
+ git.c                      |  1 +
+ t/t9999-psuh-codelab.sh    | 12 ++++++
+ 6 files changed, 133 insertions(+)
+----
+
+NOTE: When you've got a real change to send, you'll use `git@vger.kernel.org`
+in the `--to` field. For now, though, don't spam the list with the codelab -
+send it to yourself and check if it looks right.
+
+=== Sending email
+
+After you finish running the command above and editing your cover letter, you
+will be presented with an interactive prompt for each patch that's about to go
+out. This gives you one last chance to edit or quit sending something (but
+again, don't edit code this way). Once you press `y` or `a` at these prompts
+your emails will go out!
+
+Awesome, now the community will drop everything and review your changes. (Just
+kidding - be patient!)
+
+=== Applying Changes
+
+Once you do have some review comments, you should make changes if necessary, or
+push back on the changes by replying to the emails. (Make sure your mail client
+has a plaintext email mode; the Git list rejects HTML email.) Please also follow
+the mailing list etiquette outlined in the 
+https://kernel.googlesource.com/pub/scm/git/git/+/todo/MaintNotes[Maintainer's
+Note], which are similar to etiquette rules in most open source communities
+surrounding bottom-posting and inline replies.
+
+////
+TODO - mail list etiquette
+////
+
+You should apply changes using interactive rebase, or by adding new commits if
+the changes seem to require it.
+
+NOTE: Interactive rebase can be tricky; check out this handy
+https://www.oreilly.com/library/view/git-pocket-guide/9781449327507/ch10.html
+[overview] from O'Reilly.
+
+=== Sending v2
+
+When you're ready with the next iteration of your patch, the process is pretty
+much the same, with a few differences:
+
+* When you run `format-patch`, include the argument `-v2` to add a "v2" tag to
+the subject lins given.
+* When you run `send-email`, include the argument `--in-reply-to=<message-id>`
+with the Message-Id of the cover letter of the previous version. (You can find
+that Message-Id on https://public-inbox.org/git/.) Also, change the subject line
+on your cover letter to include "v2" to match the subjects of your patches.
+
+When it's time for v3 or beyond, simply change the number above, but make sure
+your v2 cover letter is in reply to your v1 cover letter, and your v3 cover
+letter is in reply to your v2 cover letter, and so on.
+
+== Now What?
+
+The Git project has four integration branches: `pu`, `next`, `master`, and
+`maint`. Your change will be placed into `pu` fairly early on by the maintainer
+while it is still in the review process; from there, when it is ready for wider
+testing, it will be merged into `next`. Plenty of early testers use `next` and
+may report issues. Eventually, changes in `next` will make it to `master`,
+which is typically considered stable. Finally, when a new release is cut,
+`maint` is used to base bugfixes onto. As mentioned at the beginning of this
+document, you can read `Documents/SubmittingPatches` for some more info about
+the use of the various integration branches.
+
+Back to now: your code has been lauded by the upstream reviewers. It is perfect.
+It is ready to be accepted. You don't need to do anything else; the maintainer
+will pull your patchset into `next` and life is good.
+
+However, if it isn't so perfect, once it is in `next`, you can no longer modify
+your commits in GitGitGadget or the email thread. Consider that review "closed" 
+- you will need to repeat the entire process for any bug fix commits you need
+to send, basing your changes on the maintainer's topic branch for your work
+instead of `master`. These topic branches are typically detailed in
+https://github.com/gitster/git and are mirrored by GitGitGadget. Since they're
+mirrored, you can still  use GitGitGadget to send email patches, as long as
+you've based your PR against the appropriate GitGitGadget/Git branch. Or, you
+can use `git send-email` just the same as before, except you will generate diffs
+from `<topic>..<mybranch>` and base your work on `<topic>` instead of `master`.
-- 
gitgitgadget
