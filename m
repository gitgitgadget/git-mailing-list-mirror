Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9191F51C
	for <e@80x24.org>; Sun, 20 May 2018 19:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbeETTM4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 15:12:56 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:54396 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbeETTMz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 15:12:55 -0400
Received: by mail-wm0-f44.google.com with SMTP id f6-v6so21808942wmc.4
        for <git@vger.kernel.org>; Sun, 20 May 2018 12:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aGskK55Lsxdfx4Fw/g+HZWApqEuwRpKNyqzWJK0jEyk=;
        b=WUAUOz21DZ3zswgkPwZhJFQq7CEhGSjzp9F53lZMAQvRzIk3jaD5/5vH6AjEGf8W96
         0uISPoD71KH+kkbArzlKQFagUyvoSnDkkUDPPOMuUYgGAKJq1nvboNpMPqlkXAOK2211
         jmhcsg9/oOBrPLkbWneuf++GxSYdYvyuRNWoiz43x4RdTsjdFzTHEdMfk2Az6/Sv0xYM
         /vd9twdHFycfm9+DpGuOXx0UnGyWK8mdg3+7Wu0YdFBuyPma3UH2gfjtu8cs/yG/JQof
         tp4wuf7bAcDDABuG6NxX6miBtYJyWG0kBJqYo1/riXTMxPpRm5bSYGsL8UUnf9CA77nY
         UxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aGskK55Lsxdfx4Fw/g+HZWApqEuwRpKNyqzWJK0jEyk=;
        b=E/CgATZfIhpN3hv4RZWxWNO4iFXbPrxNlBDeHY1KQuudi/tXoBR6hUJQM+fHY4wiav
         TvFh7JbZv32ueIwm4Ws1AEibHttw9FisgAH0B8bJofMDjQ5eHx3jUQmFJHGMWpy6Z6hC
         FIpsRdEAql5IgELw364H3pvgaijUyzsNAQe2zhm1EZsubKsy5iVrrKfUzOjFWt6DJ36l
         jWGht6EcVaXBaU3TnXbaaqmV/Mq9cj3iSqyJWmiOBgYfVGcpAxAz9qnOINg6aQI8lp59
         a15XM+KtPhtPS/4CPjVlbXd/bYCnEbMvLNa0FkKaHkjpNMBS+hhDzK75UNIJodN/OUe+
         2gqA==
X-Gm-Message-State: ALKqPweKWEMEezN+8OWWwY3GIABo7UltW0X8G8Jck53KXfCnyeXlAvV/
        MhBw25EfKCgutTXXiRIl/B+QCCf4K+VlfMWQbFw=
X-Google-Smtp-Source: AB8JxZoTAYx8ClDOrW4ZFubFrJ0QB0augXK7cRAX1K3aGvhbAtj1ySmjrOB4l9OPFsCgG15tFdwcBMdwln77KkhLkOw=
X-Received: by 2002:a50:ab42:: with SMTP id t2-v6mr20790115edc.133.1526843573913;
 Sun, 20 May 2018 12:12:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.234.135 with HTTP; Sun, 20 May 2018 12:12:33 -0700 (PDT)
In-Reply-To: <77b025bb47869478e3eef1c3c34d379164f5d91c.1526810549.git.martin.agren@gmail.com>
References: <CAN0heSp7DqxOy-UeLgj8t_T_4f-fNthMpGNS8oUbcs7+NvS-zw@mail.gmail.com>
 <cover.1526810549.git.martin.agren@gmail.com> <77b025bb47869478e3eef1c3c34d379164f5d91c.1526810549.git.martin.agren@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 20 May 2018 12:12:33 -0700
Message-ID: <CA+P7+xqPnuuQpp5e7fduLgaSd+JrTn95w=Da7q=iCXUgo0QHFA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] string-list: provide `string_list_appendf()`
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 20, 2018 at 3:17 AM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> +/**
> + * Add formatted string to the end of `list`. This function ignores
> + * the value of `list->strdup_strings` and always appends a freshly
> + * allocated string, so you will probably not want to use it with
> + * `strdup_strings =3D 0`.
> + */
> +struct string_list_item *string_list_appendf(struct string_list *list,
> +                                            const char *fmt, ...);
> +

Would it make sense to verify that strdup_strings =3D=3D 0? I guess we'd
have to use die or BUG(), but that would mean that the program could
crash..

I doubt this could be verified at compilation time....

Thanks,
Jake
