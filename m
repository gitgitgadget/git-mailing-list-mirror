Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E55EC208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 17:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbdHJRV0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 13:21:26 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36424 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752339AbdHJRVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 13:21:25 -0400
Received: by mail-lf0-f46.google.com with SMTP id o85so6400586lff.3
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 10:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4jy9icGElEM1WL7oN2OdZFgVECy4bgT5rbynYGm/GQ0=;
        b=Mvs9yXk5oRkKtoivCyzNKTKiQe+dIPFgFIj6NxIROgEQqD4JQNBgHpCTAAOz2Tv3WV
         BM5rgzgbWvUr7/dc4ZgU2prGgdY+Y6yVEjWxclkgrA0qig+M8geNLouCTBOeRqtLUvR/
         ybq6yTLwfgMXTXvgRNbnThkHxM23/50lPiwnLiQoXiYfHkZ5OqhsQE/NJIvdUf6RvBRQ
         0cRna7soo8J2rOElPw2i8Q7XD/Iyr0vjLaZFxIzO4Zxa/zu2StQR6OxS7Y1U6+V86PkP
         P2LPlNxjQUhviOegBgLBR1CWBtbS4I5iALNiAsLeDpdCiI893TyP5ZH0Sa1ZI1qaBvKy
         hReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4jy9icGElEM1WL7oN2OdZFgVECy4bgT5rbynYGm/GQ0=;
        b=bOMk25eLS8oJCI2n0P+ouoCyI2+2LyO/1GT6GwNLH9VvPai2HViHvdwl/vGDYePOAu
         pDNCE0C+SKIkAIlvPki9IpwdEBUhJWq3Z+KDNINnnri+QR7EW+8ez0nvomdl+8cgMMO7
         D3cD9l3NgZF4fy3giSQyc5I5Y3LR9aLtEzckGb9FxAXvqhT6Rqbw1HA20bUU0PqSgQWQ
         c89tKDgmM+Mhep+kLyDSTK4n5Z7WwcMs1+HemU8n/G5NGvoynTo/8QYDH/L6KsvmVcWU
         9bDT/8+1CjP16PDfOzLU73qj/2/YjfeOJc5iBmiaNmq6kbLKvawMvFGEKWYC+9ji6GNd
         sx7A==
X-Gm-Message-State: AHYfb5gFD4HuYli9xW2HqhaUT6CwFgB2ABikpTaZlam4xGi5fQ3Tb860
        TcrQzNVxK4jm6r7GkUPc5RcrhkcpQgeX
X-Received: by 10.46.5.80 with SMTP id 77mr4301610ljf.91.1502385683916; Thu,
 10 Aug 2017 10:21:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 10 Aug 2017 10:21:23 -0700 (PDT)
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 Aug 2017 10:21:23 -0700
Message-ID: <CAGZ79kbGUOWT7_Uxoc4Hp0m4XSo8YUycd0aRZwm6sMZD829irw@mail.gmail.com>
Subject: Re: [PATCH v2 00/25] Move exported packfile funcs to its own file
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 8, 2017 at 6:22 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Here is the complete patch set. I have only moved the exported functions
> that operate with packfiles and their static helpers - for example,
> static functions like freshen_packed_object() that are used only by
> non-pack-specific functions are not moved.
>
> In the end, 3 functions needed to be made global. They are
> find_pack_entry(), mark_bad_packed_object(), and has_packed_and_bad().
>
> Of the 3, find_pack_entry() is probably legitimately promoted. But I
> think that the latter two functions needing to be accessed from
> sha1_file.c points to a design that could be improved - they are only
> used when packed_object_info() detects corruption, and used for marking
> as bad and printing messages to the user respectively, which
> packed_object_info() should probably do itself. But I have not made this
> change in this patch set.
>
> (Other than the 3 functions above, there are some variables and
> functions that are temporarily made global, but reduced back to static
> when the wide scope is no longer needed.)

I read through the patches yesterday and had no comment.

Thanks,
Stefan
