Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8922F20248
	for <e@80x24.org>; Wed, 17 Apr 2019 23:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbfDQXQi (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 19:16:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33617 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfDQXQi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 19:16:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id k14so285703qtb.0
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 16:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IdaLvL2tFFu0ZkOMSzt0jpfHEgG3nnsb8IHZAQlzxXA=;
        b=iKQGIBfkjabIcoIs+44g5j6orRMBvY3Ng52/6VszzAzLjM6JhAYHj38i6jiE5C2ibW
         rdaAonl3D8zoNEIGknULSZVDAsCratVhORtQyvIHyK/AXsHgsSCBTQlaH7qD9w7Oqi/F
         bQ63mRYTr9tjvr4t+aUySszzv+Y83vKczf3xwHtbByVZS7mXhXEEdRaZTrJvszh27Q24
         oj2mhHPeBVycjc8n3qvq9S5Zke+uPvCY7YJS2nmqF7G5W1ZweuhjWpbGXyNTZcsYfuDg
         2oKo91CHO7MYijF0ZbhMrElVHgLp3AHnohT8FDgG35IqAtHNO2HueTXEuJ0pJrgfOo8q
         kg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IdaLvL2tFFu0ZkOMSzt0jpfHEgG3nnsb8IHZAQlzxXA=;
        b=J3aS5x3f1k8Er3656cahKZ704E/lWmSm9pVdIASHvzYMuNn+lkQF26XopxneBDe1/J
         9gnfmaS9a8yFE6hRXEakOi5wPaFGEgFShNf6fe7+QW5YGk0w3SSZmwUjcOd7tI5geXnr
         4LpxVWEdAFPvbtzCuSVDTnCaWyJE1zJyws5yNkZf5Z3ntBpXit+frr3wG/ENeQk0V1Gd
         exGZjcQ8IowhnV/5nAdhOdguw7HsLCFc9x+30v88YOd06CwwgXxEu7J6gDyj/4yDP3D2
         KEANpTby1yqUGySE3NGfVYqYXQD1lUUJW5+O/ZugdK2N0csYmivoPTsvVZVajJ8ba57Y
         FKYg==
X-Gm-Message-State: APjAAAWUWCRM3v26ndJFsKq+BiSY+gxSSntG3sSnoaQjSQVJ68nJPvdE
        ooS05S6eA+UVK0h6tcRmPf4aS/r5FI343OYMRbcsjA==
X-Google-Smtp-Source: APXvYqyAamXdoOpcggbpy7e49aAi4TA40iYb9zWSq3cjihDJByODiz4+vdb2uoNskkVGA9Nk6rtmZyd168k381sBru0=
X-Received: by 2002:ac8:f3c:: with SMTP id e57mr69498297qtk.75.1555542995690;
 Wed, 17 Apr 2019 16:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.177.git.gitgitgadget@gmail.com> <pull.177.v2.git.gitgitgadget@gmail.com>
 <71d5ab539c8b47155f6a3c92e26c9224d8214298.1555446372.git.gitgitgadget@gmail.com>
 <xmqqbm15kxi0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbm15kxi0.fsf@gitster-ct.c.googlers.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Wed, 17 Apr 2019 16:16:23 -0700
Message-ID: <CAJoAoZnbhyZdkNuh+3qJ+TuqfmvYY_aCRmhOOLSbBXYnHJUnhA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] documentation: add lab for first contribution
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > This code lab covers how to add a new command to Git and, in the
> > process, everything from cloning git/git to getting reviewed on the mail
>
> "lab"?  I thought we settled on "tutorial".  Also the place we are
> having conversation we call "mailing list", I think.

You're right. My find/replace missed the commit; I'll read through the document
again as well.

> > +MyFirstContribution.txt: MyFirstContribution
> > +     $(QUIET_GEN) cp $< $@
>
> Hmph.
>
> Unlike SubmittingPatches that has known as that specific filename
> for a long time before we added to the *.txt -> *.html toolchain
> (hence people may look for it without the *.txt suffix), I do not
> immediately see why the source of this new tutorial needs a variant
> without the suffix.  Is there a reason why this new file cannot be
> created as Documentaiton/MyFirstContribution.txt that I am missing?

The only reason is that I wasn't aware of the special case. Fixed.

> > +== Getting Started
> > +
> > +=== Pull the Git codebase
> > +
> > +Git is mirrored in a number of locations. https://git-scm.com/downloads
> > +suggests the best place to clone from is GitHub.
>
> "suggests that one of the best places ..."?

I'll change it. But it seems odd to say that when git-scm.com only mentions
the one mirror.

> > +Let's start by making a development branch to work on our changes. Per
> > +`Documentation/SubmittingPatches`, since a brand new command is a new feature,
> > +it's fine to base your work on `master`. However, in the future for bugfixes,
> > +etc., you should check that doc and base it on the appropriate branch.
>
> Avoid unnecessary abbreviation; s/doc/document/.  Same for "lab", if
> we are to call this "codelab" instead of "tutorial".  I won't repeat
> this for brevity, but I see many instances of them.

Sure. I'll check across for instances of "lab" and reword them to
"tutorial"; same for "doc"
vs "document" etc.

> > +For the purposes of this doc, we will base all our work on the `master` branch
> > +of the upstream project. Create the `psuh` branch you will use for development
> > +like so:
> > +
> > +----
> > +git checkout -b psuh origin/master
> > +----
>
>         ----
>         $ git checkout -b psuh origin/master
>         ----
>
> I think both of our existing tutorials spell out the shell prompt to
> clarify what these lines are.  It would especially help in this
> document, where you have other monospaced display material that are
> not commands to be typed but code snippets.

I appreciate your comment about clarity. But including the prompt also
makes it more difficult to copy-paste into the command line...
I think if someone is blindly copy-pasting this tutorial, they won't
be getting a lot out of it anyway. So I'll add the prompts.

>
> > +
> > +We'll make a number of commits here in order to demonstrate how to send many
> > +patches up for review simultaneously.
>
> I'd write "a topic with multiple patches" instead of "many
> patches".  The point being that we are not sending a group of
> unrelated changes, but are focusing on a theme.

Good suggestion, thank you.

> > +== Code It Up!
> > +
> > +NOTE: A reference implementation can be found at
> > +https://github.com/nasamuffin/git/tree/psuh.
> > +
> > +=== Adding a new command
> > +
> > +Lots of the main useful commands are written as builtins, which means they are
>
> I'd say "the subcommands" without "main" or "useful".  There are
> fringe subcommands that are implemented as built-in, there are main
> useful commands that are not built-in, and "useful"-ness is in the
> eyes of beholder.

 Sure, done.

> > +implemented in C and compiled into the main `git` executable. Since they are so
> > +common, it is a useful exercise to implement `git psuh` as a builtin subcommand.
>
> What does "they" refer to in this sentence?  Exiting built-in
> commands are so common?  In what way are they "common"?  They are
> commonly used?  That is not relevant in the choice of making 'git
> psuh' a built-in or a standalone.
>
> Adding a new built-in command, if it were common, may be a good
> target for illustration.  But it is not all that common.
>
> Adding a built-in command requires you to understand the start-up
> sequence to the exit status, and serves as a good end-to-end
> exercise, if this tutorial's main aim is to give a tour of the
> codebase and its internal API.  An almost no-op "git psuh" built-in
> is small enough to serve as a good end-to-end exercise, without
> requiring the author to know much about the internal API, and would
> be a good material to show how the contributor, the reviewers and
> the maintainer work together to add it to the system.
>
> So "they are so common" is probably not a good excuse, even though
> using `git psuh` may be a good exercise for the purpose of this
> tutorial.
>
>         Since adding an almost no-op built-in command is relatively
>         simple, it is a good material to demonstrate how you as an
>         individual contributor, the reviewers and the maintainer
>         work together to integrate such a change to the system.
>
> perhaps?

Good suggestion. Thanks. I riffed on it a little:

    Lots of the subcommands are written as builtins, which means they are
    implemented in C and compiled into the main `git` executable.
Implementing the
    very simple `psuh` command as a built-in will demonstrate the
structure of the
    codebase, the internal API, and the process of working together as
a contributor
    with the reviewers and maintainer to integrate this change into the system.


> > +Built-in subcommands are typically implemented in a function named "cmd_"
> > +followed by the name of the subcommand, in a source file named after the
> > +subcommand and contained within `builtin/`. So it makes sense to implement your
> > +command in `builtin/psuh.c`. Create that file, and within, write the entry point
>
> s/within/& it/ perhaps?

Done.

> > +for your command in a function matching the style and signature:
> > +
> > +----
> > +int cmd_psuh(int argc, const char **argv, const char *prefix)
> > +----
> > +
> > +We'll also need to add the extern declaration of psuh; open up `builtin.h`,
> > +find the declaration for cmd_push, and add a new line for psuh:
>
> s/:/ immediately before it, to keep the declarations sorted&/ perhaps.

Done, the explicit mention is a good point.

> > +The options are documented in `builtin.h` under "Adding a new built-in." Since
> > +we hope to print some data about the user's current workspace context later,
> > +we need a Git directory, so choose `RUN_SETUP` as your only option.
> > +
> > +Go ahead and build again. You should see a clean build, so let's kick the tires
> > +and see if it works. There's a binary you can use to test with in
> > +`./bin-wrappers`.
>
> ... in `bin-wrappers` directory.
>
> > +Consider something like the following as your commit message. Start the commit
>
> I'd drop the first sentence, and instead say "You'll see something
> like this in your editor" just before the sample.

Not sure I understand. They won't see any of it but the signoff line
in their editor.
Maybe it's okay to add "You'll be presented with your editor in order
to write a commit message", followed by the tips?

> > +with a 50-column or less subject line, including the name of the component
> > +you're working on. Remember to be explicit and provide the "Why" of your commit,
>
> s/your commit/your change/;
>
> > +especially if it couldn't easily be understood from your diff. When editing
> > +your commit message, don't remove the Signed-off-by line which was added by `-s`
> > +above.
> > +
> > +----
> > +psuh: add a new built-in by popular demand
>
> I probably would not even say "new" (what you add did not exist
> before, so it is redundant) and spend the bits elsewhere (perhaps by
> spelling out "built-in command").

Sure.

> > +
> > +Internal metrics indicate this is a command many users expect to be
> > +present. So here's an implementation to help drive customer
> > +satisfaction and engagement: a pony which doubtfully greets the user,
> > +or, a Pony Saying "Um, Hello" (PSUH).
> > +
> > +This commit message is intentionally formatted to 72 columns per line,
> > +starts with a single line as "commit message subject" that is written as
> > +if to command the codebase to do something (add this, teach a command
> > +that). The body of the message is designed to add information about the
> > +commit that is not readily deduced from reading the associated diff,
> > +such as answering the question "why?".
>
> If you can actually rephrase to make the above into a rectangular
> text with 72-columns wide, that would be perfect ;-)  I certainly
> would not insist.

I'm not sure what change you're looking for. The widest line (ending
in "as") is 72 columns. Do you mean that you'd like each line to be
exactly 72 characters to the end of the word..?

> > +
> > +Signed-off-by: A U Thor <author@example.com>
> > +----
> > +
> > +Go ahead and inspect your new commit with `git show`. "psuh:" indicates you
> > +have modified mainly the `psuh` command. The subject line gives readers an idea
> > +of what you've changed. The signed-off line (-s) indicates that you agree to
>
> Either "sign-off line" or "signed-off-by line".
Done.

> > +the Developer's Certificate of Origin 1.1 (see the SubmittingPatches [[dco]]
> > +header). If you wish to add some context to your change, go ahead with
> > +`git commit --amend`.
> > +
> > +For the remainder of the tutorial, the subject line only will be listed for the
> > +sake of brevity. However, fully-fleshed example commit messages are available
> > +on the reference implementation linked at the top of this document.
>
> Good.
>
> > +=== Implementation
> > +
> > +It's probably useful to do at least something besides print out a string. Let's
>
> s/print/&ing/

Sure.. I think it's fine either way, but changed.

> > +start by having a look at everything we get.
> > +
> > +Modify your `cmd_psuh` implementation to dump the args you're passed:
> > +
> > +----
> > +     printf(Q_("Your args (there is %i):\n",
> > +               "Your args (there are %i):\n",
> > +               argc),
> > +            argc);
> > +     for (int i = 0; i < argc; i++) {
>
> I do not think we use this particular C99; define 'int i' at the
> beginning of the function, not for the loop..

Done.

> > +             printf("%s\n", argv[i]);
>
> Personal preference: printf("%d: %s\n", i, argv[i]);

Good idea.

>
> > +     }
> > +     printf(_("Your prefix:\n%s\n"), prefix);
>
> I think prefix can be NULL.  Not just in a bare repository but most
> notably at the top-level of the working tree.

You're right; this is stale compared to the sample implementation,
where I fixed this issue
(but didn't update doc). I'll change it to this:

     printf(_("Your current working directory:\n<top-level>%s%s\n"),
              prefix ? "/" : "", prefix ? prefix : "");

(thanks to dscho for the suggestion via github)

> > +----
> > +
> > +As you may expect, there's pretty much just whatever we give on the command
> > +line, including the name of our command. (If `prefix` is empty for you, try
> > +`cd Documentation/ && ../bin-wrappers/git/ psuh`). That's not so helpful. So
> > +what other context can we get?
> > +
> > +Add a line to `#include "config.h"`. Then, add the following bits:
> > +
> > +----
> > +const char *cfg_name;
>
> Not file-scope static?
>
> Ah, adding to the function's set of local variables?  Explicitly say
> so when you instruct "add the following bits", e.g. "... to the
> function body".
>
> Indenting the material a bit, the same way as you have the previous
> code block, may also help.

Sure, good catch.

>
> > +...
> > +
> > +git_config(git_default_config, NULL)
> > +if (git_config_get_string_const("user.name", &cfg_name) > 0)
> > +{
> > +     printf(_("No name is found in config\n"));
> > +}
> > +else
> > +{
> > +     printf(_("Your name: %s\n"), cfg_name);
> > +}
> > +----
> > +
> > +git_config(...) will grab the configuration from config files known to Git and
> > +apply standard precedence rules. git_config_get_string_const(...) will look up
> > +a specific key ("user.name") and give you the value. There are a number of
> > +single-key lookup functions like this one; you can see them all (and more info
> > +about how to use git_config()) in `Documentation/technical/api-config.txt`.
> > +
> > +You should see that the name printed matches the one you see when you run:
> > +
> > +----
> > +git config --get user.name
> > +----
>
>         ----
>         $ git config --get user.name
>         ----
>
> (I won't repeat this for brevity).
>
> > +Great! Now we know how to check for values in the git config. Let's commit this
> > +too, so we don't lose our progress.
> > +
> > +----
> > +git add builtin/psuh.c
> > +git commit -sm "psuh: show parameters & config opts"
> > +----
> > +
>
> For this first "abbreviated" example, it probably is worth repeating
>
>     (Again, the above is merely for brevity of the tutorial---in a
>     real project, do not use "commit -m" but use the editor and
>     write a real message).
>
> immediately after the example.

Done.

> > +Still, it'd be nice to know what the user's working context is like. Let's see
> > +if we can print the name of the user's current branch. We can cheat off of the
> > +`git status` implementation; the printer is located in `wt-status.c` and we can
> > +see that the branch is held in a `struct wt_status`.  `wt_status_print()` gets
> > +invoked by `cmd_status()` in `builtin/commit.c`. Looking at that implementation
> > +we see the status config being populated like so:
> > +
> > +----
> > +status_init_config(&s, git_status_config);
> > +----
> > +
> > +But as we drill down, we can find that `status_init_config()` wraps a call
> > +to `git_config()`. Let's modify the code we wrote in the previous commit.
> > +
> > +----
> > +#include "wt-status.h"
> > +
> > +...
> > +
> > +// Add a wt_status to fill at the top.
>
> We do not use // comments.  I think this actually is taking
> advangage of the fact and giving a meta-comment that would not enter
> into the student's code, but if that is what is going on, perhaps
> tell it explicitly upfront to help readers, perhaps like:
>
>         Throughout this tutorial, you may see in-code comment that
>         uses the double-dash `// comment`.  These are not to be used
>         in the Git codebase---instead we are giving readers a meta
>         comment to explain what is going on in the example.
>
> or something.

You give me a lot of credit, when in reality, I'm a lowly C++
developer still learning. ;)

I'm actually going to try to reword this and other modification
examples below to make it more clear where to add the various pieces.
I don't think the "..." says as much as I wanted.

> > +struct wt_status status;
> > +
> > +...
> > +
> > +// modify the prior code:
> > +wt_status_prepare(the_repository, &status);
> > +git_config(git_default_config, &status);
> > +
> > +...
> > +
> > +printf(_("Your current branch: %s\n"), status.branch);
> > +----
>
> The same "is this done inside the function?  If so say so and
> indent" comment applies to this part.

Yep.

As an aside, I wonder if it would have been clearer to try to show
unified-diff added lines with more of the file shown for context.
Probably not... :)

> > +Run it again. Check it out - here's the (verbose) name of your current branch!
> > +
> > +Let's commit this as well.
> > +
> > +----
> > +git commit -sm "psuh: print the current branch"
> > +----
> > +
> > +Now let's see if we can get some info about a specific commit.
> > +
> > +Luckily, there are some helpers for us here. `commit.h` has a function called
> > +`lookup_commit_reference_by_name` to which we can simply provide a hardcoded
> > +string; `pretty.h` has an extremely handy `pp_commit_easy()` call which doesn't
> > +require a full format object to be passed.
> > +
> > +Add the following:
> > +
> > +----
> > +#include "commit.h"
> > +#include "pretty.h"
> > +
> > +...
> > +
> > +struct commit *c = NULL;
> > +struct strbuf commitline;
> > +strbuf_init(&commitline, 0);
>
>         struct strbuf commitline = STRBUF_INIT
>
> perhaps?

grep reveals about 10x instances of STRBUF_INIT exist compared to
strbuf_init(...). Sure, I'll fix it. :)

While I'm at it, I'm rewording this area as above to make it more
clear where changes should go.

> > +
> > +...
> > +
> > +c = lookup_commit_reference_by_name("origin/master");
> > +
> > +if (c != NULL)
> > +{
>
> '{' never comes on its own line unless it is for the outermost block
> of the function body.

Ok.

> > +     pp_commit_easy(CMIT_FMT_ONELINE, c, &commitline);
> > +     printf(_("Current commit: %s\n"), commitline.buf);
> > +}
> > +----
> > +
> > +The `struct strbuf` provides some safety belts to your basic `char*`, one of
> > +which is a length member to prevent buffer overruns. It needs to be initialized
> > +nicely with `strbuf_init`. Keep it in mind when you need to pass around `char*`.
> > +
> > +`lookup_commit_reference_by_name` resolves the name you pass it, so you can play
> > +with the value there and see what kind of things you can come up with.
> > +
> > +`pp_commit_easy` is a convenience wrapper in `pretty.h` that takes a single
> > +format enum shorthand, rather than an entire format struct. It then prints the
> > +commit according to that shorthand. These are similar to the formats available
> > +with `--pretty=FOO` in many Git commands.
>
> At least the first mention of "print" that describes pp_* family of
> functions should use the word "pretty-print"; that would implicitly
> explain why the functions are called pp_*.
>
>         It then pretty-prints the commit ...

Sure, done.

> > +The most important pieces of this to note are the file header, underlined by =,
> > +the NAME section, and the SYNOPSIS, which would normally contain the grammar if
> > +your command took arguments.  Feel free to add new headers if you wish.
>
> What do you mean by the last sentence, especially by "new headers"?
>
> We do not want develoeprs to feel free to add random new sections to
> the manpage, if that is what you mean.  Rather we should encourage
> them to stick to the established structure, so that all manpages
> look the same and readers would know to which section to jump to to
> find necessary piece of information.

I was sure that I saw a piece of documentation suggesting to add new
headers if necessary, i.e., "--foo options" or something. Perhaps I
dreamed it. I'll remove this suggestion and replace it with a
recommendation to use well-established manpage headers.

> > +
> > +Now that you've written your manpage, you'll need to build it explicitly. We
> > +convert your AsciiDoc to troff which is man-readable like so:
> > +
> > +----
> > +make all doc
> > +man Documentation/git-psuh.1
> > +----
>
> Hmph.  I didn't know you can do that without "-l" (local) option.
> Perhaps with "-l" spelled out, it might be more portable but I
> dunno.

Per later email, I'll leave this the way it is.

> > +Go ahead and commit your new documentation change.
>
> > +=== Adding usage text
> > +
> > +Try and run `./bin-wrappers/git psuh -h`. Your command should crash at the end.
> > +That's because `-h` is a special case which your command should handle by
> > +printing usage.
>
> This is a tangent but an important one.  I wonder we can turn the
> "crash" into a more graceful error exit?  It is important because a
> fix like that will force us to update this sentence.

I agree, although it should be a case never seen by the user - there
is a test to ensure that all commands handle "-h", so new commands
will yell during CI stage if this failure would occur...

> > +Take a look at `Documentation/technical/api-parse-options.txt`. This is a handy
> > +tool for pulling out options you need to be able to handle, and it takes a
> > +usage string.
> > +
> > +In order to use it, we'll need to prepare a NULL-terminated usage string and a
> > +builtin_psuh_options array. Add a line to `#include "parse-options.h"`.
>
> Consistently quote variables and functions `like so`.  The array
> variable above, and also ...
>
> > +Then, within your cmd_psuh implementation, we can declare and populate our
>
> ... `cmd_psuh()` here, too (I am also suggesting to add () as a sign
> that the identifier talks about a function).

Yep, done.  (Is it better generally to use foo(), or foo(...) to
indicate that isn't argumentless?) There are other places within the
tutorial where I neglected to do so. I'll go through it with a fine
comb and try to find them all.

> > +`option` struct. Ours is pretty boring but you can add more to it if you like:
>
> s/you can more to it if you like/we will add more in a later step/ perhaps?
> Or am I expecting too much?  Use of parse_options() is an important skill
> required to write a modern Git subcommand.

I was hoping that introducing very basics - this tool exists and
you're expected to use it - would lead to developers looking through
the code on their own to learn how. So the omission of more detail on
how to use it is intentional to avoid scope creep.

My thinking, throughout writing this tutorial, was to try to show
developers a glance into what they may need later. So examining a
single commit (but not more); examining a single option (but not
more); exposing the parse library (but not more). I can add a section
but I feel that demonstrating the existence of the tool is enough.

For now, I've replaced "if you like" with "if you want to explore
`parse_options` in more detail".

> > +----
> > +     struct option options[] = {
> > +             OPT_END()
> > +     };
> > +----
> > +
> > +Finally, before you print your args and prefix, add the call to
> > +`parse-options()`:
> > +
> > +----
> > +     argc = parse_options(argc, argv, prefix, options, psuh_usage, 0);
> > +----
> > +
> > +This call will modify your `argv` and `options` parameters. It will strip
> > +options you specified in `options` from `argv` and populate them in `options`
> > +instead, if they were provided.
>
> That is a misleading description.
>
> I am sure that in the right mental model used by users of the
> parse_options API, argv[] gets modified, but options[] array is
> constant.  It is just some entries in options[] have a pointer to
> locations they (i.e. the entries) request parse_options() call to
> update.  The options[] array, e.g. the entries that record these
> variables to be updated, stay the same.

Thanks. I've updated the description.

> > Be sure to replace your `argc` with the result
> > +from `parse_options`, or you will be confused if you try to parse argv later.
> > +
> > +It's worth noting the special argument `--`. As you may be aware, many Unix
> > +commands use `--` to indicate "end of named parameters" - all parameters after
> > +the `--` are interpreted merely as positional arguments. (This can be handy if
> > +you want to pass as a parameter something which would usually be interpreted as
> > +a flag.) `parse_options` will terminate parsing when it reaches `--` and give
> > +you the rest of the options afterwards, untouched.
> > +
> > +Build again. Now, when you run with -h, you should see your usage printed and
> > +your command terminated before anything else interesting happens. Great!
>
> If you had a separate section (because the first use in the tutorial
> of parse_options() that uses an empty options[] array is there only
> to use the psuh_usage usage string) that teaches the use of command
> line option, most of the above will move to that new section, and
> that may help making the result into easier-to-digest pieces.  How
> about adding "--user=<name>" command line option, which would override
> the user.name config setting your command is already reading at this
> step in the sequence?

I'll add a new section, unless I hear otherwise before I'm done writing it.

> > +
> > +Go ahead and commit this one, too.
> > +
> > +== Testing
> > +
> > +It's important to test your code - even for a little toy command like this one.
> > +Moreover, your patch won't be accepted into the Git tree without tests to
> > +demonstrate that it does what it's supposed to do. So let's add some tests.
>
> Tests are *NOT* added to demonstrate that it does what it's supposed
> to do.
>
> You add a test because you care about an externally visible
> behaviour you defined will *not* get broken by later changes
> (probably by others), by illustrating the behaviour of the feature
> and comparing it with what is expected.
>
> Secondary reason to add a test is to demonstrate that a feature does
> *not* kick in when it is not supposed to, but "Git contribution 101"
> students are probably not ready for that one.

I've replaced that claim with a bulleted list:

    Moreover, your patch won't be accepted into the Git tree without tests. Your
    tests should:
    * Illustrate the current behavior of the feature
    * Prove the current behavior matches the expected behavior
    * Ensure the externally-visible behavior isn't broken in later changes

> > +Related reading: `t/README`
> > +
> > +=== Overview of Testing Structure
> > +
> > +The tests in Git live in t/ and are named with a 4-decimal digit, according to
> > +the schema shown in the Naming Tests section of `t/README`.
> > +
> > +=== Writing Your Test
> > +
> > +Since this a toy command, let's go ahead and name the test with t9999. However,
> > +as many of the family/subcmd combinations are full, best practice seems to be
> > +to find a command close enough to the one you've added and share its naming
> > +space.
> > +
> > +Create your test script and mark it executable:
> > +
> > +----
> > +touch t/t9999-psuh-codelab.sh
> > +chmod +x t/t9999-psuh-codelab.sh
> > +----
> > +
> > +Begin with the header as so (see
> > +"Writing Tests" and "Source 'test-lib.sh'" in `t/README`):
> > +
> > +----
> > +#!/bin/sh
> > +
> > +test_description='git-psuh test
> > +
> > +This test runs git-psuh and makes sure it does not crash.'
> > +
> > +. ./test-lib.sh
> > +----
> > +
> > +Tests are framed inside of a `test_expect_success` in order to output TAP
> > +formatted results. Begin your first test and set up the repo to test in:
>
> Hmmm, I doubt the wisdom in that.  Almost all our tests can work in
> the default test repository.  Why should we show the exception to
> those who are beginning their first step with "hello world", risking
> the use of "rm -rf"?

Agreed; this was a misunderstanding on my part. In fact, I fixed my
sample code branch, but didn't fix the document.

>
> > +=== Sending a PR to GitGitGadget
> > +
> > +GitGitGadget is a tool created by Johannes Schindelin to make life as a Git
> > +contributor easier for those used to the GitHub PR workflow. It allows
> > +contributors to open pull requests against its mirror of the Git project, and
> > +does some magic to turn the PR into a set of emails and sent them out for you.
>
> s/sent them/send them/

Sure.  By the way, I'll be rolling the section before this about
making a personal fork into the GGG workflow, since below I didn't
mention running Travis with personal fork.
>
> > +== Sending Patches with `git send-email`
> > +
> > +There are a couple reasons you may not want to use GitGitGadget, such as needing
> > +to send an RFC patch, wanting to check your work before mailing, or not having a
> > +GitHub account. Luckily, you can use Git to mail your patches instead!
>
> Hmph, just for my education, is there anything in GGG that makes it
> unsuitable for an RFC/WIP?  It also is not clear to me what it does
> have to do with the ability to "check your work before mailing"; the
> proposed log message and the patch text can be polished even before
> you push to your GitHub repository, so ...

Specifically:

- You can't ask for a subject with [RFC PATCH], as demonstrated with
this very review in the previous iteration.
- You can't prepare a dry-run email or send your email to yourself for
a final checkup.

Personally, the latter for me is very scary :) What if GGG mangles my
patchset, which I am nervous to even send to all these smart Git
developers, and they all think it is my fault? Could be I am
projecting, but when I am very new to a project, I try to be very sure
the first review request is perfect.

> > +=== Preparing initial patchset
> > +
> > +Sending emails with Git is a two-part process; before you can prepare the emails
> > +themselves, you'll need to prepare the patches. Luckily, this is pretty simple:
> > +
> > +----
> > +git format-patch -o psuh/ master..psuh
> > +----
> > +
> > +The `-o psuh/` parameter tells `format-patch` to place the patch files into a
> > +directory. This is useful because `git send-email` can take a directory and
> > +send out all the patches from there.
>
> I'd rather not recommend the "send the whole directory contents"
> feature.  Instead, it is preferrable to do
>
>         git send-email psuh/0*.patch
>         git send-email psuh/v2-*.patch
>
> etc., using the same psuh/ directory as the output redirectory
> throughout the iterations.  That practice would primarily help you
> write the cover letters for later iterations while peeking at the
> ones you wrote for earlier iterations.

Good idea; I'll rework the instructions accordingly.

>
> > +`master..psuh` tells `format-patch` to generate patches for the difference
> > +between `master` and `psuh`. It will make one patch file per commit. After you
> > +run, you can go have a look at each of the patches with your favorite text
> > +editor and make sure everything looks alright; however, it's not recommended to
> > +make code fixups via the patch file. It's a better idea to make the change the
> > +normal way using `git rebase -i` or by adding a new commit than by modifying a
> > +patch.
> > +
> > +Check and make sure that your patches exist in the directory you specified -
> > +you're nearly ready to send out your review!
>
> OK.  I'll suggest using --cover-letter at this step, though.

Sure. I'll rework the whole section.

>
> > +=== Preparing email
> > +
> > +In addition to an email per patch, the Git community also expects your patches
> > +to come with a cover letter, typically with a subject line [PATCH 0/x] (where
> > +x is the number of patches you're sending).  You'll need to add some extra
> > +parameters when you invoke `git send-email` to add the cover letter.
>
> I am going to suggest getting rid of mention of the cover letter out
> of this section, and move it to the previous section.  Regardless of
> where the cover-letter is covered, I think we would want to say that
> a single-patch topic typically do not need a cover.

Sure, I'll be sure to mention.

>
> > +----
> > +git send-email \
> > +     --to=target@server.tld \
> > +     --from=me@server.tld \
> > +     --subject="[PATCH 0/7] adding the 'psuh' command" \
> > +     --compose \
> > +     psuh/
> > +----
>
> About this "--compose" thing later.  In short, I'd rather see the
> contributor prepare the cover next to the patch files when they run
> format-patch.
>
> > +
> > +The `--to` and `--from` fields are pretty obvious. `--subject` should indicate
> > +that it's a cover letter with the [PATCH 0/x] tag (check how many patches you
> > +are about to send so you can indicate the size of the thread correctly).
> > +`--compose` indicates that you want to open an editor to write the cover letter
> > + ...
> > +The argument to `--stat` bounds the column width of the output, which is handy
> > +as emails to Git shouldn't exceed 72 columns of width.
>
> Most of the above will become unnecessary if you tell format-patch
> to give you the cover template, I think.
>
> > +Here's an example of a cover letter for `git psuh`:
> > +
> > +----
> > +Our internal metrics indicate widespread interest in the command
> > +git-psuh - that is, many users are trying to use it, but finding it is
> > +unavailable, using some unknown workaround instead.
> > +
> > +The following handful of patches add the psuh command and implement some
> > +handy features on top of it.
> > +
> > +This patchset is part of the MyFirstContribution codelab and should not
> > +be merged.
> > +
> > + Documentation/git-psuh.txt | 40 +++++++++++++++++++
> > + Makefile                   |  1 +
> > + builtin.h                  |  1 +
> > + builtin/psuh.c             | 78 ++++++++++++++++++++++++++++++++++++++
> > + git.c                      |  1 +
> > + t/t9999-psuh-codelab.sh    | 12 ++++++
> > + 6 files changed, 133 insertions(+)
> > +----
> > +
> > +NOTE: When you've got a real change to send, you'll use `git@vger.kernel.org`
> > +in the `--to` field. For now, though, don't spam the list with the codelab -
> > +send it to yourself and check if it looks right.
> > +
> > +=== Sending email
> > +
> > +After you finish running the command above and editing your cover letter, you
> > +will be presented with an interactive prompt for each patch that's about to go
> > +out. This gives you one last chance to edit or quit sending something (but
> > +again, don't edit code this way). Once you press `y` or `a` at these prompts
> > +your emails will go out!
>
> I have a moderate aversion against the workflow to use the editor
> inside "git send-email" invocation.  The prompting that urges "now
> do this next" tends to make haste that is wastful.
>
> Your example at least prepares the patches in a separate step, so it
> is a bit better than running format-patch from within the send-email
> command, which is a small consolation but still...
>
> I'd rather see people trained to use "format-patch -o <topic>" to
> save the patch files and the cover letter template in a directory
> [*1*], which will give them a chance to write the cover letter in a
> separate editor session, and send the result out with a separate
> "git send-email <topic>/*.patch" or "git send-email <topic>/v2-*.patch"
> invocations, *AFTER* they have a chance to sleep on it.
>
>         Side note. *1* ... and keep it throughout iterations, so
>         "format-patch -v2 -o" will name the same output directory,
>         which will let you reuse material in the cover letter for
>         earlier iterations when you write the cover letter for the
>         latest iteration).
>

Thanks for all the tips. I didn't know much about using this tool;
I'll try it out on my own and rework the howto considering your
advice.

> > +
> > +Awesome, now the community will drop everything and review your changes. (Just
> > +kidding - be patient!)
> > +
> > +=== Applying Changes
>
> I am wondering if we want to retitle this to "responding to reviews".
>
> > +Once you do have some review comments, you should make changes if necessary, or
> > +push back on the changes by replying to the emails. (Make sure your mail client
>
> Responding that you understood what was suggested and explaining the
> reason why you do not take the suggestion (either you think your
> original is better for reason X, or you thought of a solution even
> better than your original or what was suggested) is of course good.
> But I often see people who do not respond when taking what was
> suggested and jump directly to sending the new iteration, which I
> think should be strongly discouraged.
>
> It is a better idea to respond to review comments whether you would
> take or reject the suggested changes.  Reviewers are busy, and when
> you silently take the suggestions and send v2 without responding to
> reviews on your v1, those who gave you valuable input are forced to
> read your v2 to see what you did to their suggestions.

Good point, especially outside of a GUI review environment like Gerrit
where you can easily diff v1 to v2.
This answers a question I had, too - whether it's rude to reply "Done"
to every nit :) I'll make an effort to be verbose on the list.

I'm going to try to reorganize and make a new section for this,
because the GGG and send-email sections both need mention of review
etiquette - I don't want to only mention it under send-email and be
left with rude GGG users, or vice versa. ;)

> > +has a plaintext email mode; the Git list rejects HTML email.) Please also follow
> > +the mailing list etiquette outlined in the
> > +https://kernel.googlesource.com/pub/scm/git/git/+/todo/MaintNotes[Maintainer's
> > +Note], which are similar to etiquette rules in most open source communities
> > +surrounding bottom-posting and inline replies.
> > +
> > +////
> > +TODO - mail list etiquette
> > +////

Deleting this section; stale TODO, as I linked the etiquette mentions
in the Maintainer's Note.

> > +
> > +You should apply changes using interactive rebase, or by adding new commits if
> > +the changes seem to require it.
> > +
> > +NOTE: Interactive rebase can be tricky; check out this handy
> > +https://www.oreilly.com/library/view/git-pocket-guide/9781449327507/ch10.html
> > +[overview] from O'Reilly.
> > +
> > +=== Sending v2
> > +
> > +When you're ready with the next iteration of your patch, the process is pretty
> > +much the same, with a few differences:
> > +
> > +* When you run `format-patch`, include the argument `-v2` to add a "v2" tag to
> > +the subject lins given.
>
> I think "lins" is a typo for "line", but I am not sure what "the
> subject line given" wants to say.
>
>     ... include the argument `-v2`.  This marks the patches as the
>     second iteration by prefixing their subject with "[PATCH v2]"
>     instead of "[PATCH]".
>
> perhaps?  I dunno.

Yeah, good suggestion, I've taken it close to verbatim.

>
> > +* When you run `send-email`, include the argument `--in-reply-to=<message-id>`
> > +with the Message-Id of the cover letter of the previous version. (You can find
> > +that Message-Id on https://public-inbox.org/git/.) Also, change the subject line
> > +on your cover letter to include "v2" to match the subjects of your patches.
> > +
> > +When it's time for v3 or beyond, simply change the number above, but make sure
> > +your v2 cover letter is in reply to your v1 cover letter, and your v3 cover
> > +letter is in reply to your v2 cover letter, and so on.
>
> A single-patch topic typically should not have a cover.  Saying "the
> first message of the previous round" instead of "the cover letter of
> the previous version" would cover the case as well as a multi-patch
> series with a cover letter.

I'll make mention of it while reworking this entire section.

>
> > +== Now What?
> > +
> > +The Git project has four integration branches: `pu`, `next`, `master`, and
> > +`maint`. Your change will be placed into `pu` fairly early on by the maintainer
> > +while it is still in the review process; from there, when it is ready for wider
> > +testing, it will be merged into `next`. Plenty of early testers use `next` and
> > +may report issues. Eventually, changes in `next` will make it to `master`,
> > +which is typically considered stable. Finally, when a new release is cut,
> > +`maint` is used to base bugfixes onto. As mentioned at the beginning of this
> > +document, you can read `Documents/SubmittingPatches` for some more info about
> > +the use of the various integration branches.
> > +
> > +Back to now: your code has been lauded by the upstream reviewers. It is perfect.
> > +It is ready to be accepted. You don't need to do anything else; the maintainer
> > +will pull your patchset into `next` and life is good.
>
> "pull" may not be a good verb to use in this project.  I would have
> written "the maintainer will merge your topic branch to 'next'" if I
> were doing this tutorial.

You're the one doing it, so I'm guessing you know best what you do
with the patches. :)

>
> > +However, if it isn't so perfect, once it is in `next`, you can no longer modify
> > +your commits in GitGitGadget or the email thread. Consider that review "closed
>
> If it isn't so perfect, the first thing the contributor can do that
> I as the maintainer woudl appreciate is to say "I've sent v4 of my
> series and you marked it for 'next', but I'd still want to fix up
> this and that in it; wait for v5 before merging" before it hits
> 'next'.
>
> Of course, no single contributor or reviewers (myself included) is
> perfect, so it often happens that further issues are noticed only
> after a topic hits 'next'.  But it's not like the merge to 'next' is
> point of no return---polishing can and do continue, but this time it
> is done incrementally.
>
> I'd replace "can no longer modify..." with something like "would
> switch to updating the topic incrementally, instead of redoing the
> topic wholesale".  You are still moving forward, helping to perfect
> the same topic, as opposed to be working on a separate topic that
> depends on it.
>
> Thanks.

I will try to rework this section to explain better when you can catch
something before it goes into `next`. This gives me a good opportunity
to mention the "What's Cooking" emails, too.

It seems like you're suggesting to add new patch(es) if a bug is found
when it's already merged to next, so I'll try to explain it that way.


Thanks again for the exhaustive review. I know it's a long patch, and
your comments are very helpful.
