Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1015E1F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 06:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfJaGTo (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 02:19:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37751 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfJaGTo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 02:19:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id p13so2204409pll.4
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 23:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WMAgk3aL5FKMzFlkopHAtgcFi01a2WFVBgToGG+f3WI=;
        b=ZhXPz2xa9KkJRf/jO74y4evoLGoGkhP1Z2xiLuNoHgoo6fOrqXVo20DL/d/ATTvZpi
         Uery8eMjbbM+uUiWmmsQcYniXZ1/JVnkfhpDSk41ueWt9YWCNu4B720U/dvOlZoa/C+D
         pmtYB2atiCIhNskCAg6OjVpEQPnn0KtKLZw0QNwUPY1yRCtWgWsFP96GsG0F6gsI8KsO
         crbN5gmlI5pLU4DrJ5HfHPuG6Rfi3kENw/Lq+Y8APz8015WdV1rnPguTlEBUom9octl8
         grmoHwaadFV/MrE/+KM8pCsl8N8zHO8bwjeQLQWRHG1Q0xsxYUZ3QS7GbYz+K04GEIhr
         8EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WMAgk3aL5FKMzFlkopHAtgcFi01a2WFVBgToGG+f3WI=;
        b=T8LQBINcp3+kv4dPajWqNg7fhaXQBlpFP2BLA5yqOZbejwzFEMXJN5TP2RW7mDUx7D
         Od4BeG1peQw/08RC/QtZlbeisQ4FTXnZ1/IkUPbOr2PizB5F23fD9YvD1mZJ7I/SqZFB
         ju/Yo8rvHey3yhPLgk61jbmBTdqJqrThe3hTaqd+S0RQ+zvZyB6ir0XmCLnCo9YKIbUr
         QOE9D6Jbic3rQjEFsZHcTV/iefoTn5c9vhY4xKyN03g3xy5BbPz2VLche/n/JuSqRe07
         ELP5RDs+yXFvn1KYkD+zMlDz/rQ2Yqa87F7kNEjFIHTnWjLcjb28L72n5o7RAQHqKrhe
         GMjA==
X-Gm-Message-State: APjAAAWWPOPE3d7jPNfECjo3lUE0TznnERgwibyCK6hVPefHbKigvKKn
        MZinmL1zM5Fvz7gGJMpb7f6XSMrwNQLZ9/Vs1ZM=
X-Google-Smtp-Source: APXvYqxMvNyg3qcRuoY2CHZFZ29qyodlYnMmeBjI23qzcog1KwGOxsTxwEGAE/SsKqhz7bSw1qmyAcAteK4+oUZIfII=
X-Received: by 2002:a17:902:9308:: with SMTP id bc8mr4431066plb.178.1572502781712;
 Wed, 30 Oct 2019 23:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191030204104.19603-1-martin.agren@gmail.com> <20191030212422.GE29013@sigill.intra.peff.net>
In-Reply-To: <20191030212422.GE29013@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 31 Oct 2019 07:19:30 +0100
Message-ID: <CAN0heSrWqc2cyqOBVaWQOJHs4+48viAGL7YPGP6QnDrf+m_Jpw@mail.gmail.com>
Subject: Re: [PATCH] manpage-bold-literal.xsl: provide namespaced template for "d:literal"
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 30 Oct 2019 at 22:24, Jeff King <peff@peff.net> wrote:
>
> On Wed, Oct 30, 2019 at 09:41:04PM +0100, Martin =C3=85gren wrote:
>
> > We recently regressed our rendering of "literal" elements in our
> > manpages, i.e, stuff we have placed within `backticks` in order to
> > render as monospace. In particular, we lost the bold rendering of such
> > literal text.
>
> This is just when rendering with asciidoctor, right? AFAICT the bolding
> is still fine in pages built with asciidoc.

Right. Sorry for being unclear. Fixed in v2.

> > One reason this was not caught in review is that our doc-diff tool diff=
s
> > without any boldness, i.e., it "only" compares text.
>
> I don't think this was intentional, but just a consequence of
> redirecting man's stdout to a non-terminal. Doing:
>
>   MAN_KEEP_FORMATTING=3D1 ./doc-diff --asciidoctor HEAD^ HEAD
>
> on your patch shows the improvement, though note that the diffed version
> is kind of ugly. It looks like the bolding is done with ^H characters,
> and it interacts in a funny way with our diff coloring, as well as with
> diff-highlight if you use it. Piping the above through "less" looks
> decent, but it gives me pause on whether we should be setting that
> variable inside the script.

Very interesting! Thanks for this trick.

> Speaking of annoyances, is it just me, or does the rendering stage of
> doc-diff not actually proceed in parallel? Doing this seems to help, but
> I'm not sure why:
>
> diff --git a/Documentation/doc-diff b/Documentation/doc-diff
> index 88a9b20168..1694300e50 100755
> --- a/Documentation/doc-diff
> +++ b/Documentation/doc-diff
> @@ -127,7 +127,7 @@ generate_render_makefile () {
>         while read src
>         do
>                 dst=3D$2/${src#$1/}
> -               printf 'all:: %s\n' "$dst"
> +               printf 'all: %s\n' "$dst"
>                 printf '%s: %s\n' "$dst" "$src"
>                 printf '\t@echo >&2 "  RENDER $(notdir $@)" && \\\n'
>                 printf '\tmkdir -p $(dir $@) && \\\n'
>

Hm, didn't look into this. Will try to find the time.

> I also confirmed with the MAN_KEEP_FORMATTING trick above that "doc-diff
> --asciidoctor" fixes the problem as advertised, and "--asciidoc" has no
> change at all.

Thanks!

> >  There are more manpage-*.xsl -- manpage-suppress-sp.xsl looks like it
> >  would have the exact same problem. But before diving in too deep, I'd
> >  rather submit this one to see if it's in the right direction at all.
>
> It looks like a lot of them don't actually match on the namespaced
> tagnames, and so are OK. Some of them require special options to enable,
> so we wouldn't necessarily notice problems via doc-diff.
>
> From my brief look, I think suppress-sp is the only one that needs
> attention. I kind of wonder if we can just drop it. According to the
> Makefile comment, it's needed only for docbook 1.69.1-1.71.0. But 1.71.1
> came out in 2006. Surely even RHEL7 or whatever ancient system people
> use is past that, right? :)

I also only had a brief look and realized I wouldn't know how to test
with such a broken version, so I didn't feel comfortable mucking around
with that file.

> Or alternatively, as I've argued elsewhere, we could simply be a little
> more aggressive about deprecating old doc build tools. According to the
> Makefile, no extra settings are needed with docbook >1.73.0. That came
> out in 2007. I'd be willing to just call that the cutoff point, and
> anybody without it can install the pre-formatted pages.

Yeah, that makes sense.

Martin
