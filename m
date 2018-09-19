Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C2561F453
	for <e@80x24.org>; Wed, 19 Sep 2018 23:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbeITEkL (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 00:40:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33557 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeITEkL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 00:40:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id r1-v6so10598670wmh.0
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 16:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EGgyk7a7tNJFdbyDDq3DrUtliucJ0wrJejaAebYUoy8=;
        b=FqM3uNAJOS5WZHD4gBxiyIgJl9g24w+afPHQuatJKKri43cmdfVIbRXmK17pwVVZsT
         DikH89HoXIo3C6hmjdcyl01WGO5Bz4WPkjvNzJVwtDJEWtwHx6A9v16LWz3EgYBN9rir
         Eken4APVRCd95IhVUraCU4UrZE21pHOyuumU0i31PW3Gl9wmjJeS1K9QXD946aZmtQlm
         R8mFvz9tJQhwD8rDjGWbg3e7B9gtPgilSOuSVxKmekvgR0c9yllmlbY2OF4jnYG0A8hD
         7r7yfxEbZ4bA4Y1EtxzVrJbnbOKepMp5bz4dkLQR8mROP8uSKEx7ZSDZ82KUfQtc3bPd
         Fz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EGgyk7a7tNJFdbyDDq3DrUtliucJ0wrJejaAebYUoy8=;
        b=F8cpWrSpT5S6JKe0I6TeqwCXQiYsIdOBgB2342yFfWzbGjmgs6SUJML/EjOtXC9DAU
         5fXjSOPPaR1D8o+GbLq5w+vbDt2bpTdeQI+KnUdyUAyZbedqvbWfXAl0ktstv7WlhFAp
         FOx/KJLYb3p0RK4NaCGgiHnhAKYiBCTPPMWvRkoUFYjL6LgHtTbyN4+xIuK1plJVAKM8
         VL3uRzOnx3v3yZSAyYSLKf8WkMaaE5eL/6o5TG2Cf0qcOn7Vi1GPi2+PB/Sy5txYpyMl
         /WEZVRc1BUiSHhv6dwygBWzkpzAsXklahzmTmmBfr2yLfPncU1IZyD62mFeJpJJBxk2s
         A5DA==
X-Gm-Message-State: APzg51CHbS7K540gK6RQcIZ1RjSpnSP3JQPC6/HZfbQf5O6bmSlVk2pA
        ixwMj0tC82DbKsrHrnVcafo=
X-Google-Smtp-Source: ANB0Vda0DRdTc+e2hrnkLasXhHoOhN2751gUxdz0P2EZ9ygkaLknjCdVdUX9c9dtymAMQ67gSUusxA==
X-Received: by 2002:a1c:ce0b:: with SMTP id e11-v6mr85184wmg.47.1537397999717;
        Wed, 19 Sep 2018 15:59:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b124-v6sm68530wmg.47.2018.09.19.15.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:59:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Frederick Eaton <frederik@ofb.net>
Subject: Re: [PATCH 2/3] git-column.1: clarify initial description, provide examples
References: <20180919201231.609-1-frederik@ofb.net>
        <20180919201231.609-3-frederik@ofb.net>
Date:   Wed, 19 Sep 2018 15:59:58 -0700
In-Reply-To: <20180919201231.609-3-frederik@ofb.net> (Frederick Eaton's
        message of "Wed, 19 Sep 2018 13:12:30 -0700")
Message-ID: <xmqqo9ct2ivl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Frederick Eaton <frederik@ofb.net> writes:

> When I read this man page I couldn't figure out what kind of input it
> was referring to, or how input was being put into columns, or where I
> should look for the syntax of the --mode option.
>
> Signed-off-by: Frederick Eaton <frederik@ofb.net>
> ---
>  Documentation/git-column.txt | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)

I'll defer this to its primary author.

>
> diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
> index 03d18465d..5bbb51068 100644
> --- a/Documentation/git-column.txt
> +++ b/Documentation/git-column.txt
> @@ -13,7 +13,10 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -This command formats its input into multiple columns.
> +This command formats the lines of its standard input into a table with
> +multiple columns. Each input line occupies one cell of the table. It
> +is used internally by other git commands to format output into
> +columns.
>  
>  OPTIONS
>  -------
> @@ -23,7 +26,7 @@ OPTIONS
>  
>  --mode=<mode>::
>  	Specify layout mode. See configuration variable column.ui for option
> -	syntax.
> +	syntax (in git-config(1)).
>  
>  --raw-mode=<n>::
>  	Same as --mode but take mode encoded as a number. This is mainly used
> @@ -43,6 +46,34 @@ OPTIONS
>  --padding=<N>::
>  	The number of spaces between columns. One space by default.
>  
> +EXAMPLES
> +------
> +
> +Format data by columns:
> +------------
> +$ seq 1 24 | git column --mode=column --padding=5
> +1      4      7      10     13     16     19     22
> +2      5      8      11     14     17     20     23
> +3      6      9      12     15     18     21     24
> +------------
> +
> +Format data by rows:
> +------------
> +$ seq 1 21 | git column --mode=row --padding=5
> +1      2      3      4      5      6      7
> +8      9      10     11     12     13     14
> +15     16     17     18     19     20     21
> +------------
> +
> +List some tags in a table with unequal column widths:
> +------------
> +$ git tag --list 'v2.4.*' --column=row,dense
> +v2.4.0  v2.4.0-rc0  v2.4.0-rc1  v2.4.0-rc2  v2.4.0-rc3
> +v2.4.1  v2.4.10     v2.4.11     v2.4.12     v2.4.2
> +v2.4.3  v2.4.4      v2.4.5      v2.4.6      v2.4.7
> +v2.4.8  v2.4.9
> +------------
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
