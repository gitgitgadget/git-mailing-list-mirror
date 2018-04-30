Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CD18215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 16:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754832AbeD3QjJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 12:39:09 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:43172 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754613AbeD3QjI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 12:39:08 -0400
Received: by mail-yb0-f176.google.com with SMTP id x145-v6so2418914ybg.10
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KacRAlE1AsY2J35UPA+IFjA5jFoVW3IhOCwlYm1BCnM=;
        b=WrOpE8EsmrxEJwcoOwu1d0SdttBONqapBCkijtLZXaGXfy/ikC5DDTtuEszLBoB3Of
         LuSeTe9kE5XJt8U1tYIrCwYkBgHNrV+0isISxmm1WqkVUVD3mpelmYBbB1Np49yv1Kps
         +C5Z2Uqch0DhmzukT8ltUOdxntFQgtrLt0WgsQctX89/jrGmneJU/cyvanEujCoUhkm6
         ImmzoUA0pKuxzm6x4KrWnlJUuH8pOHfWntH4xmA/hf3Z6XHk0i6bFHVDhOJK0/GjXCaP
         JTmEHGlNcm3IwI2ivjEypoI6C0uGIxOi5fE8cCPtJnHUMA08ulQ2hkx3RXck9nDXsjQ6
         A7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KacRAlE1AsY2J35UPA+IFjA5jFoVW3IhOCwlYm1BCnM=;
        b=Agb1MR4xV8fK/hs0N9KekrrAMJ6e+I8QgRZ6Y3vd6dITk5fgDCb2xkQLYjGbhWazrL
         HlL0NXQkvUzaf6Zd4pdnG6/6hYH9Z1YeoCHLPd3Qi2FehgAdPyy+xM4IOUFJfoye0ZcJ
         UJNDFNWGekAHbdmgnivIMA2MOyDFLrx8DSJg+3xZRPzWtxFrUHUwiLj7P8GKPrlnUmbq
         ag4M/KiZ1w7Tqof+pK9yaS2wSlUgd8ujR5MgbF3rMV/e1obmiTBudJi2l7bqiQz9UPt8
         X3dVdbFzD9lEGlCWUwI6pQSGOdpYD6Jt1juRuh7FamhmQ3zkos+lpRkZ9M4V1mht2vlZ
         f89w==
X-Gm-Message-State: ALQs6tCVwwoHSvO3l7S7O6M4EIRvs11gzHExCq66EoH+Jhz6e+2U2i47
        sEXjprght7qn95+WWw4gqU8vfULZ2BYbpyyxyVjNUQ==
X-Google-Smtp-Source: AB8JxZpbjOedhNrPZ93sbw8eFQXqyaNECCf5ocicusk8Z6tvr/7AbPjgP9HGEU6Dt970cSpwrsGZSg5VXhBJHzdtBG0=
X-Received: by 2002:a25:69cf:: with SMTP id e198-v6mr7595670ybc.247.1525106347847;
 Mon, 30 Apr 2018 09:39:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 30 Apr 2018 09:39:07
 -0700 (PDT)
In-Reply-To: <CAJZjrdWEgdXmcXuxmF2CH3S6SZT8Lt-3Cw8ZJKiN6fnig-wivg@mail.gmail.com>
References: <CAJZjrdWEgdXmcXuxmF2CH3S6SZT8Lt-3Cw8ZJKiN6fnig-wivg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Apr 2018 09:39:07 -0700
Message-ID: <CAGZ79kaKqVyq=y6Ocbhg8Unb2eKLSzNUkE0ZNHBgC1Tvkiu3vg@mail.gmail.com>
Subject: Re: public-inbox.org down?
To:     Samuel Lijin <sxlijin@gmail.com>, Eric Wong <e@80x24.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Samuel,

public-inbox.org is reachable from here, which may not add a lot of
information to your debugging.

I cc'd Eric Wong, who runs the infrastructure of public-inbox.org, so
he knows of your problem.

Stefan

On Mon, Apr 30, 2018 at 8:59 AM, Samuel Lijin <sxlijin@gmail.com> wrote:
> DNS lookup is working but the website (possibly the server) seems to be
> down. The TLS handshake is never acked:
>
> $ curl -v https://public-inbox.org
> * Rebuilt URL to: https://public-inbox.org/
> *   Trying 64.71.152.64...
> * TCP_NODELAY set
> * Connected to public-inbox.org (64.71.152.64) port 443 (#0)
> * ALPN, offering h2
> * ALPN, offering http/1.1
> * successfully set certificate verify locations:
>    CAfile: /etc/ssl/certs/ca-certificates.crt
>    CApath: none
> * TLSv1.2 (OUT), TLS handshake, Client hello (1):
