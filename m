Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B258420281
	for <e@80x24.org>; Mon,  2 Oct 2017 17:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbdJBRVk (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 13:21:40 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:52581 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbdJBRVi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 13:21:38 -0400
Received: by mail-pg0-f52.google.com with SMTP id i195so3299534pgd.9
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M2ZdOM/4xXL6Gz6BHftSFWL544YOjJfamrLsoEkGf6I=;
        b=mQhiPYmGTcGleDZNNlqApJhN0REZhUpMBvlwZQr6jwA5N+ulRrE8lxy34H8e/8pyf4
         Qbe4HhTmNv2PRA1sri4c1gCMw2f5yO+4HCEMt1BnSeS1foNZ4yvXqOqOVk2v68y22W6Y
         NMTCsGR0G6Lg0Pwkluw+gKu7YCQHYT98UQLVqrAu+UpPjG/2nIzg23ShysIsvIZwKXWv
         CIXgT8kEF+MPw3vrx0mfcX8ls9kWa30tgo6d3oVBpHAsRyioOXvLta5eh1VrwMWCePev
         LZjk2BCXz6YtZttpCztaCZbO7T9jWvVN99VOrCwx7vLYUp+buERM84KoNfCyu6rOwMc2
         J3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M2ZdOM/4xXL6Gz6BHftSFWL544YOjJfamrLsoEkGf6I=;
        b=N62xtFpBtRD0HJkOF/mqVnWAKQDZrqnBxscBFqMEcw6Hcf+44LpSXpfyJJg9Ihi7Wr
         KQXBb64y0N+tzszvcz8nJTOhu35nCn+H7ckhwHJxPFw7WquwsTGDlStM5Jrm4P72ZMdW
         YxiInmpbC+1bjrH8fHQayyRtsIVhJy6yziHClVlrXzOBT9BynNJMBKVpuL8ExuTfQkEV
         iHcPhlGkiVLLbgQ+NTxrDFq4YZr9l0mvrh2yv9RiR6YvxYcJPXkxWTUslCYkIorgEaTf
         D6IA0jOt8rdUuOlle6KRWUlUmtoNH+lx8q3fUwL/Edk9j1DngOBwpNFZUJOBzeIZGS0q
         W7ww==
X-Gm-Message-State: AHPjjUh8h7LTWerrUpXUcH0aqH2CJMLgE3EMr7FcXzU/TnxV0K80OJf4
        ZGk/wbPewQ620ddVgqQI2T1wNQ==
X-Google-Smtp-Source: AOwi7QBhoKy3EXVrZv9NyU7MmKn1TV8jaB2YEP+b6jFJngDMwlUO9n+lc2fE48/rAKaYKmbHw06isA==
X-Received: by 10.98.208.129 with SMTP id p123mr14918440pfg.273.1506964897734;
        Mon, 02 Oct 2017 10:21:37 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:dd1e:eb8d:bfc3:ce25])
        by smtp.gmail.com with ESMTPSA id q67sm20988904pfg.160.2017.10.02.10.21.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 Oct 2017 10:21:36 -0700 (PDT)
Date:   Mon, 2 Oct 2017 10:21:35 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] clang-format: add a comment about the meaning/status
 of the
Message-ID: <20171002172135.GB5189@google.com>
References: <20170929224505.GN19555@aiede.mtv.corp.google.com>
 <20171001154425.5568-1-s-beyer@gmx.net>
 <xmqqpoa6tp79.fsf_-_@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpoa6tp79.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/02, Junio C Hamano wrote:
> From: Stephan Beyer <s-beyer@gmx.net>
> 
> Having a .clang-format file in a project can be understood in a way that
> code has to be in the style defined by the .clang-format file, i.e., you
> just have to run clang-format over all code and you are set.
> 
> This unfortunately is not yet the case in the Git project, as the
> format file is still work in progress.  Explain it with a comment in
> the beginning of the file.
> 
> Additionally, the working clang-format version is mentioned because the
> config directives change from time to time (in a compatibility-breaking way).
> 
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * So here is a counter-proposal in a patch form.  I agree that my
>    earlier suggestion was unnecessarily verbose; this one spends
>    just as many lines and not more than the v2 round of Stephan's
>    patch.
> 
>  .clang-format | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/.clang-format b/.clang-format
> index 56822c116b..7670eec8df 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -1,4 +1,8 @@
> -# Defaults
> +# This file is an example configuration for clang-format 5.0.
> +#
> +# Note that this style definition should only be understood as a hint
> +# for writing new code. The rules are still work-in-progress and does
> +# not yet exactly match the style we have in the existing code.

Thanks for writing up this header comment to the .clang-format file,
it's something I definitely should have included when I introduced it.

And I like the wording that you've both settled on, as it reflects our
intentions (of having the code eventually conform to the format rules)
and making note that this set of rules still needs to be tuned.


Thanks!

>  
>  # Use tabs whenever we need to fill whitespace that spans at least from one tab
>  # stop to the next one.
> -- 
> 2.14.2-820-gefeff4fbff
> 

-- 
Brandon Williams
