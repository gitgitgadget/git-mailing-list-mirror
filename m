Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 636081F731
	for <e@80x24.org>; Thu,  8 Aug 2019 11:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfHHLaS (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 07:30:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36823 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbfHHLaS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 07:30:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so2061762wme.1
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 04:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pj9Sgtz4edH6RBNreO2tNCegHTi97a8dydfRzukVnn0=;
        b=BFIhv3RoiKTeDDcSeKjSDbjKysWp24mAcbqFsABMQB+i306WSQpxXrVBv9R5PWemHP
         5WTiXJ5FSrYwLMxjSWRk5C+3f0hI9bcegCZ4xMAn6uF6ZWcHXaSEZvGbPw4GK0h25FmK
         +gDIyEjnI+W47RouQtEZ+RlkGFkypnNufh1GCifnjFT5yqczMl6F3k2F+COp6nllsodt
         R4Ff96G5hgLXo5T7Q6CTdq8B+dmLJUtemmD4toEvkCKnNE1jgukKG7hcsBwzX+g5SCug
         sCrE8/9QHe9HYgS/UFuC1ewBs9Iti/ESiOXXpPHxZdjGt5kZR6GC4+5OR2bhWF7M+lfN
         sFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pj9Sgtz4edH6RBNreO2tNCegHTi97a8dydfRzukVnn0=;
        b=ocsE2ixd5bk8NrxzlljlrMm8okWyuRxbkC0uJOmnjLCV1mwHe3q6AxT/lQz4Px8qAb
         gORaA3YBLvRNG9FjsZaUkWM5oszZJ9I+u0GYg9UNetLw+RoCdAW7KBPkEuWQCmFESGLj
         bSo+Yh069OQSth7BpWcMOBR01qtiWCZ4BhQP+P3fLpvsyamhdZ9E8FbOZST4QKs02cnE
         ntvJGv84YkGjH8ErdP+uWUCfd5YYNG1ynazo0RoykBJQA2dzXzR5cj3oDC8EDb9UVtQH
         d4mov9+h4OYs4LodORz9xFuRKMzVDeJgYokZJzs3dSxlq6piT2EwdcjHShr+kfwYNRX9
         KUzw==
X-Gm-Message-State: APjAAAV/KRzeeeFVzN3in7R2sWyOizzkP2XiSHSC8YzCDmw9CoSgb8Nx
        qzf95nMxe/NFRNuA0+/ZmAsmseNQ
X-Google-Smtp-Source: APXvYqzc1AEEC5LsBecTJ6VU3K0kP2xsOEk3FyU8eg37kVtMkgy6szaApe3u8km44deO1nNTqwJrwA==
X-Received: by 2002:a1c:6c01:: with SMTP id h1mr3882140wmc.30.1565263816155;
        Thu, 08 Aug 2019 04:30:16 -0700 (PDT)
Received: from [192.168.1.18] (host-78-148-43-8.as13285.net. [78.148.43.8])
        by smtp.gmail.com with ESMTPSA id s3sm2354836wmh.27.2019.08.08.04.30.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 04:30:15 -0700 (PDT)
Subject: Re: [GSoC][PATCHl 4/6] sequencer: rename amend_author to
 author_to_rename
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Junio <gitster@pobox.com>, GIT Mailing List <git@vger.kernel.org>
Cc:     Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Dscho <Johannes.Schindelin@gmx.de>,
        Martin <martin.agren@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190806173638.17510-5-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <58e6840a-224a-8276-a376-a0f52a45e4d5@gmail.com>
Date:   Thu, 8 Aug 2019 12:30:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806173638.17510-5-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 06/08/2019 18:36, Rohit Ashiwal wrote:
> The purpose of amend_author was to free() the malloc()'d string
> obtained from get_author(). But the name does not actually convey
> this purpose. Rename it to something meaningful.

The name was intended to covey that it was only used when amending a 
commit, I'm fine with the rename though.

Best Wishes

Phillip

> 
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>   sequencer.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 65adf79222..d24a6fd585 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1417,7 +1417,7 @@ static int try_to_commit(struct repository *r,
>   	struct commit_extra_header *extra = NULL;
>   	struct strbuf err = STRBUF_INIT;
>   	struct strbuf commit_msg = STRBUF_INIT;
> -	char *amend_author = NULL;
> +	char *author_to_free = NULL;
>   	const char *hook_commit = NULL;
>   	enum commit_msg_cleanup_mode cleanup;
>   	int res = 0;
> @@ -1441,7 +1441,7 @@ static int try_to_commit(struct repository *r,
>   			strbuf_addstr(msg, orig_message);
>   			hook_commit = "HEAD";
>   		}
> -		author = amend_author = get_author(message);
> +		author = author_to_free = get_author(message);
>   		unuse_commit_buffer(current_head, message);
>   		if (!author) {
>   			res = error(_("unable to parse commit author"));
> @@ -1526,7 +1526,7 @@ static int try_to_commit(struct repository *r,
>   	free_commit_extra_headers(extra);
>   	strbuf_release(&err);
>   	strbuf_release(&commit_msg);
> -	free(amend_author);
> +	free(author_to_free);
>   
>   	return res;
>   }
> 
