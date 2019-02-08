Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D74B1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 16:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfBHQjE (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 11:39:04 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:35412 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfBHQjD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 11:39:03 -0500
Received: by mail-wm1-f54.google.com with SMTP id t200so4052028wmt.0
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 08:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x+4YblkFno1J96ZPWi7K8NNKnbD06BGFbWW1jSUojVY=;
        b=I3ffmH/97NR+4lorfelpZBhCiNShWB2N2fY2TDvlru4lKPi9Tn1+Vw/RS3zihdhCbB
         c59b1T+I1GOoI2Cg0u7s4GsmvMd+N80YsClwP08eBG6A2LI9UDeoP9I1P6YACC+J7w69
         b8KKUnM0qYmkjswUFBl+IBuSJdBJABYQRyiek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x+4YblkFno1J96ZPWi7K8NNKnbD06BGFbWW1jSUojVY=;
        b=s8aorUpeEy93xXb/nn5IZPN1J1m04xTq4RK+9He5cEpu7L9l4ZduRwbIz3CcFfYFyt
         TUXdIQ1q+LSVYH0pQgCI5X1CvK9N1ofqab1GJb+Q7iYI//ofD9eIYq4OXoi01Q5Z0Q4E
         jSjodIaCBM41Xi7XgkritejmQ/zzMpdzwav7IggEWTqwgWdIrqOx5xgalJXccZEqp0/e
         sjWejNn6iRN0INDDFDclc7r81gQ/iqbTP4kOl9oEJPjrEo1uLSJKuAipUWoHofHyONIB
         MXrl6EsJmq2slJNp9Dkw2L8H5N5I9/7xB5eIqo6aao1HTkUWCW4hrsG7kZpIrYknfYYZ
         nEUw==
X-Gm-Message-State: AHQUAuaRNrkep05tmafRYN5tjXqc+uW6Q15yGfZYcC0aqyltMu2imRFC
        RjAOTEs+s18AvkUlwjufe9kYkoeEXZ2vZN2P9T+qpw==
X-Google-Smtp-Source: AHgI3IYdv2Gz8cCp9Ua2DxbBQoZP3UTD6LZ6eU3IH8eMS60MoARf8DwHPylYuJFivOXZ93GpcpcpRgPgvfYwuEg4h7A=
X-Received: by 2002:a1c:a70a:: with SMTP id q10mr11550713wme.58.1549643940996;
 Fri, 08 Feb 2019 08:39:00 -0800 (PST)
MIME-Version: 1.0
References: <CAE5ih79DuU5Wrk4p+wpQX3j6bgyA2_ZgXYJX-tGvZpYhWazWqA@mail.gmail.com>
 <20190208100221.GA22283@ash>
In-Reply-To: <20190208100221.GA22283@ash>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 8 Feb 2019 16:38:49 +0000
Message-ID: <CAE5ih7_b_LXfPp5eMcrr4iSuyzaiKxvQqN73Osw+ck9CPrfdqw@mail.gmail.com>
Subject: Re: could not freshen shared index ..../sharedindex.0000000000000000000000000000000000000000'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 8 Feb 2019 at 10:02, Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Feb 06, 2019 at 10:25:25AM +0000, Luke Diamand wrote:
> > I've recently started seeing a lot of this message when doing a rebase:
> >
> >    warning: could not freshen shared index
> > '/home/ldiamand/git/dev_full/.git/worktrees/gcc8-take-2/sharedindex.0000000000000000000000000000000000000000'
>
> There are only two places in the code that could print this. The one
> in read_index_from() can't happen unless is_null_oid() is broken (very
> very unlikely).
>
> The other one is in write_locked_index() which could happen in theory
> but I don't understand how it got there. If you could build git, could
> you try this patch and see if it helps?

They've gone away!


>
> -- 8< --
> diff --git a/read-cache.c b/read-cache.c
> index f68b367613..5ad71478dc 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -3165,6 +3165,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
>                 fill_fsmonitor_bitmap(istate);
>
>         if (!si || alternate_index_output ||
> +           (si && is_null_oid(&si->base_oid)) ||
>             (istate->cache_changed & ~EXTMASK)) {
>                 if (si)
>                         oidclr(&si->base_oid);
> -- 8< --
>

Luke
