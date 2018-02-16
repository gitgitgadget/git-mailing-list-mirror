Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E6EC1F404
	for <e@80x24.org>; Fri, 16 Feb 2018 14:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758017AbeBPOmp (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 09:42:45 -0500
Received: from mail-pl0-f47.google.com ([209.85.160.47]:40571 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754785AbeBPOml (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 09:42:41 -0500
Received: by mail-pl0-f47.google.com with SMTP id g18so1781032plo.7
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 06:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y4h+I2A9flyf+Ixef5U9FeqHQPZkMU8mNqqsKH/K03g=;
        b=uvAKpT7MVMq27XGQu4378aLgvlX3fle6ynaM/fXlYsHwCPf00MBJLtIAz5aA3qM8Pp
         Cp9jJgdLgd718x/PzsGdQM5vZ/3TziEWqlP3yUrvPwbqf+PfGvK6BvFiQWuC2BfzU8EV
         PITntXHZNx3dd+0Tbkg5gd774O39EmmkEY8GeiH24fvByp1/ta4lCVJH0OhCXu6oKh8P
         nCQGhjLHGwkNBaq3OiWa2jjND1RLauT5lOYMY0aI609fnqHd9z2ilVmObxCzOCt9L7fA
         9FFlIEllviU5j5tv+Y6iZpYb2xb0eajx0MR+F3epLSSXs7AocmZNrOdhAr8kMHSkXH2N
         DdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y4h+I2A9flyf+Ixef5U9FeqHQPZkMU8mNqqsKH/K03g=;
        b=E51oaQaWRzdqhkSFM5x8Xi9N/0X6auF7f99KSvvxfADC1bp9KLR1/I/bxJAFuRfoZ+
         voa+UQsy4wP3H4Brj0qdOOF2Cr8+9ULokEqa7+SpeLVxVkWgmg27JyRTFWyKVkQygYe+
         MjTuRuqKMtNLWhZeKGYrXNBopkksE1Fzp8UXlFfYG5Sn0+Ue5MNTdF0HdK+t7MjGw8LU
         2JgSatwog5zcxqDMn3lXWNtD6GfM7f2ubRaBl8b3nlzZQm4Nixx8WQXSbIN0dOIfEbmg
         isuKw1IbKaAkg0v+55KOeXlxfmX/ekdYlixEkcP+N3W1yf0fb8z+wzHIKmwGcTW1GrTA
         9x+g==
X-Gm-Message-State: APf1xPB2KgbfYzaJHOmb9C32rX/ewHzX0LOeCizSKt6sKnF+88bRxniV
        Lm+9/vkM76UTnqwRrWhKtX8=
X-Google-Smtp-Source: AH8x227s9x3/GIAF4fzSNi8TK7+AqrkeYJ8Kq8ahgN6ACuO8cZoIkKdxpmjYJeV8/vkQin6pJVje1w==
X-Received: by 2002:a17:902:6c41:: with SMTP id h1-v6mr5994065pln.25.1518792161020;
        Fri, 16 Feb 2018 06:42:41 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id t63sm4201259pfj.44.2018.02.16.06.42.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Feb 2018 06:42:40 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 16 Feb 2018 15:42:35 +0100
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC552BF4-3E87-41E0-BF92-4BA9633D374E@gmail.com>
References: <20180215152711.158-1-lars.schneider@autodesk.com> <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 15 Feb 2018, at 21:03, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> lars.schneider@autodesk.com writes:
>=20
>> -- Git clients that do not support the `working-tree-encoding` =
attribute
>> -  will checkout the respective files UTF-8 encoded and not in the
>> -  expected encoding. Consequently, these files will appear different
>> -  which typically causes trouble. This is in particular the case for
>> -  older Git versions and alternative Git implementations such as =
JGit
>> -  or libgit2 (as of February 2018).
>> +- Third party Git implementations that do not support the
>> +  `working-tree-encoding` attribute will checkout the respective =
files
>> +  UTF-8 encoded and not in the expected encoding. Consequently, =
these
>> +  files will appear different which typically causes trouble. This =
is
>> +  in particular the case for older Git versions and alternative Git
>> +  implementations such as JGit or libgit2 (as of February 2018).
>=20
> I know somebody found "clients" misleading in the original, but the
> ones that do not understand w-t-e do not have to be third party
> reimplementations and imitations.  All existing Git implementations,
> including ours, don't.

Agreed!


> One thing I find more problematic is that the above places *too*
> much stress on the UTF-8 centric worldview.  It is perfectly valid
> to store your text contents encoded in ShiftJIS and check them out
> as-is, with or without this patch.  It is grossly misleading to say
> that older versions of Git will check them out in UTF-8.  "will
> checkout these files as-is without encoding conversion" is a better
> way to say it, probably.

True. But that's not what I wanted to say in the "pitfalls" section.
If my Git client supports w-t-e and I add the ShiftJIS encoded
file "foo.bar" to my repository, then Git will store the file as
UTF-8 _internally_. That means if you clone my repository and your=20
Git client does _not_ support w-t-e, then you will see "foo.bar" as=20
UTF-8 encoded.


> Also notice that even in the world with w-t-e, such a project won't
> benefit from w-t-e at all.  After all, they have been happy using
> ShiftJIS in repository and using the same encoding on the working
> tree, and because w-t-e assumes that everybody should be using UTF-8
> internally, such a project cannot take advantage of the new
> mechanism.

Agreed. However, people using ShiftJIS are not my target audience.
My target audience are:

(1) People that have to encode their text files in UTF-16 (for=20
    whatever reason - usually because of legacy processes or tools).

(2) People that want to see textual diffs of their UTF-16 encoded=20
    files in their Git tools without special adjustments (on the=20
    command line, on the web, etc).

That was my primary motivation. The fact that w-t-e supports any
other encoding too is just a nice side effect. I don't foresee people
using other w-t-encodings other than UTF-16 in my organization.

I have the suspicion that the feature could be useful for the Git
community at large. Consider this Stack Overflow question:
=
https://stackoverflow.com/questions/777949/can-i-make-git-recognize-a-utf-=
16-file-as-text

This question was viewed 42k times and there is no good solution.
I believe w-t-e could be a good solution.



With your comments in mind, I tried to improve the text like this:

    Git recognizes files encoded with ASCII or one of its supersets =
(e.g.
    UTF-8, ISO-8859-1, ...) as text files.  Files encoded with certain =
other
    encodings (e.g. UTF-16) are interpreted as binary and consequently
    built-in Git text processing tools (e.g. 'git diff') as well as most =
Git
    web front ends do not visualize the contents of these files by =
default.

    ...

    Please note that using the `working-tree-encoding` attribute may =
have a
    number of pitfalls:

    - Alternative Git implementations (e.g. JGit or libgit2) and older =
Git=20
      versions (as of February 2018) do not support the =
`working-tree-encoding`
      attribute. If you decide to use the `working-tree-encoding` =
attribute
      in your repository, then it is strongly recommended to ensure that =
all
      clients working with the repository support it.

      If you declare `*.proj` files as UTF-16 and you add `foo.proj` =
with an
      `working-tree-encoding` enabled Git client, then `foo.proj` will =
be
      stored as UTF-8 internally. A client without =
`working-tree-encoding`
      support will checkout `foo.proj` as UTF-8 encoded file. This will
      typically cause trouble for the users of this file.

      If a Git client, that does not support the `working-tree-encoding`
      attribute, adds a new file `bar.proj`, then `bar.proj` will be
      stored "as-is" internally (in this example probably as UTF-16).=20
      A client with `working-tree-encoding` support will interpret the=20=

      internal contents as UTF-8 and try to convert it to UTF-16 on =
checkout.
      That operation will fail and cause an error.

    ...



> And from that point of view, perhaps w-t-e attribute is somewhat
> misdesigned.
>=20
> In general, an attribute is about the project's contents in the
> manner independent of platform or environment.  You define "this
> file is a C source" or "this file has JPEG image" there.  What exact
> program you use to present diffs between the two versions of such a
> file (external diff command) or what exact program you use to
> extract the textual representations (textconv filter) is environment
> and platform dependent and is left to the configuration mechanism
> for each repository.

> To be in line with the above design principle, I think the attribute
> ought to be "the in-tree contents of this path is encoded in ..."
> whose values could be things like UTF-8, ShiftJIS, etc.  What
> external encoding the paths should be checked out is not a
> project-wide matter, especially when talking about cross platform
> projects.  Perhaps a project in Japanese language wants to check
> out its contents in EUC-jp on Unices and in ShiftJIS on DOS derived
> systems.  The participants all need to know what in-repository
> encoding is used, which is a sensible use of attributes.  They also
> need to know what the recommended external encoding to be used in
> the working tree is for their platforms, but that is more like what
> Makefile variable to set for their platforms, etc., and is not a
> good match to the attributes system.

As mentioned above, this is not my intended usecase here. As Peff
mentioned elsewhere "always check this out in _this_ encoding"
is the goal here.


Thanks a lot for feedback,
Lars=
