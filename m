Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6DF81F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 13:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfHMN3k (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 09:29:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40912 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfHMN3j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 09:29:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so8673627wrl.7
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/bca5Y5d8F7aINT149cvL95ktwF6RVPJ3RdhXo3fkyo=;
        b=ojE2pDu9yzWtiFpOBM4WrNWvFPExsOnXPOdFF/oYv48SlNgRK/bnxEyrWXhfcKPl9R
         pUG30l1RpPBDuloHccK3AmReEQ6cc6DVirB34b22b1LLZp5J/QKRZ9QUp+AOxf/m0jo/
         I1xZ+7g4F5zjAj0ZRTwLZDIrIs6NREAyXLzw/4fFHI/qr0QQd4Gvp0stVqnmFNCDZkaA
         OETRqd4HYzU/5REJrmJBrCs+a6MzJchqal7oWdHr5Wyn/V/CU2FiMpdq/In1vHCN5oKw
         CWkZVNxEvhEuSXecmvldcLuyaL4NlRuDhbWXRl7cCGmRFIgLdnFTx9STzkvEJ/PjA15L
         mzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/bca5Y5d8F7aINT149cvL95ktwF6RVPJ3RdhXo3fkyo=;
        b=CXQUFX6+t2ZF8HxZn+Gzm3COqGvNDiXwswBog3uBgT+rhre1EXMjzl4/4YRVUKig3S
         2QI8iGEM7sUxnT2XGABaUCwXQZUrfrxMTOPEWFtGNrEFvLaRHMG2bfg7WCIvQpJtBMNv
         P4rdgml44kH25ljWh9xKNxbhiJA1uJxbAUH+okDcD79YMGlN89lR+kqC3kI3xjF/ZPq5
         0EF29a7heTXdD5ALvxAkHJFZr/ecSsksRcy48in1YfkZajGVUbC15jQBF+zyfsRlmt/Z
         IiiFqkmsP1Zk7/LT2CNwKwHd7j9WPmlJbXRF+kdGQSroOekNaV29Vwi5KjSSI8O2QQ8O
         wIvw==
X-Gm-Message-State: APjAAAXpGpnqyeNjTLPYHbGmb/QD5dxIKtxpYjUlaWvbRZ4kS7vYS2ru
        Go4z/LZ0LXtF0LAYxNtT6hJpcIsg
X-Google-Smtp-Source: APXvYqxvWHeei3HTuezbRbBDp/qahL4gxrg16Z9o4YZ8LC+cyqbJgNqGw4J/t+8JdDYHW6bmyjIg9g==
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr10954855wro.215.1565702977671;
        Tue, 13 Aug 2019 06:29:37 -0700 (PDT)
Received: from [192.168.1.18] (host-78-148-43-8.as13285.net. [78.148.43.8])
        by smtp.gmail.com with ESMTPSA id q18sm135450533wrw.36.2019.08.13.06.29.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 06:29:36 -0700 (PDT)
Subject: Re: [GSoC][PATCH v2 4/6] sequencer: rename amend_author to
 author_to_rename
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-5-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ca11527b-0abf-9146-1e6c-d0f095c762a3@gmail.com>
Date:   Tue, 13 Aug 2019 14:29:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812194301.5655-5-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 12/08/2019 20:42, Rohit Ashiwal wrote:
> The purpose of amend_author was to free() the malloc()'d string
> obtained from get_author() while amending a commit. But we can
> also use the variable to free() the author at our convenience.
> Rename it to convey this meaning.

Thanks for rewording this

Best Wishes

Phillip

> 
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>   sequencer.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index fbc0ed0cad..e186136ccc 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1424,7 +1424,7 @@ static int try_to_commit(struct repository *r,
>   	struct commit_extra_header *extra = NULL;
>   	struct strbuf err = STRBUF_INIT;
>   	struct strbuf commit_msg = STRBUF_INIT;
> -	char *amend_author = NULL;
> +	char *author_to_free = NULL;
>   	const char *hook_commit = NULL;
>   	enum commit_msg_cleanup_mode cleanup;
>   	int res = 0;
> @@ -1445,7 +1445,7 @@ static int try_to_commit(struct repository *r,
>   			strbuf_addstr(msg, orig_message);
>   			hook_commit = "HEAD";
>   		}
> -		author = amend_author = get_author(message);
> +		author = author_to_free = get_author(message);
>   		unuse_commit_buffer(current_head, message);
>   		if (!author) {
>   			res = error(_("unable to parse commit author"));
> @@ -1534,7 +1534,7 @@ static int try_to_commit(struct repository *r,
>   	free_commit_extra_headers(extra);
>   	strbuf_release(&err);
>   	strbuf_release(&commit_msg);
> -	free(amend_author);
> +	free(author_to_free);
>   
>   	return res;
>   }
> 
