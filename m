Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CC081F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbeGRS1n (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 14:27:43 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54810 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbeGRS1n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 14:27:43 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so5337545itb.4
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJU2PSFYMdJgJAV8dm2I8vSWCGzVQellpGsliNR66SY=;
        b=PedK9ZkdZ9vMs1SH+kkgjNCifBTn3GhgMXxN6abNSxkwgY5xBU6M+IlHh+QIvlPzfo
         gJS1yvroRlS9eisbsKBNOU4MlfCMpilSiETWc19ZIKwztl1WmvHZ0fv2YlcTc/RDiYt0
         cHK1u6Y1HnoT932WLzyKQefr5Jm4Z8GGtDb5Yiqvemq3u82fOS0aFIypQ6845kBuERjb
         j9kUeWmptalME1CT6fPEbdApbAFisToxnf61RD8eJkpOAWvIAwVzBNUyp871ruu6tTRd
         EPW5W+w5lf0euwQb0hkXRuuKuQ/7YPupvRqPcyZQj1U74JFKTfvlyzf56nf0ttV9CjNM
         rXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJU2PSFYMdJgJAV8dm2I8vSWCGzVQellpGsliNR66SY=;
        b=EOijDBZ+HMCFpkgXMLMUZW/dyFNgQ7XrA6aZy37qFliNYBJyHmSV7sglfqOnNHLAz+
         oEVrfm9DSWhgE4WdMHlRHqUNMish0kE1bcyH9JqIrKOZW2k/0vRfPMCRv753haONGzDT
         z3KPsa6Tgal6u2JV8ynuW2Jk0Vl8vdrfbTpFQSJqQbT2SWg1v6tE9c2bq9rziekpQh/B
         4xN2tvKm+HhkGaY7WVlgAkKlmMMiETJnYcYu5+a7i3oC6F361fWrDSM3qO68FL7p2AyW
         W/qyLvik4yq5r/op9Om+YucbL8coN3VcWR8dH7ccbb9i7q/UsikG4BdvNitoJHTAKbUQ
         2P2g==
X-Gm-Message-State: AOUpUlGi4HjCuQykGmUv6y6pzjVtSbifPWWIDgSrLREaDA3cdzMD3k4U
        VP6N9gkBkcxjkHZ91XqBwwURX7eEyoSZb2PpYcQ=
X-Google-Smtp-Source: AAOMgpf0DSP6aY9zuUQYuGUQeruODKA6GkTaVonfQjyLoLhwJZEc9IlBa5En2haN4uY4ynpTI9VXi29OWiyvcX54DQc=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr2770580itf.121.1531936123744;
 Wed, 18 Jul 2018 10:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.9.git.gitgitgadget@gmail.com> <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com>
 <20180713203140.GB17670@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1807142351100.75@tvgsbejvaqbjf.bet>
 <20180716173636.GA18636@sigill.intra.peff.net> <CACsJy8BV3ii3MkYf6UObsX_JdDbT9ovY_K9dCCeYvQ3FWqnRUQ@mail.gmail.com>
 <20180717194148.GC30594@sigill.intra.peff.net> <CACsJy8DW8=FoRyEwAy48S76q0gxQbrS3emHou7QDhHqzwJRu+g@mail.gmail.com>
 <20180718174505.GA3084@sigill.intra.peff.net>
In-Reply-To: <20180718174505.GA3084@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 18 Jul 2018 19:48:17 +0200
Message-ID: <CACsJy8DzUW69h-EdUs1nn227b3azFZYz5HPeG6+yp0FcAOQvNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] repack -ad: prune the list of shallow commits
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 7:45 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jul 18, 2018 at 07:31:40PM +0200, Duy Nguyen wrote:
>
> > > Sort of an aside to the patch under discussion, but I think it may make
> > > sense for prune_shallow() to take a callback function for determining
> > > whether a commit is reachable.
> > >
> > > I have an old patch that teaches git-prune to lazily do the reachability
> > > check, since in many cases "git repack" will have just packed all of the
> > > loose objects. But it just occurred to me that this patch is totally
> > > broken with respect to prune_shallow(), because it would not set the
> > > SEEN flag (I've literally been running with it for years, which goes to
> > > show how often I use the shallow feature).
> > >
> > > And if we were to have repack do a prune_shallow(), it may want to use a
> > > different method than traversing and marking each object SEEN.
> >
> > All of this sounds good. The only thing I'd like to do a bit
> > differently is to pass the reachable commits in prune_shallow() as a
> > commit-slab instead of taking a callback function. I'll refactor this
> > code, move prune_shallow() to a separate command prune-shallow and do
> > the locking thing.
>
> I think using a slab is much nicer than the current global-struct flags.
> But it's not as flexible as a callback, for two reasons:
>
>   - in the lazy case, the caller might not even have loaded the slab
>     yet. On the other hand, it might be sufficient to just be broad
>     there, and just always pre-populate the slab when
>     is_repository_shallow(), before we even call into prune_shallow().
>     If we have _any_ entries in the shallow file, we'd need to compute
>     reachability.
>
>   - it precludes any optimizations that compute partial reachability.
>     Asking "is XYZ reachable" is a much easier question to answer than
>     "show me the full reachability graph." At the least, it lets you
>     stop the graph traversal early. And with generation numbers, it can
>     even avoid traversing down unproductive segments of the graph.

Both good points. Callback it is then.
-- 
Duy
