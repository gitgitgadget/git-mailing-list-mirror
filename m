Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8730C1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 18:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964988AbeAXSHP (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 13:07:15 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:39303 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964826AbeAXSHO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 13:07:14 -0500
Received: by mail-wm0-f42.google.com with SMTP id b21so10312977wme.4
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 10:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CK6qerKXT1Encs77xBR31imCHEALgUmF8/7tjfnpqVg=;
        b=GS2I+T0rrwHdUWiUL9AsUnoTdr8XZWZtVcVHm7oIDQr3cU1uFicHE4HomhMnd3DOiE
         GFj3V4sJNsSGQT+B/Fe7Xz6yhttzDKQU0qFkHUzQ1GCLnfzOfujEjBud5nw9ByuDCg1m
         Q1Fb87dOgW4nANv6mkRYJum6secH34rpyuqMDajwviBpqbLbZ0AFyUQdBLmTsIomLS3X
         TdDMhd5rxwiBd2ad4/08SPiy9a+tAVVtn/qjh2NELTFXrnWwixT1xB/D0g3A2hkOzCIX
         qQsflPS9w15GAElTM9oZM84V0Fn2DuF5CEXxEMy/vJLoLiT4Pob9UFS4l2/afOmZnKqN
         JSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CK6qerKXT1Encs77xBR31imCHEALgUmF8/7tjfnpqVg=;
        b=KbIXpyQ48nhZbcVykTirrUSRgQSUPklflUicXqFnNsHV+v7a4hDn9mMChj25oyMMt4
         34GkVmQi+BGXv6MfnXMxvQn4sH/wEq5Y3ugwyUOMdSQe0iiKZ3/OOOAyAWxX/glULqe4
         dXjDnem6UHIdB4Ibn4cND3HVcC+55aVMl7FUeT2lJT2xUlX/yKsd0rJssQ3mj6LCpvZr
         o8Jy4TzXNvp0G9ndDpP6+uOUfDI844GJAzNgqPtIuIyDQANsZhdYEvGEXmQlIln0TqN9
         7F8q6Ao4aeEkHsPaENRFRxoJ/+NhOI49VeuBBLf/ae4z7r1lyS7NsE1wTIfzifihJs8D
         y/iw==
X-Gm-Message-State: AKwxytdN4oZzfDat4SMgnjC4rkPX+g1OqtqacyZmgIUwUpU9KxdWSL66
        Hghl2yN8qVMSt6DmFfqWbsxkUTiqiBUk7xece7XITA==
X-Google-Smtp-Source: AH8x227T0JTPXU+o49A6ZJS4Q1+cZt+0ir3mXkbgIoqMIaNawfqgIJsJCbAnMhNACbec4N6UUBgGtmfbWCiZzykhH2E=
X-Received: by 10.80.196.73 with SMTP id w9mr20319509edf.293.1516817233512;
 Wed, 24 Jan 2018 10:07:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.177.180 with HTTP; Wed, 24 Jan 2018 10:06:53 -0800 (PST)
In-Reply-To: <12531516812201@web36o.yandex.ru>
References: <14657461479715884@web21h.yandex.ru> <CA+P7+xrKfqOb-3FhKxXdnF6g9PktNWNzY+ZnHJS=yuVo1YdXzg@mail.gmail.com>
 <CAGZ79kZbGPneUXVEqJYhQAn+dfYve7qCjhO7QFaV1JBs3HD1aA@mail.gmail.com>
 <CA+P7+xqMUPLC-aKW-fiS629_Owat8sCa5vp_bOwQTO8LP4hCzw@mail.gmail.com> <12531516812201@web36o.yandex.ru>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 24 Jan 2018 10:06:53 -0800
Message-ID: <CA+P7+xrVavoJkPmR17sbUS4zTH4ZioHJLgaKBvXg45UN1popxg@mail.gmail.com>
Subject: Re: Feature request: Improve diff algorithm
To:     KES <kes-kes@yandex.ru>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 8:43 AM, KES <kes-kes@yandex.ru> wrote:
> Here is another place where diff can be improved:
> @@ -141,8 +140,9 @@ My_runops(pTHX)
>                 // Do not trace variables in DB:: module
>                 if( SvOK( inDB ) ) continue;
>
> -               sv_inc_nomg( inDB );
>
> +               // save_item( inDB );
> +               sv_inc_nomg( inDB );
>                 dSP; SINFO; SAVETMPS;
>
>                 // printf( "SWITCH\n" );
>
>
> This would be better it the patch looks like:
> ( this patch is manually created just to light the idea. It may contain errors)
> @@ -140,6 +140,7 @@ My_runops(pTHX)
>          // Do not trace variables in DB:: module
>          if( SvOK( inDB ) ) continue;
>
> +
> +        // save_item( inDB );
>          sv_inc_nomg( inDB );
> -
>          dSP; SINFO; SAVETMPS;
>
> As we can see, here the `sv_inc_nomg( inDB );` line is unchanged and `// save_item( inDB );` is added.
> Here we just add/remove empty lines and patch looks more better.
>
> I think (and this is my assumption), the the diff algorithm should take into account the string length.
> This is more better to add/remove more short lines
>

Hi,

Can you check if this is already handled by --indent-heuristic option
of diff? I think it might help this one already.

Thanks,
Jake
