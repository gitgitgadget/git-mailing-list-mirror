Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C2D41F404
	for <e@80x24.org>; Thu,  6 Sep 2018 17:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbeIFWKg (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 18:10:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40037 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbeIFWKg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 18:10:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id 207-v6so12025259wme.5
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SQZVLX2lpZnChFkvmX0RzvyXMWmNOOSsiNNVuzVK7bg=;
        b=gtBQNPyvl3AO7eY4XtAixucbmTAzcRiOMyp6KjzEwmZknltQhchBHoGaQ/SJ47M/AM
         Vo3XKCFAFeTuNq5nhM66hKKMcjKkGCoAEn83ouCT27wD09rSIpeXQrYq/PQ+YJNkoILh
         oeC1mqykufjoYFbUTOZLpLw4oh7tUNKW6y9hwEXk3inmOGOeyfzYInu6B1zwsMdUz/88
         eacEs3N/I7h/LWBrsEvEH4/AhIkJqQJFZK6C8KZF13Relj/68SaZ5nzBX1ACWstyr6g5
         HoYvCxtJoWOSpoootUPF4ygwBnP8iQ7pkteEMDikq9dBN1Nv0u/RY0J080PzVYKibmQ4
         /yGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SQZVLX2lpZnChFkvmX0RzvyXMWmNOOSsiNNVuzVK7bg=;
        b=NAaDi8yQadklQNDQO1moGftbcX6Hwm/dJLZ+HgGvGJE6vwBIsmOK2B0Z5Hs9v35aiz
         Lh/2zi7yIXqmxYRbU5GAivGGOuQ1bT9BJsIttmub9GE+Hw0AVN581ICKDkfMU7qEzPO6
         vi1yLm/cQrXluxFLSz2TlrTtbvssPSs99e/O4UnSkdfyBqWvKy2gMUsKmLx6h2mawmHQ
         VRxnRPDEcfPIQ8Vlvu6xroEtSsstsheOgnjLZw+tCk8JzMf2LeVLpLH9MjY9o4VFlNhW
         MK9PrcBD+tXbaIqVr646CtasYygYrBKn6nvvYtuj7ccnkg8l7PE/H4AHJvmAk+TrAZXH
         12uA==
X-Gm-Message-State: APzg51CjXiu8icR+i7LSKruI3eA1h+tAwtlPceFEkLYPaduSVGxIPD3v
        HBWNIOpOA6DYcr/Rp9Egg7oSqhyV
X-Google-Smtp-Source: ANB0Vdaclx/razGumzQpGZLAghxH4dwasTU/VCLcdrTv0hqoMxsrt4rZ5JQeJQYxBeTWE6vPnFpzKw==
X-Received: by 2002:a1c:c501:: with SMTP id v1-v6mr2838543wmf.115.1536255244315;
        Thu, 06 Sep 2018 10:34:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 72-v6sm5105509wrb.48.2018.09.06.10.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 10:34:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 05/11] submodule.c: fix indentation
References: <20180904230149.180332-1-sbeller@google.com>
        <20180904230149.180332-6-sbeller@google.com>
Date:   Thu, 06 Sep 2018 10:34:03 -0700
In-Reply-To: <20180904230149.180332-6-sbeller@google.com> (Stefan Beller's
        message of "Tue, 4 Sep 2018 16:01:43 -0700")
Message-ID: <xmqqin3i1qes.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The submodule subsystem is really bad at staying within 80 characters.
> Fix it while we are here.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index da2ed8696f5..8345d423fda 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1244,7 +1244,8 @@ static int get_next_submodule(struct child_process *cp,
>  		if (!submodule) {
>  			const char *name = default_name_or_path(ce->name);
>  			if (name) {
> -				default_submodule.path = default_submodule.name = name;
> +				default_submodule.path = name;
> +				default_submodule.name = name;

Besides indentation, it is good to avoid A = B = C assignment.
Written this way, it is more obvious that these two fields share the
same pointer.

Good.

>  				submodule = &default_submodule;
>  			}
>  		}
> @@ -1254,8 +1255,9 @@ static int get_next_submodule(struct child_process *cp,
>  		default:
>  		case RECURSE_SUBMODULES_DEFAULT:
>  		case RECURSE_SUBMODULES_ON_DEMAND:
> -			if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
> -							 submodule->name))
> +			if (!submodule || !unsorted_string_list_lookup(
> +					&changed_submodule_names,
> +					submodule->name))

			if (!submodule ||
			    !unsorted_string_list_lookup(
					&changed_submodule_names,
					submodule->name))

would be easier to see what is going on.
