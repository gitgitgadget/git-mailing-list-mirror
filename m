Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D014A1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 05:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeFIFEV (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 01:04:21 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37745 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeFIFEU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 01:04:20 -0400
Received: by mail-oi0-f66.google.com with SMTP id l22-v6so13636919oib.4
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 22:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vXjQfY0C1ApFTUGRPCR79lzTBHf6k9UfD/D4uYSiWuA=;
        b=NmRjeCyYAZIdDn+RYQVgUQFTEfvH8TxMTB6pOS1JTUkaU9XFhrYUjTQESECoL94Q5f
         ZnuroU/3V7BsQz1pTPLF319Z4Pqnx4ZnBfJ4Ia+iLUU5zyPjMCPnhEyKh8OvPzEbZObL
         jbU4HtJ5nnvkVtZBvDEtRohOWDuj+e2lAL2TC7e85cc8W3QUkyAkiSOHJ6W27oxlYJRz
         rLT4KpFZD2VXsI3tL6RnPOHgEqgyvZBYbBlmauck6qiYk2SIREn2EwGI3zrEx59tIT8y
         y5zbx1QRlw0qyZzDeXjfVMS6JQvL79vf/NRhPE+090Y9ToEKkwAf4RtdoRTi2EJSCliB
         Cj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vXjQfY0C1ApFTUGRPCR79lzTBHf6k9UfD/D4uYSiWuA=;
        b=TP580eSg2BvoBGfFBntoIesZ3XTeEt4iAitDk8IKEM5xLOwr53z2zYperQyCxE8Jas
         yle8thG024hJOG5TbdF3fJ8z4/sGjMHX/U+q5mHa5uuBJEpvySFtQRk4mEtWQgJ4+ecv
         QV8zDhsqYyNQ+dS12nGENUtYN32sljzrWspboVTYCyCSxcPJ/V+QJbpj+Gy8+GpCNfyN
         TegBDx4pO38CQTuN24CLUQoTm79SmcZmJU2EDPqFDNI5kqjjvZTqc/YqfyuuVptzqwWL
         2/9wlnr1uY6YV/0KUf3/Kh1I0wpfwi0cNbixu4IFgM2HrQGXKQB8uXFPI7Uq+1SYR1SB
         6OKQ==
X-Gm-Message-State: APt69E0y5ipDs1baddbUZHXtkvkqXDmq4TG5bbpaVN5vesfc71bzG/nG
        k/oEClIXSlMUBV5+IizfkM0HB/D1Z6SgInAPJ+c=
X-Google-Smtp-Source: ADUXVKKo9OfPTGpULJvEDJDXT6dtijf+2v7UPMXXC7Lo5BEWdZ0PccIKBizQRdfbMRPxxo1GnlQ0AAn0CZVjJrAbqC0=
X-Received: by 2002:aca:f594:: with SMTP id t142-v6mr4821066oih.56.1528520659766;
 Fri, 08 Jun 2018 22:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180607145313.25015-1-git@jeffhostetler.com> <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
 <20180608090758.GA15112@sigill.intra.peff.net> <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
 <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org> <87fu1w53af.fsf@evledraar.gmail.com>
In-Reply-To: <87fu1w53af.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Jun 2018 07:03:53 +0200
Message-ID: <CACsJy8BPhzs5M4peHN2HczmDxGmAuKZ0corzT66i+rJ2UQRTHQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 9, 2018 at 12:22 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Jun 08 2018, Johannes Sixt wrote:
>
> > Am 08.06.2018 um 18:00 schrieb Thomas Braun:
> >> I for my part would much rather prefer that to be a compile time
> >> option so that I don't need to check on every git update on windows
> >> if  this is now enabled or not.
> >
> > This exactly my concern, too! A compile-time option may make it a good
> > deal less worrisome.
>
> Can you elaborate on how someone who can maintain inject malicious code
> into your git package + config would be thwarted by this being some
> compile-time option, wouldn't they just compile it in?


Look at this from a different angle. This is driven by the needs to
collect telemetry in _controlled_ environment (mostly server side, I
guess) and it should be no problem to make custom builds there for
you. Not making it a compile-time option could force [1] linux distro
to carry this function to everybody even if they don't use it (and
it's kinda dangerous to misuse if you don't anonymize the data
properly). I also prefer this a compile time option.

[1] Of course many distros can choose to patch it out. But it's the
same argument as bringing this option in in the first place: you guys
already have that code in private and now want to put it in stock git
to reduce maintenance cost, why add extra cost on linux distro
maintenance?
--=20
Duy
