Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27A451FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 16:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbdBJQEL (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 11:04:11 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:32893 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbdBJQEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 11:04:09 -0500
Received: by mail-io0-f181.google.com with SMTP id v96so53775480ioi.0
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 08:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ThlcMqEW/AbHAAUGlTOFNfXTMMw9MMLsA/YyLwEsJrk=;
        b=WHl2/Q6hTcxMxCXTulnKypF9VT8L/AvJrWUqbAiKbbiUvDYnRrokB9XWw9z1lGIo6d
         50dXKZXdzLghks1vldFMDUl7j04Fe6QExAh6IUPLMPQp/6jt+C3qJID4HM+MASAASH/3
         PWkAsmCP8tu7W/bmGoyLux/M2RfqVPmql9To2bYUfERxzHt8IuKFY0C6AdR3/vbz1IGx
         GFOGHeIKzwXIcScV45W2yMPoWjH2zaz1v3xNpiP3VDNh5I1sj8E/c5Kp0083dpFDB9/U
         KGoJpgJCQNwHI90nOCH8+symw/HBICV7DxfYBYPwPZme0o3uZu+PPcDQTKDOK4UWgP1y
         RShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ThlcMqEW/AbHAAUGlTOFNfXTMMw9MMLsA/YyLwEsJrk=;
        b=WNjsTb1hSx5K4uIcretRzJohvSbc9mm26832QfgXQ9mp8gZd5CHuI94Y1UFLlPj69O
         QzHAkdkfWarwlPcav0xsPjlAA1CUz1GZKFGlW1MGiai77+8v/Vud7DS5Qdb/QIwpuoET
         fIOFJ0TOlp+1LBheAyOvwmnD8zEeM4VjYs1LLRaKJ7HRwo0P81eHL2bYfEU5Z1fHG19s
         Kvm7AfzL1jHKFKxPGs3mFymP9AGqVgxeRfzhOr2nH9YNaHbPb2SLnUw4GKcy9ohGWG3I
         dKMjYdlEJYAA7qVSl4HAl881vb8mOnwCwPKlsBoPgdvE+FUW0WwhD7vEixSBENT3vI/2
         7MJw==
X-Gm-Message-State: AMke39nm3Y7L78O+mBGJ20N92QXTYdiz7lRtgpNIEnLaGpg/T+X6qdNJI44pCMjiPT+aC3//lmtDOlYtU9PiBQ==
X-Received: by 10.107.63.2 with SMTP id m2mr9382163ioa.74.1486740620529; Fri,
 10 Feb 2017 07:30:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.147 with HTTP; Fri, 10 Feb 2017 07:30:19 -0800 (PST)
In-Reply-To: <a1b9143bb29a8a5979dd733ed20161e6769b2b83.1486736391.git.johannes.schindelin@gmx.de>
References: <a1b9143bb29a8a5979dd733ed20161e6769b2b83.1486736391.git.johannes.schindelin@gmx.de>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Fri, 10 Feb 2017 21:00:19 +0530
Message-ID: <CAFZEwPOo6RPKgf-FKL6GNPK2RDtw00=WvaBYMjeoZXX+wHkjwA@mail.gmail.com>
Subject: Re: [PATCH] fixup! bisect--helper: `bisect_next_check` & bisect_voc
 shell function in C
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Johannes,

On Fri, Feb 10, 2017 at 7:50 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
>
> It is curious that only MacOSX builds trigger an error about this, both
> GCC and Clang, but not Linux GCC nor Clang (see
> https://travis-ci.org/git/git/jobs/200182819#L1152 for details):
>
> builtin/bisect--helper.c:299:6: error: variable 'good_syn' is used
>                 uninitialized whenever 'if' condition is true
>                 [-Werror,-Wsometimes-uninitialized]
>         if (missing_good && !missing_bad && current_term &&
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> builtin/bisect--helper.c:350:7: note: uninitialized use occurs here
>         if (!good_syn)
>              ^~~~~~~~
>
> If you "re-roll" (or, as pointed out at the Contributors' Summit, better
> put: if you send another iteration of the patch series), please squash
> this fix in.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks for making this fix! :) I will squash it in.

Regards,
Pranit Bauva
