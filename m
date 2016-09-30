Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05CC2207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 06:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935896AbcI3GST (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 02:18:19 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36387 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935528AbcI3GSS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 02:18:18 -0400
Received: by mail-yw0-f196.google.com with SMTP id r132so159867ywg.3
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 23:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4K4DZV7zFxcqmB33VyShcLTs5Q790xRuJ543GWKsdM8=;
        b=Mawh55Q/c4p1fqiM6WgQO45Mg4815K2EGInPBN3amjmxHA2B95Rvzu6yWVuGJ8p1Im
         tU9kjcQbKq2QVlgoG4qG0v7nq06klfQ7nMxPipVPTbdTx3ZpY1kO5UvF9okZeP7jY9JY
         WRImgfdQU7V0XFiBAMiRJeXL+RKyui4JEUb9gRlFCmd9y0Ck8QsYq+Y3oD9rQfZt0VKR
         SvtGmMdcZ9HsYtCh2khleQtIKBQxA4OcDCNCaWztQXosfVXwf3zFJbF/5EevhYpQKAJx
         9/PIQ1woFAclaKsm552hUIIzdhaWSOIyOCfY3x9fuqAMdpPZqOj8pn+sp0z8XNVWF1FB
         NJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4K4DZV7zFxcqmB33VyShcLTs5Q790xRuJ543GWKsdM8=;
        b=YVscI3ciLyE+yu13dyVWlZlIbRLil8q3zAyqvhrekw844/RB5xvrdF7MVexxtiFfoz
         /qonAlsAeNBRG3HsF/b41B7toDdld0slosuZl/GUoV+VGnVWZCyM0c0+Dy3kR3FI2F4S
         9PvRPpUYxboMykSAotXxqMVWR6tWmy+8kcOM1v+ZEHwawvCchIkYM1Duj+RRNfoteEVh
         LlSaRCahpVSWwRuSj0Q9efKITf0GGESDV5nHj4IFvowxa3wID0iD/o2Oc9BirSjx4rdE
         b+D6oWw0c2J/ASZ8IVCs/49Zsnk2DY5PmExnoGgms0dTzXNi1bdKzwUajLk0TDZeWPrE
         CSiw==
X-Gm-Message-State: AA6/9Rl8NdUcgowlDlDeiay4QdNKxcEKBBwIidmUa92kkiqJt31SJsSW3VpHRlbM8SZxLwGZm+NjeZwlkGNb6w==
X-Received: by 10.13.203.79 with SMTP id n76mr3015919ywd.122.1475216298035;
 Thu, 29 Sep 2016 23:18:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Thu, 29 Sep 2016 23:17:57 -0700 (PDT)
In-Reply-To: <20160929083342.ozo2tef45hu4ox7g@sigill.intra.peff.net>
References: <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net> <20160929083342.ozo2tef45hu4ox7g@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 29 Sep 2016 23:17:57 -0700
Message-ID: <CA+P7+xoxTpqn=jkuHYp5pKCCWfKLP5OKCTBYkcTVw_RhEw0KVw@mail.gmail.com>
Subject: Re: [PATCH 1/5] pretty: allow formatting DATE_SHORT
To:     Jeff King <peff@peff.net>
Cc:     "Kyle J. McKay" <mackyle@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 1:33 AM, Jeff King <peff@peff.net> wrote:
> There's no way to do this short of "%ad" and --date=short,
> but that limits you to having a single date format in the
> output.
>
> This would possibly be better done with something more like
> "%ad(short)".
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  pretty.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/pretty.c b/pretty.c
> index 493edb0..c532c17 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -727,6 +727,9 @@ static size_t format_person_part(struct strbuf *sb, char part,
>         case 'I':       /* date, ISO 8601 strict */
>                 strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(ISO8601_STRICT)));
>                 return placeholder_len;
> +       case 's':
> +               strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(SHORT)));
> +               return placeholder_len;
>         }
>
>  skip:
> --
> 2.10.0.566.g5365f87
>

Nice. I use date=short in some of my aliases and switching to this is
nicer. I assume this turns into "%(as)"?

What about documenting this in  pretty-formats.txt?

Thanks,
Jake
