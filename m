Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EBCA1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 02:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbdL0CoU (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 21:44:20 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:35639 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdL0CoT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 21:44:19 -0500
Received: by mail-io0-f177.google.com with SMTP id 14so27556546iou.2
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 18:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+mZmyOlQklZ4VaHzDpuoa/JQxJKqT04b4juprJ6QzyE=;
        b=M5HOORUv8G6uayEFxHMJrV+ik8plZncnlVLwqDta8XyUhnlXPL6bSpekqXFvHzGcLa
         tR27v0tWe7VsAFpb7LoSQ4b5vghLH7mO6MQU6H31NN5r5qYpIJpbe+GDAu94uqaht0bc
         SrtJ+P/3eoZxUBksuDe+72cqV9/tlHB66Gxe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+mZmyOlQklZ4VaHzDpuoa/JQxJKqT04b4juprJ6QzyE=;
        b=JyHZC/SxiF9pJtFqI3Pzv4GXJnBW2KJnuGKto6OP88FHmclJWSV7gFqoaCIASCRs72
         iGsGdmo3U3eROxcl/rYrZg/jejmIdtTZ6FDbEtTOI7dy+6wxKqmCT8FDjQtsA8EyNW6Z
         qSXMilwTZGwLLn+bpB0w/bwVGGYEMb8nk9R0dhf6WbEC7+5nS33M5KBgHSymAJQw/y0u
         fUoGcUcSqPCmL3jqFauLnbwIjBE/BOihGJj6XYh0UHTTXJvSvt3kDJ5jxBXpvi2Bp1e1
         sA06reUOjs7aFCA60qZO6siWSwUEJnO2knYY5gglo4GT/Cn0c5YmCI0fVg3HXwCPPsP4
         J+5g==
X-Gm-Message-State: AKGB3mLMkHh0sLajgIquafhAU3VMeFO3jTryjzri7dx4yVEueFn/etNT
        CIrQwsEVReDUrTsYJwHYoHJqBf+Qpe0=
X-Google-Smtp-Source: ACJfBouUwxE36281loXyWnDUwMqp5jNev5s954nOv/rg4AxlQYTBKEjQaKLncB/vO0sSK3bmmJzAyw==
X-Received: by 10.107.53.99 with SMTP id c96mr27618903ioa.147.1514342658391;
        Tue, 26 Dec 2017 18:44:18 -0800 (PST)
Received: from Carl-MBP.ecbaldwin.net ([2601:282:8001:ffba:59aa:140c:4d30:a473])
        by smtp.gmail.com with ESMTPSA id c8sm9800539itg.15.2017.12.26.18.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2017 18:44:17 -0800 (PST)
Date:   Tue, 26 Dec 2017 19:44:15 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20171227024413.GA26579@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <20171226040843.h7o6txkrp6zlv7u5@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171226040843.h7o6txkrp6zlv7u5@glandium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 26, 2017 at 01:08:45PM +0900, Mike Hommey wrote:
> FWIW, your proposal has a lot in common (but is not quite equivalent)
> to mercurial's obsolescence markers and changeset evolution features.

I've had experience with mercurial but not since about 2009. After
reading up a little bit on this changeset evolution feature, it looks
very much like what I'm proposing. Obsolescence markers look a lot like
replaces references except, as illustrated by this blog [1], they point
the other way! Hence, the illustrations confused me for a moment. It
seems more natural to embed the reference in the new commit pointing at
the old. That said, the illustrated direction of the arrows doesn't
really affect the usefulness of the idea.

His third example (#3-working-with-other-people), appears to be the kind
of collaboration that I'm trying to describe here. To quote the blog:

  In git or vanilla (no extension) mercurial, you would have to figure
  out that b’ and b” are two new versions of b and merge them. Changeset
  evolution detects that situation, marks b’ and b” as being divergent.
  It then suggests automatic resolution with a merge and preserves
  history.

This is the kind of thing that I had to deal with manually in gerrit. I
hadn't seen this feature in mercurial but I'm glad to know now there is
a precedent for it.

Carl

[1] https://blog.laurentcharignon.com/post/2016-02-02-changeset-evolution/
