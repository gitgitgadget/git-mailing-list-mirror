Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E3611F404
	for <e@80x24.org>; Wed, 12 Sep 2018 18:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeILXIV (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 19:08:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39095 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbeILXIV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 19:08:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14-v6so2994498wrw.6
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 11:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kKqnkOt78dktERluI+s5+5v5KTgcMnr9c0mZsxYmlOQ=;
        b=J+dWfdgJtVTnO87Sw348JUbsOhFovppYa9Zf4m9zFwmuVNLeb/4RoOgDgNLF7SxTs3
         FtQXdZDSl5fvcemJorbtJoHperUmDZfEgLkz/D2kp5NmppZkibFBrOS2f6nveqODD5zP
         vSjC7A5aQlTDjBW3uUj3/lgeFQLgMl4LHNEuY8WcFYn3Z7CEQ/nOSNNTJHgwYD0dtS7a
         SDiKfjIcBDzidrOsI4Go6txFRgcqtYtGIeZhVrn2arrUKoHU0HkVBDZjwtdQS5CYCx1C
         Hr90JzVnUzC+rkvGR1WXpeN4l/S0TpooWynuxtohNwr9FteNnH1MGXnhtC4Nr0uuH0GK
         JOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kKqnkOt78dktERluI+s5+5v5KTgcMnr9c0mZsxYmlOQ=;
        b=XbJR5oHUzm9fW7xQnUvrM0sr4I7v7g3MEFps9foUjkEdDWlBzwH+tVSNxYMPNIwth/
         daLgjvj3TmlyyPD9y50oBXng/d8nou1o6NgJKZ5nz130VXsUUwO5fTtzbgDJzAY99LrK
         f63CuWTveCh0SfbWvG3aUMlCAEqgJAeyYjj/qs8kJUpuidnGTIphQc6nYnQjkVx9x5D9
         l13/2dnLOJETr61fRN1ny/uZAPjt1YZ5PED3TZJXep0c42fJvO9VfyLFWPklAOT6ogcq
         XwEPH6tJ2sskLYPlcoE4IUFswpZkH8joOKq1KnJvbPkq/2fJItEVKDgj8lqkuxcSKQAM
         lBsw==
X-Gm-Message-State: APzg51DNZnFhGTPtN0LCBv5GRUDeQ44H8dvA+jsDHtt8t2wQeL2ProH8
        CMzk6dYdUV5tUY8b3rw5E5PcL2jr/zc=
X-Google-Smtp-Source: ANB0VdaF+zqWU6YqRMBHyoRzXtTIW+aIH4HL7RBqCxcQ0gaFhQBC/rcABmSXWF08szBZUugsSbaoHQ==
X-Received: by 2002:adf:e792:: with SMTP id n18-v6mr2435909wrm.136.1536775360741;
        Wed, 12 Sep 2018 11:02:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w3-v6sm2322728wru.93.2018.09.12.11.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 11:02:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/9] submodule.c: fix indentation
References: <20180911234951.14129-1-sbeller@google.com>
        <20180911234951.14129-4-sbeller@google.com>
Date:   Wed, 12 Sep 2018 11:02:39 -0700
In-Reply-To: <20180911234951.14129-4-sbeller@google.com> (Stefan Beller's
        message of "Tue, 11 Sep 2018 16:49:45 -0700")
Message-ID: <xmqqva7alhkw.fsf@gitster-ct.c.googlers.com>
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

Makes sense.  Thanks.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index a2b266fbfae..d29dfa3d1f5 100644
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
