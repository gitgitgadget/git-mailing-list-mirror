Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D730D1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 18:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeG3UCs (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 16:02:48 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34099 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbeG3UCr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 16:02:47 -0400
Received: by mail-yb0-f195.google.com with SMTP id e9-v6so5138261ybq.1
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 11:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+ETCjBdcH6O68UqeWfkK9sS5W2je6g7oWTie60J/Y0=;
        b=cngDtp80SqoYcCfcal4KBXniBTuhtHlxOnKhkM9hthPFEAzKGdolNK0sIBeIqylKht
         TSmz1pVZI2G7PHHG433GzlC1wtYjR7vX5uIeMuQFfVXFAf/JsFGoiylVzjtMruddOoyS
         susgpQR8ZiGuY7cRQ685kjjGuqB0rXcOyGTBhDnk0MXjhkQt+gUpXYetXVR9y0MpvhJs
         uZK+15nKfexqbtLLXr9TNPm/9uY8l4pf7T3FcSbweK12pFSOHdzegd6VJQxyplftR26B
         VTAlNqZc08sZzQZTJjX0bIhe1GoiTsrENvOPPWxR4vU2R9Bv7wkqtr3DuMTb0Ee8Co39
         8xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+ETCjBdcH6O68UqeWfkK9sS5W2je6g7oWTie60J/Y0=;
        b=HfN/8kjhmMUI3NoVT8XCrJqMYz/f9kNG3fNQVYGllUlCB2XCQsfWvbOxr/PPMdlbu6
         /ek+IYL7YsDJioOTAEy2Z4ztYYhB2G0Lj4wO1DmOR0pOg+ZBd+A45pNPPwA8QNCZUNPe
         StKuqPxSmv/KuPSsq40bA+hWR5yRyMST8RHSZwJw5se/V0bXg3Nldpy2qYT23nTveFJf
         D7dCs7GcwyBf1veyDIxG2Uqvgo3lLW1kiU+RqYM7xiTew7oleFPmiNZ/qc+76pWiqSEw
         JTRtCMQxeY8WKywFFU9eQY8LFbWCUBi5HDZ7gx5MWRLHHxlpswzjRv5MsEW4VH6L0EBP
         4eMg==
X-Gm-Message-State: AOUpUlG2mlAMh2b/vnRGWLOBAegLkTIaayEliw0Pr4YaYz677hBGuCRq
        A/9zuaRiIfHOiDhBove0k+8367RJfUxMnsVGQ3W07drieqKr6w==
X-Google-Smtp-Source: AAOMgpdjMTZdsV8G0rLNP0VtNRB/8sRkH958BsId+MWChuW4ehk6+5dew5Oloakqeboge3/TuHgqLbxAbrnHo4cgDNI=
X-Received: by 2002:a25:a263:: with SMTP id b90-v6mr10083874ybi.247.1532975192224;
 Mon, 30 Jul 2018 11:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180728211630.29573-1-masayasuzuki@google.com>
In-Reply-To: <20180728211630.29573-1-masayasuzuki@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Jul 2018 11:26:21 -0700
Message-ID: <CAGZ79kYOqP-8t1r_-NVLA025UP+_Zi5SXHWfc7HxRo9gemWDpQ@mail.gmail.com>
Subject: Re: [PATCH] doc: fix want-capability separator
To:     draftcode@gmail.com
Cc:     git <git@vger.kernel.org>, Masaya Suzuki <masayasuzuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 28, 2018 at 2:16 PM Masaya Suzuki <draftcode@gmail.com> wrote:
> Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>

The email addresses mismatch?

> Unlike ref advertisement, client capabilities and the first want are
> separated by SP, not NUL, in the implementation. Fix the documentation
> to align with the implementation.

Makes sense! Thanks for the fix!

> pack-protocol.txt is already fixed.

which has

  capability-list  =  capability *(SP capability)

since b31222cfb7f (Update packfile transfer protocol
documentation, 2009-11-03), which is the first to mention
the capability line, so I'd claim it was always correct?

>
> ---
>  Documentation/technical/http-protocol.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
> index 64f49d0bb..9c5b6f0fa 100644
> --- a/Documentation/technical/http-protocol.txt
> +++ b/Documentation/technical/http-protocol.txt
> @@ -338,11 +338,11 @@ server advertises capability `allow-tip-sha1-in-want` or
>                        request_end
>    request_end       =  "0000" / "done"
>
> -  want_list         =  PKT-LINE(want NUL cap_list LF)
> +  want_list         =  PKT-LINE(want SP cap_list LF)
>                        *(want_pkt)
>    want_pkt          =  PKT-LINE(want LF)
>    want              =  "want" SP id
> -  cap_list          =  *(SP capability) SP
> +  cap_list          =  capability *(SP capability)
>
>    have_list         =  *PKT-LINE("have" SP id LF)

Just after these context lines we have

  TODO: Document this further.

which is a good hint that the existing documentation
can benefit from patches like these.

Thanks,
Stefan
