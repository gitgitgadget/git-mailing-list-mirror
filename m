Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 313501F404
	for <e@80x24.org>; Tue, 14 Aug 2018 16:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbeHNTCi (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 15:02:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33141 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731370AbeHNTCh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 15:02:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so17733748wrp.0
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2Rq/AkUxOxR7Ic/Ilxnxul/USDzO5+ywmiM7iYZSxIA=;
        b=CDODM3WUDYKkr6cwSoLxELPG8zF2Q2A6meZ1pQ76mSlotGqaQD2q34AIxHTEuhw6q9
         KBXJ//9bVKRiEfKEgKnrhYA0dvxU5mrGVYfNcaPrPvsVxskDsE/jlag4CdX+8/jz2eaJ
         qilGOaz+0iwskGYedPxrRnHf/PHAJSN4KjoUoBIH41stn9FsyuXnUImzJJ77h3ZMvtxx
         x+lP9rqKKMu0NxpkyG/aCfguIuP7zy4XISwjsjOuS0NubQhvS2rNMjv8uwWVdo8r8TmY
         j2QGqx3kcpj5Q5LU+KXRQ6gxJSOJEDKdemsIBL4As/QIYENR5jvV2KBejbfIWOVj1+Hl
         GeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2Rq/AkUxOxR7Ic/Ilxnxul/USDzO5+ywmiM7iYZSxIA=;
        b=ENSn1ZclTOO4EOHYaZYz30vDJqUe7bVyYpoX1yJ2fHOTQEbVW+JLFrfHZoGvA05d4c
         n6SKeQagVDTzWK3Xy3rH3AJ7EHxGJiUo4SJsAoZB9ZoyR9yTDLEY4xt+HzAGoTUtcgBa
         Y+LhaXr9CjP3TNxRUfCFA4AVTAX4kRI36Ins108rnjcJXh5hVW4VFK2GKrvBMUMvmMwY
         d4DAt9Np9MBeNG3ZNqqgPPrJDpnZi6KkgKGnLRAwaTi1LpMUAw6o0BuRVWKjU1sQcrdf
         2tw5lBVWjOqANsdm3YmKQ8h/iJrUnbbraTYcBH0OSZwFXFcmTTdMU8t6wK4zCR/6xiAo
         I3JQ==
X-Gm-Message-State: AOUpUlHxnT9ILXYFcwhIfZ+HD9gD4vS1/sLGN0cAiuVQABcm3nsC4svk
        +dgBVPNwsoRYXsgV+Z7adB07VcbR
X-Google-Smtp-Source: AA+uWPx/Ug54wO6urB9bqLXTDtHXUJId1mpCnUSPkeQR2GiJ/SegnuU02gWR6VOYWy8s3HI77xukiA==
X-Received: by 2002:a5d:4f82:: with SMTP id d2-v6mr13726311wru.261.1534263288350;
        Tue, 14 Aug 2018 09:14:48 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i23-v6sm18371292wmf.24.2018.08.14.09.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 09:14:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Pursell <william.r.pursell@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: git-describe
References: <CAJPQ5NaYn=rMb2j1KxEk8518Z3vD+-uEOamuu1QWacgnzNtKWQ@mail.gmail.com>
Date:   Tue, 14 Aug 2018 09:14:46 -0700
In-Reply-To: <CAJPQ5NaYn=rMb2j1KxEk8518Z3vD+-uEOamuu1QWacgnzNtKWQ@mail.gmail.com>
        (William Pursell's message of "Tue, 14 Aug 2018 06:58:53 -0600")
Message-ID: <xmqqmutp0vt5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Pursell <william.r.pursell@gmail.com> writes:

> commit cc4bd5268b2dbe90279198acb400a528ee23f5d5
> Author: William Pursell <williamp@wepay.com>
> Date:   Tue Aug 14 06:41:00 2018 -0600
>
>     doc: Reference <mark> for --dirty/--broken
>

Thanks for trying to help.  Overall the resulting text does look
much better than the original, but

 - "git show" output is for your own consumption, it is not
   something you would feed other people (see patches from other
   people on the list,
   https://public-inbox.org/git/20180814110525.17801-7-ao2@ao2.it/raw
   for example)

 - Please sign-off your patch (see Documentation/SubmittingPatches)

 - The patch is seriously whitespace damaged and does not apply.
   Please first try sending it to yourself and make sure it applies
   to the commit your change was based on, before sending it to the
   list.

Thanks.

> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> index e027fb8c4b..f7d67306c0 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -39,11 +39,12 @@ OPTIONS
>  --broken[=<mark>]::
>   Describe the state of the working tree.  When the working
>   tree matches HEAD, the output is the same as "git describe
> - HEAD".  If the working tree has local modification "-dirty"
> - is appended to it.  If a repository is corrupt and Git
> - cannot determine if there is local modification, Git will
> - error out, unless `--broken' is given, which appends
> - the suffix "-broken" instead.
> + HEAD".  If the working tree has local modification, "-dirty"
> + (or <mark>, if supplied) is appended to it.  If a repository
> + is corrupt and Git cannot determine if there is local
> + modification, Git will error out unless `--broken' is given
> + in which case it will append the suffix "-broken" (or <mark>,
> + if supplied) instead.
>
>  --all::
>   Instead of using only the annotated tags, use any ref
