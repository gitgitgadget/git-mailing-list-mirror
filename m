Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 498CA1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 20:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388756AbfIWUi7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 16:38:59 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:54283 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387586AbfIWUi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 16:38:59 -0400
Received: by mail-pg1-f201.google.com with SMTP id m17so9971044pgh.21
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 13:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2mNx3P5BUD/D4bEsH1/YYsLhNQcGY2kO7Y7k0/8DL5k=;
        b=giKO4reQnaEw9/f0p770kHtnZFOFzkhbIy0w+145/TeP1yxrSBKwKQ+AIXWm7BtKdg
         Qe1P9mrPKCui0eSUINR2GB1zXg5rOtulF+dpMr4u8fJmMGPStYS56b7Ug96nsZNKyMGl
         TR9h5025Cqvl6V/5w8njxqbZTdwVxpeSXg7kaELB44O9E+J8LctkNID4KDUoakU7t8Ni
         hRbrnnbjfQOSp03i9YPSSaBinz+7OUOHX0cNDlH2G+oK5Fc0fbuVxsC5hkZYs8MxuFYr
         pEGKy/9CkoOL5XfoUFur9UP0IXxBgOpQg2tkYFCkPi0ObVi9gRK/iXrV3IaNLThwQiab
         Ifew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2mNx3P5BUD/D4bEsH1/YYsLhNQcGY2kO7Y7k0/8DL5k=;
        b=Zc4QpX6pJ+hl9iaJIS4y9v81XNqdwQTlID2x/On8idI+qvUE6v2DEYFTLGYs8AMNPy
         OKWlWt/K5MOlfxIiENEf4vCEPcUxLacDTQAkYNSM1AGohgrSNUqEwO2PfmLqLrRc4Zwd
         PrNyI4loU77o+7bDNG4ONKVYa9/F/yvKK//m8S28MjdjtpANdIYcGWGUvAd5q71Y4Qqj
         +SzRdMTRs2evRLMjJ/k0Nex8PElpBh+8+JcvOPC7v6kBWndQPFpleah54dHCrqqN6JQ6
         k0PJSkFW38xl7L/67KHUnt179S6ZcDjjmTHdHqtnmIMEpdyGDc1+7BHMHSM+v7QkpH9H
         sOcA==
X-Gm-Message-State: APjAAAWyFUXxIs5pwKZN7n9t6xPdqe6k0CJkktglZ3OO7VUFa8XIYS1h
        Mpfko61ozqAOZf3gXoKie/S8NKfHYcBT5R7XyNpD
X-Google-Smtp-Source: APXvYqwLwKq/NPVbkvMb+8hG2HOdADfAU4Rp4nMxGMDpOQvvat6/dsY02aCycKjM9F5ehQzx0ENQZSgfQwUpneno7GmW
X-Received: by 2002:a65:6104:: with SMTP id z4mr1714265pgu.27.1569271138035;
 Mon, 23 Sep 2019 13:38:58 -0700 (PDT)
Date:   Mon, 23 Sep 2019 13:38:54 -0700
In-Reply-To: <20190923191509.GC21344@sigill.intra.peff.net>
Message-Id: <20190923203854.171170-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190923191509.GC21344@sigill.intra.peff.net>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: Re: Git in Outreachy December 2019?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think this is an OK level of detail. I'm not sure quite sure about the
> goal of the project, though. In particular:
> 
>   - I'm not clear what we'd hope to gain. I.e., what richer information
>     would we want to pass back and forth between index-pack and the
>     other processes? It might also be more efficient, but I'm not sure
>     it's measurably so (we save a single process, and we save some pipe
>     traffic, but the sideband demuxer would probably end up passing it
>     over a self-pipe anyway).

I didn't have any concrete ideas so I didn't include those, but some
unrefined ideas:

 - index-pack has the CLI option to specify a message to be written into
   the .promisor file, but in my patch to write fetched refs to
   .promisor [1], I ended up making fetch-pack.c write the information
   because I didn't know how many refs were going to be written (and I
   didn't want to bump into CLI argument length limits). If we had this
   feature, I might have been able to pass a callback to index-pack that
   writes the list of refs once we have the fd into .promisor,
   eliminating some code duplication (but I haven't verified this).

 - In your reply [2] to the above [1], you mentioned the possibility of
   keeping a list of cutoff points. One way of doing this, as I state in
   [3], is my original suggestion back in 2017 of one such
   repository-wide list. If we do this, it would be better for
   fetch-pack to handle this instead of index-pack, and it seems more
   efficient to me to have index-pack be able to pass objects to
   fetch-pack as they are inflated instead of fetch-pack rereading the
   compressed forms on disk (but again, I haven't verified this).

[1] https://public-inbox.org/git/20190826214737.164132-1-jonathantanmy@google.com/
[2] https://public-inbox.org/git/20190905070153.GE21450@sigill.intra.peff.net/
[3] https://public-inbox.org/git/20190905183926.137490-1-jonathantanmy@google.com/

There are also the debuggability improvements of not having to deal with
2 processes.

>   - index-pack is prone to dying on bad input, and we wouldn't want it
>     to take down the outer fetch-pack or receive-pack, which are what
>     produce useful messages to the user. That's something that could be
>     fixed as part of the libification, but I suspect the control flow
>     might be a little tricky.

Good point.

>   - we don't always call index-pack, but sometimes call unpack-objects.
>     I suppose we could continue to call an external unpack-objects in
>     that path, but that eliminates the utility of having richer
>     communication if we sometimes have to take the "dumb" path. A while
>     ago I took a stab at teaching index-pack to unpack. It works, but
>     there are a few ugly bits, as discussed in:
> 
>       https://github.com/peff/git/commit/7df82454a855281e9c147f3023225f8a6f72e303
> 
>     Maybe that would be worth making part of the project?

I'm reluctant to do so because I don't want to increase the scope too
much - although if my project has relatively narrow scope for an
Outreachy project, we can do so. As for eliminating the utility of
having richer communication, I don't think so, because in the situations
where we require richer communication (right now, situations to do with
partial clone), we specifically run index-pack anyway.
