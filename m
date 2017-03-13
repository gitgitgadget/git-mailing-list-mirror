Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2DDF20373
	for <e@80x24.org>; Mon, 13 Mar 2017 22:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753541AbdCMWML (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 18:12:11 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35092 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752745AbdCMWMK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 18:12:10 -0400
Received: by mail-pg0-f45.google.com with SMTP id b129so71303858pgc.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 15:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jff+s99lCd1OxthFVryCrX1Yr9UlHZCNrEf2bKvJ8KY=;
        b=vYO8jcR6tWY0gPPxbA433UoyDtbVEF2BF/dSgOaIRqH3cx08zzR1SKM3DpY/wxhaCp
         WlhCsiFRQJyXdoHNy2PRWkt+qR9Uec87kTYYGIoMMtcHAJZfPd/ZOpx/wRG6T7CIWM2h
         n6N9WqIMpQ4jURfmJT9gh/XqI6F1p4W/pCfsGyb/R8vt2d3LRUek93UfaRBtHYhzcs8h
         QZXMI8yeexyMRHN6W3TaGG1gEwkFkHWq1+xOL04fDm72iUQtC7zy2e6fPB0/5V+Q+Tc7
         +uGJr5Fki0nKrr6Da70ux8vxb6y0m1FnfzC/B4n/kTr7TfhLtt3IvqmhyBwdAxpyzciI
         SNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jff+s99lCd1OxthFVryCrX1Yr9UlHZCNrEf2bKvJ8KY=;
        b=IoNVuJ/C+ZKzUWPc8tsVUsYOox0F2N3gkxnnJ2aI/m9tRrmrSEVL4PDhLzFt1Erw2I
         ve+m2v19r0c8L+KsYDfypoqA1J30CoRIlaAfQwhaEYsc1edGsuEA0LxgYEYg5y+suKEG
         69ZkgXKdiUKoIdFQS2h0EazF+lcsHqpwrzW2a0Le+EEG9zgCSB8C+vVXYbU8ZfZK81h0
         oTU6jRmaC2qagfuIl5VUHOG4sVtKOxUMMAlRvwdxM+NeNQIP/9jd/UU/cx7yh4h0Ks54
         hbnXEPzqV82PnET/ALBtj3b3EUcNi4nGzyAllfoSk49986JMDaqrdirxDxmNCab+OBIh
         Auuw==
X-Gm-Message-State: AMke39kjzJqt7UPcmoxmtwiMTEVEC4ZELaQO92wJou9Nma8EGaGraNVhTxdYUqkD1a1w8gv4ZFj0E0WjCXg9v448
X-Received: by 10.99.140.77 with SMTP id q13mr38812902pgn.179.1489443128465;
 Mon, 13 Mar 2017 15:12:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 13 Mar 2017 15:12:07 -0700 (PDT)
In-Reply-To: <20170312075404.23951-2-nikhil.benesch@gmail.com>
References: <20170312075404.23951-1-nikhil.benesch@gmail.com> <20170312075404.23951-2-nikhil.benesch@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Mar 2017 15:12:07 -0700
Message-ID: <CAGZ79kZrbvJz+S434BmEA_qeMOUXHk60yDSwdcKef62-Bz8nyw@mail.gmail.com>
Subject: Re: [PATCH 1/1] archive: learn to include submodules in output archive
To:     Nikhil Benesch <nikhil.benesch@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Welcome to the Git community!

On Sat, Mar 11, 2017 at 11:54 PM, Nikhil Benesch
<nikhil.benesch@gmail.com> wrote:
> This commit is a revival of Lars Hjemli's 2009 patch to provide an
> option to include submodules in the output of `git archive`.

I am unaware of said patch, could you link to it, e.g.
on https://public-inbox.org/git/ ?

>
> The `--recurse-submodules` option (named consistently with fetch, clone,
> and ls-files)

... and unlike fetch and push we do not need to introduce extra options?
(or they can be added later when the need arises)

> will recursively traverse submodules in the repository and
> consider their contents for inclusion in the output archive, subject to
> any pathspec filters.

ok.

> Like other commands that have learned
> `--recurse-submodules`, submodules that have not been checked out will
> not be traversed.

Junio writes:
> A question to the submodule folks: Is "checked-out" the right terminology
> in this context?  I am wondering if we have reached more official set
> of words to express submodule states discussed in [*1*].

http://public-inbox.org/git/20170209020855.23486-1-sbeller@google.com/

The "checked-out" here would translate to "populated" in said proposal.

I guess that is sufficient for the first implementation, but eventually we
might be interested in "recurse-submodules=3Dactive/init" as well.
Consider the case, where you delete a submodule and commit it.
Then you still want to be able to create an archive for HEAD^ (with
submodules). So in that case we'd want to recurse into any submodule
that has a git directory with the commit as recorded by the superproject,
i.e. the example given would refer to "depopulated" in the referenced
proposal.

When the initialization is missing, we may not be interested in that
submodule any more, but we don't know for the user, so a user may
want to ask for "archive --recurse-submodules=3D{all / initialized-only /
all-submoduless-with-git-dir, none, working-tree}". No need to add all
these options in the first patch, but keep that in mind for future
extensions.

> @@ -59,6 +59,10 @@ OPTIONS
>         Look for attributes in .gitattributes files in the working tree
>         as well (see <<ATTRIBUTES>>).
>
> +--recurse-submodules::
> +       Recursively include the contents of any checked-out submodules in
> +       the archive.
> +

Here is "any", in the commit message we had "subject to any pathspec filter=
s."

> @@ -132,18 +133,15 @@ static int write_archive_entry(const unsigned char =
*sha1, const char *base,
>                 args->convert =3D ATTR_TRUE(check->items[1].value);
>         }
>
> -       if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
> -               if (args->verbose)
> -                       fprintf(stderr, "%.*s\n", (int)path.len, path.buf=
);
> -               err =3D write_entry(args, sha1, path.buf, path.len, mode)=
;
> -               if (err)
> -                       return err;
> -               return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
> -       }
> -
>         if (args->verbose)
>                 fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
> -       return write_entry(args, sha1, path.buf, path.len, mode);
> +       err =3D write_entry(args, sha1, path.buf, path.len, mode);
> +       if (err)
> +               return err;
> +       if (S_ISDIR(mode) || (S_ISGITLINK(mode) && args->recurse_submodul=
es &&
> +                             !add_submodule_odb(path_without_prefix)))

This is a bit hard to read. Maybe reformatting can help

     if (S_ISDIR(mode) ||
        (S_ISGITLINK(mode) &&
         args->recurse_submodules &&
         !add_submodule_odb(path_without_prefix)))
        return ...

Though I wonder if we need to special case the
return value of add_submodule_odb as that could
be an error instead of fall through "return 0;" ?

> @@ -419,6 +418,8 @@ static int parse_archive_args(int argc, const char **=
argv,
>                         N_("prepend prefix to each pathname in the archiv=
e")),
>                 OPT_STRING('o', "output", &output, N_("file"),
>                         N_("write the archive to this file")),
> +               OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
> +                       N_("recurse through submodules")),

This is the first time hearing "through" used with submodules.
I guess it makes sense when looking at the contents on disk as
a tree data structure.

push:    N_("control recursive pushing of submodules"),
fetch:    N_("control recursive fetching of submodules"),
grep:    N_("recursivley search in each submodule")),
ls-files:    N_("recurse through submodules")),

Ok, we introduced recursing "through" submodules with ls-files.

...
> +
> +add_submodule()
> +{
> +       mkdir $1 && (
> +               cd $1 &&
> +               git init &&
> +               echo "File $2" >$2 &&
> +               add_file $2

test_create_repo / test_commit
might come in handy here as well.

> +       ) &&
> +       add_file $1
> +}
> +
> +test_expect_success 'by default, submodules are not included' '

This test case may be covered elsewhere (in the default archive tests)
already, though not spelled out as such?

> +test_expect_success 'with --recurse-submodules, checked out submodules a=
re included' '
> +       cat <<EOF >expected &&

In the modern parts of Git we indent the content of the here-doc-text
(If the operator is =E2=80=9C<<-=E2=80=9D instead of =E2=80=9C<<=E2=80=9D, =
then leading tabs in the
here-doc-text are stripped.)
i.e. cat <<-\EOF >expect
    well indented text
    that doesn't break visual alignment
    of tests.
    EOF
    git archive ...

There are a lot of old tests still out there, so it is easy to
find them for guidance first. :/


> +test_expect_success 'submodules in submodules are supported' '

cool! Usually these are referred to as "nested submodules" in
case you want to shorten the description.

> +test_expect_success 'packed submodules are supported' '

Not sure what we try to test here? The internal representation
of the submodule ought to not matter.

> +       msg=3D$(cd 2 && git repack -ad && git count-objects) &&
> +       test "$msg" =3D "0 objects, 0 kilobytes" &&

I read that in submodule tests before; t7408 that tests if
submodules with alternates are useful. I am not convinced we
need this test here?

> +test_expect_success 'pathspecs supported' '
..
> +       git archive --recurse-submodules HEAD >recursive.tar &&

The test ought to test that Git can use pathspecs ...

> +       tar -tf recursive.tar 4/6/7 2/3 >actual &&

... unlike tar. We consider all external tools to be perfect within
the git test suite. So we rather want to test for the absence of
paths, that were not given as a pathspec to the git archive command.

> +test_expect_success 'missing submodule packs triggers an error' '

cool!

> +       mv 2/.git/objects/pack .git/packdir2 &&

Uh :/ please do not assume we have the submodule at
<path>/.git. See 293ab15ee (submodule: teach rm to remove
submodules unless they contain a git directory, 2012) for example.

> +       test_must_fail git archive --recurse-submodules HEAD

Do we want to also check for a sensible error message here?
e.g.
    test_must_fail git archive ... >out &&
    test_i18n_grep "<message>" out

> +test_expect_success '--recurse-submodules skips non-checked out submodul=
es' '

I read that as "skips unpopulated" ...


Thanks,
Stefan
