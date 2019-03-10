Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A88620248
	for <e@80x24.org>; Sun, 10 Mar 2019 18:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfCJSKs (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 14:10:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36496 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfCJSKr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 14:10:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id e4so2088955edi.3
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/td1mgA1UyvMII3MDvgv6gLOHNDyfYd9jc8Sj91jdX8=;
        b=QVPSomUiB9Dtjf3yt7NUbqeBGtgm/hKTTFFYrOv8iVkCKdNxuYEM43Y749clUNrBvO
         jMozdBnbF1CjnZEPSzjxjrZUAceucEV+Ensv9/aAf3/vWuhWmhy03LGTKb3CRCaPSnhY
         SKVMWz0J4LkNtXNu/5+n2TmCedmdWkfbRbrtW/P/uNvzgrHlgN7pk1uROhnMcBnfun0w
         2XFiA8wn2ySyexeBr+7y3Y0kh9Xmqy4NxzkqllizA9wfIS/0ARCm2ds+oD7T4h2OxRRs
         dHMiM1jLc1h1JR4AkYAfetxqZuVEAl7VcOT2+Xgr4mmCaXoB92kHlB/oY8rh1Hg1O/u8
         hlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/td1mgA1UyvMII3MDvgv6gLOHNDyfYd9jc8Sj91jdX8=;
        b=UkZ0fPIN4lGxLAJjasBklAweoDMxl1CtT1a4j7+DJCLjuhcizXruScv5NfRaRBFGrF
         Y8GW97BlqbbE1joEOTJoTVCQ/HewK7IDDW7xf6j2gLInCdO7eRWWPqwV9l1RKYf13OFW
         6x55ihKAFe6oiAx2A+XM6+0+fU6ASlbdevTE9IyCDw7is4CsKd0BF5XU6siODDmUlugx
         8PqR+tc99Sj8nceowZAE3kaBfx9qdH2gb4EqH5wBaIQUls+4dlF3AKWQde2RdxiniDly
         YjKUh6WOJd61cuTle/OOHf4BN8xCL3NQPWTnxK4DogCK9OuPulmVgGNju6jLV7YA35RL
         ZNkw==
X-Gm-Message-State: APjAAAXIhETPqGFiBjbvIQ9UsLN9e6HF/265pb/oeVLlrOAazRPaHOIE
        SnFOTIjUUHx+T/A3et+FDUOqpD4x9kuSb8sxxAc=
X-Google-Smtp-Source: APXvYqxfEX1nTxxk+bXRbt689PzmYZ2Dfejh+1w4VDKT25cnWLs2KT7ACkf2LSEDHXIwVJHbUgjQfbeVDl4xzTAPehE=
X-Received: by 2002:a50:a535:: with SMTP id y50mr41040107edb.163.1552241445519;
 Sun, 10 Mar 2019 11:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190310143126.GA13588@hacker-queen>
In-Reply-To: <20190310143126.GA13588@hacker-queen>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 10 Mar 2019 19:10:33 +0100
Message-ID: <CAP8UFD03cjbWE1pKRj93BKxxQnNuAUPCHNxmtM8RqqfJO2nu-Q@mail.gmail.com>
Subject: Re: [GSOC][PATCH] Fixed an issue which contained extra unnecessary code
To:     sushmaunnibhavi <sushmaunnibhavi425@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 4:30 PM sushmaunnibhavi
<sushmaunnibhavi425@gmail.com> wrote:
>
> From 5a6c233c6bf0a35aca000b32b9e936a34532900a Mon Sep 17 00:00:00 2001
> From: sushmaunnibhavi <sushmaunnibhavi@gmail.com>
> Date: Sun, 10 Mar 2019 19:37:33 +0530
> Subject: [GSOC][PATCH] Fixed an issue which contained extra unnecessary code
> Signed-off-by: Sushma Unnibhavi <sushmaunnibhavi425@gmail.com>
> ---
> Since '\n' and '\0' are char_len==1,it is not necessary to check if the char_len<=1.
>  compat/regex/regexec.c | 5 -----
>  1 file changed, 5 deletions(-)

It doesn't look like the patch is formatted correctly. I think that
the explanation line ("Since '\n' and '\0' are...") should be above
the line that contains your "Signed-off-by: ..." and there should be a
blank line between those two lines.

Also we ask for an author name in the "From: ..." header that looks
like "Firstname Lastname". A simple way to do that would be to make it
match the name in your "Signed-off-by: ...".

> diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
> index 1b5d89fd5e..df62597531 100644
> --- a/compat/regex/regexec.c
> +++ b/compat/regex/regexec.c
> @@ -3799,11 +3799,6 @@ check_node_accept_bytes (const re_dfa_t *dfa, int node_idx,
>    char_len = re_string_char_size_at (input, str_idx);
>    if (node->type == OP_PERIOD)
>      {
> -      if (char_len <= 1)
> -       return 0;
> -      /* FIXME: I don't think this if is needed, as both '\n'
> -        and '\0' are char_len == 1.  */
> -      /* '.' accepts any one character except the following two cases.  */
>        if ((!(dfa->syntax & RE_DOT_NEWLINE) &&
>            re_string_byte_at (input, str_idx) == '\n') ||
>           ((dfa->syntax & RE_DOT_NOT_NULL) &&

The code looks like:

 char_len = re_string_char_size_at (input, str_idx);
 if (node->type == OP_PERIOD)
    {
      if (char_len <= 1)
    return 0;
      /* FIXME: I don't think this if is needed, as both '\n'
     and '\0' are char_len == 1.  */
      /* '.' accepts any one character except the following two cases.  */
      if ((!(dfa->syntax & RE_DOT_NEWLINE) &&
       re_string_byte_at (input, str_idx) == '\n') ||
      ((dfa->syntax & RE_DOT_NOT_NULL) &&
       re_string_byte_at (input, str_idx) == '\0'))
    return 0;
      return char_len;
    }

If the byte at re_string_byte_at (input, str_idx) is indeed '\n' or
'\0', then yeah probably char_len == 1 so the current code should
return 0 just before the code below the FIXME comment is reached. So
in this case the 2 checks below the FIXME comment are useless because
they check re_string_byte_at (input, str_idx) == '\n') and
re_string_byte_at (input, str_idx) == '\0' which cannot happen.

So I would say that the right fix would be to remove those 2 checks,
not to remove the if (char_len <= 1) check above the FIXME comment.

Also note that I used "probably" when I wrote "then yeah probably
char_len == 1", because I think it is worth checking what
re_string_char_size_at() actually does before being too much
confident...
