Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5BE1201B0
	for <e@80x24.org>; Mon, 27 Feb 2017 06:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbdB0GlR (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 01:41:17 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38546 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdB0GlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 01:41:16 -0500
Received: by mail-wm0-f46.google.com with SMTP id u199so10530557wmd.1
        for <git@vger.kernel.org>; Sun, 26 Feb 2017 22:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IJM9Z0IgxzhKqQLAhFf4wHNYvU1JieodsXOdfiZ5z0E=;
        b=CNhvQgKdza/DQTXETy+/5ogDjn4l8WD2Dj04jaIeIhXNDsxcCOIUw88mjThpBss0la
         Ak6i4gubTsYG2mzdxmFiUjXGT+vwi2dNhBwe02ujq9TOPKgdn3fAirU8shzQI0rG5n6H
         cR9UViV/xnlzyNKoaoMxuB/5tXg+6D72Nai2xP0juCw2QGZVhnCNsjrILQm2rR2Gajvc
         eP7xZoTg+aBp7Ik6Mpl7LMCt1f10REwRrysX2pz4haJdtFA2m5O2KLuY+Cszbuhu4Q1k
         xwoaKHVuhLGHCqJwxnCGLidO4x1sbUZOTNzu6JUX6gpVDSlCNGPjBn5wVipb/bQxgVDh
         w/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IJM9Z0IgxzhKqQLAhFf4wHNYvU1JieodsXOdfiZ5z0E=;
        b=kOfKS997xrtlCIfM4Z1EAQv4tTx7Y7Rz53hJ4R7AXSxcotA65aOAThGa4UlN3ZXpMb
         o2ntLwS6PBo9X4jwkQ/SCnAyXV4m5CUaPkR6hO6ngN+W3Y9C874MxGmKgE76EZo96Z82
         Uh1eMtNAKMsIIYK0EAqZFQfgy8sSymXdhMHhW3OsIaGL1OpW0Q1msw2lhkL9N8dmPGJI
         CUCxfGlXEvSVR+rkb0ubpIzIL//TDVMZDMXpChR/4P0lm4VJguuws1ugYjJRlB9+26e0
         raAgbM3R0JyQXVHY8KzBd5KCJNl6Xulfxj9HCvxygvAHUE3daeMP7qhhS6djroNOL94M
         XZiw==
X-Gm-Message-State: AMke39neZlgcjJBXSe0/AfzVFEcmPgAICOaifqzSKSbX7QJUP+YhnpQP/VKeuGUKG/FJs2uO+PQ+ZiwdxvjM1g==
X-Received: by 10.28.129.5 with SMTP id c5mr11753406wmd.19.1488176056475; Sun,
 26 Feb 2017 22:14:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.167.65 with HTTP; Sun, 26 Feb 2017 22:13:46 -0800 (PST)
In-Reply-To: <20170227045257.yazqlrqlnggosi5t@macbook.local>
References: <20170227045257.yazqlrqlnggosi5t@macbook.local>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Mon, 27 Feb 2017 11:43:46 +0530
Message-ID: <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
Subject: Re: [BUG] branch renamed to 'HEAD'
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Thanks for reporting, but I don't think it is a bug.

On Mon, Feb 27, 2017 at 10:22 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Hi,
>
> I just discover something which very much seems a bug to me
> while making an error in renaming a branch.
> The scenario is the following:
> - I have a branch named 'orig'
> - I want to make some experimental changes on it:
>         $ git checkout -b temp orig
>         $ ... edit some files ...
>         $ ... make some tests & commits ...
> - I'm happy with my changes, so I want to have my original
>   branch to now points to the head of this temp branch
>   but did it wrongly:
>         $ git branch -m -f orig @

Here you are using the '-m' flag, which is to rename a branch. So what
you're essentially
doing is:
    $ git branch -m -f orig HEAD
Do note that this won't reset 'orig' to point to 'HEAD', rather this
renames 'orig' to 'HEAD'.

What you actually want to do (to reset 'orig' to 'HEAD') is:
    $ git branch -f orig @
This would make orig point to the current HEAD.

-- 
Regards,
Karthik Nayak
