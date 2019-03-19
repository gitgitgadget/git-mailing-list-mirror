Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B1D320248
	for <e@80x24.org>; Tue, 19 Mar 2019 07:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfCSHLG (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 03:11:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37042 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCSHLF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 03:11:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id q206so13242895pgq.4
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 00:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oKNW+NoTOuXbkQDwaYDIGyrIKbV5KqmBngJsdX+gRIY=;
        b=kvWOgGR+llgc/PJ8Nt8jz3w1BjV572hgHlHjg0bmhLHGl1+Gyfm20jYxBcJFajSs47
         72uER11FwJvBXQpWUn6Zu77O2uLec0nmMigOU0uvdWNRBeDHv/+9HuaSJdCboLrHnq1R
         geolsnNCu4X615JA44aVW1g0c6I37eWUOSLhQ4b4pw+SNsZR/9l455Vtxv2Levx08HNq
         ZswHWPnnLZkcJqAbH4sbymlHj4k4pulxltapbDB3W3lyeYsVA9lZkiaqVjHf3THHqko8
         5sJTO8ghft9vMbZcDyCMhTsMSjtNL7gX1pNQVvK/8P1ZKkzO+M8Z7H/HRtDV8A34/2MI
         LGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oKNW+NoTOuXbkQDwaYDIGyrIKbV5KqmBngJsdX+gRIY=;
        b=ZeoEzJ+r+OIdenkMjVM9QcXh1hKCStceZgrLr9/qdtqXN6iqNNOcGUvoz8EAvPR49l
         dAtjYrrkyI46V4UnsuqBY5FO8B2APhedEiPU2bnUW8SyTn3EExHVCu7OASNfXspCCNqG
         65yb+WkYlpgWUlxoIPxbxdeYkRdiTQU+bYvfUSUI8vVotiLuUvKi7OS/TWRo+crRAc5d
         0+K7nGHEN+lLif8oU2t4GQZvtPOdiJlnH8gN84ksRr1fo18u5+rS+leHyKOlT+lzCewe
         MbaDyqvAUDHuhbGtZZQ18mOZXqhJc6PU4dvnCIGqx1XBw9wV312VX9UDsC2oBW6DFIsg
         CpnA==
X-Gm-Message-State: APjAAAWkKnqnIKsG3KCsWCEaAwzhQSFMYPBoPcf9R3Tzzx7H7K/c3sS1
        0Tla2n1edciDl2S138pUUeInZ6SR389d6/+D6v0/0rOPKIM=
X-Google-Smtp-Source: APXvYqw9yih0CUiqoCvGBdHM/+ArXn1tMFytGy63phj6tISGAGPSdL3gUyTsO2DCK4X3R46wy2VQsFh77hRGXo1u9gM=
X-Received: by 2002:a63:4287:: with SMTP id p129mr20597164pga.84.1552979464649;
 Tue, 19 Mar 2019 00:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190317144747.2418514-1-martin.agren@gmail.com> <20190319024645.GA6173@sigill.intra.peff.net>
In-Reply-To: <20190319024645.GA6173@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 19 Mar 2019 08:10:52 +0100
Message-ID: <CAN0heSoS_M-nYCTaL0jKBot8PWv1k-nscD9tgf3pgAz-Ddn-7g@mail.gmail.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 19 Mar 2019 at 03:46, Jeff King <peff@peff.net> wrote:
>
> On Sun, Mar 17, 2019 at 03:47:47PM +0100, Martin =C3=85gren wrote:
>
> >  Cc Todd and Peff who had a brief exchange [1] a while ago. Apparently
> >  Todd saw this "[FIXME: source]" on Fedora but Peff did not on Debian.
> >  I'm on Ubuntu 18.04 and used to see this also on 16.04. I'm not sure
> >  what might make Debian so special here.
>
> I think it was just that my version of asciidoctor had
>
>   https://github.com/asciidoctor/asciidoctor/pull/2636
>
> and Todd's did not. However, mine still does not do the _right_ thing,
> because we didn't pass the right attributes in to asciidoctor. It just
> didn't print an ugly "FIXME". Looking at the XML, I have:
>
>   <refentrytitle>git-add</refentrytitle>
>   <manvolnum>1</manvolnum>
>   <refmiscinfo class=3D"source">&#160;</refmiscinfo>
>   <refmiscinfo class=3D"manual">&#160;</refmiscinfo>
>   </refmeta>
>
> So it's just an nbsp instead of the real content, and the "version"
> field is missing entirely.

Huh, yeah, that's a big improvement already.

> > That Asciidoctor ignores asciidoc.conf is nothing new. This is why we
> > implement the `linkgit:` macro in asciidoc.conf *and* in
> > asciidoctor-extensions.rb. Follow suit and provide these tags in
> > asciidoctor-extensions.rb, using a "postprocessor" extension.
>
> Yeah, that seems sensible overall. Some thoughts on your approach:
>
> >   * Provide the `mansource` attribute to Asciidoctor. This attribute
> >     looks promising until one realizes that it can only be given inside
> >     the source file (the .txt file in our case), *not* on the command
> >     line using `-a mansource=3Dfoobar`. I toyed with the idea of inject=
ing
> >     this attribute while feeding Asciidoctor the input on stdin, but it
> >     didn't feel like it was worth the complexity in the Makefile.
>
> It does seem like "mansource" is the way asciidoctor expects us to do
> this. Why doesn't it work from the command line? Is it a bug in
> asciidoctor, or is there something more subtle going on?
>
> I think even if it is a bug and gets fixed, though, it still wouldn't
> have the version field (though that seems like something we could
> contribute to asciidoctor).

The bug is in my docs-reading, see below.

> >   * Considering the above abandoned ideas, it seems better to put any
> >     complexity inside asciidoctor-extensions.rb. It is after all
> >     supposed to be the "equivalent" of asciidoc.conf. I considered
> >     providing a "tree processor" extension and use it to set, e.g.,
> >     `mansource` mentioned above.
>
> This seems like the least bad option, at least for now. Your code does
> do a generic regex substitution. The promise of XML is that we're
> supposed to be able to do structured, robust transformations of the
> document. But my experience has been that the tooling is sufficiently
> difficult to work with that you just end up writing a regex.
>
> So I'm curious if you tried to use an actual XML parser (or god forbid,
> XSLT) to do the transformation. But if you spent more than 5 minutes on
> it and got disgusted, I wouldn't ask you to look deeper than that. :)

Well, I didn't spend 5 minutes on it, but my experience told me
something like that would happen. ;-)

Now I realize that I'm wrong in my "it doesn't work from the command
line". Somehow, I read the following in the user manual: "Many
attributes can only be defined in the document header (or via the API or
CLI)." And *repeatedly* read is as "(not via the API or CLI)", somehow
always expecting a "not" to follow an "only". Oh well.

But of course, I did try it out before reaching for the docs, like
anyone would. The true reason it doesn't work for me is probably this
header from the listing that contains "mansource": "Manpage attributes
(relevant only when using the manpage doctype and/or converter)".

> I doubt we'd see any other refmeta tags (and any non-tag content would
> be quoted).
>
> > Let's instead try to stay as close as possible to what asciidoc.conf
> > does. We'll make it fairly obvious that we aim to inject the exact same
> > three lines of `<refmiscinfo/>` that asciidoc.conf provides. The only
> > somewhat tricky part is that we inject them *post*-processing so we nee=
d
> > to do the variable expansion ourselves.
>
> One thing that asciidoctor buys us that asciidoc does not is that we
> might eventually move to directly generating the manpages, without the
> XML / Docbook step in between. And if we do, then all of this XML
> hackery is going to have to get replaced with something else. I guess we
> can cross that bridge when we come to it.

Todd has made a promising start in another part of this thread. There
seems to be a few wrinkles that need some care, but hopefully nothing
impossible (famous last words).

> The patch itself looks sane. Would we ever need to XML-quote the
> contents of git_version? I guess the asciidoc.conf version doesn't
> bother.

Good point. Hadn't thought of it. You're right that the asciidoc.conf
version has the same problem and a version string like "<>" goes
unescaped into the xml.

> Technically the user running "make" could put whatever they want
> into it, but I think this is a case of "if it hurts, don't do it", and
> we can ignore it.

:-)

Martin
