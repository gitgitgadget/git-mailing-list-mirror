Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694C71FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 19:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752420AbdBMTeg (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 14:34:36 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:33235 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752285AbdBMTef (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 14:34:35 -0500
Received: by mail-io0-f193.google.com with SMTP id 101so10412347iom.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 11:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HWq2yyNcAm11oaVijWEnNxj0z1WSvS63sY517rIMNoU=;
        b=ZgtPLvcxeN4vdk0NAJnK17OThSkVggrEm6N4l8KdChyu/ooWHG1F9RloddZmDD6D71
         ziqFmRyGIyoZ/O2StdJcaELjkX+lUr3AEsQig8tPOTAD95U7Ku0L9gtxjIijA8wiFpL5
         iH4pkw0N5JSfTNikvfqu7l1zpKpE45LXF/BbNIAsMZs+e+xN+J1YeBd8FjprW5mmzFom
         Jlc09CnbHDRGxQlt6UvJeqqExOqpIsRlRASbg/UmcaTa6QTrJHOVoxssOAFO/1DG8u5r
         TZb4/UEnEXp9GqUPWuZ1K4Ti9rALMFNDIIMieT5zbIthD66HuLSSD17cxMMLjEi+9qUe
         q/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HWq2yyNcAm11oaVijWEnNxj0z1WSvS63sY517rIMNoU=;
        b=bOE4QBttsJ4nRUSQglh1TJGd0EY3ePLJXJHlhp+PWqc8nmUpTNlLyqfhW6fihevIFW
         xsh6U1thc+IOPVxpNFL8Y2Zn3yobX4qPluvn6KTM7J/oSwTLX+RoJTHfj9fij13kE5tl
         7QdPbstcNDEXDrX0FTYNVjVPIC80EJz0j27HBZTXbbq+3v31mmqodkE56REKZOqUWw1s
         s1mzoNMmspzvG7UVXLn8PNJKuxBMuA947TBBdZ5NkwR5PPcJRhRiOj/so0JeGszzj3PN
         SeXY59Eo+2pgF7mydIzgPxeHwLYzAZm+JwB8uGC45UJL91FjJy3ZDzZhclCTktNaSZzk
         yeXQ==
X-Gm-Message-State: AMke39nCvKYe47dn+tkJurad8rX3Rv69nU5Oy/ZLU3250BXvMiTRwHTh0O/DKd1f+CpXYEJf8GIbJAXg39H0EQ==
X-Received: by 10.107.161.83 with SMTP id k80mr22249283ioe.47.1487014474794;
 Mon, 13 Feb 2017 11:34:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.147 with HTTP; Mon, 13 Feb 2017 11:34:34 -0800 (PST)
In-Reply-To: <xmqqinodewdr.fsf@gitster.mtv.corp.google.com>
References: <a1b9143bb29a8a5979dd733ed20161e6769b2b83.1486736391.git.johannes.schindelin@gmx.de>
 <128b4de6-7b8e-27b9-414d-c6c6529cb491@web.de> <alpine.DEB.2.20.1702131722350.3496@virtualbox>
 <74dfcffe-274c-7045-420a-95612394d66b@web.de> <xmqqinodewdr.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Tue, 14 Feb 2017 01:04:34 +0530
Message-ID: <CAFZEwPNUXcNY9Qdz=_B7q2kQuaecPzJtTMGdv8YMUPEz2vnp8A@mail.gmail.com>
Subject: Re: [PATCH] fixup! bisect--helper: `bisect_next_check` & bisect_voc
 shell function in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Tue, Feb 14, 2017 at 12:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Initializing to NULL is still the correct thing to do, of course --
>> together with removing the conditionals (or at least the negations).
>
> So, let's give Pranit a concrete "here is what we want to see
> squashed in", while you guys discuss peculiarity with various
> platforms and their system headers, which admittedly is a more
> interesting tangent ;-)
>
> There are early returns with "goto finish" even before _syn
> variables are first assigned to, so they would need to be
> initialized to NULL.  The other two get their initial values
> right at the beginning, so they are OK.
>
>  builtin/bisect--helper.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 8cd6527bd1..6949e8e5ca 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -280,7 +280,7 @@ static int bisect_next_check(const struct bisect_term=
s *terms,
>         int missing_good =3D 1, missing_bad =3D 1, retval =3D 0;
>         char *bad_ref =3D xstrfmt("refs/bisect/%s", terms->term_bad);
>         char *good_glob =3D xstrfmt("%s-*", terms->term_good);
> -       char *bad_syn, *good_syn;
> +       char *bad_syn =3D NULL, *good_syn =3D NULL;
>
>         if (ref_exists(bad_ref))
>                 missing_bad =3D 0;
> @@ -341,14 +341,10 @@ static int bisect_next_check(const struct bisect_te=
rms *terms,
>         }
>         goto finish;
>  finish:
> -       if (!bad_ref)
> -               free(bad_ref);
> -       if (!good_glob)
> -               free(good_glob);
> -       if (!bad_syn)
> -               free(bad_syn);
> -       if (!good_syn)
> -               free(good_syn);
> +       free(bad_ref);
> +       free(good_glob);
> +       free(bad_syn);
> +       free(good_syn);
>         return retval;
>  }

This helps a lot ;) Thanks!

Regards,
Pranit Bauva
