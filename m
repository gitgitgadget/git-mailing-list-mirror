Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65F61F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 12:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbeJNT4s (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Oct 2018 15:56:48 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:55352 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeJNT4s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Oct 2018 15:56:48 -0400
Received: by mail-it1-f177.google.com with SMTP id c23-v6so24924527itd.5
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f7eNDFLrCoJ4HVhnhsAVJV1YgJnv5vFxEAUYQf7r18Q=;
        b=Bckn86yF6D6/0QMq+RgoeqSlGIn3mvvV+xNw0WNTfN/T6J9U1J61xUr4foaZQ4Gv5d
         ZfDXx4RUGapNvCdftjRlO9XNLmgby5MwPAEdTFIisk/ThIIUHv3Cf7mb0AMvj0f3LEgv
         ThxHGFpdCjZjWQqdp0gWqe3ExbdUmnIiFNzKQEVrhC7BZqEum3nCkiN52080QwcLDH//
         0Bfh7Xp8xrF4hwUsuxxLWi7E9lj+MUoO3L6StEnnNzI4qvkWe7zan+qPrx4Z9EukKwtG
         MQPNmoYrHrjup0ls1Cf1HGhZ72FDf/p37/6TSJFp+xzvwTI3p/s0kiTqYK+D3Yzdv8Bv
         SL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f7eNDFLrCoJ4HVhnhsAVJV1YgJnv5vFxEAUYQf7r18Q=;
        b=hQHh1qxE07Gtn9Uzq19m9IuvFaEugKm2tKgIpZV+EMhxaEMHuJ6w3HqsHpA4g5c7Lj
         4ipv6vuPQijHI8GANGnvl85WEk1YbXAbprA7vKPwyhVdQ1lHYmxnV65xRWryrWdkpgb0
         MuF2RFmPEmGiQpbH4+4YVuxX8/2PYVtw173fIh0YKW9aQX+j6tTseudRP+x3Q85d5dLJ
         SPKoRLyM6yMt+ZqRIngB1veq+r1cGXKGPIdCyocbZiGAjZVfrMjlM2y96HCY9nr469Pf
         FWIref+hK3VAW5tY8R24YdGwBqEwOH4StiYjGEg9Z5/QBqIaE7mTJfpIcOyLILkltzzJ
         WMVg==
X-Gm-Message-State: ABuFfojwz6rzAj6kbjuEPN8bpXKpAqix9F7z0mVEWtwGjf6/ZMMZJeEZ
        GaEnEFhaEohDOc0uGi8y0euduUT5T4i4t1KlOTw=
X-Google-Smtp-Source: ACcGV63zafy7ZKXfAm0B8vOgbej+voJx7nImB6/VUyFUF1KQXMtrG65RPJR/MqrXoVK+z8uCv9j/xdWQemGcpYC1dGs=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr9781893itc.123.1539519357408;
 Sun, 14 Oct 2018 05:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is> <87bm80eo6h.fsf@evledraar.gmail.com>
In-Reply-To: <87bm80eo6h.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 14 Oct 2018 14:15:31 +0200
Message-ID: <CACsJy8DVSu2Sh34UG4P9aqqEMsY5zOGc61tEizo=0sG4BoSgkw@mail.gmail.com>
Subject: Re: [BUG] gitignore documentation inconsistent with actual behaviour
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     dana@dana.is, Git Mailing List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 2:41 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Oct 11 2018, dana wrote:
>
> > Hello,
> >
> > I'm a contributor to ripgrep, which is a grep-like tool that supports u=
sing
> > gitignore files to control which files are searched in a repo (or any o=
ther
> > directory tree). ripgrep's support for the patterns in these files is b=
ased on
> > git's official documentation, as seen here:
> >
> >   https://git-scm.com/docs/gitignore
> >
> > One of the most common reports on the ripgrep bug tracker is that it do=
es not
> > allow patterns like the following real-world examples, where a ** is us=
ed along
> > with other text within the same path component:
> >
> >   **/**$$*.java
> >   **.orig
> >   **local.properties
> >   !**.sha1
> >
> > The reason it doesn't allow them is that the gitignore documentation ex=
plicitly
> > states that they're invalid:
> >
> >   A leading "**" followed by a slash means match in all directories...
> >
> >   A trailing "/**" matches everything inside...
> >
> >   A slash followed by two consecutive asterisks then a slash matches ze=
ro or
> >   more directories...
> >
> >   Other consecutive asterisks are considered invalid.

Perhaps "undefined" is a better word than "invalid".

> > git itself happily accepts these patterns, however, apparently treating=
 the **
> > like a single * without fnmatch(3)'s FNM_PATHNAME flag set (in other wo=
rds, it
> > matches / as a regular character, thus crossing directory boundaries).
> >
> > ripgrep's developer is loathe to reverse-engineer this undocumented beh=
aviour,
> > and so the reports keep coming, both for ripgrep itself and for down-st=
ream
> > consumers of it and its ignore crate (including most notably Microsoft'=
s VS Code
> > editor).
> >
> > My request: Assuming that git's actual handling of these patterns is in=
tended,
> > would it be possible to make it 'official' and explicitly add it to the
> > documentation?

You mean "**" in the fourth case is interpreted as "*"? Yes I guess we
could rephrase it as "Other consecutive asterisks are considered
normal wildcard asterisks"

> Yeah those docs seem wrong. In general the docs for the matching
> function are quite bad. I have on my TODO list to factor this out into
> some gitwildmatch manpage, but right now the bit in gitignore is all we
> have.
>
> Our matching function comes from rsync originally, whose manpage says:
>
>     use =E2=80=99**=E2=80=99 to match anything, including slashes.
>
> I believe this is accurate as far as the implementation goes.

No. "**" semantics is not the same as from rsync. The three cases
"**/", "/**/" and "/**" were requested by Junio if I remember
correctly. You can search the mail archive for more information.
--=20
Duy
