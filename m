Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6CF1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 04:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbeKFNmS (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 08:42:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44430 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeKFNmR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 08:42:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id j17-v6so6729830wrq.11
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 20:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LDAZ62mNJ2muiiBHephrIHqkDNm0K3kzK3sWkpadz9g=;
        b=PNs0Uw16dop21J4vu8syUOvAyYs+0pb3a074TzG+p5XSCgxTgafnQTPXHiJWmp/OMu
         RDyR6vomzhPq3uRovVEKLhyQ/7zSwHgnTZhEnJS326+sC/EGbW6VlUvkUWv+FJMhj/nk
         T/Bedse0EVpXZFwEiSPrmVzj+qNO6deug1U3I3sDh7PrnNAfsnXPbDVLfetHT78RXzfx
         7EJE76W6wqc1G/2IitFmtyXvjkI2pci2A7+/feT04cf+i4H8MKh0tKhemEwnjc4Td9D4
         y7lOoLoGvvNcNwU9Eq+QIzy8YwTtjnmi/AdZ+QtrGSH0cGGbEx9U8dW4z0YPdbBdFvio
         djiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LDAZ62mNJ2muiiBHephrIHqkDNm0K3kzK3sWkpadz9g=;
        b=qwRZTaXHF2X4yW3CQK2QsorPEQBBbXg/14vQsOC8oGUI9QNmVooNf+q6jn5MZ0F6a8
         RQk4QfaOLuj9ngw43D5Aot3vwUbnFRqvfGapjwHiVCBsZLB3cI1SHwxvUUGnnVfs4ZeW
         cdYxFJoQBB57Vc+xBOAKOACK4+1a6TiQ7CrmgszOll+aHTT5g4QG6Bm/V2g36lpDkWYJ
         +y0sXh525Bl96EcrWBaXK+COMK4mpJGZoFJcG7VjHPcCMhSx76+CW6HQuIhtNw53cjhr
         zof/xQIEnxck7x2uN+31LiiQmJmMFYFmETVJiQcp9/MBG03DCBDjrk6wIeNJLrcs3ryC
         ae7w==
X-Gm-Message-State: AGRZ1gLNw3F0biolZ4+uZwUqTgSiqFjr3zo6cu3yK1jCEVKtQaHLxkrJ
        PdIrg1779J2nwO2SnN6D434=
X-Google-Smtp-Source: AJdET5d/20Ijif24qZ2ZU/cJiPZoxE12MdSv4v/DLdezbZw54KMNoyb5Xv4dr/C7uXX8DL+a2OHFbQ==
X-Received: by 2002:adf:83a4:: with SMTP id 33-v6mr21273191wre.13.1541477942296;
        Mon, 05 Nov 2018 20:19:02 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x11-v6sm500317wmg.14.2018.11.05.20.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 20:19:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     orgads@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: fix typos in release notes
References: <20181105194713.25383-1-orgads@gmail.com>
Date:   Tue, 06 Nov 2018 13:19:00 +0900
In-Reply-To: <20181105194713.25383-1-orgads@gmail.com> (orgads's message of
        "Mon, 5 Nov 2018 21:47:13 +0200")
Message-ID: <xmqqr2fyet3f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

orgads@gmail.com writes:

> From: Orgad Shaneh <orgads@gmail.com>
>
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>  Documentation/RelNotes/2.20.0.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks.

>
> diff --git a/Documentation/RelNotes/2.20.0.txt b/Documentation/RelNotes/2.20.0.txt
> index 4b546d025f..bc0f4e8237 100644
> --- a/Documentation/RelNotes/2.20.0.txt
> +++ b/Documentation/RelNotes/2.20.0.txt
> @@ -56,7 +56,7 @@ UI, Workflows & Features
>  
>   * "git format-patch" learned new "--interdiff" and "--range-diff"
>     options to explain the difference between this version and the
> -   previous attempt in the cover letter (or after the tree-dashes as
> +   previous attempt in the cover letter (or after the three-dashes as
>     a comment).
>  
>   * "git mailinfo" used in "git am" learned to make a best-effort
> @@ -78,7 +78,7 @@ UI, Workflows & Features
>     meaningfully large repository.  The users will now see progress
>     output.
>  
> - * The minimum version of Windows supported by Windows port fo Git is
> + * The minimum version of Windows supported by Windows port of Git is
>     now set to Vista.
>  
>   * The completion script (in contrib/) learned to complete a handful of
