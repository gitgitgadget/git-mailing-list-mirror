Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A5C520248
	for <e@80x24.org>; Fri, 22 Mar 2019 21:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfCVVBw (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 17:01:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37325 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfCVVBv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 17:01:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so2319960pgq.4
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K9cFjxdNiy8iMDvEutle3EE2aQAY89agABiNvNT990I=;
        b=LXKH9Q6JYi5+3b1Ruai+PmOfTSm0IOUnCQKBqmFMwpvUpqsRvrlQ4ubaU6Wlcwcpfg
         0YPdtzhEprrWXbMfKG86ElBBTIDDy2YkTweA9dzkmzjlP6DlF9cd/xpeECQKPq5YtW8W
         LdnYzzEqd+v5rJVENUsx65RCwApUZBxsW0hjmVTulYye4FX2bWzvYcV0uWJYiSwFM+qd
         if8n4Wgz/ybB5VziJqyeQwWx9Gs6CImyqt6U353USRMEDaXz0PN99ylKI8th0OyKY1sn
         GZGOldmQnNASoQXvOQt9+Sq3L9gfZTmHIaT9CqzDsju3DrSVMbp7NK+VTwkJS1/fqWqh
         nQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K9cFjxdNiy8iMDvEutle3EE2aQAY89agABiNvNT990I=;
        b=neAV1XeJbVqWkBHGege5LJAI1L+ZnnFIBcSCkv2RhC8AZzKpj1afZb8Tbi//OtwuJ1
         yzcBI5In+sBUKBWMO/3H15B61+lkrU8Cn2IA2tSs0CR5icN+hvU8bAnt7cHcZSTCej81
         wAKxUXqjBHYt4xeJqoO6RbNIj4VWnrRB2kyaWZiNUbib02hr8Wj5mUQksny9KhFWpuo6
         wWxPLU8CxeB/havig83JRBrvNQjyINt6smKy2JLp/23aHXLBJrBSoiF1Lc2HFUzU0zZZ
         WmhRlo8UhQDt0d7Ao5Ik93DEh8LcA8TYV3jVRlVPdFJMnu+X67rzdzxVzkMJLM4IVoI4
         3HzA==
X-Gm-Message-State: APjAAAWyheMapSXsUg1xv3OREghAqU7BFKlZpEl+ii7Tvf6FCdtokhSe
        9P6mnHAwNTwmW0iJKPkb0yUkevZfFum5YA74ZqSbpDiF
X-Google-Smtp-Source: APXvYqxRA5588VhauHPY0YBycYItbg0acX1qf8Rpml9C2dOGkw3S4nWYqxmP68dEQrHFSRYRlfE+UQX/FskwBzbQDZg=
X-Received: by 2002:a62:1d90:: with SMTP id d138mr11163761pfd.232.1553288510682;
 Fri, 22 Mar 2019 14:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190317144747.2418514-1-martin.agren@gmail.com>
 <20190317194431.GY31362@pobox.com> <CAN0heSrajiswzpm+au_5nmZMZG9406iZa-CK9p5CaHLTuxm8nw@mail.gmail.com>
 <20190320181715.GJ31362@pobox.com>
In-Reply-To: <20190320181715.GJ31362@pobox.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 22 Mar 2019 22:01:37 +0100
Message-ID: <CAN0heSpJvsPm_qq63VumokmyOG6N=6fwMZRqf_9CzoCeHsdiyQ@mail.gmail.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Mar 2019 at 19:17, Todd Zullinger <tmz@pobox.com> wrote:
> Martin =C3=85gren wrote:
> > {litdd} now renders as &#x2d;&#x2d. We should find some other way to
> > produce '--'. This should then be a simple change, as we're already
> > providing this attribute inside an `ifdef USE_ASCIIDOCTOR`.
>
> I noticed that one and didn't work out a good fix, but it
> sounds like you have one in mind.  That's great.
>
> > "+" becomes "&#43;". I didn't immediately find where we do that.
>
> For this one, I was working on replacing "{plus}" with `+`
> (along with " " and "-").  That's probably not ideal though.

The "plus" and "litdd" issues seem like they can be solved by doing:

  ASCIIDOC_EXTRA +=3D -aplus=3D'+'
  ASCIIDOC_EXTRA +=3D -alitdd=3D'\--'

> > `./doc-diff HEAD^ HEAD` shows how several "git-\nfoo" become
> > "\ngit-foo", i.e., linkgit expansions are now treated as non-breaking.
> > [...] Hmm, was this
> > why you increased MANWIDTH?
>
> Yeah, I noticed a number of places where asciidoc and
> asciidoctor wrapped lines at slightly different places.  I
> didn't see if they were all due to wrapping at a dashed git
> command, but that could certainly have been the main cause.
>
> I set the large MANWIDTH and then I think I added
> --color-words to the diff call in doc-diff.
>
> > A double-space between sentences turns into a single space -- at least
> > in constructions such as "... to foobar. `git-foo` does ...". Not a
> > problem perhaps, but noise in the diff.
> >
> > And I'm sure there's more lurking in that huge diff. Whether any of tha=
t
> > is significant or not is another matter. ;-)
>
> Oh my yes, I'm sure. :)

:)

Using origin/ma/doc-diff-doc-vs-doctor-comparison, you can do something
like

  ./doc-diff --asciidoctor --cut-header-footer foo bar --
--ignore-space-change --word-diff

to reduce the amount of noise in the diff by a great deal. Going through
the result, I noted two issues which should be fixed by Asciidoctor
1.5.7, according to some initial searching (but I haven't tested):

"--" renders as an em dash followed by a ";". Looks like it's
https://github.com/asciidoctor/asciidoctor/issues/2604

"&" turns into "&amp;". Seems to be known and fixed:
https://github.com/asciidoctor/asciidoctor/issues/2525

Plus a few other problems. There's the odd problem here and there, but
most of the diff seems to be a large number of occurences of just a few
issues.

It would probably be worthwhile to try 1.5.7+ to see how much that
improves things. Seems like you're already underway there.

Martin
