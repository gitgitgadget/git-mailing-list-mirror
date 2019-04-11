Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 769F520248
	for <e@80x24.org>; Thu, 11 Apr 2019 18:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfDKScG (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 14:32:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41185 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfDKScG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 14:32:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id g6so2130824edc.8
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r8+GjKHRxBVRiHbL+ttlKEytH+W2gNF3OYIpZ2orZlE=;
        b=W6Ej37egBBfmk4jT+ofxjzpr14dxyTYwmgzG6shv2ZWxLgEkL7al0SCxuBinsqMHN/
         d2XRpPE8jAoruQecLrcY42bsG89WlLjUsGmqrAxJd7rLXeUhWDlvCS6o6VfRI6evANYo
         ESqwklpWrLHO0dx4gB0FFBxAfc+bMYqn2zh2iErEw1kk2Epbgj8dOK6IELEoDpJaIPo7
         A1inA/VKkRXM6EWwWfmPkLF4PxSalHi/kTkTHFNlkDz2BVkQQ1yXjMVUNBz0EKVRVqvM
         oYOZMIYP8YuMVgdPMlRel+upy9RYS3xunNakHGhk3pIo2r5ek1xrL1eguXqr4mSqz8N9
         swNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r8+GjKHRxBVRiHbL+ttlKEytH+W2gNF3OYIpZ2orZlE=;
        b=ojtd/+p2koqWTTr4wvHFZlNJNHeGe3HuF3rsSopmq/6j8bp5AUJIJhNsrID+3jtBIz
         dw3X2ATkXDomkirUpTBsvKSR1e44RFj1G1t6bKnSCmjs3PPQOoYdPdpUqRmQ/ZB+08rP
         rmyTYECmSp7rEi5dlHu3nWBbCfh5u0TOrEVW220JKQ8spG78lSLWWEks1X9bCY0BAUJu
         HwJlJLwRuer306aX6GVAUu9rWx8g8blzzvo7AdxSHjHQZ+fQOuxMZDbm1E71YLlQ+nQh
         JPyTQJ56mgQUFSNAGNTqT6UyPhIMaElvCEGgUDIcCTbPq0QMh+GYEvQay3tDVxXYPtkV
         C5aw==
X-Gm-Message-State: APjAAAWwwnUjwGr1PkMd7HNiRyOkLxihjJI96wcRelE68eG72jyxTiYN
        VxAQcfPcfPR9cBI4SOVMA5ULsF9Y
X-Google-Smtp-Source: APXvYqwQTojE+gEUhg3doxdW4OiWVzVufEP3A7MUEb4tWN5ItViKmrNOwlo1BTTBfnz6+wXvZFbQ+A==
X-Received: by 2002:a50:978e:: with SMTP id e14mr32002585edb.217.1555007522221;
        Thu, 11 Apr 2019 11:32:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19sm1730652edq.53.2019.04.11.11.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:32:01 -0700 (PDT)
Date:   Thu, 11 Apr 2019 11:32:01 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Apr 2019 18:32:00 GMT
Message-Id: <8b71fe78719aa40feee509e6a6229775daa79a2f.1555007520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.177.git.gitgitgadget@gmail.com>
References: <pull.177.git.gitgitgadget@gmail.com>
From:   "Emily Shaffer via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] documentation: add lab for first contribution
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
 Documentation/MyFirstContribution | 674 ++++++++++++++++++++++++++++++
 1 file changed, 674 insertions(+)
 create mode 100644 Documentation/MyFirstContribution

diff --git a/Documentation/MyFirstContribution b/Documentation/MyFirstContribution
new file mode 100644
index 0000000000..9b87e424d6
--- /dev/null
+++ b/Documentation/MyFirstContribution
@@ -0,0 +1,674 @@
+My First Contribution
+=====================
+
+== Summary
+
+This is a codelab demonstrating the end-to-end workflow of creating a change to
+the Git tree, sending it for review, and making changes based on comments.
+
+=== Prerequisites
+
+This codelab assumes you're already fairly familiar with using Git to manage
+source code.  The Git workflow steps will largely remain unexplained.
+
+=== Related Reading
+
+This codelab aims to summarize the following documents, but the reader may find
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
+In this codelab, we will add a new command, `git psuh`, short for "Pony Saying
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
+For the purposes of this doc, we will base all our work on `master`. Before
+running the command below, ensure that you are on `master` first so your
+branch diverges at the right point.
+
+----
+git checkout -b psuh
+----
+
+We'll make a number of commits here in order to demonstrate how to send many
+patches up for review simultaneously.
+
+== Code It Up!
+
+NOTE: A reference implementation can be found at
+https://github.com/nasamuffin/git/tree/codelab.
+
+=== Adding a new command
+
+Lots of the main useful commands are written as builtins, which means they are
+implemented in C and compiled into the main `git` executable.. So it is
+informative to implement `git psuh` as a builtin.
+
+Create a new file in `builtin/` called `psuh.c`.
+
+The entry point of your new command needs to match a certain signature:
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
+Go ahead and add some throwaway printf to that method. This is a decent
+starting point as we can now add build rules and register the command.
+
+NOTE: Your throwaway text, as well as much of the text you will be adding over
+the course of this lab, is user-facing. That means it needs to be localizable.
+Take a look at `po/README` under "Marking strings for translation". Throughout
+the lab, we will mark strings for translation as necessary; you should also do
+so when writing your user-facing commands in the future.
+
+Let's try to build it.  Open Makefile, find where `builtin/push.o` is added
+to BUILTIN_OBJS, and add `builtin/psuh.o` in the same way. Once you've done so,
+move to the root directory and build simply with `make -j$(nproc)`. Optionally, add
+the DEVELOPER=1 variable to turn on some additional warnings:
+
+----
+echo DEVELOPER=1 > config.mak
+make -j$(nproc)
+----
+
+Great, now your new command builds happily on its own. But nobody invokes it.
+Let's change that.
+
+The list of commands lives in `git.c`. We can register a new command by adding
+a cmd_struct to the commands[] array. struct cmd_struct takes a string with the
+command name, a function pointer to the command implementation, and a setup
+option flag. For now, let's keep cheating off of push. Find the line where
+cmd_push is registered, copy it, and modify it for cmd_psuh. 
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
+starts with a single line as "commit message subject" that uses the
+imperative present tense, and is designed to add information about the
+commit that is not readily deduced from reading the associated diff,
+such as answering the question "why?".
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
+single-key lookup methods like this one; you can see them all (and more info
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
+TODO: ref & object read
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
+git-psuh - Chastise users' typo with a shy horse
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
+So let's add some tests.
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
+////
+TODO: The next few bullets describe testing and pushing your change with
+GitGitGadget. It may be useful to describe a workflow using git send-email as
+well.
+////
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
+////
+This is the path for git send-email. Do we want to cover that approach as well?
+=== Running with Travis On Your Fork
+
+== Sending For Review
+
+=== Preparing initial patchset
+
+=== Preparing email
+
+=== Sending email
+
+=== Applying Changes
+
+=== Sending v2
+
+End of path for git send-email
+////
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
+your commits in GitGitGadget. Consider that PR "closed" - you will need to
+repeat the entire process for any bug fix commits you need to send, basing your
+changes on the maintainer's topic branch for your work instead of `master`.
+These topic branches are typically detailed in https://github.com/gitster/git
+and are mirrored by GitGitGadget. Since they're mirrored, you can still  use
+GitGitGadget to send email patches, as long as you've based your PR against the
+appropriate GitGitGadget/Git branch.
+
+(TODO - does that mean that GGG will Just Work for those branches?)
-- 
gitgitgadget
