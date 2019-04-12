Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99F6320248
	for <e@80x24.org>; Fri, 12 Apr 2019 03:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDLDUZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 23:20:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33503 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDLDUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 23:20:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so10006670wrp.0
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 20:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2jP/uFadXDHxk2X/kv7gHG4HtPPYcIJlcr8y63tc0Rk=;
        b=MRK1tEe9/TW2Q3yBuzZa0SdyJ2lhoGNxhmWdjIHwVTiSkBTfUSKtSt/iqTw6hAuxWM
         4zTvWmfzM7JE6g5RVYLFFHzYzxNwtyuhNkYf4r6kQY6E4ZrB9TuqA5awBuIEQ6jVuSuc
         0AvEbbkLde9aEVSwMErNVQi9SpShCNgpiWXwFhVZQ0IvsW2tKGBnCKXXfzJ6sWAkBKtB
         MxTtn9gEaHO01rDesCFiMYpT3ugVleMRSTcsgKkQFNH6E7fj5n6aDm21cS5FxVYzHoJO
         Gc9JPD5/V7ChCJx4+XjIWT4yGZcgOpQ+iGRWcsdBZy6J6bcVOwoF5CqXS9AVxi9hUl8U
         vahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2jP/uFadXDHxk2X/kv7gHG4HtPPYcIJlcr8y63tc0Rk=;
        b=aCtrfsCEaK6H9gLJaLWDF0YJEtt2xgNEzpkWkdAIsT20LY7lzPMt5w1UzPB0Ucs7g1
         7nJ0C+Kk1feMJavAZC1hejcLqPMysespogkrU+fzY3iiXeHjHdII4OMB/0iMVLFRxnyx
         8ouUWJEs8EtRnAO7OsrpySlnIPt8qk7a7w59zGeQ+XoDp84ipYw7Ua8SRj8VlgZYF1M9
         2kfwfR1RXIeiape+ot9ugLoZ5fpgiQm4ci1EqL/dVtV8fLFxJjqr6BrACp0Upa/wPR2U
         SraIF1AMq3hYmsyAU+qQeuUhRye57+iuWfH2kweI/DuM+jJIGXq+toQm5xImkCf08JzX
         jdpw==
X-Gm-Message-State: APjAAAUHLbq4hR/srUIpVFwPVcNV9gSuiU4awUdrN2lG6zhJt9AHPXWe
        LtmVKIEjqHMrEmuRrhVvfKU=
X-Google-Smtp-Source: APXvYqxSUiJsCZCaa4KzjSPMLhIwHoQlfNQqUjgjzK2f2o42WB6zbpNSaKtVAHzW417n7jTkjDliKQ==
X-Received: by 2002:adf:8bc5:: with SMTP id w5mr31577129wra.226.1555039222643;
        Thu, 11 Apr 2019 20:20:22 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y17sm7216673wma.8.2019.04.11.20.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 20:20:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Emily Shaffer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 1/1] documentation: add lab for first contribution
References: <pull.177.git.gitgitgadget@gmail.com>
        <8b71fe78719aa40feee509e6a6229775daa79a2f.1555007520.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Apr 2019 12:20:21 +0900
In-Reply-To: <8b71fe78719aa40feee509e6a6229775daa79a2f.1555007520.git.gitgitgadget@gmail.com>
        (Emily Shaffer via GitGitGadget's message of "Thu, 11 Apr 2019
        11:32:01 -0700 (PDT)")
Message-ID: <xmqqef67zz7u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Emily Shaffer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/MyFirstContribution b/Documentation/MyFirstContribution
> new file mode 100644
> index 0000000000..9b87e424d6
> --- /dev/null
> +++ b/Documentation/MyFirstContribution
> @@ -0,0 +1,674 @@
> +My First Contribution
> +=====================
> +
> +== Summary

Just a minor nit but only the document title uses the underlined
mark-up format, but not each of its sections?

Is the goal of this document to help those who want to contribute to
*THIS* project, or to any project that happens to use Git as their
source control tool of choice?  I take it to be the former, but if
that is the case, perhaps extend the title to "My First Contribution
to the Git Project" or something, so that those who use us merely as
a tool can tell that it can be ignored more easily?

> +=== Set Up Your Workspace
> +
> +Let's start by making a development branch to work on our changes. Per
> +`Documentation/SubmittingPatches`, since a brand new command is a new feature,
> +it's fine to base your work on `master`. However, in the future for bugfixes,
> +etc., you should check that doc and base it on the appropriate branch.
> +
> +For the purposes of this doc, we will base all our work on `master`. Before
> +running the command below, ensure that you are on `master` first so your
> +branch diverges at the right point.
> +
> +----
> +git checkout -b psuh
> +----

An obvious and more explicit alternative, which may be better both
for tutorial purposes (as it illustrates what is going on better by
not relying on an implicit default) and for real-life (as it does
not require checking out 'master' only to switch away from a new
branch, saving a entry of two in the HEAD reflog) is

	For the purposes of this doc, we will base all our work on
	the `master` branch of the upstream project.  Fork the
	`psuh` branch you use for your development like so:

	----
	$ git checkout -b psuh origin/master
	----

> +=== Adding a new command
> +
> +Lots of the main useful commands are written as builtins, which means they are

Drop 'useful', and possibly 'main' as well.  I would have written
"Many of the Git subcommands are..." if I were writing it myself
without reading yours.

> +implemented in C and compiled into the main `git` executable.. So it is
> +informative to implement `git psuh` as a builtin.
> +Create a new file in `builtin/` called `psuh.c`.

I am not sure what "informative" in this context means.

	Typically a built-in subcommand is implemented as a function
	whose name is "cmd_" followed by the name of the subcommand
	and stored in a C source file that is named after the name
	of the subcommand inside `builtin/` directory, so it is
	natural to implement your `psuh` command as a cmd_psuh()
	function in `builtin/psuh.c`.

> +The entry point of your new command needs to match a certain signature:
> +----
> +int cmd_psuh(int argc, const char **argv, const char *prefix)
> +----
> +
> +We'll also need to add the extern declaration of psuh; open up `builtin.h`,
> +find the declaration for cmd_push, and add a new line for psuh:
> +
> +----
> +extern int cmd_psuh(int argc, const char **argv, const char *prefix);
> +----

I think there is a push to drop the "extern " from decls of
functions in *.h header files.

> +Be sure to `#include "builtin.h"` in your `psuh.c`.
> +
> +Go ahead and add some throwaway printf to that method. This is a decent
> +starting point as we can now add build rules and register the command.

We are writing in C; don't call a function method.

> +
> +NOTE: Your throwaway text, as well as much of the text you will be adding over
> +the course of this lab, is user-facing. That means it needs to be localizable.
> +Take a look at `po/README` under "Marking strings for translation". Throughout
> +the lab, we will mark strings for translation as necessary; you should also do
> +so when writing your user-facing commands in the future.

Good.  I think that it is beneficial to give a more concrete
example, rather than leaving at saying "type any throwaway printf",
perhaps like:

	----
	int cmd_psuh(int ac, const char *av, const char *prefix)
	{
		printf(_("Pony says Uh, hello!\n"));
		return 0;
	}
	----

at this point.  That illustrates _() and also the fact that
successful command execution is concluded by returning 0 from the
service function.

> +Let's try to build it.  Open Makefile, find where `builtin/push.o` is added
> +to BUILTIN_OBJS, and add `builtin/psuh.o` in the same way. Once you've done so,

In the same way "next to it"?  Do we want to say taht we are trying
to keep these lines sorted?

> +move to the root directory and build simply with `make -j$(nproc)`. Optionally, add
> +the DEVELOPER=1 variable to turn on some additional warnings:

We tend to avoid saying `root` and instead say the top-level
directory, to avoid clueless literally doing "cd / && make" ;-).

As this is a developer-facing document, not making DEVELOPER=1
optional is preferrable.  Only when you are on a platform where
DEVELOPER=1 does not work well for you, optionally it is OK to drop
it.

Is it needed to say -j$(nproc) here, by the way?  That's a
preference highly personal.  I wouldn't write

	$ time nice -20 make -j

in a toturial I'd be writing, even if that is what I might often
use, and I expect those developers who are hacking Git to know how
to run $(MAKE) in a way appropriate for their boxes.

> +----
> +echo DEVELOPER=1 > config.mak

Follow the Documentation/CodingGuildelines when writing for our
developers.  Lose SP between the redirection operator and its
target filename.

> +make -j$(nproc)
> +----

> +
> +Great, now your new command builds happily on its own. But nobody invokes it.
> +Let's change that.

This is a tangent, but if we want to show off check-docs at this
point or perhaps a bit later, where it would notice that psuh is
implemented but not documented.

> +The list of commands lives in `git.c`. We can register a new command by adding
> +a cmd_struct to the commands[] array. struct cmd_struct takes a string with the
> +command name, a function pointer to the command implementation, and a setup
> +option flag. For now, let's keep cheating off of push. Find the line where
> +cmd_push is registered, copy it, and modify it for cmd_psuh. 

Right now, the elements in commands[] can be in any order, if I am
not mistaken in reading get_builtin().  It might want to be updated,
though, so recommanding to meek the list sorted may not be a bad
idea.

> +The options are documented in `builtin.h` under "Adding a new built-in." Since
> +we hope to print some data about the user's current workspace context later,
> +we need a Git directory, so choose `RUN_SETUP` as your only option.
> +
> +Go ahead and build again. You should see a clean build, so let's kick the tires
> +and see if it works. There's a binary you can use to test with in
> +`./bin-wrappers`.
> +
> +----
> +./bin-wrappers/git psuh
> +----
> +
> +Check it out! You've got a command! Nice work! Let's commit this.
> +
> +----
> +git add Makefile builtin.h builtin/psuh.c git.c
> +git commit -s
> +----
> +
> +Consider something like the following as your commit message. Start the commit
> +with a 50-column or less subject line, including the name of the component
> +you're working on. Remember to be explicit and provide the "Why" of your commit,
> +especially if it couldn't easily be understood from your diff. When editing
> +your commit message, don't remove the Signed-off-by line which was added by `-s`
> +above.

... then leave it in your example, perhaps?

> +
> +----
> +psuh: add a new built-in by popular demand
> +
> +Internal metrics indicate this is a command many users expect to be
> +present. So here's an implementation to help drive customer
> +satisfaction and engagement: a pony which doubtfully greets the user,
> +or, a Pony Saying "Um, Hello" (PSUH).
> +
> +This commit message is intentionally formatted to 72 columns per line,
> +starts with a single line as "commit message subject" that uses the
> +imperative present tense, and is designed to add information about the

There is no imperative past tense ;-) 

Use "that is written in the imperative mood" instead if you want to
be grammatical, or alternatively "that is written as if giving an
order to the codebase to 'be like so'" (it actually is giving an
order to the patch-monkey at the other end of your e-mail submission
to do so ;-).

> +commit that is not readily deduced from reading the associated diff,
> +such as answering the question "why?".

Nicely written.

Keep a sample sign-off by "A U Thor <author@example.com>" here.

> +----
> +
> +Go ahead and inspect your new commit with `git show`. "psuh:" indicates you
> +have modified mainly the `psuh` command. The subject line gives readers an idea
> +of what you've changed. The signed-off line (-s) indicates that you agree to
> +the Developer's Certificate of Origin 1.1 (see the SubmittingPatches [[dco]]
> +header). If you wish to add some context to your change, go ahead with
> +`git commit --amend`.
> +
> +For the remainder of the tutorial, the subject line only will be listed for the
> +sake of brevity. However, fully-fleshed example commit messages are available
> +on the reference implementation linked at the top of this document.

OK.

> +=== Implementation
> + ...
> +=== Adding documentation
> + ...

After skimming the remainder of your draft, i am not sure if this
order of presentation is the best one.

My personal preference is to make a small progress in the
implementation and then immediately after that add a test, whose
first iteration might even look like:

	#!/bin/sh
	test_description="test git psuh"
	. ./test-lib.sh

	test_expect_success setup '
		: nothing special yet
	'

	test_expect_success 'git psuh succeeds without an argument' '
		git psuh
	'

	test_done

But that may make the very initial step a bit too broad for a new
develoepr to grok.  I dunno.

