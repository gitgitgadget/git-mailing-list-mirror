Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89C4820A2A
	for <e@80x24.org>; Thu, 28 Sep 2017 19:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750951AbdI1TeP (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 15:34:15 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33303 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdI1TeP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 15:34:15 -0400
Received: by mail-pg0-f65.google.com with SMTP id u136so2981509pgc.0
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 12:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rnwvLVMlru5HNAIgjD6SenpPJc7cn9CfWho6EKzXnkY=;
        b=ojzKb+MFH07MjfrcdPffole960tFt2xvzGHgfxhEmagiUOiUpmRMaRGldAGpEgF4Y0
         IfDRkwxWOS+J8Hnjv/C11ScCYIDIPUcmUk1Cme9zz6gRW5PSRecJc8LJ7BmaSRNHaijK
         RtY3ALIqHuY8UDfc/nC0Ya4/joRwBC1/tzZWrGCLP8eCEzOUBJR6kvjJ+RsY7qquHGoo
         61ke1ufaJPqmTQrZSccAvYBzD+xuWEf4QxLt047l9zKB5OWXYCV2y3tnGCus+hoKJkG3
         Tvu48WGoh/Kz3JNttYotL414+vTPdsnR2yUgqtvnSv7WweMqqDRqYe1HN/UliSkXgTlD
         pF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rnwvLVMlru5HNAIgjD6SenpPJc7cn9CfWho6EKzXnkY=;
        b=JP/8t6u0DG/JlB3ONsjRlq5LcovY589wPYF1ib9zhl3je0qGwE1YEpe4jWfYYKMnnX
         GiVEuXwVwTF5Lf6OwDYa5qGsQkqCK3VlXaOaB3h5R2o/QkeGZIGkje1JqZ2Y9K7FOUP2
         9oy4zEuV+IP4h5PqnedNsZ+lASYyiiZiixB8B8gDDO2AAyg9cqFAG5tbYL1+UZCiP2uc
         VCqxhn935KxT0lqDtUUYbnTvpiTTxpawsu3GvKWxMN8dLUKHEpPeeDxZ3nNzUl3P6Qk4
         DhO7bkC0m1WY6VVJs/zOyoNWDez6KNK9xHR8gIabXc+gg+53ZPHd24I1S1QAJS0Vze+C
         dsSA==
X-Gm-Message-State: AHPjjUiIMBuLw240yJEbs0hed2d0iQt65ulm1SstkXGGFNhOT5mcWDxt
        rNUuB2hc3Nx8+VbKtqk70xk=
X-Google-Smtp-Source: AOwi7QBqm44Es5qAJyM0+UDlvjzP8FBXcleLVnhQJI1WJjLj167832uACfWQnWC/jYeMkj2X9vNmLw==
X-Received: by 10.99.164.81 with SMTP id c17mr5222050pgp.445.1506627254487;
        Thu, 28 Sep 2017 12:34:14 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:ddb6:7bcc:de8:4755])
        by smtp.gmail.com with ESMTPSA id h82sm4895456pfd.148.2017.09.28.12.34.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Sep 2017 12:34:14 -0700 (PDT)
Date:   Thu, 28 Sep 2017 12:34:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
Subject: Re: [PATCH] doc: correct command formatting
Message-ID: <20170928193412.GB174074@aiede.mtv.corp.google.com>
References: <20170928140648.GC9439@dinwoodie.org>
 <70decbc2-093c-9f9a-3661-ee6500cec641@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70decbc2-093c-9f9a-3661-ee6500cec641@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Andreas Heiduk wrote:

> +1, Thanks for spotting.

Thanks for looking it over.  Can we add your Reviewed-by?  (See [1]
for what this means.)

> I did a quick
>
> 	grep -r " ` "
>
> which came up with with another relevant place:
>
> Documentation/git-format-patch.txt:	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
>
> But here the space IS relevant but asciidoc does not pick up
> the formatting. Perhaps that one could read like this:
>
> 	`--subject-prefix` option) has `<SPACE>v<n>` appended to it.  E.g.

Interesting.  This comes from

  commit 4aad08e061df699b49e24c4d34698d734473fb66
  Author: Junio C Hamano <gitster@pobox.com>
  Date:   Wed Jan 2 14:16:07 2013 -0800

      format-patch: document and test --reroll-count

In some output formats, the text with backticks surrounding it is
shown in a different background color, which makes something like
`{space}v<n>` tempting (with appropriate definition of {space} in
the attributes section of asciidoc.conf).  But that feels way too
subtle.

How about something like

	has a space and `v<n>` appended to it

?

Thanks,
Jonathan

[1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/9cd6681cb1169e815c41af0265165dd1b872f228/Documentation/process/submitting-patches.rst#563
