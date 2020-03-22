Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BCFC1975A
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 23:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF57120736
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 23:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uBIS2NF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgCVXiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 19:38:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55533 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgCVXiN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 19:38:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA4FE52270;
        Sun, 22 Mar 2020 19:38:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4AtWgL/rC9rPuFfRY8iOoQEl8UI=; b=uBIS2N
        F1mxjnn59Z86B1lUXF5h84VCkYyVVSeYMpJXveoIogHZRnIMCgxPD0LUk9QCY/iG
        /b0i3ekoL9SgrnSM0NPcVm3UEZTi7svGAiZxZ/NFchxM2EXza8iKr54AwPIpiO4G
        w1EsP/6JavxpzPcBERts7XkcxccqDDaYg3buc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wt0pnqEGbNTzggdt1acVTO6JtZJkeOOB
        SA29ep0OdvR1Vhu2Dm+hX3qXQkab15Gb40zVvigHsIfL3/RuLuhulyIZ0Xj9zDTB
        hFu3pQ1MPjOf9jXwRcJYudqBtN2x4j2QR71FjQz8EGPYk7IXNERQoESCyghBTbmU
        HdP/GyGjV9I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D37C85226F;
        Sun, 22 Mar 2020 19:38:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6137F5226C;
        Sun, 22 Mar 2020 19:38:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     sheikh hamza <sheikhhamza012@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC] cache.h: change READ_GITFILE_ERR constants group to enum
References: <sheikhhamza012@gmail.com>
        <1584898493-27180-1-git-send-email-sheikhhamza012@gmail.com>
Date:   Sun, 22 Mar 2020 16:38:08 -0700
In-Reply-To: <1584898493-27180-1-git-send-email-sheikhhamza012@gmail.com>
        (sheikh hamza's message of "Sun, 22 Mar 2020 22:34:53 +0500")
Message-ID: <xmqqv9mw6jvj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FFC079C-6C96-11EA-AE38-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sheikh hamza <sheikhhamza012@gmail.com> writes:

> From:   sheikh hamza <sheikhhamza012@gmail.com>

Please make sure that the "your name <address>" on your From: header
matches what you write on the Signed-off-by: trailer.

> this patch is my microproject for the GSoC i converted
> the group of constants in cache.h on line 573 to an enum
> named read_gitfile_err to follow newer coding convension
> i intend to contribute as much to git as i can and this is
> my initial contribution i hope to get guidance for future
> contribution. i would be working on the GSoC proposal any
> help would be appreciated, Thank you

Almost nothing in the above paragraph explains what this patch is
about and why we should consider updating our code with it.

It would be a good background story that can be told below the
three-dash line, though.

The body of the log message is where you explain what the change is
about and justify why the change is a good idea.  Both preprocessor
macros (that is what these things are called; "constants" could mean
"const int READ_GIFILE_ERR_STAT_FAILED = 1;" so avoid using the word
to refer to them) and enums can be used to make the code more
descriptive, so the code that processes the error code, e.g.

	int err;
	const char *path = read_gitfile_gently(git, &err);
        if (err == 7)
		die("not a repository: '%s'", git);

can become more readable by using READ_GITFILE_ERR_NOT_A_REPO
instead of a magic constant "7".  But they help readability the same
way, so that is not a justification to change preprocessor macro to
enum.

One reason why folks prefer enum over preprocessor macro is because
some debuggers can show enum values symbolically, while macros are
not even seen by the debuggers.  For example:

	enum read_gitfile_err err;
	const char *path = read_gitfile_gently(git, &err);

	printf("the first letter is '%c'\n", path[0]);

would segfault while attempting to call the printf(), when
read_gitfile_gently() finds an error and returns NULL.  In such a
case, a debugger that knows about the type of variable 'err' can
show you READ_GITFILE_ERR_NOT_A_REPO instead of 7 when you say
"print err".

I suspect however that this benefit is only possible when the type
of err is known to be a particular enum.  Note that I updated the
type of 'err' in the second example, but you could have left the
variable as "int" and it would have been perfectly valid C, but I do
not think a debugger can infer that what is in err is one of the
values taken from "enum read_gitfile_err".

So, I suspect that this patch alone does not give us the potential
"it helps the debugger" benefit, either.  The callsites of this
function that currently pass a pointer to a variable of type "int"
need to be updated if we want to use it as the justification.

So does the type of the latter parameter of read_gitfile_gently()
function need to change, I think.

> Signed-off-by: Muhammad Hamza <sheikhhamza012@gmail.com>
> ---
>  cache.h | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 37c899b..6aae035 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -570,14 +570,17 @@ static inline enum object_type object_type(unsigned int mode)
>   */
>  int is_nonbare_repository_dir(struct strbuf *path);
>  
> -#define READ_GITFILE_ERR_STAT_FAILED 1
> -#define READ_GITFILE_ERR_NOT_A_FILE 2
> -#define READ_GITFILE_ERR_OPEN_FAILED 3
> -#define READ_GITFILE_ERR_READ_FAILED 4
> -#define READ_GITFILE_ERR_INVALID_FORMAT 5
> -#define READ_GITFILE_ERR_NO_PATH 6
> -#define READ_GITFILE_ERR_NOT_A_REPO 7
> -#define READ_GITFILE_ERR_TOO_LARGE 8
> +enum read_gitfile_err {
> +	READ_GITFILE_ERR_STAT_FAILED = 1,
> +	READ_GITFILE_ERR_NOT_A_FILE = 2,
> +	READ_GITFILE_ERR_OPEN_FAILED = 3,
> +	READ_GITFILE_ERR_READ_FAILED = 4,
> +	READ_GITFILE_ERR_INVALID_FORMAT = 5,
> +	READ_GITFILE_ERR_NO_PATH = 6,
> +	READ_GITFILE_ERR_NOT_A_REPO = 7,
> +	READ_GITFILE_ERR_TOO_LARGE = 8,
> +};
> +
>  void read_gitfile_error_die(int error_code, const char *path, const char *dir);
>  const char *read_gitfile_gently(const char *path, int *return_error_code);
>  #define read_gitfile(path) read_gitfile_gently((path), NULL)
