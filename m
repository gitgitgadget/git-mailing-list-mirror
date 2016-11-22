Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A6F01F4CF
	for <e@80x24.org>; Tue, 22 Nov 2016 00:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754072AbcKVALw (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 19:11:52 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35057 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753763AbcKVALv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 19:11:51 -0500
Received: by mail-pg0-f46.google.com with SMTP id p66so772967pga.2
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 16:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MlJHwNr5bIF9fxy/OspFvHxz9ycTkwy9qf08NRz1iJ0=;
        b=p0qo9/7pkAnX2ZAcwF+Hye29vOSfkW7T/QTn9E+uD8F5Jk+RtSRjnQMyT+YoHuG0tF
         PwdcZGejVVQNONVaj8rCERH2IBUF0EymyE1UMvxa5rsecr8+cMASfjpgO+a2yeU1YgCC
         xzmwX5CeekG1e0ZzqLgb6P9FkRDZ04DHvnG9w/80MVBSK/G881D8r8BOvpw3G2paQ8Dw
         Q2vSKfxUu/j7JSW0t3/9Rbma0gmDRH4KDEtMKXVTN4c9SafhXyfzoD+aIBGNtnXV5Hls
         htn6PhigJUH5iVFnutgZ/lTbhDc73oqqXf75CI0nhlqnQ4kaVb0I9FfSCME79Q/z9HYz
         QtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MlJHwNr5bIF9fxy/OspFvHxz9ycTkwy9qf08NRz1iJ0=;
        b=bzf5Qr0ybeaUrDuJih4T9G5Qvu9I2sDTOqyZM3Y6uiKuLit/RNaYHkKqLvCigGCrK2
         q8+aPQ5Mn9PzHJE5bZSpoAGuKV56TuPvG77cKzSslO3peZASbILODZRJclGYOsuOu9bY
         9ZjQWt1AojbaJS5RtH3Zl3+qNF+DepwSiCQNoguac+hhevMZpSnsB+eE7Byh0ZjlW6Mu
         0AJGhdBiRFW8NyxruRIovd78SqPkGrcM2fLT9jF44auDr3S1i+vhaH2eDgctVKyGyOKB
         sRJ80p/+DmUV1IBDWFNp+aQ6+ReOxLsY22mbvoUyVaM9pgCeXPcGw3DZ+VsM/DD3Dh/j
         t8Ag==
X-Gm-Message-State: AKaTC02IURZ0oUpy5wG8cfliOw7DUIesYlD3b6CZYc972dQNopuswznreSwZbiI6467ggGii
X-Received: by 10.99.149.22 with SMTP id p22mr38041393pgd.21.1479773510662;
        Mon, 21 Nov 2016 16:11:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:9837:5b20:fc2:14ed])
        by smtp.gmail.com with ESMTPSA id y66sm22025739pgb.21.2016.11.21.16.11.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 16:11:49 -0800 (PST)
Date:   Mon, 21 Nov 2016 16:11:48 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jacob.keller@gmail.com
Subject: Re: [PATCHv2 2/3] submodule-config: rename commit_sha1 to
 commit_or_tree
Message-ID: <20161122001148.GD149321@google.com>
References: <20161121232709.8906-1-sbeller@google.com>
 <20161121232709.8906-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161121232709.8906-3-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21, Stefan Beller wrote:
>  
>  	switch (lookup_type) {
> @@ -448,7 +448,8 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>  
>  	/* fill the submodule config into the cache */
>  	parameter.cache = cache;
> -	parameter.commit_sha1 = commit_sha1;
> +	// todo: get the actual tree here:

s/todo/TODO

Makes it more clear that this is a TODO


-- 
Brandon Williams
