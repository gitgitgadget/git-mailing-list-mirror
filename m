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
	by dcvr.yhbt.net (Postfix) with ESMTP id 238B41F463
	for <e@80x24.org>; Mon, 16 Sep 2019 10:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfIPKwJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 06:52:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32855 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfIPKwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 06:52:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so19634815pgn.0
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 03:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=W+sxCWPv46tnuaxEw+aneQYfmdnFjD0leNRnf6kD6WE=;
        b=EejeQu+xqra0Iq63JHRn0hipgkwOb1Mj/1rYV6fCPWwYAbCCm8azS/JTLYRkb/Kchd
         jiMVhJc3J8QedO+KF4iLnzNMnIxqQWqiAuBpbMIPVYZbBcwVdW4odrHMbCd8cGgl/mHt
         fPE8ABKhDogUk3WmFFeqAASVN0vnauniGxcF/SZpH12eF36UR/Rie2q3pZsyu96fcDpz
         iNZYw3OYBkM3ltweh/Iz0NyxQ5dxEdpPR4BoYm9BY/NiPXKVoPApU3g/PGEw8FRBr+Ed
         7BVcrYLE1BUt5Lf/I8btCzH24Of8tvAEOGCi74DJ29jx4Qe5lbg2YTL4beP2iCfije03
         UNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=W+sxCWPv46tnuaxEw+aneQYfmdnFjD0leNRnf6kD6WE=;
        b=eA9T/PFEnqp5cK3QUafynvxbEO7/8QWLUTwgH0bQ40n5wRb2WZ14sz93623JafTDW/
         QW6wEjYCmI2gRpZYBup3HI6CR65buiBtnTG2iv1z2oboPLbfBeU4ceANtdoT3VCh5oec
         z92JCKG7yJy6cDSY1Mc/m+greDBwId05hCMRVA+NSLKtVns6UAQdzPX6PZTfYmygpgdk
         9HdOcNkgVcROF+VzVEfrl0f3N7PrsEEs85orxyPhUJ/IobqkhbDYKqjyucuXPzBXxozq
         sdzrh6RyJY8Gah+puw95U7NQb/Qfkn9YIBO1TYsAG0OMeKCAvmZ2+FnBzgBIjzjFfjkq
         bwLg==
X-Gm-Message-State: APjAAAXHKJOsR/voAOnZTf6iVETjzDVixb1rXjWY8gSpyv86XBn7Kb4K
        nMjaGF5tAGczbpq/8LYzoQZhzP0mxQ0qO2E1h3k=
X-Google-Smtp-Source: APXvYqwRyO8tG/OraUylY36sNKnQ5QNsU/uErJmjZHWCz3kji0py1GQ8536i3GdVneJLyQFeZBY4yfQXX/NXdmrBELs=
X-Received: by 2002:a65:430b:: with SMTP id j11mr54892100pgq.383.1568631128417;
 Mon, 16 Sep 2019 03:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190914194919.748935-1-sandals@crustytoothpaste.net> <20190915095952.GA6190@szeder.dev>
 <20190915212621.GV11334@genre.crustytoothpaste.net>
In-Reply-To: <20190915212621.GV11334@genre.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 16 Sep 2019 12:51:55 +0200
Message-ID: <CAN0heSqWx09w_fVOBdaYCzz4Rse+sRPFLX1nu4iT9q0N5uzAmw@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: fix build with Asciidoctor 2
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 15 Sep 2019 at 23:26, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2019-09-15 at 09:59:52, SZEDER G=C3=A1bor wrote:
> > On Sat, Sep 14, 2019 at 07:49:19PM +0000, brian m. carlson wrote:
> > >     test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
> > >     gem install --version 1.5.8 asciidoctor
> >
> > So, since the documentation can now be built with Asciidoctor v2, is
> > it already time to remove this '--version 1.5.8'?
>
> I think Martin was going to send in some more patches before we did
> that.

I've got two series floating around [1] [2]. I'll be rerolling [2]
hopefully tonight and then I feel pretty good about the manpages. I've
got a third series that I'll get to then, which fixes up the rendering
of user-manual.pdf/html with Asciidoctor. Assuming those three series
graduate, I'm not aware of any reason to hold off on the switch to
"Asciidoctor by default".

As for "v2.x vs 1.5.8", that seems like a separate issue to me, though
-- and one that your patch does a very good job at! My series [2] will
make the rendering with v2.x /prettier/, but since your series makes the
docs build /at all/, maybe it's worth switching the CI-job sooner rather
than later to make sure we keep it so.

[1] https://public-inbox.org/git/cover.1567707999.git.martin.agren@gmail.co=
m/

[2] https://public-inbox.org/git/cover.1567534373.git.martin.agren@gmail.co=
m/

Martin
