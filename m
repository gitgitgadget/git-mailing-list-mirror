Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 653471F78F
	for <e@80x24.org>; Mon,  1 May 2017 20:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbdEAUu7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 16:50:59 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33086 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdEAUu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 16:50:58 -0400
Received: by mail-pg0-f42.google.com with SMTP id y4so44588181pge.0
        for <git@vger.kernel.org>; Mon, 01 May 2017 13:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QwBZeARoUMyAioFBTpaPXVTd/M/nRXI2yOlov7OC25M=;
        b=wRXbL0FNPG6m/gBDHc4VnmL4+/RHYY9sYn1IJibux5if3e8qarmycYXuNCRQiENjTv
         qSXlg9XNWVOHpvxfsZoJZY7s0kf1XkOrlYvumSa7nKoeuJUA264XxEm58zNWAMaEKn8o
         HOh+h5qj7E4N/30QbrKUJ01RtNnztqm9Fwew+TJrCYjJjOW0FmciJkVg/hfxbYUkI6AE
         LkFkurpTRrkkT3o8fE59/pUP3z3pomn36QHuxkjfl6VzsnxbESfIljrwp8DomlrrlFtI
         mnVgB9Biza7RgXiv0Koc5gPciOoRQJvMpomRL2Yta4BjHs6OOWuQ4PabQTUXeTMFsQSX
         LKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QwBZeARoUMyAioFBTpaPXVTd/M/nRXI2yOlov7OC25M=;
        b=P0SxtF/iOsXVnLXQvU7mSqHwhkhqO7yrC1GUUquLhNBeX0W0zs9UToXMywCz4jXweI
         5IX2yZwaZkNocwSHADhqSgOGTbHVWQ0cFPnxVJuJ/JBOs/NPsBXUzvXZ7qmvdtdYAf1w
         6X0d9MpEFhsYQDzJzhySgdzQ58HVLji2BjHrHdHFyTw0C/wtzUte7OR2mCvF9psTK4x7
         OZDgKuvELCXrzYH0Rtkaot0jvVsq2sZVot9r/2hs10GjUdm9hDXIpTzVpRWenDqhk98D
         Pg8Mi5w2QmdV62EYbG8c9ueHUOCRqHYmzkGNwlwSilMPmUlZzA2aRn3L2uI5qwallanP
         Rw1w==
X-Gm-Message-State: AN3rC/4wC2DKGdh403E1y1myx+bLVtKg+4K6imAMVveFx+0YS53i+8Gy
        DRdwemWpA1A/juVGFTyD2B+gbg91autd1Cks0w==
X-Received: by 10.99.60.81 with SMTP id i17mr18525019pgn.183.1493671857504;
 Mon, 01 May 2017 13:50:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Mon, 1 May 2017 13:50:57 -0700 (PDT)
In-Reply-To: <C3A43A45-9120-4755-AE42-FD33F68F3FCB@gmail.com>
References: <C3A43A45-9120-4755-AE42-FD33F68F3FCB@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 1 May 2017 13:50:57 -0700
Message-ID: <CAGZ79kYfoBOc+hVhm7XEg1TvYQ8myF4f=0wSwDs-agYxaArsWQ@mail.gmail.com>
Subject: Re: [PATCH] small memory leak fix
To:     David CARLIER <devnexen@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2017 at 1:40 PM, David CARLIER <devnexen@gmail.com> wrote:
> Hi this is my first submission, a memory leak found in the maint branch (might be in master as well).
>
> Kind regards.

Hi and welcome to Git!

> From d98f3944780730447f111a4178c9d99f5110c260 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Mon, 1 May 2017 21:14:09 +0100
> Subject: [PATCH] memory leaks fixes for remote lists.

We usually word the subject line as "area: what we do"
(C.f. $ git log --oneline --no-merges -- remote.c)
Maybe:

    remote.c: plug memleak in for_each_remote

>
> both push and fetch lists were not freed thus
> using free_refspecs usage.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> remote.c | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/remote.c b/remote.c
> index 9f83fe2c4..2f8cb35a3 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -742,6 +742,8 @@ int for_each_remote(each_remote_fn fn, void *priv)
>  r->push = parse_push_refspec(r->push_refspec_nr,
>      r->push_refspec);
>  result = fn(r, priv);
> + free_refspecs(r->push, r->push_refspec_nr);
> + free_refspecs(r->fetch, r->fetch_refspec_nr);

After freeing the refspec, r->push/fetch still points to
the (now free'd) memory. We'd want to reset it to NULL as well,
such that e.g. in this function

    if (!r->fetch)
        ...

still works.

After reading this, I think we'd rather want to keep the fetch/push refspec
around for the next access of the struct remote, and only free the memory
when the remote itself is freed?

That however is a problem as we never free them, they are globals :(

Thanks,
Stefan
