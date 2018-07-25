Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4B21F597
	for <e@80x24.org>; Wed, 25 Jul 2018 15:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeGYQ1h (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 12:27:37 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36885 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbeGYQ1h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 12:27:37 -0400
Received: by mail-it0-f67.google.com with SMTP id h20-v6so8030144itf.2
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N0ayVUt6Ch0HBNzOiSx2HZc/TJHbo1siebpF6pUZLKI=;
        b=bjr4wJvyk1IdnFX6gbadLqIzSwXqyS0m6v9trEMpnMBeYs2dbtvhwt0/aGuXGhJhQU
         1ySZDxFPnDo208rbrAUMIzGhzTScE2dOR7Gow7wE5lhTf2hbayoL/Zrtfv8zB8pbAqKv
         AAExYYIMTZ3J5mwHCqKX+NXsLZKN3nVnglaI69c2VmENcyGcvNGPriBqnO3OA2+pSFgT
         RpGmM18TopoSm/iPq3rAcm44qLu60Zw4Jx4O40lDQBdUa5tdBwJAS30cqFME7yNA/E4r
         Ll4dLJ1Y7iOtkMBYcxM4muoIHKrZ3JXp9QaTKmjxA2EAfaIGziA55YJfA8OMeF64ucDc
         Fs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N0ayVUt6Ch0HBNzOiSx2HZc/TJHbo1siebpF6pUZLKI=;
        b=lzPHUp01SOSEbScOLT32gg4BzpD+wcfSaKhgsS4bEZsFO+ctjgmCU+cF8r6nLCPdYL
         Tns+Vqmlx5HZ8v+XEPoOAR40vL9kkoI8hSDfWW7ACC6vISYdOzOgx+Wi4vQoaKuFgCA2
         0uJpKN6v1EsWHugYkGbYq2UHSSwxNhXzmurbEw1ThIfruhCPKFSEnAUZdOknEJQZfqqN
         zG9yHBmLm1TvH4G/B0iC7SZQbeodcJejMIxxEFMi/zHE0gkowOwVhOXVt+trOG54/fyk
         8RQrPp47TR4iLwUayM1mkqALTIrpCqbOIYVYC/SP6fmrd4uNC5HdSWzHb3IvGtIfTqXe
         TP7Q==
X-Gm-Message-State: AOUpUlGofUqT2Ed5lRNwOw4YZ7yzdLI5RyThVz7lJwtTRpOykWvq5yRZ
        bMLIZZ17Ed2iwoCbARI3ZYSIUcS5T9ouWnVkwKM=
X-Google-Smtp-Source: AAOMgpcrLY7cKhbpM+o9kLpgMGW2i5kLylyX7Z8O7kccRDk7ND558yg/L+PcESjzz6vg8El/jwDfny+2J2paiBbAOoQ=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr6356724itf.121.1532531729904;
 Wed, 25 Jul 2018 08:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180717210915.139521-1-bmwill@google.com> <20180724192811.GC225275@google.com>
In-Reply-To: <20180724192811.GC225275@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 25 Jul 2018 17:15:03 +0200
Message-ID: <CACsJy8C9z14GsxfyPm_pDuGwAQqm6Cdi2dO3bsqiYDE0scVbkQ@mail.gmail.com>
Subject: Re: [RFC] push: add documentation on push v2
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 9:29 PM Brandon Williams <bmwill@google.com> wrote:
>
> On 07/17, Brandon Williams wrote:
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >
> > Since introducing protocol v2 and enabling fetch I've been thinking
> > about what its inverse 'push' would look like.  After talking with a
> > number of people I have a longish list of things that could be done to
> > improve push and I think I've been able to distill the core features we
> > want in push v2.  Thankfully (due to the capability system) most of the
> > other features/improvements can be added later with ease.
> >
> > What I've got now is a rough design for a more flexible push, more
> > flexible because it allows for the server to do what it wants with the
> > refs that are pushed and has the ability to communicate back what was
> > done to the client.  The main motivation for this is to work around
> > issues when working with Gerrit and other code-review systems where you
> > need to have Change-Ids in the commit messages (now the server can just
> > insert them for you and send back new commits) and you need to push to
> > magic refs to get around various limitations (now a Gerrit server should
> > be able to communicate that pushing to 'master' doesn't update master
> > but instead creates a refs/changes/<id> ref).
> >
> > Before actually moving to write any code I'm hoping to get some feedback
> > on if we think this is an acceptable base design for push (other
> > features like atomic-push, signed-push, etc can be added as
> > capabilities), so any comments are appreciated.
> >
> >  Documentation/technical/protocol-v2.txt | 76 +++++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
>
> Pinging this thread again to hopefully reach some more people for
> commentary.

Could you send a v2 that covers all the push features in pack version
1? I see some are discussed but it's probably good to summarize in
this document too.

A few other comments

If I remember correctly, we always update the remote refs locally
after a push, assuming that the next 'fetch' will do the same anyway.
This is not true for special refs (like those from gerrit). Looking
from this I don't think it can say "yes we have received your pack and
stored it "somewhere" but there's no visible ref created for it" so
that we can skip the local remote ref update?

Is it simpler to tell a push client at the end that "yes there's new
stuff now on the server, do another fetch", sort of like HTTP
redirect, then the client can switch to fetch protocol to get the new
stuff that the server has created (e.g. rebase stuff)? I assume we
could reuse the same connection for both push and fetch if needed.
This way both fetch and push send packs in just one direction.
-- 
Duy
