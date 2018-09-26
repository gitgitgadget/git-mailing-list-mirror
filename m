Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B13061F453
	for <e@80x24.org>; Wed, 26 Sep 2018 22:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeI0EdR (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 00:33:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36767 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeI0EdR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 00:33:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id n23-v6so34295wmc.1
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 15:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+9+bzg0Icky7IdhMvYrZfGQ3kqNsORd9bGBfRbE0aro=;
        b=sT0245g7EnNaboLn34YxNdCSGlLgm8Ckf7dl+duIqzg+65rmimi/HXxkheySjfzJJD
         W5XBXw7t6fSLZmpkipS1DUREIBKv4pSQe7qJds7fCGzJ2i+E2Qck8EDrpqtogOyX2wUM
         rUp9Vd4sG3P1spRO093g94j0KHsSCMFAWnRwsN8LHl9MvJl8He4LP23zflnOenxPalhb
         VxpOQ8Ww3I4G7UfS0n3PeLFlOi/d7QaxEAw362G0r93ARd1X9qiNeOFJdz7l+TDUt/Zu
         4pfSXoKfh+EZSh76Gfk0unhiy2Haqu3dGiWB/atSA7A7YbIhKGwy9eKmKAWeuWgtuw91
         oLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+9+bzg0Icky7IdhMvYrZfGQ3kqNsORd9bGBfRbE0aro=;
        b=N7VqY3agm9wFUg5Ygs4o6hJx6wbenzoe0YKRlUCdMNvqdz0WNnBP+mH9tecvLJb/mB
         Xu446/N3jbDe1EUyc4WAgmXRh0Hg1azfZMsAPrX2ObEu8eHeivkR5oqooCHM95DIsFeU
         CubwKPDgwB0jKOgSO7fOYD3njec9ifzl5bF/4s22WN+/n3DZkXiWJADcgV0Fe1aFmaS7
         RJxotMpDBWiH0Gf6PC/7iSQ8hPfbDxHgJyAKvI/Q9L7LX0ALedoRS0oh9MGb/tvHymFP
         flgueZr4ppzMd9d+wvQDRlwqbOc1fewFiBVf4Dxcmy4Q0Pfrr+fmA7JC4rE5+brH2DFe
         /ukg==
X-Gm-Message-State: ABuFfoivv9VOmKLwtPPMv4Ab4xXuTGCDZTBOYsQT72QuSUW8OhmOK880
        rXPc4nndMxLSGARjKbWCnd2lAojt
X-Google-Smtp-Source: ACcGV61lPL6IUZdmaClqxy+rhs4kiN0BLP1Fm1JlYQzOKAKC+bcFsIsZPpkNH9Z8QjeucO4deSZjkg==
X-Received: by 2002:a1c:2384:: with SMTP id j126-v6mr5790142wmj.124.1538000290168;
        Wed, 26 Sep 2018 15:18:10 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y4-v6sm148835wrr.75.2018.09.26.15.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:18:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 2/9] submodule.c: fix indentation
References: <20180925194755.105578-1-sbeller@google.com>
        <20180925194755.105578-3-sbeller@google.com>
Date:   Wed, 26 Sep 2018 15:18:09 -0700
In-Reply-To: <20180925194755.105578-3-sbeller@google.com> (Stefan Beller's
        message of "Tue, 25 Sep 2018 12:47:48 -0700")
Message-ID: <xmqqsh1vj42m.fsf@gitster-ct.c.googlers.com>
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

Makes sense.

>  submodule.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index b53cb6e9c47..0de9e2800ad 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1244,7 +1244,8 @@ static int get_next_submodule(struct child_process *cp,
>  		if (!submodule) {
>  			const char *name = default_name_or_path(ce->name);
>  			if (name) {
> -				default_submodule.path = default_submodule.name = name;
> +				default_submodule.path = name;
> +				default_submodule.name = name;
>  				submodule = &default_submodule;
>  			}
>  		}
> @@ -1254,8 +1255,10 @@ static int get_next_submodule(struct child_process *cp,
>  		default:
>  		case RECURSE_SUBMODULES_DEFAULT:
>  		case RECURSE_SUBMODULES_ON_DEMAND:
> -			if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
> -							 submodule->name))
> +			if (!submodule ||
> +			    !unsorted_string_list_lookup(
> +					&changed_submodule_names,
> +					submodule->name))
>  				continue;
>  			default_argv = "on-demand";
>  			break;
