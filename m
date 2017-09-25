Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A973D202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 17:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965308AbdIYRZ1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 13:25:27 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:54895 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964851AbdIYRZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 13:25:26 -0400
Received: by mail-pg0-f44.google.com with SMTP id c137so4349905pga.11
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 10:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a+tVTjc5BIAD7eOFeG6CBx8oH+MqvKwAd4kb2pohWdA=;
        b=InQ9rl+eyxCEudszDJRDQBUwbWiYnEvD4rkhdPq3HX7fwhK76Q4dK+rGsKeLpPi5KP
         bBbOdBaMGlX/KbMBRrf4qZih66FSkkz31T+f7GQG77HTbbpmDU2JQEhZt/tPbKSWA7QR
         w3crVOnLpTEY/PUPBqNkkpjZ0WDXdRnfwgEwmokInRQapesAImO6CG3pjMG0WJgYLCyO
         E23EZnGUJjE8urSyJw5/N3rLL5SNQU0SZDsguJX/wUr2GGfRhxEtGCtxyVi2ucDVrKoE
         IOmzEEYFz1UkQB4pe7FtLzjoU9h1IG3bUWBeQ44zmW0a1iOZOtuv6wWlw/tO6X+EmURZ
         P2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a+tVTjc5BIAD7eOFeG6CBx8oH+MqvKwAd4kb2pohWdA=;
        b=WJprcQxfBi7cP5shMBXE8q0sK+eKn2jAHTuIfkX122483i21xdmBEbF/joZhrzwVe0
         rVnExLeyCkgawRETinvXJVJokjE6AbLtpkMMrMZsrsWKFlFyLu10yrHdgg796QOlJave
         xTgECRtBMNRWQZOepHExJn94YmlzSBGKEaQNaIyjpW+U9uBwTQse1c0ZDICIa85tEoKy
         SNUVqobnhj8AOMQ+mzpA0q+37II6vksJFnoz1HIU9JzqkmQUMm2+05OBk/Oq3+h/ZYx3
         R5lD8cLTbu59CMjtLP2vzz8cyGzEC1l4Ih6qCVoDbl8UE2NCdZgxxAIuoz60rHCA/hcZ
         XpMA==
X-Gm-Message-State: AHPjjUhmNZfKeXH1J2+rU3QYuWt5JlGI6c2jKsUs2XaAyK6Y59eGwdns
        LAxIT0vQ+1Ek3ctNIkRxehxMc0jlb5Q=
X-Google-Smtp-Source: AOwi7QDBYgvAMrJB8Cn1OD+Ky3sfdlPzllJzIZZVVW3WQA6XB1Eea81j6AD7hXmVTEapLSOWXFisiQ==
X-Received: by 10.99.117.30 with SMTP id q30mr8613350pgc.106.1506360326111;
        Mon, 25 Sep 2017 10:25:26 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:2d6e:b6b:1517:59cb])
        by smtp.gmail.com with ESMTPSA id o17sm11270450pfa.22.2017.09.25.10.25.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 10:25:25 -0700 (PDT)
Date:   Mon, 25 Sep 2017 10:25:24 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/4] Document submodule_to_gitdir
Message-ID: <20170925172524.GC35385@google.com>
References: <20170925155927.32328-1-hanwen@google.com>
 <20170925155927.32328-4-hanwen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925155927.32328-4-hanwen@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/25, Han-Wen Nienhuys wrote:
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  submodule.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/submodule.c b/submodule.c
> index b12600fc7..b66c23f5d 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1997,6 +1997,9 @@ const char *get_superproject_working_tree(void)
>  	return ret;
>  }
>  
> +/* Put the gitdir for a submodule (given relative to the main repository worktree)
> + * into `buf`, or return -1 on error.
> + */

Same nit as in patch [2/4]

>  int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
>  {
>  	const struct submodule *sub;
> -- 
> 2.14.1.821.g8fa685d3b7-goog
> 

-- 
Brandon Williams
