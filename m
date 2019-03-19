Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91FB920248
	for <e@80x24.org>; Tue, 19 Mar 2019 07:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfCSHeL (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 03:34:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33438 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSHeL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 03:34:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id i7so10059389pgq.0
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 00:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=36LpXofcxCl3g+qFCw3geXextPIunx/S7wFzB6n4b1A=;
        b=QBb8zdK/lyFh48NJfCjXtdRC1x+khJj/pApFFUaEc9VoV3kTChqSm18YbZ29Sdi7+X
         GpeGYmkx7ehP9dPgZVHjbhcimIpqBk0WUbva93+VJIFUf7tzBn4HaNA34gs8Hk5Q//2t
         z9BorZ9ckkxxLQPvByNu2jesklP9pxUiSp3YyOChEeBN5hqt3HhMDr5GdMZr/960+RMM
         pPODgcRkiNthIe6K3Aeh+7Dyh/M5jzICQoq/ueNEXgz2KfoLN5tCxHfqwjRh/txgG8Ii
         kOFeni+/ytpklde3EClRtNeQuD4Tc6WAZ1WR0CAbTF0PS4MHr+WTrhmtOk77+Fo3MIVt
         u/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36LpXofcxCl3g+qFCw3geXextPIunx/S7wFzB6n4b1A=;
        b=p/gl/ssQOZb5wfsA7Nl+phZTKlBvjGmEbuh0E5MPkWZge8OdHsL+bM1PcTOZ0IoSWY
         6jh2ElbHFJhve4XOIKd4VDMKDMzDvkC0dvsdCy4/gVE/7w3iJbFFviOWTMCpirmtsedL
         3n+o0pOt+s3Z3XgYzprfL9nARQW+ZbI1DkM1FYnEXO67HkgXkkzTFsOteYJdwf6X86Xf
         yf4ZNDxWNgYDoioQWXag0KFtsdQ6XEbvTak3U8MxcsxYD2aBBue0c06WEetStfQmhoNh
         coGH1d4I8bPR9jylxjeBS0LJkMyAXxN94g9H5tEVbKU0IBY4eUzXZqtlHQXI0A6BnIjp
         rsmg==
X-Gm-Message-State: APjAAAVphBbsAWJ/b78/PTujBTlzoCzpSonArnatt07U1qfYA8ZpSN5p
        vkWiXO8WbvJL8Rbhcyczbqc7kKEgTgkQzFVa7C0=
X-Google-Smtp-Source: APXvYqysnSJkOpyIfe6ozfcyGJ8D2ZQv2MGX21aygLEC6cGAOjh5SjbfNX8AOwBqPzkByq/vPyiXTlrcbK8nMdTqknA=
X-Received: by 2002:aa7:914f:: with SMTP id 15mr562002pfi.49.1552980850793;
 Tue, 19 Mar 2019 00:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190317144747.2418514-1-martin.agren@gmail.com>
 <20190319024645.GA6173@sigill.intra.peff.net> <20190319025945.GB6173@sigill.intra.peff.net>
 <xmqqr2b3y0tx.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2b3y0tx.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 19 Mar 2019 08:33:57 +0100
Message-ID: <CAN0heSo2hdkvwnZPipgqnOnb4fmhdY6d+iHqXPfVyiLsf8SkOQ@mail.gmail.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 19 Mar 2019 at 04:55, Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > So in my mind, the endgame is that we eventually drop asciidoc in favor
> > of asciidoctor. The repo at:
> >
> >   https://github.com/asciidoc/asciidoc
> >
> > says:
> >
> >   NOTE: This implementation is written in Python 2, which EOLs in Jan
> >   2020. AsciiDoc development is being continued under @asciidoctor.
>
> ;-)
>
> > I'm not sure when is the right time to switch. If we can get the output
> > at parity, I don't think asciidoctor is too onerous to install (and we
> > don't have to worry about ancient platforms, as they can use
> > pre-formatted manpages).
>
> One minor thing that bothers me abit is the continuity of the
> pre-formatted pages when I switch to asciidoctor to update them.
>
> I do not mind having to see a huge diff in the "git log -p" output
> run in pre-formatted manpages and htmldocs repositories at the
> boundary due to e.g. the differences how lines are broken or folded
> between the formatters, but by the time we have to transition, the
> efforts by you, Martin and friends to allow us compare the formatted
> docs would have made the real differences to empty (or at least
> negligible).  Knock knock...

This might be a good spot to provide a bit of current status on this.

The patch under discussion here and 185f9a0ea0 ("asciidoctor-extensions:
fix spurious space after linkgit", 2019-02-27), reduce the diff
between asciidoc and asciidoctor considerably. Let's assume for the
moment that these patches or something like them enter master...

There's one larger difference in git-checkout.txt which I'm staying away
from at the moment, since Duy is doing a lot of work there at the time.
(He's not making that asciidoc/tor issue any worse, and he's not
spreading it to say git-switch.txt, so I'd rather just not rush to it.)
Let's assume I get around to this soonish...

Let's also assume that `./doc-diff --cut-header-footer --from-asciidoc
--to-asciidoctor HEAD HEAD` enters master [1]. Then what remains is a
fairly small and understandable diff where most issues are "yeah, I
guess that looks nicer" or even "they're just as fine", rather than "oh
wow, that's ugly". (IMHO.)

Martin

[1] You could already now run it to diff "master master", but you'd
trip on the Makefile thinking there's nothing to do. That'd be fixed by
9a71722b4d ("Doc: auto-detect changed build flags", 2019-03-17).
