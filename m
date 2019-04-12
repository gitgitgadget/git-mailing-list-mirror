Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87A420248
	for <e@80x24.org>; Fri, 12 Apr 2019 22:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfDLWD3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 18:03:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35103 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfDLWD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 18:03:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id h39so13059182qte.2
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QwtAEPtKv65o0IQ6ZWhFKhg0mas3J0bP1cb1fuuSzSM=;
        b=BspZGLDmrU8b7jUYD9/+UDz7PbPMmjdrKsncaafYLQ2zVitj4ZZ8rd/A9jIOCBndZm
         os/fR4FbkAxFA5582VgxiJjWo2101CqsvHUAh5/+0MKo1e/f7OFDm8+uYhfU8xDwBfd8
         naKb6vgzqQaHAJswCuPkxVIbGZ4E7vYx0Y0ou2PMaFWfhyjaUc7RzQWEcDGiA2BX8zGi
         uwMB8x8iNzNO8zivHYfOiaQugP9g4Q9EVuz+vACoEoBXE+p8hXH8SmvL6BkRMjTDX/Ya
         2xVefgMo3zRU7Q6E8nSmFaCjLV3mPZ8ZvjogYBvs3brfcOt3tysgLig8bcbBLjJvxu9j
         yTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QwtAEPtKv65o0IQ6ZWhFKhg0mas3J0bP1cb1fuuSzSM=;
        b=XDznZfiIgUAHxKGKww9auNfFHKe0+dDw7S81m7saoBmPifcRvoOqPv8+m8+Inl1Yb8
         /l4MnUE/tFI9HERFPhs5qI1sO26pLfxzMgwUlimLKdYCH4zxPQpu83yakMUKrP/jrCuk
         LrekrlDj8QDQ1VydIAFYISTfow1Od4FKOCTXR8zcvBJ5NTjeGjM7onlUpNUlurmUYR12
         HGvUfKVw9VAtZdWqPTsmI7t5Wd25FfvkP4aLUQWT6Za6FYnuJ659yKWIe2I3T+fojWMF
         XGt/uFn9QQtoVHOfvQctRrMEAZXOHxRtZV2my8ko9W3g3iTL2NzOrsC0v7A8pc3s46ME
         XwmA==
X-Gm-Message-State: APjAAAWN5mRmxkT6q3PbHsyWvXg2v1fvAC6UMNSc07LShL+8qJ69Gkgv
        GxjU+CrfEx0/kp+6a2r2DCcmkNI89cl2PiEpYOhGpg==
X-Google-Smtp-Source: APXvYqzNmU4qDS/tAjW/GD+hk5y+yjQU6P9uVbbf6aFtBPgZCvM8v2UJkTPHXP9pYyS6vuksxLQGMK8k7NHMwtYG/x0=
X-Received: by 2002:ac8:74d5:: with SMTP id j21mr50976322qtr.232.1555106607930;
 Fri, 12 Apr 2019 15:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.177.git.gitgitgadget@gmail.com> <8b71fe78719aa40feee509e6a6229775daa79a2f.1555007520.git.gitgitgadget@gmail.com>
 <xmqqef67zz7u.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqef67zz7u.fsf@gitster-ct.c.googlers.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Fri, 12 Apr 2019 15:03:16 -0700
Message-ID: <CAJoAoZnY8hQmxPBcFFZEonQvMLT6x2xrfupy7+gcu+uUN1h1cg@mail.gmail.com>
Subject: Re: [PATCH 1/1] documentation: add lab for first contribution
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 11, 2019 at 8:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Emily Shaffer via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/Documentation/MyFirstContribution b/Documentation/MyFirstContribution
> > new file mode 100644
> > index 0000000000..9b87e424d6
> > --- /dev/null
> > +++ b/Documentation/MyFirstContribution
> > @@ -0,0 +1,674 @@
> > +My First Contribution
> > +=====================
> > +
> > +== Summary
>
> Just a minor nit but only the document title uses the underlined
> mark-up format, but not each of its sections?

I was basing the format of this document on
Documentation/SubmittingPatches, which underlines the document
title but prefixes the rest of the headers with /=+/ to indicate level. I
can change it, but I like the hierarchical headers offered by ={1,4}
prefix.

>
> Is the goal of this document to help those who want to contribute to
> *THIS* project, or to any project that happens to use Git as their
> source control tool of choice?  I take it to be the former, but if
> that is the case, perhaps extend the title to "My First Contribution
> to the Git Project" or something, so that those who use us merely as
> a tool can tell that it can be ignored more easily?

Good point, I'll extend the title.

>
> > +=== Set Up Your Workspace
> > +
> > +Let's start by making a development branch to work on our changes. Per
> > +`Documentation/SubmittingPatches`, since a brand new command is a new feature,
> > +it's fine to base your work on `master`. However, in the future for bugfixes,
> > +etc., you should check that doc and base it on the appropriate branch.
> > +
> > +For the purposes of this doc, we will base all our work on `master`. Before
> > +running the command below, ensure that you are on `master` first so your
> > +branch diverges at the right point.
> > +
> > +----
> > +git checkout -b psuh
> > +----
>
> An obvious and more explicit alternative, which may be better both
> for tutorial purposes (as it illustrates what is going on better by
> not relying on an implicit default) and for real-life (as it does
> not require checking out 'master' only to switch away from a new
> branch, saving a entry of two in the HEAD reflog) is
>
>         For the purposes of this doc, we will base all our work on
>         the `master` branch of the upstream project.  Fork the
>         `psuh` branch you use for your development like so:
>
>         ----
>         $ git checkout -b psuh origin/master
>         ----
>

I like this suggestion, but don't like the use of "fork" as it
somewhat conflates
a GitHub-specific term. I'll take this recommendation but use "create" instead
of "fork".

> > +=== Adding a new command
> > +
> > +Lots of the main useful commands are written as builtins, which means they are
>
> Drop 'useful', and possibly 'main' as well.  I would have written
> "Many of the Git subcommands are..." if I were writing it myself
> without reading yours.
>
> > +implemented in C and compiled into the main `git` executable.. So it is
> > +informative to implement `git psuh` as a builtin.
> > +Create a new file in `builtin/` called `psuh.c`.
>
> I am not sure what "informative" in this context means.

I was hoping to indicate that it would be an informative exercise for the reader
who is following the tutorial. I'll try to reword this and make it
more clear; thanks
for the example.

>
>         Typically a built-in subcommand is implemented as a function
>         whose name is "cmd_" followed by the name of the subcommand
>         and stored in a C source file that is named after the name
>         of the subcommand inside `builtin/` directory, so it is
>         natural to implement your `psuh` command as a cmd_psuh()
>         function in `builtin/psuh.c`.
>
> > +The entry point of your new command needs to match a certain signature:
> > +----
> > +int cmd_psuh(int argc, const char **argv, const char *prefix)
> > +----
> > +
> > +We'll also need to add the extern declaration of psuh; open up `builtin.h`,
> > +find the declaration for cmd_push, and add a new line for psuh:
> > +
> > +----
> > +extern int cmd_psuh(int argc, const char **argv, const char *prefix);
> > +----
>
> I think there is a push to drop the "extern " from decls of
> functions in *.h header files.
>

I'd just as soon change this documentation when that push changes the
other decls,
rather than spend time explaining a transient shift in how to do
something in one
file, but if you wish I can encourage the new good behavior here instead.

> > +Be sure to `#include "builtin.h"` in your `psuh.c`.
> > +
> > +Go ahead and add some throwaway printf to that method. This is a decent
> > +starting point as we can now add build rules and register the command.
>
> We are writing in C; don't call a function method.

You got me! Fixed throughout the file. Hanging head in shame. Etc.

>
> > +
> > +NOTE: Your throwaway text, as well as much of the text you will be adding over
> > +the course of this lab, is user-facing. That means it needs to be localizable.
> > +Take a look at `po/README` under "Marking strings for translation". Throughout
> > +the lab, we will mark strings for translation as necessary; you should also do
> > +so when writing your user-facing commands in the future.
>
> Good.  I think that it is beneficial to give a more concrete
> example, rather than leaving at saying "type any throwaway printf",
> perhaps like:
>
>         ----
>         int cmd_psuh(int ac, const char *av, const char *prefix)
>         {
>                 printf(_("Pony says Uh, hello!\n"));
>                 return 0;
>         }
>         ----
>
> at this point.  That illustrates _() and also the fact that
> successful command execution is concluded by returning 0 from the
> service function.

Sure, done.

>
> > +Let's try to build it.  Open Makefile, find where `builtin/push.o` is added
> > +to BUILTIN_OBJS, and add `builtin/psuh.o` in the same way. Once you've done so,
>
> In the same way "next to it"?  Do we want to say taht we are trying
> to keep these lines sorted?
>

Done, mentioned alphabetical order.

> > +move to the root directory and build simply with `make -j$(nproc)`. Optionally, add
> > +the DEVELOPER=1 variable to turn on some additional warnings:
>
> We tend to avoid saying `root` and instead say the top-level
> directory, to avoid clueless literally doing "cd / && make" ;-).
>
> As this is a developer-facing document, not making DEVELOPER=1
> optional is preferrable.  Only when you are on a platform where
> DEVELOPER=1 does not work well for you, optionally it is OK to drop
> it.

I'd like to add a line mentioning that someone ought to report that the flag
was broken for them. Is the preference to have that reported to the mail
list?

>
> Is it needed to say -j$(nproc) here, by the way?  That's a
> preference highly personal.  I wouldn't write
>
>         $ time nice -20 make -j
>
> in a toturial I'd be writing, even if that is what I might often
> use, and I expect those developers who are hacking Git to know how
> to run $(MAKE) in a way appropriate for their boxes.

Good point. I'll mention that the Git build is parallelizable and leave it
at that.

>
> > +----
> > +echo DEVELOPER=1 > config.mak
>
> Follow the Documentation/CodingGuildelines when writing for our
> developers.  Lose SP between the redirection operator and its
> target filename.

Done, thanks.

>
> > +make -j$(nproc)
> > +----
>
> > +
> > +Great, now your new command builds happily on its own. But nobody invokes it.
> > +Let's change that.
>
> This is a tangent, but if we want to show off check-docs at this
> point or perhaps a bit later, where it would notice that psuh is
> implemented but not documented.
>

I'll add mention of it in the documentation section.

> > +The list of commands lives in `git.c`. We can register a new command by adding
> > +a cmd_struct to the commands[] array. struct cmd_struct takes a string with the
> > +command name, a function pointer to the command implementation, and a setup
> > +option flag. For now, let's keep cheating off of push. Find the line where
> > +cmd_push is registered, copy it, and modify it for cmd_psuh.
>
> Right now, the elements in commands[] can be in any order, if I am
> not mistaken in reading get_builtin().  It might want to be updated,
> though, so recommanding to meek the list sorted may not be a bad
> idea.

Done, mentioned alphabetical order.

>
> > +The options are documented in `builtin.h` under "Adding a new built-in." Since
> > +we hope to print some data about the user's current workspace context later,
> > +we need a Git directory, so choose `RUN_SETUP` as your only option.
> > +
> > +Go ahead and build again. You should see a clean build, so let's kick the tires
> > +and see if it works. There's a binary you can use to test with in
> > +`./bin-wrappers`.
> > +
> > +----
> > +./bin-wrappers/git psuh
> > +----
> > +
> > +Check it out! You've got a command! Nice work! Let's commit this.
> > +
> > +----
> > +git add Makefile builtin.h builtin/psuh.c git.c
> > +git commit -s
> > +----
> > +
> > +Consider something like the following as your commit message. Start the commit
> > +with a 50-column or less subject line, including the name of the component
> > +you're working on. Remember to be explicit and provide the "Why" of your commit,
> > +especially if it couldn't easily be understood from your diff. When editing
> > +your commit message, don't remove the Signed-off-by line which was added by `-s`
> > +above.
>
> ... then leave it in your example, perhaps?
>

Good point. :)  I had wanted to avoid including my own name/email in the
tutorial; I used a throwaway "Git Contributor <very@smart.dev>" for the example.

> > +
> > +----
> > +psuh: add a new built-in by popular demand
> > +
> > +Internal metrics indicate this is a command many users expect to be
> > +present. So here's an implementation to help drive customer
> > +satisfaction and engagement: a pony which doubtfully greets the user,
> > +or, a Pony Saying "Um, Hello" (PSUH).
> > +
> > +This commit message is intentionally formatted to 72 columns per line,
> > +starts with a single line as "commit message subject" that uses the
> > +imperative present tense, and is designed to add information about the
>
> There is no imperative past tense ;-)
>

I'll blame dscho for that one :)

> Use "that is written in the imperative mood" instead if you want to
> be grammatical, or alternatively "that is written as if giving an
> order to the codebase to 'be like so'" (it actually is giving an
> order to the patch-monkey at the other end of your e-mail submission
> to do so ;-).

It's a good point though. I'd like to avoid technical grammar names
since obviously myself and dscho can't keep them straight ;) so I'll try
to explain better.

>
> > +commit that is not readily deduced from reading the associated diff,
> > +such as answering the question "why?".
>
> Nicely written.

Credit to dscho for the last paragraph :)

>
> Keep a sample sign-off by "A U Thor <author@example.com>" here.
>
> > +----
> > +
> > +Go ahead and inspect your new commit with `git show`. "psuh:" indicates you
> > +have modified mainly the `psuh` command. The subject line gives readers an idea
> > +of what you've changed. The signed-off line (-s) indicates that you agree to
> > +the Developer's Certificate of Origin 1.1 (see the SubmittingPatches [[dco]]
> > +header). If you wish to add some context to your change, go ahead with
> > +`git commit --amend`.
> > +
> > +For the remainder of the tutorial, the subject line only will be listed for the
> > +sake of brevity. However, fully-fleshed example commit messages are available
> > +on the reference implementation linked at the top of this document.
>
> OK.
>
> > +=== Implementation
> > + ...
> > +=== Adding documentation
> > + ...
>
> After skimming the remainder of your draft, i am not sure if this
> order of presentation is the best one.
>
> My personal preference is to make a small progress in the
> implementation and then immediately after that add a test, whose
> first iteration might even look like:
>
>         #!/bin/sh
>         test_description="test git psuh"
>         . ./test-lib.sh
>
>         test_expect_success setup '
>                 : nothing special yet
>         '
>
>         test_expect_success 'git psuh succeeds without an argument' '
>                 git psuh
>         '
>
>         test_done
>
> But that may make the very initial step a bit too broad for a new
> develoepr to grok.  I dunno.
>

Do folks on Git project usually engage in test-driven development? I
would be happy to move the test up towards the front of the document
and mention the usefulness of TDD, but not if that's not something
emphasized usually by the group..

-- 
Emily Shaffer
