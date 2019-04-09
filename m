Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6CBF20248
	for <e@80x24.org>; Tue,  9 Apr 2019 16:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfDIQVk (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:21:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33026 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIQVk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:21:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so21736564wrp.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l+BAbIwnyfvnT6fp7WgINwQCzuXGSGAMbnHp8IA8OHY=;
        b=Ca79QkFoEQ/YMNXq1qgvzQLJ1rRFGku/G9U8m1/1/Tw5V3dIhKW98qhhRtbTeQW1cE
         Uicex3w00XB7qOOx6qAVOir1slPf47xul7PUYGZn86fznFnm35sYR1bg6DZW9UJ03vNV
         JghSauHQ1k4HxSqb7B8fTWNe6GyGj91fSBK02y3cd8oDDVQ7m42v4Xi4HWMzaZlkQClQ
         YY8qO6tmPEUvTlccwHYcF8PPoaf/ah9fT/lpHayH/sehYVBra+usXrJW9F5NYyjqhiec
         fwYcyQMKCZtk7tGf8ui9Zx+7xI+nL4DzF3+WGBy4b17TDQUq+tXMURoIOUGHoYWJJ3Wh
         mt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l+BAbIwnyfvnT6fp7WgINwQCzuXGSGAMbnHp8IA8OHY=;
        b=LYKMQ9abs8eFF0z7BnNeYMUf6pKMtmjC6hxmy9hnc4MCw09Jt03ML9/HEhwuqfozvJ
         voGBoN7lYGOhItq6lIL5eV4Q83WS9Ppd2eh5OROmZmn778DCwguKTZnSw6iJy0uC7BY7
         HEQQ8Bg5+hV+zMIZnNYEOOIZHz/oamFuvekV4ML9FyDzgKXcTEeWlxmyLyCJx4Cm+GZv
         VsTP0+6jnXJlsaZphwUmrr4X5E/nWRGTkFLpSsXXP0eX8fZad8Tm9p5551cb+t0KEXam
         86TYaX502hfmB/5/iHwNwJRm/vn4Lm9hJfw7nyoHIvWLmMamlKUwTrprj9qDTuA2uzAL
         opfg==
X-Gm-Message-State: APjAAAVteJuMoYGqSOvPSD1nCP4F68jdnULTYOccdyyeormpYHAN5xHM
        uP8kSyla5btIBh9IRsGwZCA=
X-Google-Smtp-Source: APXvYqwnMGPFDZ1X5/tI4rmIIQuE3aDxFiQXwr3bpyz731Ckq/NlxVv2astg96kqY+KrevT72JX5Ag==
X-Received: by 2002:adf:ea43:: with SMTP id j3mr538317wrn.210.1554826897498;
        Tue, 09 Apr 2019 09:21:37 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id r18sm16439247wme.18.2019.04.09.09.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:21:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Dr. Adam Nielsen" <admin@in-ici.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/docs] make slash-rules more readable
References: <20190405200045.10063-1-admin@in-ici.net>
        <xmqqftqt7x49.fsf@gitster-ct.c.googlers.com>
        <CAKrvxcVgMLNEEY6U+ybm6n4WtUCdOaYRjBrDKFvRwzYbZyB2UQ@mail.gmail.com>
        <xmqqy34j7jci.fsf@gitster-ct.c.googlers.com>
        <CAKrvxcW1hKUjMsCGUz7GothxbEKiQek2J5CkjhuiSKoGrArjbQ@mail.gmail.com>
Date:   Wed, 10 Apr 2019 01:21:36 +0900
In-Reply-To: <CAKrvxcW1hKUjMsCGUz7GothxbEKiQek2J5CkjhuiSKoGrArjbQ@mail.gmail.com>
        (Adam Nielsen's message of "Tue, 9 Apr 2019 14:19:14 +0200")
Message-ID: <xmqqzhoz2lpr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Dr. Adam Nielsen" <admin@in-ici.net> writes:

>           If the pattern contains no slash "`/`"
>           (except an optional trailing slash),

That's perfect.

>           the pattern will match in all directories relative to
>           the `.gitignore` file, with infinite depth.

Maybe it is just me but "in all directories relative to the file"
does not say the same thing as

    the pattern is matched against paths in the directory where the
    `.gitignore` file that has the pattern in it is in, and any of
    its subdirectories (recursively).

which I think is what we want to say.  Especially, I do not think
the phrasing implies the match is limited to the directory and its
subdirectories, as it is unclear what the words "relative to" wanted
to mean in that sentence.

>           For example, `frotz/` matches `frotz` and `a/frotz` that
>           is a directory, but does not match if these are files.
>           A pattern `frotz` on the other hand matches these paths
>           whether they are files or directories.

Yeah this is good.

> For the next paragraph I would suggest this:
>
>         If the pattern contains a non-trailing slash "`/`",
>         it matches the beginning of the pathname.

The reference of "it" in "it matches" is fuzzy; first I was confused
as I thoguht it refers to the slash (which one?  if the pattern has
two or more slashes a/b/c).

	A pattern with a non-trailing slash matches the beginning of
	the pathname

would mean the same thing without ambiguity, but I am not sure
"matches the beginning of" is quite right.  

A pattern doc/frotz that appears in v1.0/.gitignore file would match
a file or directory v1.0/doc/frotz (pathnames in these example are
all from the top level of the repository).  

I think woe most important messages we need to deliver are

 - a pattern without slash applies in a directory the pattern
   "appears in", or any of its subdirectories (recursively).

 - a pattern with slash on the other hand is anchored at the
   directory the pattern "appears in" and does not apply to any of
   its subdirectories.

So with that in mind, perhaps

	Unlike a pattern without a slash, a pattern with a
	non-trailing slash is matched against paths immediately in
	the directory the `.gitignore` file the pattern appears in
	is stored in, and does not get used in its subdirectories..

or something?

>         For example, the pattern `doc/frotz/` matches
>         `doc/frotz` that is a directory
>         but does not match `a/doc/frotz`.

Correct, almost.  

	For example, the pattern `doc/frotz/` that appears in
	`.gitignore` at the top-level of the project matches
	`doc/frotz` directory (again, seen from the top-level), but
	not `a/doc/frotz`.

Also, a pattern "/doc" matches doc at the current level (i.e. the
directory in which .gitignore file that the pattern was taken from
is found) and not in any subdirectories.  Is that clear in the
proposed update?

Procedurally (I am writing to make sure we are on the same page for
the technical correctness, so that I can let you take care of the
ease of understanding of the end result---it is of no use if an easy
to understand document describes incorrect behaviour ;-)

 * A trailing slash is used *only* to mark that a pattern matches
   only against directories, and it is ignored by the actual pattern
   mac.thing logic.  It also is ignored by the logic to determine if
   the pattern is anchored.

   e.g. /foo-bar/ becomes /foo-bar but "must match dir" (aka "ends
   with a slash") is remembered.


 * A leading slash is used *only* to mark that a pattern is
   "anchored" at the current level, and otherwise it is ignored by
   the actual pattern matching logic.

   e.g. /foo-bar that used to be /foo-bar/ then becomes foo-bar but
   we also remember "must match here" (aka "had a slash in it").


 * A slash in a pattern that is not ignored by the above two rules
   (i.e. your "intermediate slash") marks a pattern as "anchored",
   i.e. used to match against the paths relative to the current
   level only.

   e.g. foo-bar that used to be /foo-bar that used to be /foo-bar/
   thru the above processing, as well as foo/bar that was ignored by
   the above two rules, are both anchored to the current level, and
   they do not match a/foo-bar or a/foo/bar in our immediate
   subdirectory 'a'

