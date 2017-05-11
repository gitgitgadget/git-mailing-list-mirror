Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47AF7201A0
	for <e@80x24.org>; Thu, 11 May 2017 21:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755966AbdEKVla (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 17:41:30 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36353 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755474AbdEKVl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 17:41:29 -0400
Received: by mail-pg0-f65.google.com with SMTP id h64so277829pge.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 14:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3ps39CDLZgNwRCPFfOSarMtNirzH+BDaGQc0KQ7UZVU=;
        b=tb1kwBjwc31zGC007qX6kN8Z2feYbIifsLA8tM4/I2BXAmYx1JpMcBXxEQxqwK9JQd
         i+Zgs9AjokLxmtX8yXw6PgNjHWAtNMxDaOciRBSGnlIMlCNuQ4G5ZP9SutYIos2ga9+w
         CA+i10jTYO8dRLWcxFBDygroHhBphRSeSugkpImjB8NBNpxIVmSk/b32blZh5YHaVChQ
         Doe1t8wWzZYPynSYMRDMtgGDUFJy91zPRs6y9F2t/t0MndRERSSxTk1GVCvcl6EMBp8h
         PEyEmLVC/ZWOKLeMLMbUOrlrKDXMjXimdZK1I3qNuclmgUncwOdHoAN4OKjSYT0JZ8++
         eWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3ps39CDLZgNwRCPFfOSarMtNirzH+BDaGQc0KQ7UZVU=;
        b=Q+3VaoswQNCsLhJzRBLlYmQ8PNAitD5nTBgfZul/bkfNObgTu2iuo54bnsJmc0WO6Q
         /b89S8oit3yigyIbzwKE/ENEa3OzIUOapuxk9cZ0/fd5f18gj3mpRd+IyACr2FjJT4aG
         MBZt4u54xJa+A48bh+PY55iCt4SK7vZv+h2f5QaELz3v6hwlJ2I8RjTzY2mBvFdFzKeb
         Y/HyirFnYMSzmpAuwjMJCjzOLWKUtKwGCA4RMqh4sWGU9d4SqVUIfjFVPGMkx5IL8bG/
         sOJ0Qhb8bcxhI715zjkVutAI8Uu1OS6JxHe2f4XpjzH+vJly8P6044m6GUXHiHmpEXCd
         6AvA==
X-Gm-Message-State: AODbwcBHVuo+Y5pKu4Ri/NrxgRcE3PgmXd2c8tEJTERpysT4V6vKB/WY
        4XD+LAsoehnCtQ==
X-Received: by 10.84.137.169 with SMTP id 38mr825604pln.134.1494538888632;
        Thu, 11 May 2017 14:41:28 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:ac23:a158:2bd3:569b])
        by smtp.gmail.com with ESMTPSA id s83sm1684364pfa.128.2017.05.11.14.41.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 14:41:28 -0700 (PDT)
Date:   Thu, 11 May 2017 14:41:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] C style: use standard style for "TRANSLATORS" comments
Message-ID: <20170511214125.GB21723@aiede.svl.corp.google.com>
References: <20170511204334.GM83655@google.com>
 <20170511212012.6782-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170511212012.6782-1-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> Change all the "TRANSLATORS: [...]" comments in the C code to use the
> regular Git coding style, and amend the style guide so that the
> example there uses that style.

Hooray!

[...]
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -256,12 +256,12 @@ For C programs:
>  
>     Note however that a comment that explains a translatable string to

The "Note however" isn't needed since it's not contradicting
the previous point any more.  This can be an entirely separate item:

 - A comment that explains a translatable string to translators
   uses a convention of starting with a magic token "TRANSLATORS: "
   [etc]

It might even make sense to remove the explanation of TRANSLATORS
comments from this file altogether, since they're intuitive to use.
A more common place to want to learn about them is po/README, which
already explains them.

[...]
> --- a/bisect.c
> +++ b/bisect.c
> @@ -995,8 +995,10 @@ int bisect_next_all(const char *prefix, int no_checkout)
>  
>  	steps_msg = xstrfmt(Q_("(roughly %d step)", "(roughly %d steps)",
>  		  steps), steps);
> -	/* TRANSLATORS: the last %s will be replaced with
> -	   "(roughly %d steps)" translation */
> +	/*
> +	 * TRANSLATORS: the last %s will be replaced with "(roughly %d
> +	 * steps)" translation.
> +	 */

Nice.

[...]
> +++ b/ref-filter.c
> @@ -1251,13 +1251,17 @@ char *get_head_description(void)
>  			    state.branch);
>  	else if (state.detached_from) {
>  		if (state.detached_at)
> -			/* TRANSLATORS: make sure this matches
> -			   "HEAD detached at " in wt-status.c */
> +			/*
> +			 * TRANSLATORS: make sure this matches "HEAD
> +			 * detached at " in wt-status.c
> +			 */

optional: could treat "HEAD detached at " as an unbreakable phrase
for the sake of line-breaking, for easier grepping.

But what's here is also perfectly fine.

[...]
> -			/* TRANSLATORS: make sure this matches
> -			   "HEAD detached from " in wt-status.c */
> +			/*
> +			 * TRANSLATORS: make sure this matches "HEAD
> +			 * detached from " in wt-status.c
> +			 */

Likewise.

The rest also look good. This is great.

Thanks,
Jonathan
