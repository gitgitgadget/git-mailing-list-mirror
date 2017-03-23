Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FF4620958
	for <e@80x24.org>; Thu, 23 Mar 2017 22:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934357AbdCWWMy (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 18:12:54 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34232 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934280AbdCWWMv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 18:12:51 -0400
Received: by mail-io0-f195.google.com with SMTP id n76so1033572ioe.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 15:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=euMIhqU8/7ynu+VsKD022SgQco5lCt/uPDmf7qaT25o=;
        b=Qfqg3V2nfyHmyyu0oQDgdVNuszFLlgfy2cQ3x2o9ys0vV5jRxcib12QJl5wdSAWe38
         rRk9OP53rl/nyAycqeF07y1IAEO0EgPEc+ww0SKYLQq1bFszTZ/kzOrdZ3Zp1moDaO1m
         NCM9riNo1Q5pqI8z2jaXUjTAtOkfzxROjLJumVfm4GIJn0ojJg+WTs/ix/SEVyIIpNP9
         LzxiU9Om/sczKFAY4BDmF1iJa7/OpMS2BnNm3XoPyb35iEQ4xoBfSwJ9aF9RpacCfuju
         5kq2tfLswH1vQIMp130pJ4unU6NjYMAkCAdmyngd7ypFkZxvAUpeN6R+vRaXOD9lYqM/
         42Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=euMIhqU8/7ynu+VsKD022SgQco5lCt/uPDmf7qaT25o=;
        b=jANGv7nA76ZuaTuKPwhm5eOrinRHlECnHjLRRL8/4haiHhEbYTrIK7fL6xNR58B4oP
         4NlGdxcAI2pTG+XXz2+PUcsE20T3wWcVB09kNLpT3m8u2hupGC2Nbb4QH0kfgeqV1PWW
         YsLWo8tnPanB2cFSCN66VyPvQSlMgg8ZqqZGw5gm3n0SR+l5MsnHnC/alqJfgsTq0r5A
         U3MbTW2rXHAAGKVO1A+lSV9Ib6hhe+r6SGCNwWBxzfMB0k1cmjMCcl4fr5xwaRvbyzV5
         aBMlqLYHDbm9ANO7CPwyb9Xi6mtS2bLzdFJXddBCpxHkwv2oxPt1vtI+rBfaNmdMDM+l
         tuxw==
X-Gm-Message-State: AFeK/H1E94GVh/u4cIYOqLRsfepORzMO/zf5mhK3yfzqFNuWPzxhFm8wByLK4vaCkCQKJw==
X-Received: by 10.107.180.70 with SMTP id d67mr5688118iof.21.1490307170170;
        Thu, 23 Mar 2017 15:12:50 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:6c40:39b9:f9ab:ec6f])
        by smtp.gmail.com with ESMTPSA id 86sm216866iom.58.2017.03.23.15.12.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 15:12:49 -0700 (PDT)
Date:   Thu, 23 Mar 2017 15:12:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: [PATCH] sequencer: fix missing newline
Message-ID: <20170323221217.GA20794@aiede.mtv.corp.google.com>
References: <20170323170233.50499-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323170233.50499-1-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> When using rebase --interactive where one of the lines is marked as
> 'edit' this is the resulting output:
>
>     Stopped at ec3b9c4...  stuffYou can amend the commit now, with
[...]
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for fixing it.  I don't see any other fprintf in the file with
missing \r or \n at the end, so this fix looks complete.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
