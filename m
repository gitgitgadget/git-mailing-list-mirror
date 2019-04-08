Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76F3420248
	for <e@80x24.org>; Mon,  8 Apr 2019 07:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfDHHvz (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 03:51:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51303 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfDHHvz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 03:51:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so13104143wmf.1
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 00:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RkKNikBospj228E7jTM0dFOHITJ3QyCcyyK4KHo883U=;
        b=dBqK/m8LM7VW7+M5oMkuEWwtf/D1AW773l85e9+EsoRpTNfcCyKOsyOi0ChkLuNxbz
         7AjjNIg6OHZ6hJbYa2GKMENHhkFJuFEWpPwrjP1gu/V2neChm6d2ndjRDqJkOCGBxc7D
         9KlUBJjL/TzAWZethtAEHizuoYHgA36dHJ1N71QkZQQTnsV6AiporYhDLFjTm+gSyRF3
         PhJnrMWOPNhfbs1I9IAFnkY81nlVrJ9QtNeSYBjbEXWkCFAIk4ZhNVCPweGxgtQ/dLNv
         PVgw7lTQ713U6pvLPiONKl/1bmIvKzQeHfO5ZK69NJJZQqHVBNpqmJfKXECSWDpNn8zS
         jh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RkKNikBospj228E7jTM0dFOHITJ3QyCcyyK4KHo883U=;
        b=h4+grmL0duTGTRxTmKGfV1Qt/0cRuFrTmYEH8Rxw0YkY+OEr+9h7wPwizK6gbaBrfE
         FRRI/VP2yBuOJamZBsI/9eCREGFT+WHsWlvNobz2T+bHsZpMLumKdU0P3siX1ZPzM+0s
         8Rh7NYPstfhuKYkbgKhrMwNmBixSmef6f8dyA6MqR0O765B+06aW4nx9wkgQtdiSf9ga
         KGLpuqGzd9nmoF0EccJia9PWpHvPB5FhjGZdoeoEFVwyf9boJueJXEzXIg5XWEsP3gB8
         FryYbD9R5v/pR7tZm4xx4SvRUnqqglHFXifaSQ98RkT0q9BKuQcrKsRx6DkCl1QUypNI
         Fj7g==
X-Gm-Message-State: APjAAAWqjjcM3mtynQL+paL7u3o8nXoNA4BcB9dGXpLpcHi1z8O7mwZ1
        mS1wPxFU17z9ffu++VVOgU5G/yZM/20=
X-Google-Smtp-Source: APXvYqyoA7hWcDDbyRkKBguOGgxyY0hiGjFbTixqYcBmwzmFA6XBWcL1EKffRDWahLFQyf9SAfty6A==
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr15388964wmg.56.1554709912572;
        Mon, 08 Apr 2019 00:51:52 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id j3sm70037961wre.51.2019.04.08.00.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 00:51:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Dr. Adam Nielsen" <admin@in-ici.net>
Cc:     git@vger.kernel.org, "Adam J . N . Nielsen" <info@drnielsen.de>
Subject: Re: [PATCH/docs] make slash-rules more readable
References: <20190405200045.10063-1-admin@in-ici.net>
Date:   Mon, 08 Apr 2019 16:51:50 +0900
In-Reply-To: <20190405200045.10063-1-admin@in-ici.net> (Adam Nielsen's message
        of "Fri, 5 Apr 2019 22:00:45 +0200")
Message-ID: <xmqqftqt7x49.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Dr. Adam Nielsen" <admin@in-ici.net> writes:

A few notes on the form.

> From: Adam Nielsen <admin@in-ici.net>

This "author" identity and the name-email on the Signed-off-by: line
should match, at least for this project.  I cannot tell which one is
your preference, and I do not have any preference over your name
either ;-), but please pick one and use it consistently.

>
> gitignore.txt: make slash-rules more readable
>
> Remove the addition `it is removed for the purpose of the following description` and 
> make clear in which situations a trailing slash is used or not. Increase readability
> and make all paragraphs valid, even if they are not read in strict order.
> Replace `otherwise` with the the concrete pattern that is considered in the paragraph to avoid
> confusion. 
> Add simple examples to point out the significant difference between using or not using a trailing slash.

These are overly long lines; we tend to fold long lines at around
70 char or so.

> Signed-off-by: Adam J. N. Nielsen <info@drnielsen.de>
>
> ---
>  Documentation/gitignore.txt | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index 1c94f08ff4..c6720b0ac4 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -89,22 +89,25 @@ PATTERN FORMAT
>     Put a backslash ("`\`") in front of the first "`!`" for patterns
>     that begin with a literal "`!`", for example, "`\!important!.txt`".
>  
> - - If the pattern ends with a slash, it is removed for the
> -   purpose of the following description, but it would only find
> + - If the pattern ends with a slash "`/`", it would only find
>     a match with a directory.  In other words, `foo/` will match a
>     directory `foo` and paths underneath it, but will not match a
>     regular file or a symbolic link `foo` (this is consistent
>     with the way how pathspec works in general in Git).

I do like this change, even though I cannot bring myself backing it
100% immediately.  The reason why I wrote it the way in the original
was because I did not want to repeat "... but a slash at end, if
exists, is exempt from this rule" over and over in the later bullet
points, as it would be a maintenance burden when we have more bullet
points and when we find a better phrasing to say "... but a slash at
end if exists, is exempt from this rule".

The patch I am responding to bites the bullet and repeats the "the
one at the end does not count", which may be slightly harder to
maintain, but certainly makes it easier to read.

> - - If the pattern does not contain a slash '/', Git treats it as
> -   a shell glob pattern and checks for a match against the
> -   pathname relative to the location of the `.gitignore` file
> -   (relative to the toplevel of the work tree if not from a
> -   `.gitignore` file).
> + - If the pattern contains no slash "`/`" other then a trailing slash,

While pretending to be a fresh reader and reading only this line
made me wonder if the rule described in this bullet point applies
only to a pattern that has a single slash at the end.  I wonder if
it is just me, or we can improve the phrasing so that it is clear
that a pattern without any slash also is covered by this rule, not
just a pattern that has all non-slash chars followed by a single
slash.

> +   then the pattern will match in all directories. In other words,
> +   `foo/` will match `/bar/foo/` and `foo` will match `/bar/bar/foo`.

The half-technical "treats it as a shell glob pattern" from the
original is gone, which I think is a good change.  The examples may
need to be improved, as it may not be clear to naive readers that
with /bar/foo/, you meant that it is limited to a directory but not
a file, and with /bar/bar/foo you meant both a directory and a file
is fine.  Perhaps

	For example, 'frotz/' matches 'frotz', 'a/frotz', etc. that
	is a directory, but does not match if these are files.
	A pattern 'frotz' on the other hand matches these paths
	whether they are files or directories.

I also wonder if "in all directories" is clear enough that your
"all" is limited to below the level the ignore pattern is defined
for (i.e. "*.1" that appears in "Documentation/.gitignore" does not
ignore "foo.1" at the top-level of the tree).

So I can tell that this patch is trying to address a problem in the
original that is worth fixing, but I cannot say the result is good.
At least not yet.

> - - Otherwise, Git treats the pattern as a shell glob: "`*`" matches
> -   anything except "`/`", "`?`" matches any one character except "`/`"
> -   and "`[]`" matches one character in a selected range. See
> + - If the pattern contains a slash "`/`" other then a trailing slash, then

The same comment applies to this first line about the ambiguity of a
pattern without any slash anywhere.

> +   the pattern is always considered from the `.gitignore` file location.
> +   In other words, `foo/bar` will match `/foo/bar` but not `/bar/foo/bar`.

Again, loss of the mention of "shell glob" is a good thing, as we
still have a clue for those "in the know" at the end by mentioning
fnmatch(3).

The example lacks one crucial description to be useful.  The reader
must be told where foo/bar came from.  Was it in the .gitignore file
at the top-level?  A per-directory exclude file bar/.gitignore?
Without making that clear, none of the "In other words" example
makes much sense.

Also another issue common to previous example is that you are using
absolute path notation "/bar/foo/", "/bar/foo/bar", etc. without
explaining what you want it mean.  I can guess that it does not
refer to the root of the filesystem but you meant to refer to the
top level of the working tree, but you are not writing documentation
to help _me_ understand Git, so we should not rely on that "I can
guess".  I do not think an average first-time reader can.

> + - The character "`*`" matches anything except a non trailing slash "`/`".
> +   For example, "foo/*" matches "foo/test.json" and "foo/bar/"
> +   but not "foo/bar/test.json".

I think your writing out the trailing slash on the filesystem-entity
side (i.e. things that are matched by patterns) is making the
resulting description more distracting than necessary.  Being able
to mark a pattern with a trailing slash to "match only to directory"
is one thing, but when the example talks about paths foo/test.json
(presumably a regular file and not a directory) and foo/bar
(presumably a directory), it shouldn't force users to mistakenly
think that the matching engine first appends a slash after a
directory we read from the filesystem before applying the pattern
matching logic, which has a compensating hack to ignore trailing
slash from the path when matching.

Once you write consistently that a path for a directory foo/bar is
foo/bar, not foo/bar/, then this example would become much easier to
write and read, I suspect.

	An asterisk "`*`" matches anything except a slash.  A
	pattern "foo/*", for example, matches "foo/test.json" (a
	regular file), "foo/bar" (a diretory), but it does not match
	"foo/bar/hello.c" (a regular file), as the asterisk in the
	patter does not match "bar/hello.c" which has a slash in it.

perhaps.

> +   The character "`?`" matches any one character except "`/`".
> +   The character "`[]`" matches one character in a selected range. See

Calling `[]` construct "the character" is blatantly wrong.

	The range notation, e.g. `[a-zA-Z]`, can be used to match
	one of the characters in a range.

perhaps.  It still omits negation [!0-9] but it probably is OK to
leave that for fnmatch(3), and you've done so by leaving these two
lines from the original intact, which is good.

>     fnmatch(3) and the FNM_PATHNAME flag for a more detailed
>     description.


Thanks.
