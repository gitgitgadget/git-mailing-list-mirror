Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 968791F462
	for <e@80x24.org>; Wed, 29 May 2019 17:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfE2Rck (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 13:32:40 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:40776 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2Rck (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 13:32:40 -0400
Received: by mail-ed1-f54.google.com with SMTP id r18so3913343edo.7
        for <git@vger.kernel.org>; Wed, 29 May 2019 10:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KZPjH/65MMTbdYuVDqJrldvorGEKOFeqMhBAmPlucx8=;
        b=CmsddoYF+eqmcqqiNUxbfOmmGTNn6R9FmjpxpkMlGIKx1Ah0xlcXPTU+6NqGwFkA77
         Em3QF030KpjFmP3egATuduLpQWIHcIVWm7/Erul9BLKxjUySidNsisajpAqb5DqWg/pa
         ZQBpJrIuqvxW0keTfXr51DEWxUZIUUfDA2yLAgmWGzHoorPyrceoaJnPOiEbABRfYNAf
         +lGZwjSL90RW8YHZvxhTBdujSa9CEityhFMVfAdFGjeLBu41pB3ib6WdwbKdGdRc1mMa
         84ohubxjNF4+DlTuCtJIot7E/+93MmEs8Ho/np1NQilUnSH+f8oopiVNih6gwO5MLwJr
         bNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KZPjH/65MMTbdYuVDqJrldvorGEKOFeqMhBAmPlucx8=;
        b=Afy764ppT51H+GLDJNvienzhL4/vmIVKWHBmgpIq4/ZDADjt6icuQwh66I35vv7Sbr
         C2GBtxcoE/HGV169U3rCwwsbIH5XyUnHvwlASriYwhSi7hyXqvam3dZb0Cp08Jl6jhgX
         CrMwgLhzMnoAY2p0XuclpPWIsj6zHOd0w0p0i2ysCnhHQuUPafI7RgcqeeQcONJulWKf
         4RDB4qJlT0YQfDiaB/5F8x7p1TP3jfN0OxSOC7l7hLA2YuXRSKPHVhxFrj47rPSjrnMd
         P5n1EBfS905jqhi5es+QPjXQEeVjnXMW+GGRoB7lrrgvC7jQts24GkJ/rMzcwnqyPGML
         e6MA==
X-Gm-Message-State: APjAAAXlVe86BIxFNYhuGJB8B25U9LFlZFxoF7g0vmgtl3JVebfLUDCM
        ZOcMcSlBzYWsQ7KObpTZGcpj4C6uRu4HSnbV2/k=
X-Google-Smtp-Source: APXvYqyx5s1cwwsuPi3OTieXOm8c2JUP3BAwvyDK/BGwQbkiKiKy/z52fyWRWcDpcYfp499rHtbG2vIN2t9jsoTJeTw=
X-Received: by 2002:a17:906:720e:: with SMTP id m14mr35800183ejk.84.1559151158464;
 Wed, 29 May 2019 10:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+P7+xrXz7-TgV4ufVkXqjgi8X1UD=pQJC3s2JA5fH-sEEnENA@mail.gmail.com>
 <8736l6ujcr.fsf@evledraar.gmail.com>
In-Reply-To: <8736l6ujcr.fsf@evledraar.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 29 May 2019 10:32:27 -0700
Message-ID: <CA+P7+xovDWswGpM-E4tc2AmHsnpwRzK57Zs27bm-itjwrdehhg@mail.gmail.com>
Subject: Re: git describe/contains for submodule commits
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 22, 2019 at 5:04 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, May 23 2019, Jacob Keller wrote:
>
> > Hi,
> >
> > I've had a few times where I was curious of when a submodule got set
> > to a specific commit.
> >
> > I noticed that git describe has "blob" support, which outputs something=
 like
> >
> > <commit>:/path/to/file
> >
> > using the revision walking machinery.
> >
> > I'm curious if anyone knows if that sort of revision walk could be
> > expected to find the first treeish that had a submodule commit instead
> > of a blob.
> >
> > I'm not that familiar with the revision walking, so I was hoping to
> > get some pointers of whre to look before I began implementing.
> >
> > Ultimately, I'd like to have some sort of command like:
> >
> >   git submodule contains <submodule> <commit id>
> >
> > and have it try to figure out the most recent commit htat has a
> > submodule change for which the submodule is a child of the specified
> > submodule commit.
> >
> > I can sort of reverse engineer this through git log, but it's slow and
> > tedious, so I was hoping to be able to implement it into a revision
> > walk that did this.
> >
> > Once I know the commit that introduces the submodule change, I could
> > feed that to git describe --contains to find the tag/version which
> > included the change easily enough.
> >
> > Thanks,
> > Jake
>
> You can do this with --find-object, e.g. on git.git:
>
>     git log --find-object=3D855827c583bc30645ba427885caa40c5b81764d2
>
> Plugging that into describe.c should be fairly straightforward.

Thanks, I'll take a look at this.

Regards,
Jake
