Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65421F461
	for <e@80x24.org>; Wed, 28 Aug 2019 09:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfH1JFY (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 05:05:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37040 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1JFX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 05:05:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so1493958lff.4
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 02:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=okvDooLLFJpLj+IhAPiVapI2i/8rzrVdjbnKRDtUu+g=;
        b=kDFKz33LUtlKEkn2fHp+yZZlb3Il+KkxqJfTAoWlhawEeK3V8A/h/fV83ZoamiYtJz
         C+GWerj19MOkIwacy+ezG53tNcSbzxcD1e6IoohIx9ORnXKS4HjoVP5ZOVrAyScZtw37
         t4M6t44cvHOvKFNQ1h8iMPvJ6MwXvfmhvPiU+8KDpwW4OwF8lgboNPOb0vInXFZ/JyX6
         fWzbnVTDwUDHYuxwY8Pc/JWMgvD4oLiX4a+5zzrOmfevZ2Mi2XuJbDeRlWmuRQUkAh2R
         qjEupjITz+6VxW3v2NKRjqJYG4gGPzEP2DV8FksJkt+Yqe3NmJUQg4Y5ENjPpip01nIR
         5LEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=okvDooLLFJpLj+IhAPiVapI2i/8rzrVdjbnKRDtUu+g=;
        b=LvdTP6EKak/IX85/z5Wgwx8kvjLNTTKjzgwy0Ak9erkG8nx26cPCUaNZJJhdRXDTQJ
         cIAnVbm8n4ble1kk1z1oAurQi3eBz2ETaxJgATCSkP2OocUI1mBWoklSGEXHhdd6hBL0
         Xdbz9dZf3MRktX4D0vdXAumRtdigFAZpmJ1V5Rns8qSwUcyTS9YcX4jTsV3pPAzr3wRe
         RzpBTMT1z4aypIkBH9tAHl+WscFh3SzcC7I9XGTvlA0t3qzRcPhacJmoeVTsJGyAP8rr
         yKMSqLDrfhYbqLpH4bnEwnq4wrLPqZwGQVtOf4eykYOzkwrxeE8JlCB6kAGEg5HynzJ3
         yrIA==
X-Gm-Message-State: APjAAAXnQjxKEgS2Fl47xJrQd2eypvQ3a73LRp6VblNwZ076iCe6jLfK
        7ngT/AvJFsrEuiPm8/HQIJk=
X-Google-Smtp-Source: APXvYqzUNY35bAynmIreZDgMdk83ze/kWPMYltpR2adKipQMcbLslxVv0Xp9hJgqU7WWEEUpf4zezw==
X-Received: by 2002:a19:428f:: with SMTP id p137mr1943730lfa.149.1566983121662;
        Wed, 28 Aug 2019 02:05:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id r76sm477682ljb.13.2019.08.28.02.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 02:05:21 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-options.txt: clarify meaning of various ff-related options
References: <20190828001307.8042-1-newren@gmail.com>
Date:   Wed, 28 Aug 2019 12:05:20 +0300
In-Reply-To: <20190828001307.8042-1-newren@gmail.com> (Elijah Newren's message
        of "Tue, 27 Aug 2019 17:13:07 -0700")
Message-ID: <877e6x3bjj.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> As discovered on the mailing list, some of the descriptions of the
> ff-related options were unclear.  Try to be more precise with what these
> options do.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> I noticed this patch sitting around in one of my branches, and noticed it
> wasn't upstream.  I'm pretty sure I submitted it a few months back, but I
> think it got lost in the cracks.  Resubmitting and I'll see if I can do a
> better job following up on it.
>
>  Documentation/merge-options.txt | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 79a00d2a4a..b39df5f126 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -40,20 +40,22 @@ set to `no` at the beginning of them.
>  	case of a merge conflict.
>  
>  --ff::
> -	When the merge resolves as a fast-forward, only update the branch
> -	pointer, without creating a merge commit.  This is the default
> +	When the merge can resolve as a fast-forward, do so (only
> +	update the branch pointer to match the merged branch; do not
> +	create a merge commit).  When a fast forward update is not
> +	possible, create a merge commit.  This is the default
>  	behavior.
>  
>  --no-ff::
> -	Create a merge commit even when the merge resolves as a
> -	fast-forward.  This is the default behaviour when merging an
> -	annotated (and possibly signed) tag that is not stored in
> -	its natural place in 'refs/tags/' hierarchy.
> +	Create a merge commit even when the merge could instead resolve
> +	as a fast-forward.  This is the default behaviour when merging
> +	an annotated (and possibly signed) tag that is not stored in its
> +	natural place in 'refs/tags/' hierarchy.

Please notice that virtually all the other cases of
--something/--no-something are formatted like this:

--something::
--no-something::
        [descriptions]

So, even only for consistency, it seems to be better to have this the
same way:

  --ff::
  --no-ff::
  --ff-only::
        [descriptions]

that, as a bonus, will make it explicit and crystal clear that these 3
things are alternatives, and thus the last one on the command line takes
precedence.

-- Sergey
