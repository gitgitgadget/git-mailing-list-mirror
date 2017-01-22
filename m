Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A9CF20A17
	for <e@80x24.org>; Sun, 22 Jan 2017 19:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbdAVTN5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 14:13:57 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35718 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbdAVTN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 14:13:56 -0500
Received: by mail-lf0-f49.google.com with SMTP id n124so83269659lfd.2
        for <git@vger.kernel.org>; Sun, 22 Jan 2017 11:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SWV9ijFLNCnWK2FFU0kgqU+DrVI4KaAK7nNzmZ/jsmo=;
        b=diay0g/obtGjC8BIG9ktw1+jzZU/4Gz+1DCvhzdgc+SHB0Har+/wC9zSr/H0Zm3Sz6
         ZjwDTlETw/Asur+04ws5p70iwlaMVUEG6of8+I/UhrqLHRz2MeJHIkhNB77sUr7ufpnl
         XXPLj6MppdZCEhBB89vYt9u2vCT4X0lBfCkYZFvMOpu6uD2F2bGtxZTseKksbUMCK+fX
         Ba9xekM031jYBvSjGwfhlzXX7agj6CzHI2637e8NPOw72OWNFqMKVey/Z/juvS2ha0xT
         VmcSeClZb4T8aCIR+WcrGRVtZw2iBzccQqPcwZcWLpp9SeQ002GEPSaele6cyLE3A3OO
         rShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SWV9ijFLNCnWK2FFU0kgqU+DrVI4KaAK7nNzmZ/jsmo=;
        b=saAKOU2sgpIw8lrjVgxbScSFbQrtTPbceYJrj88dYPa/vMNfgr2seDzxIPGrNg3Yt7
         OmdpQL1kwhtISKui+DW+iu+yydkOd//VbG+CTikGpNpEDqYFXxXa3x+2XasBGexHiDZm
         zX+UcL3Nb7iXRWcF0+7c2xXlyrXH1OzwwkL4rAT7kZS0/lwSl0AsiGkSYUIKv+wS+I9x
         5TyuGygjf2WoZQYKgiHqjrsiS/zVEqOv7vVO1Tt7wjgwV4HCxeHXVIHiYXh4ExCeVchr
         +An9pPA4Olpn30Fn76gzlp1AT+b50c6OPHiArkLc+bjk0HRgMWhwNMf31x+nB6zeWj4A
         QOUg==
X-Gm-Message-State: AIkVDXIRpMLDyMLpJ6+GTBvgxOOHsE6PSHJmDebDXTKBFpLlCmzZ4V/lvzuX0fuKa/WiSiUVFYjfGmArQ/4CXg==
X-Received: by 10.25.203.3 with SMTP id b3mr3147964lfg.130.1485112434286; Sun,
 22 Jan 2017 11:13:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Sun, 22 Jan 2017 11:13:53 -0800 (PST)
In-Reply-To: <20170121135545.gi6crct66msylhpr@sigill.intra.peff.net>
References: <20170121135545.gi6crct66msylhpr@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 22 Jan 2017 20:13:53 +0100
Message-ID: <CAP8UFD3Z9ZrLEZVkgL7ACkL5nOsoo2R6dUC=Bfy1AjF_9+4snQ@mail.gmail.com>
Subject: Re: [RFC] what content should go in https://git-scm.com/doc/ext
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 21, 2017 at 2:55 PM, Jeff King <peff@peff.net> wrote:
> I'm wondering if anybody has opinions on:
>
>   https://github.com/git/git-scm.com/pull/924
>
> (and I suspect most people in this community do not read pull requests
> there, hence this post).

Yeah, thanks for posting it here.

> Basically, we maintain a list of links to outside documentation, as well
> as to books. Somebody has requested a link to their paid tutorial
> course. How should we handle it?

I think it depends if you are ready and willing to handle more changes.

> If the resource is valuable, then it may make sense to link to it, even
> if it costs money. We already do this with book links, and my policy has
> been to link any relevant book that is requested (I don't read them for
> quality, so I have no opinions).
>
> Should we do the same for tutorial content like this?

It could make sense to link to tutorial content, and then it could
also make sense to link to trainings (online and maybe offline too),
but my fear is that you could then have many people who want to
advertise their tutorials and trainings, and that it might be
difficult to draw a line while keeping the playing field even.

But maybe it's worth trying anyway.
