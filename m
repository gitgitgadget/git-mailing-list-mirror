Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D6D11F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfAWUvp (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:51:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37132 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfAWUvo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:51:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so4104457wrt.4
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=D2TMKBOeNn1hM+KKch7g7fmk1hEfoaa61sO2ELwkto4=;
        b=lzGnay7yg2iwJF5oaxgO53LElJ1//BGD1bQYrU5+p/HIcpudeqgaP9pHhOvzpyFekD
         1miRN6ArJHFVX2RpoDZB3bp0L4gY1iP5AlNfImp7r44TRmOXv7Ot2zIPIipBgNJnIh/N
         JZTER1BWBDk5O8NqPmVWp60MXhwZazVxWePxGH+C4a1N/08qQn6uzHVqeoACMzi++Kgc
         ZLvG4EjugDQaVdF1piEj1I4D4RRzLmMZviK7n9YN51nBdIdQfC3TSFplTNaxBdpmwdim
         wLcFRXEf1cU9yTgQSCzhxz2P8iltEjFx/dJz/XpMWetUMmQgZqVG960dRWLSWb6bmZRI
         1gJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=D2TMKBOeNn1hM+KKch7g7fmk1hEfoaa61sO2ELwkto4=;
        b=n9tNJ1RQw+KtQ6YTQ4yn0FIfqBG/DBcGZA9Uhrn/OlnsgqnSsG8sW5YdLnGYCjXp1Z
         y+7/q4fo8DVrdXTH5qoBNZz30zCgKcIGBKOQeYuJm50cTbQak6L9lWgELwWF+sz9cU32
         zd3owP6JqJJLX/K6jBNJxrRq+pSypbGdbnwaWUXSSilf510xbt72Yo6rqXfkyCAwQJrg
         /oA30ZL145FidKcWzslPKX9IDluxpcWYgKVXjfeqz5H//jbGNllk37QwqcinAYOVL6EX
         BQ9Ge2+nsyw6WqLO5kxbfvEH9rSd2bkM3jh4r55puVVRdq2Zgu4AxyjaFIoQO61fC3Uz
         /AuQ==
X-Gm-Message-State: AJcUukda/bKuTLvc2WG1NsVOl1CzcVENFCYWgk7URUFmzvoIVfnaTQ+q
        vSk956IIjFqSTR8tnYLubZDBbyO5
X-Google-Smtp-Source: ALg8bN7ZbQEGL7I4eEWfQx28sKKqWoM3T3Ytjm29CLzO5OFcx2FWhB3AFoSZxcfOpWhulc7NqTOqwA==
X-Received: by 2002:adf:bb8d:: with SMTP id q13mr4257983wrg.183.1548276701124;
        Wed, 23 Jan 2019 12:51:41 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 10sm71801870wmy.40.2019.01.23.12.51.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 12:51:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com
Subject: Re: [PATCH 01/14] trace2: Documentation/technical/api-trace2.txt
References: <pull.108.git.gitgitgadget@gmail.com>
        <1a90de9dab0dd836e54fee9e08ab9e2284e1027a.1548192131.git.gitgitgadget@gmail.com>
Date:   Wed, 23 Jan 2019 12:51:40 -0800
In-Reply-To: <1a90de9dab0dd836e54fee9e08ab9e2284e1027a.1548192131.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Tue, 22 Jan 2019
        13:22:12 -0800 (PST)")
Message-ID: <xmqqbm47ayhv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +These high-level events are written to one or more Trace2 Targets
> +in a target-specific format.  Each Trace2 Target defines a different
> +purpose-specific view onto the event data stream.  In this mannor,

"In this manner"

> +a single set of Trace2 API event calls in the Git source can drive
> +different types of analysis.
> +
> ...
> +$ cat ~/log.perf
> +12:28:42.620675 common-main.c:38                  | d0 | main                     | version      |     |           |           |            | 2.20.1.155.g426c96fcdb
> +12:28:42.621001 common-main.c:39                  | d0 | main                     | start        |     |           |           |            | git version
> +12:28:42.621111 git.c:432                         | d0 | main                     | cmd_verb     |     |           |           |            | version (version)
> +12:28:42.621225 git.c:662                         | d0 | main                     | exit         |     |  0.001227 |           |            | code:0
> +12:28:42.621259 trace2/tr2_tgt_perf.c:211         | d0 | main                     | atexit       |     |  0.001265 |           |            | code:0
> +------------
> ...
> +
> +trace2_def_param(...)

Not limited to this single one, but please either

 - omit "..." in parens, unless all of these functions take varargs
   of unspecified type (which I do not think is the case), or

 - write a proper prototype for these functions, explain what the
   function itself and what the parameters are for.

I'll complain about lack of info around here later X-<.

> +trace2_def_repo(...)

> +----------------
> +
> +Git Child Process Events::
> +
> +	These are concerned with the various spawned child processes,
> +	including sub-git processes and hooks,
> ++
> +----------------
> +trace2_child_start(...)
> +trace2_child_exit(...)
> +
> +trace2_exec(...)
> +trace2_exec_result(...)
> +----------------
> +
> +Git Thread Events::
> +
> +	These are concerned with Git thread usage.
> ++
> +----------------
> +trace2_thread_start(...)
> +trace2_thread_exit(...)
> +----------------

Lack of _wait()/_join() feels a bit curious, but _exit() from what
is being waited would suffice as a substitute.

> +Initialization::
> +
> +	Initialization happens in `main()`.  The initialization code
> +	determines which, if any, Trace2 Targets should be enabled and
> +	emits the `version`, `start`, and `exit` events.  It causes an
> +	`atexit` function and `signal` handler to be registered that
> +	will emit `atexit` and `signal` events.
> ++
> +----------------
> +int main(int argc, const char **argv)
> +{
> +	int exit_code;
> +
> +	trace2_initialize();
> +	trace2_cmd_start(argv);

Nobody other than trace2 integration would make a call to this
helper, so it may not matter, but sending av alone without ac, even
though ac is almost always redundant, feels somewhat unexpected.

> +Command Details::
> +
> +	After the basics are established, additional process
> +	information can be sent to Trace2 as it is discovered, such as
> +	the command verb, alias expansion, interesting config
> +	settings, the repository worktree, error messages, and etc.
> ++
> +----------------
> +int cmd_checkout(int argc, const char **argv)
> +{
> +	// emit a single "def_param" event
> +	trace2_def_param("core.editor", "emacs");

Without knowing what "def_param event" is, this example is hard to
fathom.  At this point in the doc, the reader does not even know
what "def" stands for.  Is this call to define a param called
core.editor?  Is it reporting that the default value for core.editor
is emacs?

> +	// emit def_params for any config setting matching a pattern
> +	// in GIT_TR2_CONFIG_PARAMS.
> +	trace2_cmd_list_config();

As the reader does not know what def_param is, this is also hard to
follow.

> +	trace2_cmd_verb("checkout");
> +	trace2_cmd_subverb("branch");

These are guessable.  It probably reports what the codepath is
doing.

> +	trace2_def_repo(the_repository);

Again, this is not easy to guess.  Is it reporting what the default
repository is?

> +	if (do_something(...))
> +	    trace2_cmd_error("Path '%s': cannot do something", path);

This is guessable, which is good.

> +void run_child(...)
> +{
> +	int child_exit_code;
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +	...
> +
> +	trace2_child_start(&cmd);
> +	child_exit_code = ...();
> +	trace2_child_exit(&cmd, child_exit_code);

Even though child_exit() has not been explained just like
def_param(), this is far more guessable.  I wonder why it is.  The
name of the variable passed to it in the example certainly helps, as
it is totally unclear where the string constant "emacs" in the
earlier example came from (e.g. is it hardcoded in the program?  is
it merely illustrating "here is how you report the value you have
decided to use for 'core.editor' variable"?).

> ...
> +$ cat ~/log.perf
> +d0 | main                     | version      |     |           |           |            | 2.20.1.160.g5676107ecd.dirty
> +d0 | main                     | start        |     |           |           |            | git status
> +d0 | main                     | def_repo     | r1  |           |           |            | worktree:/Users/jeffhost/work/gfw
> +d0 | main                     | cmd_verb     |     |           |           |            | status (status)
> +...
> +d0 | main                     | region_enter | r1  |  0.010988 |           | status     | label:worktrees

It is hard to guess what "d0" and "r1" stand for here.  

In an earlier example we also saw an unexplained "d0" there, which I
think was OK because the illustration was merely to give the "feel"
of the format up there.  But now we are giving a bit more detailed
explanation, we probably would want to at least briefly mention what
each column means.

I'd stop here for now, as I am more interested in reading the code
;-)

