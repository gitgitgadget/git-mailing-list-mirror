Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50FB020248
	for <e@80x24.org>; Sun, 21 Apr 2019 10:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfDUKwV (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 06:52:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56232 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfDUKwV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 06:52:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id o25so11220138wmf.5
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 03:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QOXbrx5Sty5s7KF+bK8JOFfjpjRPdamr+Rc1+yQvF68=;
        b=ZpPSwjLae3eK9aktT05vf/TW0QPwER3w+nDhvztbu5HjIqnJl/Ma/QmDr19CH3pjIB
         yDxt8+qOuMN9X063uV5Y3h0zzYilOOU9RE2KLO3nQUcHwPZDErjGTSBVb8RmufM50NTh
         izO3xb5fu/Ewc0I4spPWy6dsJH/z1rbqxk4MnGhs8r/OMQ3dCHILbVIDylyoue4Vwt3W
         VwZZB3EtjGZJEDaQNRk0Gj371FOlJ0Pm7Fyrs3VKDSBI8KcZoXQ1RNHvOj1NvKLweDL/
         0Zy7p4QMcvtDJhHYNUD1YHow6DPSlGIk2apOtfgsF5Oz/+TV7GoXYYPjgUCOQLZSZkU4
         lSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QOXbrx5Sty5s7KF+bK8JOFfjpjRPdamr+Rc1+yQvF68=;
        b=PZnUrnRR/bfo5+2LaJfr8BMgfwoT8AlJm8wY9XPoquz6yUzE+G9WvooPmU0dKfcvOP
         ZMFz/PrRsS/P9nss59OiX2OsOAJtP6HmXh2j2QVUhFNKFresQakEtvwfllUS1nDq3UAl
         oDS/z3mhWH75JrD1blUV+es3qM96+yR93U+ZzXOcohuSWA+ljhImS6C37xjLwJCWyEwc
         b/rwKxblm0GBJ5xUbkv11LC5rRYscr1SyBkJEw/42T6szbN98nkvfmeHTuosY8UU/MtN
         SDKvJWmE/4lY+6GAlHTAlIT0ie/fquFmalPCqNW1E6hm+lEZXjOeLFqXSnRYg/24CqNw
         GTOw==
X-Gm-Message-State: APjAAAXYqm3pRizaW4Cb8HlM5n6XOrVjaTtYOthCr7OSJCVUp/fiLm/g
        rer0khbBrhhbwePVUYIVu88=
X-Google-Smtp-Source: APXvYqz16Kl/CVYSwd2przxzhaM/aCYAPmwuMIV5f32VBT+SVVUkD4bfdvEgnFWkXQj5KVKjHTX7/g==
X-Received: by 2002:a1c:d1c5:: with SMTP id i188mr8717918wmg.8.1555843938896;
        Sun, 21 Apr 2019 03:52:18 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id n18sm5371206wrt.16.2019.04.21.03.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 03:52:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] documentation: add lab for first contribution
References: <20190419165709.123502-1-emilyshaffer@google.com>
Date:   Sun, 21 Apr 2019 19:52:17 +0900
In-Reply-To: <20190419165709.123502-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Fri, 19 Apr 2019 09:57:09 -0700")
Message-ID: <xmqqr29vbpge.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> This tutorial covers how to add a new command to Git and, in the
> process, everything from cloning git/git to getting reviewed on the
> mailing list. It's meant for new contributors to go through
> interactively, learning the techniques generally used by the git/git
> development community.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---

I think a stray "lab" remains in the title of the patch.  They seem
to have disappeared from all the other places, and "tutorial" is
consistently used, which is good.

My eyes have lost freshness on this topic, so my review tonight is
bound to be (much) less thorough than the previous round.

> +- `Documentation/SubmittingPatches`
> +- `Documentation/howto/new-command.txt`

Good (relative to the earlier one, these are set in monospace).

> +
> +== Getting Started
> +
> +=== Pull the Git codebase
> +
> +Git is mirrored in a number of locations. https://git-scm.com/downloads

Perhaps URLs should also be set in monospace?

> +NOTE: When you are developing the Git project, it's preferred that you use the
> +`DEVELOPER flag`; if there's some reason it doesn't work for you, you can turn

I do not think you want to set 'flag' in monospace, too.
i.e. s| flag`|` flag|;

> +This commit message is intentionally formatted to 72 columns per line,
> +starts with a single line as "commit message subject" that is written as
> +if to command the codebase to do something (add this, teach a command
> +that). The body of the message is designed to add information about the
> +commit that is not readily deduced from reading the associated diff,
> +such as answering the question "why?".

Nicely written.

> +	git_config(git_default_config, NULL)
> +	if (git_config_get_string_const("user.name", &cfg_name) > 0)
> +	{
> +		printf(_("No name is found in config\n"));
> +	}
> +	else
> +	{
> +		printf(_("Your name: %s\n"), cfg_name);
> +	}

Style.  Opening braces "{" for control structures are never be on
its own line, and else comes on the same line as closing "}" of if,
i.e.

	if (...) {
		print ...
	} else {
		print ...
	}

Or just get rid of braces if you are not going to extend one (or
both) of if/else blocks into multi-statement blocks.

> +----
> +
> +`git_config()` will grab the configuration from config files known to Git and
> +apply standard precedence rules. `git_config_get_string_const()` will look up
> +a specific key ("user.name") and give you the value. There are a number of
> +single-key lookup functions like this one; you can see them all (and more info
> +about how to use `git_config()`) in `Documentation/technical/api-config.txt`.
> +
> +You should see that the name printed matches the one you see when you run:
> +
> +----
> +$ git config --get user.name
> +----
> +
> +Great! Now we know how to check for values in the Git config. Let's commit this
> +too, so we don't lose our progress.
> +
> +----
> +$ git add builtin/psuh.c
> +$ git commit -sm "psuh: show parameters & config opts"
> +----
> +
> +NOTE: Again, the above is for sake of brevity in this tutorial. In a real change
> +you should not use `-m` but instead use the editor to write a verbose message.

We never encourge people to write irrelevant things or obvious
things that do not have to be said.  But a single-liner message
rarely is sufficient to convey "what motivated the change, and why
the change is done in the way seen in the patch" in a meaningful
way.

i.e. s|verbose|meaningful|;

> +Create your test script and mark it executable:
> +
> +----
> +$ touch t/t9999-psuh-tutorial.sh
> +$ chmod +x t/t9999-psuh-tutorial.sh
> +----

I never "create an empty file" before editing in real life.  Is this
a common workflow in some circles?

I'd be tempted to suggest s/touch/edit/ here, but I dunno.

> +https://public-inbox.org/git/foo.12345.author@example.com/other/junk
> +----
> +
> +Your Message-Id is `foo.12345.author@example.com`. This example will be used

Technically, <foo.12345.author@example.com> with angle bracket is
the message Id, but the tool is lenient to allow this common mistake
;-) so this one, and the "send-email --in-reply-to=" example below
can stay as-is.

> +below as well; make sure to replace it with the correct Message-Id for your
> +**previous cover letter** - that is, if you're sending v2, use the Message-Id
> +from v1; if you're sending v3, use the Message-Id from v2.
> +
> +Now send the emails again, paying close attention to which messages you pass in
> +to the command:
> +
> +----
> +$ git send-email --to=target@example.com
> +		 --in-reply-to=foo.12345.author@example.com
> +----
> +
> +=== Bonus Chapter: One-Patch Changes
> +
> +In some cases, your very small change may consist of only one patch. When that
> +happens, you only need to send one email. Your commit message should already be
> +verbose, but if you need to supply even more context, you can do so below the

s|be verbose|explain what and why of the change well| or something
like that?

> +`---` in your patch. Take the example below, generated with `git format-patch`
> +on a single commit:
