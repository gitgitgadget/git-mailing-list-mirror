Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326E11F404
	for <e@80x24.org>; Tue, 10 Apr 2018 03:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeDJDAx (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 23:00:53 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40122 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeDJDAw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 23:00:52 -0400
Received: by mail-wr0-f195.google.com with SMTP id n2so11393838wrj.7
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 20:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=n60ZKWWkvwoiIzX1p6zrKHO6dqvuxPYOp4Ce0AjLMWk=;
        b=jsqQGwI1y41N+7/s2XeMnVjO+RroWMgvOhKfnm8bJDxf+z5Xr9N3yu/Ap1nlfmTBAN
         0+1exI8A3Zbm58lCXqfc0gl5Np6zA+TccshrQiTqyZO/CK4aJXxmsHN4d3/u7T9A5Aif
         9VywuSlDzygdlhgAenibsm5bFhV6Bqt8Wkrtg2ezY/J9J3HiuPk7KPV4s2n5JYxxErHF
         sq8hxbZbik6hAUMk9kxN5OtX0hgGpL6o3TTKeGios6WaY8GZHjlM9U49Kq3YOIRcTMcx
         6UJ+jwkBnwJRAzvdIMGmdESHIUG9/ci++Cc8jVnuSdRfQJ5nC+XKeU5Q2TshQmttTLa9
         T+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=n60ZKWWkvwoiIzX1p6zrKHO6dqvuxPYOp4Ce0AjLMWk=;
        b=j765spb5hMvoDiAQ0Chw/U7CWaylATpJMGFCqN6tnvcuDb7dPE+s7775GmHFO11Fyr
         ZoAtUtTeqPHdBXqyB7SzGhhjpduk73j6Ch/5sreu6N8agakoYTmuYoKjABjZiJPxcZtI
         Eivg/Pi4RFYnuerjpgXRpEQjs2t+y5522IBxJ24hj+RHKmst3xE+iQQVNiGEYXqpZQMy
         ONeNPMUJNhyRlhj4e4Prec9IJJ4f0vT5PnkzA2pHQiQtb+AsgrljAtP4UyzhrjWyWDj/
         45XdUoNLi6kIwne2Lz/gjB6nQRSFtgRFPuM3CnrBNXFQpofyLPdCaFKtTaWhrAcXsE/z
         Ar5w==
X-Gm-Message-State: AElRT7GOAZ9pubNzpAwetA/f8pUNukM9b3UNpZUsACFju+deRvxTf3jO
        TY912I4O3TSAU8nWvt07Wn0=
X-Google-Smtp-Source: AIpwx49HN4dyzxgXSJannw8wMON2rBaxAn7YCBuXnvbnC16ad3BJ/t5mFs6whDsoyQnVgt8hVcyC2A==
X-Received: by 10.223.152.138 with SMTP id w10mr29490487wrb.34.1523329251087;
        Mon, 09 Apr 2018 20:00:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x9sm2860415wrb.18.2018.04.09.20.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 20:00:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/16] replace_object.c: rename to use dash in file name
References: <20180406232136.253950-1-sbeller@google.com>
        <20180409224533.17764-1-sbeller@google.com>
        <20180409224533.17764-3-sbeller@google.com>
Date:   Tue, 10 Apr 2018 12:00:50 +0900
In-Reply-To: <20180409224533.17764-3-sbeller@google.com> (Stefan Beller's
        message of "Mon, 9 Apr 2018 15:45:19 -0700")
Message-ID: <xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This is more consistent with the project style. The majority of
> Git's source files use dashes in preference to underscores in their file
> names.
>
> Noticed while adding a header corresponding to this file.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Hmph, is this authored by Jonathan?

There are sha1_{file,name}.c, exec_cmd.[ch], and unicode_width.h
remaining, though ;-)

>  Makefile                             | 2 +-
>  replace_object.c => replace-object.c | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename replace_object.c => replace-object.c (100%)
>
> diff --git a/Makefile b/Makefile
> index de4b8f0c02..94e0bf47b1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -871,7 +871,7 @@ LIB_OBJS += refs/packed-backend.o
>  LIB_OBJS += refs/ref-cache.o
>  LIB_OBJS += ref-filter.o
>  LIB_OBJS += remote.o
> -LIB_OBJS += replace_object.o
> +LIB_OBJS += replace-object.o
>  LIB_OBJS += repository.o
>  LIB_OBJS += rerere.o
>  LIB_OBJS += resolve-undo.o
> diff --git a/replace_object.c b/replace-object.c
> similarity index 100%
> rename from replace_object.c
> rename to replace-object.c
