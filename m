From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 3/3] commit: add a commit.verbose config variable
Date: Sat, 26 Mar 2016 23:34:49 -0400
Message-ID: <CAPig+cTBxH7BAs2M+PBwTHfVJvH0ADL1OSEKdHQY59L-WiYosA@mail.gmail.com>
References: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
	<01020153b478cfab-5309f834-7617-4a7f-a3e9-93f0dcf4a6be-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 05:35:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ak1Th-0008Ag-Lq
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 05:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbcC0Dew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2016 23:34:52 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36244 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645AbcC0Deu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2016 23:34:50 -0400
Received: by mail-vk0-f67.google.com with SMTP id z68so11538321vkg.3
        for <git@vger.kernel.org>; Sat, 26 Mar 2016 20:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=wVSTRM68mgfQsE8GU4wF6wRo2McZ9qODbwqzBYWu/RE=;
        b=X7Xn7hDcuA111Wm4ZZr6wYQUz9gPPVPh2rhf2PsyyylwlXneTyf6AofRJqz8nw9OUE
         BYMHE2PiY+ZZCzwAXkNiIWTr6osME+bX7/sea5VNGDEiX7GWjgn6t0ZNMv9ICfHf0KK9
         EfZoqW8hLf6yLj56OLeMEQmqebCU4HGtuQgxU7ivcuDvHchP97q3tH10DL99+vap6BlV
         Ds/2KNTuxWD0rNqZK4YT4H41lxYnvoWeULMiXIiGBZeLQBt2L7ukbITHOA6gTvl5KqBE
         ZS0k7XFkLksnDy47PKowwEsYXQv8Rz9yTu5bGBIzoxDatJggWQW8EsEjjBAffqJc8qPZ
         CKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=wVSTRM68mgfQsE8GU4wF6wRo2McZ9qODbwqzBYWu/RE=;
        b=hfViiIjMt9kQh5t2Ie0UaHY8QzbOo+9SmEGRCPvsB4kbGS0loWXQCJMpczq3mis+df
         QEr8kmNDlqhn4rYPoUTi6IX7Fcv2fWrIjlmWKd5fGcf+/lYWDvSgZUibjCidkmnywjOE
         W47KShWvtDdjmVyzLPpkZKIy8rrCTuoKVAi3nsVHP4x2/lo7UVcO5GhB3/kwaRJGIuCS
         wHLPymdakkI2qp4w2u+06slz+h2O+EmVMOXpZB2hBtuQ2OAlT4EHZ4j8cpcHl0yAGraU
         zZ5fh+aU4B0Dfp4mlPiq0NS4paDv8HJktmezNoqbZ+KOKOVDIwTObW5Ho4VpCDh0AdwY
         cfhA==
X-Gm-Message-State: AD7BkJLrJxQQvQ/24/t5U7q9OtMcqGxllfu1KWVrOoORK1WNzVxwKbvVPVXVbB7tK8xU7vVj4EUGhoIfOTBaFQ==
X-Received: by 10.159.33.206 with SMTP id 72mr4152102uac.14.1459049689826;
 Sat, 26 Mar 2016 20:34:49 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sat, 26 Mar 2016 20:34:49 -0700 (PDT)
In-Reply-To: <01020153b478cfab-5309f834-7617-4a7f-a3e9-93f0dcf4a6be-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: ILQeM4fXX2VllOaknXa6Hi_Saig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289993>

On Sat, Mar 26, 2016 at 3:48 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Add commit.verbose configuration variable as a convenience for those
> who always prefer --verbose taking care of multiple levels of verbosity.

What does "taking care of multiple levels of verbosity" mean? I
suppose you mean that commit.verbose specifies a verbosity level
(rather than being merely boolean), but that phrase is difficult to
decipher. And, since it's obvious from the patch itself that verbosity
is not a mere boolean, there isn't really a need to mention it here.
The commit message would be perfectly fine without that bit, so
perhaps just drop it.

> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>
> ---
> Changes with respect to the previous patch:
>  - Fixed a status related bug pointed out by SZEDER
>  - Change some tests

Please help reviewers out by being a bit more verbose when describing
the changes. For instance, what bug did you fix pointed out by SZEDER?
And, "change some tests" says nothing useful. What did you change in
the tests?

> ---
> diff --git a/builtin/commit.c b/builtin/commit.c
> @@ -1355,6 +1357,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>         finalize_colopts(&s.colopts, -1);
>         finalize_deferred_config(&s);
>
> +       if (verbose == -1)
> +               verbose = 0;
> +

Nit: It might be good to drop the blank line above this new
conditional to make it clear that it is part of the
init_config/parse_options processing (the tail of which is visible in
the context above).

>         handle_untracked_files_arg(&s);
>         if (show_ignored_in_status)
>                 s.show_ignored_files = 1;
> @@ -1654,6 +1664,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>         argc = parse_and_validate_options(argc, argv, builtin_commit_options,
>                                           builtin_commit_usage,
>                                           prefix, current_head, &s);
> +
> +       if (verbose == -1)
> +               verbose = (config_verbose == -1) ? 0 : config_verbose;
> +

Nit: For consistency, dropping the blank line above this new
conditional wouldn't hurt either.

>         if (dry_run)
>                 return dry_run_commit(argc, argv, prefix, current_head, &s);
>         index_file = prepare_index(argc, argv, prefix, current_head, 0);
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> @@ -101,4 +101,52 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
> +test_expect_success 'commit.verbose true and --verbose omitted' '
> +       echo content >file2 &&
> +       echo content >>file &&
> +       git add file2 &&
> +       git -c commit.verbose=true commit -F message &&
> +       test_line_count = 1 out
> +'

Why is this test so utterly different than it was in v9 (even though
the title is the same), and why is it so different from other tests
below?

More below...

> +test_expect_success 'commit.verbose true and --verbose' '
> +       git -c commit.verbose=true commit --amend --verbose &&
> +       test_line_count = 1 out
> +'
> +
> +test_expect_success 'commit.verbose true and -v -v' '
> +       git -c commit.verbose=true commit --amend -v -v &&
> +       test_line_count = 2 out
> +'
> +
> +test_expect_success 'commit.verbose true and --no-verbose' '
> +       git -c commit.verbose=true commit --amend --no-verbose &&
> +       ! test -s out
> +'
> +
> +test_expect_success 'commit.verbose false and --verbose' '
> +       git -c commit.verbose=false commit --amend --verbose &&
> +       test_line_count = 1 out
> +'
> +
> +test_expect_success 'commit.verbose false and -v -v' '
> +       git -c commit.verbose=false commit --amend -v -v &&
> +       test_line_count = 2 out
> +'
> +
> +test_expect_success 'commit.verbose false and --verbose omitted' '
> +       git -c commit.verbose=false commit --amend &&
> +       ! test -s out
> +'
> +
> +test_expect_success 'commit.verbose false and --no-verbose' '
> +       git -c commit.verbose=false commit --amend --no-verbose &&
> +       ! test -s out
> +'
> +
> +test_expect_success 'status ignores commit.verbose=true' '
> +       git -c commit.verbose=true status >actual &&
> +       ! grep "^diff --git" actual
> +'

The fact that v9 broke a number of tests in other scripts which use
git-status (as SZEDER pointed out[1]), due to initializing 'verbose'
to -1 in builtin/commit.c, suggests that you probably ought to add
another test here to protect against that sort of breakage, as well.
Specifically, git-status should remain non-verbose when neither
commit.verbose nor --verbose is specified.

> +
>  test_done
