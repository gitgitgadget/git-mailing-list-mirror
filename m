Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E9DC20259
	for <e@80x24.org>; Wed,  7 Dec 2016 13:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbcLGNAj (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 08:00:39 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:36164 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbcLGNAi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 08:00:38 -0500
Received: by mail-io0-f193.google.com with SMTP id s82so13465740ioi.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 05:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YE0vXq/m79RrIKTKYUgNJ/UAvEMgn2k7KSCbd2uOu64=;
        b=c3erieUOqyKSk6lYgbo2oPzhza1yaA0chdYzyuQhEs4HmPIcD8mRPYKUIGijvOh6mG
         WKcKQwUbw/4+U+gdChNB/Tb4ReFvQ6wbPSc3u9Fz1YJKZr9YYGSls+3o9wX+xb2IqV8A
         6DMruvDVPhjX/i1awBwXh6Sgx07phY/kiiPMeiA8vpgUG3IfgJ7ZWOpzVkjxt3xIgOpx
         fA26ps5vfPlm+w45FUuUKedINh1iwvEv/hIBXtYoj1JwlonGvUMLSws0UWuYkwfTH5zp
         6DgKm8EiwQDhywVYEIIGcHGQsa65gygeWRINAkqaHukPqVbxYBVKLTiDjiE6n7B7RtCg
         OzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YE0vXq/m79RrIKTKYUgNJ/UAvEMgn2k7KSCbd2uOu64=;
        b=VcIFlhU2IG2PJ+boFy0oxeF4bLUctoI73tbFJq/upQfQtBaiZtHjWm0nhscMNI3oQu
         yNHqmfQsbIFgLOQZQwxwu+ORyTAMy2UmlbtG04KnLB9NxLbAWupv4hExMcBJnUQ5yAhj
         CDFIxAFNsht0awVmh2DwBBbClN64KuuAnsEx8yumr4OwWucU2jJj4zB2qY5TCEIbxWdf
         WhtrsQxXuMP0aYvQ4o0k5UDWAB93PL5ju0WxKGBqDoJUCVV/zIxrL7GIa3qEyTL22871
         1AMXZvMMsCvHwweFtwFcD6qkLQ/bms0GvZJJ9RNXhI3cWSzhEGGv8y0SU/L4qZijC3x0
         jMEQ==
X-Gm-Message-State: AKaTC03S2ZdgJ/1pY1rmW2PkOTaW7OkTZTvXjW1winGMG/nzDPqJj4Vhy1qOUUkXya6V22hHUHbT73HvdJH5BQ==
X-Received: by 10.107.44.137 with SMTP id s131mr55451917ios.212.1481115637210;
 Wed, 07 Dec 2016 05:00:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Wed, 7 Dec 2016 05:00:06 -0800 (PST)
In-Reply-To: <1481061106-117775-17-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com> <1481061106-117775-17-git-send-email-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Dec 2016 20:00:06 +0700
Message-ID: <CACsJy8ChJ_H3gDOuKVYGAKYumG0u2WkBVpNr_3ePyAJ9NojvEg@mail.gmail.com>
Subject: Re: [PATCH 16/17] pathspec: small readability changes
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> A few small changes to improve readability.  This is done by grouping related
> assignments, adding blank lines, ensuring lines are <80 characters, etc.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  pathspec.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/pathspec.c b/pathspec.c
> index 41aa213..8a07b02 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -334,6 +334,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>         if ((magic & PATHSPEC_LITERAL) && (magic & PATHSPEC_GLOB))
>                 die(_("%s: 'literal' and 'glob' are incompatible"), elt);
>
> +       /* Create match string which will be used for pathspec matching */
>         if (pathspec_prefix >= 0) {
>                 match = xstrdup(copyfrom);
>                 prefixlen = pathspec_prefix;
> @@ -341,11 +342,16 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>                 match = xstrdup(copyfrom);
>                 prefixlen = 0;
>         } else {
> -               match = prefix_path_gently(prefix, prefixlen, &prefixlen, copyfrom);
> +               match = prefix_path_gently(prefix, prefixlen,
> +                                          &prefixlen, copyfrom);
>                 if (!match)
>                         die(_("%s: '%s' is outside repository"), elt, copyfrom);
>         }
> +
>         item->match = match;
> +       item->len = strlen(item->match);
> +       item->prefix = prefixlen;
> +
>         /*
>          * Prefix the pathspec (keep all magic) and assign to
>          * original. Useful for passing to another command.
> @@ -362,8 +368,6 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>         } else {
>                 item->original = xstrdup(elt);
>         }
> -       item->len = strlen(item->match);
> -       item->prefix = prefixlen;
>
>         if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP)
>             strip_submodule_slash_cheap(item);
> @@ -371,13 +375,14 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>         if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE)
>             strip_submodule_slash_expensive(item);
>
> -       if (magic & PATHSPEC_LITERAL)
> +       if (magic & PATHSPEC_LITERAL) {
>                 item->nowildcard_len = item->len;
> -       else {
> +       } else {
>                 item->nowildcard_len = simple_length(item->match);
>                 if (item->nowildcard_len < prefixlen)
>                         item->nowildcard_len = prefixlen;
>         }
> +
>         item->flags = 0;

You probably can move this line up with the others too.

And since you have broken this function down so nicely, it made me see
that we could do

item->magic = magic instead of returning "magic" at the end, which is
assigned to item->magic anyway by the caller.
-- 
Duy
