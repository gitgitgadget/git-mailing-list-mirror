Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED5222022D
	for <e@80x24.org>; Fri,  4 Nov 2016 20:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758308AbcKDUrp (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 16:47:45 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34699 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758134AbcKDUro (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 16:47:44 -0400
Received: by mail-lf0-f54.google.com with SMTP id o141so1085810lff.1
        for <git@vger.kernel.org>; Fri, 04 Nov 2016 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YZNsvhhe/PqSvJ6rKrPxBVbRln1eBvdXCh24KGWFDpU=;
        b=ChA3VAeNMSEg6ijJWgv6GbsuOwTwxH7Deqyyx0sRUO4LOifGNjFuRfr0H3CH6vvA/T
         8WHAF8j9SdXEFwVZUjYbaikJX5MyC9m9COLCZte3FTCQ/eJ5F2yKzt51g4joFd6/w5Cw
         wusfrYShQZrRuMYLy0r6J8NC9oYAQhpi7ThFCirpfyy8CAFVy5TpyXN6qvmYfyLXtYTI
         Hs1/Dc+GbG9VdQWgxr0X924nJrE6utuCJVxrZrBfyov8ajhiGcHS/6YPtKf3xZalYy2a
         hpCN1h186ki2XrmttrW2XY4P2jzckEuGhAdNKD/9DSaLgbmu+KeA0Xdbu1YzdMhcjAms
         swkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YZNsvhhe/PqSvJ6rKrPxBVbRln1eBvdXCh24KGWFDpU=;
        b=KqYP3cnAOZCIcqESxVHxgDIDyVNs4o8A74gU8KG/7RuOU3mYuj/tuof3tDrVtE8NiR
         RP5SAvy2/1Vv+2XdbMV8+C2yLmgBl48WyFiTp49a5h/E3lU79yIuTnfLZKJxHBIswcaM
         iD+4A9sZHZoNbgOmuNnB/7RwuHBWbqsx00GLHwkPLdV5ldTO9lzHJ/CdMLZxCDF7M+Dj
         jhudzjEB/8mv7QW8Lz6Hah6djvbR72proNwRXkVh9sXKE8LGT8PyHkU5zNHtKemN1m1f
         rmwiypNXpmbYfYBSJYfLDNGbA44qkpSlR2ygFHMiaSod/FZ5lCs1si8PLTim6emxzdol
         0rQw==
X-Gm-Message-State: ABUngvfsZ+HbZm0zYDxdJVnsLPF2F08FpyyXntghPGeQTptmGhf7nO/icSjzbIl0Wa95MppAiZPk6LrqG+WJ5w==
X-Received: by 10.25.93.84 with SMTP id p20mr2398189lfj.151.1478292462139;
 Fri, 04 Nov 2016 13:47:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Fri, 4 Nov 2016 13:47:41 -0700 (PDT)
In-Reply-To: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 4 Nov 2016 21:47:41 +0100
Message-ID: <CAP8UFD2+A0MUKazAfSwCvv61TJRPuoOzH5EkqcrBOUi4TcuoDw@mail.gmail.com>
Subject: Re: Regarding "git log" on "git series" metadata
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Triplett <josh@joshtriplett.org>, git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 4, 2016 at 6:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Imagine we invent a new tree entry type, "gitref", that is similar
> to "gitlink" in that it can record a commit object name in a tree,
> but unlike "gitlink" it does imply reachability.  And you do not add
> phony parents to your commit object.  A tree that has "gitref"s in
> it is about annotating the commits in the same repository (e.g. the
> tree references two commits, "base" and "tip", to point into a slice
> of the main history).  And it is perfectly sensible for such a
> pointer to imply reachability---after all it serves different
> purposes from "gitlink".

The more I think about this (and also about how to limit ref
advertisements as recently discussed in
https://public-inbox.org/git/20161024132932.i42rqn2vlpocqmkq@sigill.intra.peff.net/),
the more I think about Shawn's RefTree:

https://public-inbox.org/git/CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com/

Couldn't a RefTree be used to store refs that point to the base
commit, the tip commit and the blob that contains the cover letter,
and maybe also a ref pointing to the RefTree of the previous version
of the series?
