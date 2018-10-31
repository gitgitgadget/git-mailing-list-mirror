Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B39051F453
	for <e@80x24.org>; Wed, 31 Oct 2018 02:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeJaLYk (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 07:24:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39462 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbeJaLYk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 07:24:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id y144-v6so13072126wmd.4
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 19:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QGMO9b13/r1Gx0cAxYm6LPa5sJh4gL5jIq3V05V+FUI=;
        b=KCD+DMlJ+wYhVIBxRdYjOcwhbo2FCO0EINghFWvco/LYU6XR9jQCPUHsoicthBbzkK
         17SIpSl24Vk+v4tS6xm0dJaE/B1rU901oXjSOvBapEhmnqKQOdJtEYek/9S47YOxYE8y
         tHWdzrz1TxaIamS6weFieKsCblK3QlXk5TlFm8t1+Hox+M75lD4l5W/yF4iJRa2IGO5o
         xLSi/ahd5D38Wm7jwoSN8SaEuxa2+yBHT4ge46NfoS7LKfECAZHE/IVXB8HM02GB4IB8
         OWL9Q+L0Y1qt38aMDZlK8dzlCNwpkvxwYqdswD7Rkdd8jWoTm95Xlw5ym433ZG+fFoD3
         xTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QGMO9b13/r1Gx0cAxYm6LPa5sJh4gL5jIq3V05V+FUI=;
        b=Gp25jgh3FhT1RiwAqgTIWhkH2mHgR/e8aC4KyVjyct63AV+KxakAUX9RF3mpSUTYAe
         Ihb3AwV7JUjWBTXxNqwUVSwujZaD92TxntgmDDPtnIh4GozlxgD7uxYcwkcATgx2aBMy
         qEiftjJ/++QucdNSG4cPpdcbJK1u7DjTT6Pi6XpJoWqwGEimOdN9LruOumVJ514bQYZW
         oJphzyWwy+ELLxiLWabu/0PnijKP4z/f3pc1dUsnRDD13bKaTL1ybh6w5yqe1E6YWLMi
         UNe/ebn69EGKOnj8Ln/gTWdI3q1ZAFO/FTCghU4EqRkQvIUhrV027DUReml9LcpCzZlY
         lQrA==
X-Gm-Message-State: AGRZ1gKBghmqMtVwF2FiissP923yfFCnghxWeWaYA617bXlcz76eovh8
        lBLg1fw+d6GDiZ7VIX+H1uSekDM6xBw=
X-Google-Smtp-Source: AJdET5ecjlmntDWEhqSl5+DIWdjTZb1RQQD8HvNwECU/IJ6YCVh2JbXJYC/No1wHnQrlkb4o+kq5Jw==
X-Received: by 2002:a1c:4b1a:: with SMTP id y26-v6mr816358wma.82.1540952919407;
        Tue, 30 Oct 2018 19:28:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f67-v6sm9194550wme.22.2018.10.30.19.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 19:28:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [PATCH v3 1/2] worktree: update documentation for lock_reason and lock_reason_valid
References: <20181025055142.38077-1-nbelakovski@gmail.com>
        <20181030062409.42169-1-nbelakovski@gmail.com>
Date:   Wed, 31 Oct 2018 11:28:35 +0900
In-Reply-To: <20181030062409.42169-1-nbelakovski@gmail.com> (nbelakovski's
        message of "Mon, 29 Oct 2018 23:24:08 -0700")
Message-ID: <xmqqlg6ezw6k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nbelakovski@gmail.com writes:

> From: Nickolai Belakovski <nbelakovski@gmail.com>
>
> Clarify that these fields are to be considered implementation details
> and direct the reader to use the is_worktree_locked function to retrieve
> said information.
>
> Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
> ---
>  worktree.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/worktree.h b/worktree.h
> index df3fc30f7..6b12a3cf6 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -10,12 +10,12 @@ struct worktree {
>  	char *path;
>  	char *id;
>  	char *head_ref;		/* NULL if HEAD is broken or detached */
> -	char *lock_reason;	/* internal use */
> +	char *lock_reason;	/* private - use is_worktree_locked */

s/use /used by/, probably.

>  	struct object_id head_oid;
>  	int is_detached;
>  	int is_bare;
>  	int is_current;
> -	int lock_reason_valid;
> +	int lock_reason_valid; /* private */
>  };

These annotations to the two fields are not wrong per-se, but I have
a feeling that it would equally be important to document what the
other "non-private" fields mean, if peeking them *is* the API this
subsystem offers.

Thanks.
