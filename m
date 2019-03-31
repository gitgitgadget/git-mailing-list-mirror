Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A47620248
	for <e@80x24.org>; Sun, 31 Mar 2019 09:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfCaJyi (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 05:54:38 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36177 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfCaJyi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 05:54:38 -0400
Received: by mail-it1-f193.google.com with SMTP id y10so8619654itc.1
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 02:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=huxpw84fwSvjbP4FIM3v7M+SRTrWf+1XwfqwCPBCPj0=;
        b=AR6HL4TELzUVwxAS8h5Q1AlbY2LK1pwuoYf4kkTMHOrpY/F3hA/V/gHIlc5a8MEX0g
         UB+l2o/njXZZcDHUydN4jFPZ2KSoT6M7oXGv3Edp5B/t1T2+Rl3SmQhH/X3aexVKnLE7
         EiHC5XH6DGNumCanjuRrk7Y6WYj4RA3YGMkbNnQKcQWbQf/jC95eCmlTLwFvdWbVIT4j
         VgIlFRvMoedlDnaX4NHpJPpwW9HCOojltvyT6z1VaGKmucHx7LjqZY7m0embKZT1ocjV
         ZOtnCpA9l9yRTGZoZEmjAbiaKT7SKAzT7m+N7cEKPN3XkEaN7ecGVrHRqWk678EsHGz8
         uQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=huxpw84fwSvjbP4FIM3v7M+SRTrWf+1XwfqwCPBCPj0=;
        b=ZlEhZtEZ0V8Qra2eVdhPXhrtMlKQI4IwHejZrZHfPYV8twgMolHtqbqcwxOfkjqCTh
         t4AL2q45LFMF9WtqsX38woeoV+oQEcgVsF4qvitjHj0VsTgvvGfQmoeNHv8ZP4/HTEKw
         d35TBZGUTUvLBzW4qbg3T5Uv/R6rg5LitPwglmah3/F4LLUTypT2CcYGHL+Xp2y9IqNA
         RSRa59igRQUREhjQy3UtTKADAPVCs/J8Tx2YqNG+iMC9x8XGXFSCyXoLDuYB7Ri1UlEE
         T7Sj4iAHMtA87qYBi/pGRf8IOOsBQR6ULLuPsg+tKYkswE0qaXQds1mDS7ZuluYjconT
         hX7g==
X-Gm-Message-State: APjAAAUGNzCJ8w4dRYiPypejRLLml+aBZOLJajVn9L614H4/Eg/W0Q6W
        bCHVJnwJ+ZQcU5oKGzpGwknLv/yYHxbczZiufw67r6of
X-Google-Smtp-Source: APXvYqwIFhG0/QCCNYuiw0tSBBs8v8/7F9P0ShgI0snvEKt5wHf88p75Ih6YI2tZ+ui9JRvAMJy1etfPQpUfPjfkGo4=
X-Received: by 2002:a24:b953:: with SMTP id k19mr10869792iti.123.1554026077296;
 Sun, 31 Mar 2019 02:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAKrvxcUkLcJ782xe-ETAPNWvD-zv_KXmu0VxRPvJhOGnrChVOg@mail.gmail.com>
In-Reply-To: <CAKrvxcUkLcJ782xe-ETAPNWvD-zv_KXmu0VxRPvJhOGnrChVOg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 31 Mar 2019 16:54:11 +0700
Message-ID: <CACsJy8Dz1TLpMSRNwGtvv9kBHKJsKcses+LegfOfpz2_N3eEHg@mail.gmail.com>
Subject: Re: Typo in the .gitignore docs?
To:     "Dr. Adam Nielsen" <info@drnielsen.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 31, 2019 at 2:53 AM Dr. Adam Nielsen <info@drnielsen.de> wrote:
>
> Hi everyone,
>
> I think there is a typo in the gitignore docs.
>
> Its stated on https://git-scm.com/docs/gitignore that
>
> >If the pattern does not contain a slash /, Git treats it as a shell
> >glob pattern and checks for a match against the pathname relative to
> >the location of the .gitignore file (relative to the toplevel of the
> >work tree if not from a .gitignore file).
>
> I think that maybe two things are not 100% correct. First I think it
> should be "If the pattern does contain" instead of "does not contain".
> Secondly, I think it should be mentioned that this is only true for
> slashes that are not a trailing slash.

The trailing slash is already covered in the previous paragraph as you noticed.

The "does not contain" is correct, but perhaps the wording is a bit
too easy to misunderstand. If you go back to the original version of
this document in cedb8d5d33 (Create a new manpage for the gitignore
format, and reference it elsewhere, 2007-06-02), you can see an
example of the "otherwise" part where the present of '/' will anchor
the pattern to the current directory

+   For example, "Documentation/\*.html" matches
+   "Documentation/git.html" but not
+   "Documentation/ppc/ppc.html".  A leading slash matches the
+   beginning of the pathname; for example, "/*.c" matches
+   "cat-file.c" but not "mozilla-sha1/sha1.c".

This part was later removed by me in 2e22a85e5c (gitignore.txt:
elaborate shell glob syntax, 2018-02-01). In hindsight that was a
mistake since having an example seems to help clarify the description.

So rewording this paragraph (and keep the 'does not contain' part) to
be easier to understand would be great. If you turn 'does not contain'
to 'does contain' then you would need to update the 'otherwise'
paragraph as well.

I think the part that trips people is the 'pathname' in 'checks for a
match against the pathname relative...'. I think the key point is
matching the pattern against any pathname _component_ in the path
relative to the location of .gitignore. In other words '*.c' would
match 'abc.c' component in 'def/abc.c'. 'def/ghi/abc.c' or 'abc.c'.

The following 'otherwise' paragraph perhaps could also elaborate a bit
more, that the pattern is matched against the entire path (relative to
.gitignore), not just one path component. The FNM_PATHNAME implies
that (because it would not make sense otherwise) but that's just too
hard to see.

Patches are welcome.

> You find discussions about this at
> https://github.com/git/git-scm.com/issues/1332 and at
> https://stackoverflow.com/a/41761521/2311074
>
> Here is my proposal for an alternative, maybe more clear version:
>
> >Whenever you have a string that contains a non-trailing slash "/" , its always considered from
> >the root. There is no difference between foo/bar and /foo/bar. The pattern foo/ is not
> >considered from the root, because it has no non-trailing slash "/".
> >One may match a path that does not start at the root by using "**" (see below).
>
> Also since we are on it, I would suggest to reduce
>
> >If the pattern ends with a slash, it is removed for the purpose of the following description, but it
> >would only find a match with a directory. In other words, foo/ will match a directory foo and
> >paths underneath it, but will not match a regular file or a symbolic link foo (this is consistent
> >with the way how pathspec works in general in Git).
>
> to
>
> >If the pattern ends with a slash, it would only find a match with a directory. In other words, foo/
> >will match a directory foo and paths underneath it, but will not match a regular file or a
> >symbolic link foo.
>
> What do you think?
>
> Best regards,
> Adam



-- 
Duy
