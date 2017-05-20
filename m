Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D5732027B
	for <e@80x24.org>; Sat, 20 May 2017 11:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbdETL2d (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 07:28:33 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34947 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdETL2c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 07:28:32 -0400
Received: by mail-pg0-f65.google.com with SMTP id i63so12420232pgd.2
        for <git@vger.kernel.org>; Sat, 20 May 2017 04:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=38SbURHVG30t4KyIWvWSDu/EEA7VpX0niM1LbjOss+Q=;
        b=Gh6kPVFxQV/NpuBTidte5nngjrtxnCsLEYQx85Zv90x25BKq02mRe7gJwIbWGbivgR
         cLkUX70bUo+t0UMqfk9bS4Om7JEDcxZhogBfqjsaH3adDImr4X7c8WY1s0aaVMW2r39m
         4ZEHw0rx16HzB9cX2zSc/mANaPgRCgL5cN+GGmPVqHRNZHNvQOkK504o9VAI9J8nefIX
         Tr/kdvkgv4mx75YYZ/LjfPxybA63SjVep9o13sIwC1sxoMnommH7RDtsLCwxaSFUbIWM
         QEfkD5q/vvMTHwd1c0IOZMrJorLGLwrJ4jC2xwJKcHQkLpbwR5xGEePfXswg6BnCa0Zz
         QfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=38SbURHVG30t4KyIWvWSDu/EEA7VpX0niM1LbjOss+Q=;
        b=WyJbgBVnEruZF7amBeXCRT45fPtxcBuTibK8Y5CiTVX44peWnho2sZwi4ORUBOJhoX
         E+1k7cYIkjia3jEriaT2eQ550nmKkJFxvnLa2TZVWTfDmE+2cfjEriJSGnH9iywgJdK6
         /hnArPpIDHW3KfAUDIrEHFxntGuldN779FY/E8egcdYJX3/PGMuf3a9Awo+BKaYeC3JG
         kq60h9N3I9WljbaofqXnnBIgfRR0UtAKieHHtZPxFo2GjmzwsVYG1jU1Hnzq45sIwG/L
         J7oa5VxXCEUkkYl8uR12jtyhl0FkUlblF2p7+DAc9JSwX6t92266bNYmN/5xLtYchjKQ
         bkbA==
X-Gm-Message-State: AODbwcC2YEbsdllyG+/9BMANrOmnZaedDjXpOBNfXHoX4Ges/dT4oRet
        /VEJziPDAs/z058492I=
X-Received: by 10.99.97.6 with SMTP id v6mr15220270pgb.186.1495279711796;
        Sat, 20 May 2017 04:28:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4027:806a:d2b9:807c])
        by smtp.gmail.com with ESMTPSA id 3sm21863202pfp.11.2017.05.20.04.28.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 20 May 2017 04:28:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: Re: [PATCH v2 5/6] fsmonitor: add documentation for the fsmonitor extension.
References: <20170518201333.13088-1-benpeart@microsoft.com>
        <20170518201333.13088-6-benpeart@microsoft.com>
Date:   Sat, 20 May 2017 20:28:30 +0900
In-Reply-To: <20170518201333.13088-6-benpeart@microsoft.com> (Ben Peart's
        message of "Thu, 18 May 2017 16:13:32 -0400")
Message-ID: <xmqqlgprsr6p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 706091a569..f7b4b4a844 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -448,6 +448,29 @@ The commits are guaranteed to be listed in the order that they were
>  processed by rebase.
>  
>  
> +[[query-fsmonitor]]
> +query-fsmonitor
> +~~~~~~~~~~~~

This underline is short by 3 '~' for the string it underlines.
