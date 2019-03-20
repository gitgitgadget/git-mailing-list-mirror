Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC53C20248
	for <e@80x24.org>; Wed, 20 Mar 2019 20:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfCTUMH (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 16:12:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40995 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCTUMH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 16:12:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id k11so2573986pgb.8
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 13:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LNjWplGTFaVC/q1Wt1N19wP2PjtsqmLXelYWxEboQXc=;
        b=ovNRmbHw43qOkpsm2FBXuWkaDW5Q6pAfWhuVW6AzX9NyDX1F9FlR1Y21/cPcq4c9hl
         DTcQrrtLzoF5Azj1rQUH115Gj4Oko0GdWtbGN12CcsGGcO7bt30z8F1PaI1a0KxHXT1P
         1BddBu5hGl22utwv1la8xAuHtoJgG8pRTKD7Ox3WU2M+FU+8F2lJD4G3bHung9RY382X
         Zyuqo2ZrAKuXFuxapzyDF9j3Nn/s9oTBqYE110G+Wu11rotB0AjB8Wjl0TNY4yIVFJzT
         H1Ixbbk21loaIEWb8hEtNjOPjz/IBdZbBC8oPygsx4REb6wpQHHjTYY/61f5Gq2BtjEc
         B4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LNjWplGTFaVC/q1Wt1N19wP2PjtsqmLXelYWxEboQXc=;
        b=aCzKr82hCR03MZPmjhaUoMU2VjliFVP1Yh6+d/tNC6OswMUh1nNPNqpPBcAgs1j6ct
         rybPDPFsc3WkeLjTp+6HTJ55BFnH7sAYf4F9KpmSnmU9nQ8UoPTHvZKaiVxigO1OmnC/
         8r1x9wRQgczJwWBdEmp5ccb9cP/Roslp3tEkHiV3ZIh++PXgA1jOQvn5WJIYSNy8706z
         URFT0NyrL3hMk40wwRTfEVHv7PBDWbdG9UPJgIpLUWA2gCB4YW21BgVfraAUFgeYd23O
         h7NHoMtyDi6GX9SLxbDDPhaMIjSSLvcaGAJe1YWJhMBHxyUgOEWu3+ClZnqKkvREfp2V
         PvjQ==
X-Gm-Message-State: APjAAAV7K5xdL78+DrGP99/7bML6k8e2t0WzWluIazRrI35x8XzFlsSU
        QsKquu+kLip+juqkZXiIVqGxwiBJncXmHfPRXqdRrQ==
X-Google-Smtp-Source: APXvYqx2r7O7i/XzDf4XEhTDusFki3CLPDIlQgsyU8eCXOvAnSlQfndcHs61v+FL5XQ0m0EdTyyag18H0LzFiCOxrEM=
X-Received: by 2002:a63:2403:: with SMTP id k3mr9250565pgk.200.1553112726391;
 Wed, 20 Mar 2019 13:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552838239.git.martin.agren@gmail.com> <20190319031412.GC6173@sigill.intra.peff.net>
In-Reply-To: <20190319031412.GC6173@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 20 Mar 2019 21:11:53 +0100
Message-ID: <CAN0heSr0vVYBL9=xG=sqHFvRGHWVRi+Uzn1kekb6w6ZP6FHdog@mail.gmail.com>
Subject: Re: [PATCH 0/4] doc-diff: support diffing from/to AsciiDoc(tor)
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 19 Mar 2019 at 04:14, Jeff King <peff@peff.net> wrote:
>
> On Sun, Mar 17, 2019 at 07:35:59PM +0100, Martin =C3=85gren wrote:
>
> > I've taught `doc-diff` a few new knobs to support usage like
> >
> >   $ ./doc-diff --from-asciidoc --to-asciidoctor HEAD HEAD
>
> Very nice. All the patches look good to me.

Thank you.

> The "from" and "to" variants of the options are a little awkward; these
> are really properties of the actual endpoints. It would be nice if we
> had some fixed syntax that defined the whole state, like:
>
>   ./doc-diff asciidoc:HEAD asciidoctor:HEAD^

Right. I wasn't terribly impressed by the look of the "--from-foo
--to-bar" syntax, but at least I felt like I couldn't possibly mess up
the handling of it. As opposed to parsing substrings and whatnot.

> or something. But I think as you introduce new options (like the
> header/footer cutting) that syntax would get pretty unwieldy. So
> probably the separate options is the best way forward.

And this too. A few more orthogonal parameters on top and it would get
hairy pretty quickly. (At least I got the feeling it would.)

I think that at least --cut-header-footer is pretty useless to apply to
only one of the sides (you'd be asking for 4-6 lines to definitely
differ, for each and every rendered file), so this particular parameter
would perhaps not be useful to bake into your alternative syntax.

> > I'd be happy to rework the final
> > patch to `--cut-header` if that's preferred.
>
> I think what's here is fine for now. This is our own internal script, so
> if options become useless later on, we can always cull them.

That's true.

> > [2] After [1], the date in the footer is still formatted differently
> >     here. It might be a locale thing, and I tend to shy away from even
> >     trying to understand those. :-/
>
> Yeah, mine too.

Thanks for a data point. So at least it's not just me.


Martin
