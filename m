Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC97D20193
	for <e@80x24.org>; Thu, 11 Aug 2016 20:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbcHKUNK (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 16:13:10 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:33849 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129AbcHKUNI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 16:13:08 -0400
Received: by mail-io0-f178.google.com with SMTP id q83so6697773iod.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 13:13:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z4mUJ4qz1EfNkTMpN92N52L5cit1cCTknnT6xrOFF8w=;
        b=WcnqbcyBj/x0u62b0xTpRvFzVpc9USJj2pu2anVppbxcb1c7qLbyc+k2abQuMyPOjs
         vWZvqFW6mTDeB1Kmhi9tiDDXJmzkT5tKRYlGJFwjst0CL92TLSBXpd41K88516BWpXZN
         zffw0kVVRMnqUHDP7Qm9l0EZ87dX19OWxHlYrdu79cYVYnKK2/uwZL39Uwk5bKjLhXU1
         6YzGJGmOk5nDABA68hBvLl/8pb7anquKRhtbvHT0816IaaZPPZIjmDgxSpkuYYAlP63z
         kz3v5yknXrrHJ3HEfcNZaRyBnPcHVxFpbbtCOXm8uFXxntrlVkpxTbhoTObqDbVxHTwK
         w/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z4mUJ4qz1EfNkTMpN92N52L5cit1cCTknnT6xrOFF8w=;
        b=jnYMvIOR7jyQkZ0D/GpUHR8MchL2fKh5rUfz3/87ON0PkJf56X94rAiwQebvxGhHY3
         dhuti9/e+KQsO44b0Wbmi4I7y/pNnYkjCC4I6mw5wIduO0kmYNiDZvJ0VIyN6lAj6OeM
         2z/fEvFg+B9nwy9Jus87TgZ+34yCP8+0j5EIJUyeHQ1mtQYeWKMBCGEd3YbVjhRo4tVJ
         NtTcUBIV7fEjqAmovjnf/IA1z0FYgy2xoKW514i6MUdqYpboqBKw4N3SBCEaHoZoulMU
         UK/RA7MTSbbq2btHd8JAb9YKBcdTgwX3gynkmY+nIKKSLDD1azD/G1f5lVdMu5D5CGfH
         sHcA==
X-Gm-Message-State: AEkoousAf8y/KDU5SIuxcnCEfl6jom1YMLXFscHrG01l9mHZ3ayzw9HZbjvKdmY3qPP8bOk+0T2IKEjsIf7QhWD3
X-Received: by 10.107.144.10 with SMTP id s10mr13246639iod.165.1470946387458;
 Thu, 11 Aug 2016 13:13:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 11 Aug 2016 13:13:06 -0700 (PDT)
In-Reply-To: <322d7d47-423c-f631-3057-1feb03d50591@ramsayjones.plus.com>
References: <322d7d47-423c-f631-3057-1feb03d50591@ramsayjones.plus.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 11 Aug 2016 13:13:06 -0700
Message-ID: <CAGZ79kZw2E8GDLBvs9MRW90ny8AnszxOcV2yVM8+r2y_sE3=og@mail.gmail.com>
Subject: Re: [PATCH] submodule: mark a file-local symbol as static
To:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 11, 2016 at 12:57 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Stefan,
>
> If you need to re-roll your 'sb/submodule-clone-rr' branch, could
> you please squash this into the relevant patch (commit 336c21d,
> "submodule: try alternates when superproject has an alternate",
> 08-08-2016).

Not just reroll but rethink and rewrite. ;)

Thanks for catching!
Stefan

>
> Thanks!
>
> ATB,
> Ramsay Jones
>
>  builtin/submodule--helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 4c765e1..4c7d03c 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -641,7 +641,7 @@ struct submodule_alternate_setup {
>         struct strbuf *out;
>  };
>
> -int add_possible_reference(struct alternate_object_database *alt, void *sas_cb)
> +static int add_possible_reference(struct alternate_object_database *alt, void *sas_cb)
>  {
>         struct submodule_alternate_setup *sas = sas_cb;
>
> --
> 2.9.0
