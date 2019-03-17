Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7195B20248
	for <e@80x24.org>; Sun, 17 Mar 2019 20:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfCQUDp (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 16:03:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45118 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQUDo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 16:03:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so640663pgk.12
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 13:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oJtosTMVLY8xxUFvCTBZKhWcONKx0hkJhFjlQGy3L4w=;
        b=qjXZnR0AO5x8FMoPFOPrP7pI6SgnH8V9eMAVr/Dub3MOtDKUZ++GOTenFcAkUG9HuG
         OPguL6H/yS6P2Ybd5k7qGJhH4YIVT/dVjcEgQEpFolMy39Z/mSw9pTCGfw9XyUQhi/mY
         hJA5jrfd8zkT4/Nl115UfaNoxlDg2YijBRCSPEPmgNRn01MwwI1bfhVXWCvhBkVr3B3B
         /71VKIv5o5tHak7G/Hgm+3BLekM2hritR7BXQ31AOoHljAcLuhy2roP+SwhUxwkVXi5Q
         WYetosvU+jOJrSgzMh6ci6A/MzeulhQDek+GGO+oo+vApiq8Lel9iDBnPHZ34VqkkfcX
         w7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oJtosTMVLY8xxUFvCTBZKhWcONKx0hkJhFjlQGy3L4w=;
        b=G4SC531eSW5tTT2DRpeMXElL1wJrn9sHyuWIiIITJaWg0uuN9vW73u+1nf7IPyc/g3
         VAqLmt/zMT144srTHnobPc+RRQInK4PJdK6vIT3ugDXt3s7zgJ0fuR/hwewQ3OfXCEly
         kGOBYqvl9vvuWJg6RTZiw3OzHX/2JdKdfcsHHxovNMtlxZw8uMPSa786Q9FyEFHeCnlL
         2ZnHF0CcTihcbhdQY3rCjy1Yegup6X6AKuKmLa7RVNX+h6yQ9m9Oz5aITdFKMU5E6H4F
         r+U4RDVH0XfYNWYNTF+ub/BvMvuiXVAfLQXb+7pO9XE61kbdI3fEXNH44RG32Wcuabxt
         5vCA==
X-Gm-Message-State: APjAAAUgeE0tzNn1u0liQaj5HG84Fs3IB0ouApPhfovD3yA+zZKugt7/
        FXL6JsYRJgSmPpcNsmc1q55lGjNi7siT9BnPmbo=
X-Google-Smtp-Source: APXvYqzC+LzIAVr4e3UFiEQMv+tFqOzgLQeSifyBfAIe58mPkWcKuYZMLjsg1vn2BnVWgfZmv2EA33QMSxVNA7qdK/Y=
X-Received: by 2002:a63:4e57:: with SMTP id o23mr13444084pgl.368.1552853023837;
 Sun, 17 Mar 2019 13:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190317144747.2418514-1-martin.agren@gmail.com> <20190317194431.GY31362@pobox.com>
In-Reply-To: <20190317194431.GY31362@pobox.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 17 Mar 2019 21:03:30 +0100
Message-ID: <CAN0heSr3Q48Dfskc7A55Z6MUEk0A3MPQAn3b25+=J1Ezrwk9Hg@mail.gmail.com>
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

Hi Todd,

On Sun, 17 Mar 2019 at 20:44, Todd Zullinger <tmz@pobox.com> wrote:
>
> Hi Martin,
>
> Martin =C3=85gren wrote:
> > That is, we miss out on the `<refmiscinfo/>` tags. As a result, the
> > header of each man page doesn't say "Git Manual", but "git-foo(1)"
> > instead. Worse, the footers don't give the Git version number and
> > instead provide the fairly ugly "[FIXME: source]".
> >
> > That Asciidoctor ignores asciidoc.conf is nothing new. This is why we
> > implement the `linkgit:` macro in asciidoc.conf *and* in
> > asciidoctor-extensions.rb. Follow suit and provide these tags in
> > asciidoctor-extensions.rb, using a "postprocessor" extension.
>
> > We may consider a few alternatives:
> >
> >   * Provide the `mansource` attribute to Asciidoctor. This attribute
> >     looks promising until one realizes that it can only be given inside
> >     the source file (the .txt file in our case), *not* on the command
> >     line using `-a mansource=3Dfoobar`. I toyed with the idea of inject=
ing
> >     this attribute while feeding Asciidoctor the input on stdin, but it
> >     didn't feel like it was worth the complexity in the Makefile.
>
> I played with this direction before.  Using Asciidoctor we
> can convert directly from .txt to man without docbook
> and xmlto.  That does have some other issues which need to
> be worked out though.  Here's what I had as a start:
>
> -- 8< --
> Subject: [PATCH] WIP: doc: improve asciidoctor manpage generation
>
> Avoid 'FIXME: Source' by setting mansource.  Skip xmlto step and render
> manpages directly with asciidoctor.
>
> TODO:
>     - apply to all man pages
>     - fix links to html docs, like user-manual.html in git.1 (currently
>       it is listed in brackets inline rather than as a footnote)
>
> Reference:
> https://lore.kernel.org/lkml/20180424150456.17353-1-tiwai@suse.de/
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  Documentation/Makefile                  | 8 ++++++++
>  Documentation/asciidoctor-extensions.rb | 2 ++
>  2 files changed, 10 insertions(+)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index a9697f5146..494f8c9464 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -197,6 +197,7 @@ ASCIIDOC_DOCBOOK =3D docbook45
>  ASCIIDOC_EXTRA +=3D -acompat-mode -atabsize=3D8
>  ASCIIDOC_EXTRA +=3D -I. -rasciidoctor-extensions
>  ASCIIDOC_EXTRA +=3D -alitdd=3D'&\#x2d;&\#x2d;'
> +ASCIIDOC_EXTRA +=3D -a mansource=3D"Git $(GIT_VERSION)" -a manmanual=3D"=
Git Manual"
>  DBLATEX_COMMON =3D
>  endif
>
> @@ -354,9 +355,16 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
>  manpage-base-url.xsl: manpage-base-url.xsl.in
>         $(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
>
> +ifndef USE_ASCIIDOCTOR
>  %.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
>         $(QUIET_XMLTO)$(RM) $@ && \
>         $(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
> +else
> +%.1 %.5 %.7 : %.txt
> +       $(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> +       $(ASCIIDOC_COMMON) -b manpage -d manpage -o $@+ $< && \
> +       mv $@+ $@
> +endif
>
>  %.xml : %.txt asciidoc.conf asciidoctor-extensions.rb
>         $(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asci=
idoctor-extensions.rb
> index f7a5982f8b..ebb078807a 100644
> --- a/Documentation/asciidoctor-extensions.rb
> +++ b/Documentation/asciidoctor-extensions.rb
> @@ -12,6 +12,8 @@ module Git
>          if parent.document.basebackend? 'html'
>            prefix =3D parent.document.attr('git-relative-html-prefix')
>            %(<a href=3D"#{prefix}#{target}.html">#{target}(#{attrs[1]})</=
a>\n)
> +        elsif parent.document.basebackend? 'manpage'
> +          "#{target}(#{attrs[1]})"
>          elsif parent.document.basebackend? 'docbook'
>            "<citerefentry>\n" \
>              "<refentrytitle>#{target}</refentrytitle>" \
> -- 8< --
>
> That was based on ma/asciidoctor-extensions, but it may be
> missing other recent improvements you've made to the make
> targets.  It's been a month or so since I worked on it.
>
> I munged up doc-diff to set MANDWIDTH=3D1000 and set one
> branch to default to asciidoctor to compare.  (Your other
> recent series looks like it'll make doing asciidoc and
> asciidoctor comparisons easier.)
>
> There were a number of differences that I didn't work
> through though.  Most importantly was the change in the
> links noted in the commit message.

Your approach looks like the correct one long term, at least.

I'll try to play with this to see if I can figure out the differences.
That will have to wait until tomorrow though.

Thanks for sharing your progress.

Martin
