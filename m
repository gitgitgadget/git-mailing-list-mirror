Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2D0B202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 17:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932725AbdJ3RlC (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:41:02 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:55352 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932612AbdJ3RlB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:41:01 -0400
Received: by mail-qt0-f196.google.com with SMTP id v41so17394053qtv.12
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=crX2S1gPs8kT9A2Jnac5czEX2BSELpqV0wvGifNmjvc=;
        b=P0ZD4shCSgCZiEG2sF617/88XtP7485VQgkrf6wTCGQ8Pvaqj+HbM+YVintxuRuVzL
         6C0FJBKvnUDhAQbVHSdEin/GSGs+Z2B3rgobk1V8d5ceR16t1XAewLCUhnBfUem3+SsK
         FTgPNYLwknPeboyJp+KGN+8IL1mYeXzMXyXjzWaz+7Q5Y4VKD0gC8ZwQShwa3gNGTm3m
         J9VLs7D+0wH6gwZEOzEjrGhGiDRyUBKf62aJvhClcU8lIl5hB5qHz7gVWpwQ18gjNwkc
         yssxEHEB6YrZqfh4MlOls+76wmf+HQwSie+WQkz4ZWVVO5Mt0zFZiauFg1rlQc9AS6j2
         J/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=crX2S1gPs8kT9A2Jnac5czEX2BSELpqV0wvGifNmjvc=;
        b=oxT6+j3rlmhDxvF83r1qz4GG2/yrj3lsCpQ+biBpExuW6PSffLIiv8rcgFF2fjJWG0
         z5DVgxdFAyncahEiBz22dN59GcTiTO49NCBOIXP7q2yq0BZWNFTbtE8Rwelh1FtnyXlj
         4SIE7KCY6ySD0Z/gKcdpwAibKnzniuZ69YaEKSqKe/48vjORbB+Wt1AlVn/MxRYvlmg3
         cTZnuKRlhGWwxM/xak5zp7vrs1ydWde9Al+p3+34q61Q1jo+zJITHREEf/3OsnVyJ/Qr
         I/SO4/PjV/o/d/CD2q+6LET3HfEa0W6eQrmwQT2B0WKSGTsFjksqeyMnmpeFzeI/KrlU
         gCqQ==
X-Gm-Message-State: AMCzsaXnQ+jfuquu9C/6+YUIEBRTWtXJOBEqFZxiu4dhN1rv6xXRflrm
        sxsw3DTk/xQyZzaEmNHN9v8IIVEVI+dx138eeAU=
X-Google-Smtp-Source: ABhQp+SZ3aURD62lPf6g2sUpGhHorpUjwyImQ+oQsTPfALzbviMRKe6l3FcVcCi5tJYwU07/uRNBvv7f0nLrKzuAfy4=
X-Received: by 10.237.63.129 with SMTP id s1mr15747134qth.89.1509385260373;
 Mon, 30 Oct 2017 10:41:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.28.246 with HTTP; Mon, 30 Oct 2017 10:40:59 -0700 (PDT)
In-Reply-To: <CAN0heSpRc5VwuMgusoPBegUSsc3t8USK6hm2wd5CyqNpKUiObg@mail.gmail.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee2ca-bf824205-86e6-4259-b7d7-a68e2fbb087d-000000@eu-west-1.amazonses.com>
 <CAN0heSpRc5VwuMgusoPBegUSsc3t8USK6hm2wd5CyqNpKUiObg@mail.gmail.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Mon, 30 Oct 2017 23:10:59 +0530
Message-ID: <CAFZEwPPH+pZQ2OtQjbDqjz3L_WCU2UvRQx60WFg8y-jTNUKnQQ@mail.gmail.com>
Subject: Re: [PATCH v16 Part II 5/8] bisect--helper: `bisect_next_check` shell
 function in C
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Martin,

On Fri, Oct 27, 2017 at 11:05 PM, Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> On 27 October 2017 at 17:06, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> +               /*
>> +                * have bad (or new) but not good (or old). We could bis=
ect
>> +                * although this is less optimum.
>> +                */
>> +               fprintf(stderr, _("Warning: bisecting only with a %s com=
mit\n"),
>> +                       terms->term_bad);
>
> Maybe this should use `warning()`?

Yeah. That would be better.

>> -               # have bad (or new) but not good (or old).  we could bis=
ect although
>> -               # this is less optimum.
>> -               eval_gettextln "Warning: bisecting only with a \$TERM_BA=
D commit." >&2
>
> I wonder if we can somehow pick up the existing translation? It would
> now be fuzzy, in some sense, but since the string was originally in a
> different file, maybe the po-tools won't be able to discover the
> fuzzyness? We could add a TRANSLATORS-comment, so that the translators
> know that this string matches an old one. There are more strings like
> that in this patch, and maybe in some others as well, I haven't looked.
>
> (Adding Jiang to cc.)

Since I am re-rolling my previous series as well, I can make the
change in all patches.

Regards,
Pranit Bauva
