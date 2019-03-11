Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8AB120248
	for <e@80x24.org>; Mon, 11 Mar 2019 18:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfCKSQp (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 14:16:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41063 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCKSQp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 14:16:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id p1so1744255wrs.8
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hBcNUfi6zZ963oPJjnRNLxSTwiyj74lRYgVcJytpS30=;
        b=lh28qTG3J4A5L4XFaXJzboJVZ83H4OUPM2GddzyZoWb0cc/pvoj8PNUMrhTf3C9pWh
         +vlt/DhRdYJw3tiIAQIl7Nx7LAGplkra0wDPbF0nGqysDJQCXzMlDYx7+F4u2ch2zS1l
         30jB5EF5jV39tktadAY1MTJ1rhqumnXi3eWBj7DuXS1aRiD1JCbbFWsKOo0cfIllWjTb
         kOmWgYOCJqEfiMOdYL/koGcQ1qN/C4EAWOcyYKMcArEkjX+15zEIwGkG1FcgQo6/JV6o
         9k+W1wFR+IlkEcB52m3DjdCaQyywlCNmJpWdt7TqbFtNMnnQ1C0lruWoWwe+ZadPXjM5
         vfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hBcNUfi6zZ963oPJjnRNLxSTwiyj74lRYgVcJytpS30=;
        b=KPKfIklgrSctztKkRhOFJez5wESkVjO0spp1D7dKRdnR1CzFkvqBJBmZ1l1jPrlUwG
         ZrD5RhcwTMQiwIjdMiTK7e2vpRUE8i5nLVnib5R6OUu8zasQEl6P8GaLqomsaEK3d8jZ
         z1kgpgEARtNqHqZPiMG0rqfJU9NV6EeAPn/TAh3e/iWwa65LjlCkOqRdT4IT3Tb/SZ3w
         e1tRD9KNOn8jn9+W9axO8ndqau0v0hV4ATnmdaahEMuNWCBUSzUoZ6VGX7UPGytxYmCr
         gUc/PzqESlETbxwy5yCcWYgS0qw18Yg8MIskwD3M3GZzT0H+zfm7kmCG1HSJB7sK1gIg
         mIDg==
X-Gm-Message-State: APjAAAWsTMgutQoBEY7nNB4T6Vl8zLyYRflNkNDvetiPdSTM4YpqytEG
        3HK8XWgBI6Tqsc/MKv/UhG2P9JSzdIUqo84AwvCSiw==
X-Google-Smtp-Source: APXvYqz/jydsni3ZDNbSPT7leuJyOzAKVdALDp/bpad5zKzcV5Kx633WNqFZIND23CtWg7xd3kDsydPiaIbC9txlQfQ=
X-Received: by 2002:adf:ffc3:: with SMTP id x3mr12149890wrs.111.1552328203706;
 Mon, 11 Mar 2019 11:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <CA+dzEBkkbQj0rCjvPfcET2Uvt6fP_v+wQE52ZkAND2Mps08SNQ@mail.gmail.com>
 <10972e0e-7fe1-437f-efe6-cff82a1205e0@kdbg.org> <20190311175519.6lbppv5u44w2u4sj@tb-raspi4>
In-Reply-To: <20190311175519.6lbppv5u44w2u4sj@tb-raspi4>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Mon, 11 Mar 2019 11:16:32 -0700
Message-ID: <CA+dzEBm7fdrncnd_7tDu-q047qxt3CsHVQna3GRMagJetisQeA@mail.gmail.com>
Subject: Re: `git add <<windows 8.3 path to file inside repo>>` results in
 "fatal: ... is outside repository"
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 10:55 AM Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>
> On Mon, Mar 11, 2019 at 06:48:11PM +0100, Johannes Sixt wrote:
> > Am 10.03.19 um 23:41 schrieb Anthony Sottile:
> > > git init longname-repo
> > > cd longname-repo
> > > touch f
> > > git add ..\longna~1\f
> > >
> > ...
> > >
> > > C:\Users\Anthony\AppData\Local\Temp\t\pre-commit-hooks\longname-repo>=
git
> > > add ..\longna~1\f
> > > fatal: ..\longna~1\f: '..\longna~1\f' is outside repository
> >
> > This has nothing to do with long vs. short path names. It would report
> > the same error when you say
> >
> >   git add ..\longname-repo\f
> >
> > -- Hannes
>
> You can probably do another test:
>
>  mkdir longname-rexxx
>  git init longname-repo
>  cd longname-repo
>  touch f
>  git add ..\longna~1\f
>
> And now nobody knows for shure if "longna~1"
> is longname-rexxx or longname-repo
>
> It may happen that it is longname-rep at this point in time,
> at your machine.
> It may happen that it is a complete different directory on another machin=
e,
> or even on your machine.
> For that reason, to avoid that someone tampers data outside a repo,
> "../" (or ..\ under windows) is not accepted by Git.

the same can be said for `git add /full/path/to/repo/file` as any of
those components could be symlinks.

However that is currently allowed

Note also I've updated my report, it isn't about relative paths any
more but about full paths with 8.3 paths

Note that 8.3 filanames do canonically disambiguate themselves, the
number after the tilde is used to refer to filenames alphabetically

This report is very similar to the change that happened to
disambiguate drive letters in
https://github.com/git/git/commit/d8727b3687c1d249e84be71a581cc1fb0581336a


> Oops, I misreported while trying to minimize my reproduction
>
> Here's an accurate bug report
>
> git properly handles this:
>
>     git add C:\full\path\to\longname-repo\file
>
> When the root of the repo root is `C:\full\path\to\longname-repo`
>
> But it does not handle the equivalent 8.3 path:
>
>     git add C:\full\path\to\longna~1\file
