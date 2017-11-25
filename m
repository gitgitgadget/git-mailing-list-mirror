Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D718520954
	for <e@80x24.org>; Sat, 25 Nov 2017 23:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbdKYXvN (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 18:51:13 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41055 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbdKYXvN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 18:51:13 -0500
Received: by mail-qk0-f195.google.com with SMTP id f63so28379165qke.8
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 15:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ahH4aVhv8Snl0oHOVjQ8Y25H5dQEfjUH9z8PqoG2qeM=;
        b=A7GLPf6KLFEvLqDkGDikSjBKcaxYQd5HYrC3kOnPax7W1hJts/OrdueGW28fDhuVBl
         OiETRV6SamIlShJGFpV8IglVsWsu/fxbt4z0ZPPX7RsM3OZpRDa6W716v35CaBIgk2o4
         LpbS61UV6GCGRdjTVg1eZMAjUlizVYEQoilz8W+0BwDOoFUkiphUBNcoQwdX4Zdg9i8u
         gAkbxqwlmVHK2a5BKyvc14CAGYJJcXjVbADZW/UuA8/zbAGjgwQiZagv/x4NMEbSdLOn
         6MnTrbnHhVj6651WAOZW8+qsCA5epKbQdAaXGFL1uLXQHloppYSRLbFptAgb3EqgM5cW
         mbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ahH4aVhv8Snl0oHOVjQ8Y25H5dQEfjUH9z8PqoG2qeM=;
        b=t8MYVlLQ3hGRTwkt8auOAdS1mOwIs2bjvUjWo1oN4oeSQf+AQco/mMc/u0o6+qK3vV
         g+pi7erD4bvngASvrYezQd079WLSDY3F0ky7bgPFTQoi3xd6Qzw34wYjhGwfqbNU034r
         5oeIQRo9K70oMi+oI0mD2/Nw+mS3uaRLfCpI8Aom7G0zgTZXgT1JoUKp/kvaZSMPU5QF
         Wb8I7LrIN865PgC12YJllQR4OBJU9pdASqoPtH0FiPi0CFWCBnSmwBF9MtkBmLOx88By
         LtHkFkS+PZkuaO33BrPh7AtGKvsRNEEtnFwwgIYruzTF9p6hYh95MM/uTDiAYkdiWx73
         ROjQ==
X-Gm-Message-State: AJaThX7KE7ECVebF7Nlz0yn0QBefUgfDac9YUUK1VBrfZiFB1m1D7dSl
        5aYE8xdO3XM0jHPVP5gzb6AHscv9wh3vggMIyxxfgg==
X-Google-Smtp-Source: AGs4zMbigj4WD2hkoG3DW+fPCnxQ9oJSz01iJjsywf7IqC72kTGXBXqsg+Q1UGPQRYHmVPiZTJbRx5VKOETXVnXJ/6k=
X-Received: by 10.55.42.75 with SMTP id q72mr51694730qkh.57.1511653872253;
 Sat, 25 Nov 2017 15:51:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Sat, 25 Nov 2017 15:51:11 -0800 (PST)
In-Reply-To: <20171125195524.29162-1-jn.avila@free.fr>
References: <20171125195524.29162-1-jn.avila@free.fr>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 25 Nov 2017 18:51:11 -0500
X-Google-Sender-Auth: TwZ5HzcIkD67A0yaCWczCukSfe4
Message-ID: <CAPig+cTZcS0nk-grQaN7kXxJMRELd6fuhS459FtVVeOV1ZYODw@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper.c: i18n: add a missing space in message
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 25, 2017 at 2:55 PM, Jean-Noel Avila <jn.avila@free.fr> wrote:
> The message spans over 2 lines but the C conconcatenation does not add

s/conconcatenation/concatenation/

> the needed space between the two lines.
>
> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 2086f0eb0..a5c4a8a69 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -623,7 +623,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
>
>                 if (refs_head_ref(get_submodule_ref_store(path),
>                                   handle_submodule_head_ref, &oid))
> -                       die(_("could not resolve HEAD ref inside the"
> +                       die(_("could not resolve HEAD ref inside the "
>                               "submodule '%s'"), path);
>
>                 print_status(flags, '+', path, &oid, displaypath);
> --
> 2.15.0
