Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B08D01FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 16:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbcF2QPM (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 12:15:12 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33282 "EHLO
	mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbcF2QPK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 12:15:10 -0400
Received: by mail-qk0-f195.google.com with SMTP id n132so10781916qka.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 09:14:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EPXvRHsK62c6NZa66Z4U2JvEl4DmcsGEoIo7z0Ujuy0=;
        b=q7rQNFgYn2IX7qSY2Rdgz/A3gjxFMIO7BlfWzVGrzKd7UdhM5xEy/F74CrtNljw+yn
         i5jlFsYiKla0NkoPcB7zczjJrTavGfyElB0C3eM0hS+RFTEWfRNjVqiLGRDfGYoU05/x
         h0WPJ9SxUauHJRJhzSULq4JnnNDyuGvQIishOChTctg/gB6GBBkYBRbdhvD9GbUNPJ8A
         MkzGGYUl7wuZUhf6cG4qTk0aTdZmEK0caOqtJdS/J+hKcoHQQMd6k2qzY6GP3ACEju3w
         W0tBnY02/nylDBdh4FygLh770D9y3z8UQYDipYqZTQ58B2YQXpjcwLv8DVOXbYMOMSyS
         00tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EPXvRHsK62c6NZa66Z4U2JvEl4DmcsGEoIo7z0Ujuy0=;
        b=GxGwgWlAXzF+fvoq62wtoJGe6sOimqYS9wJghXWrGJglhv4ZXPDVaX9K8amepQaY3T
         9gNYOXfKTUwa8otSXntasjzFEUrk3RDgq1cko6NvlR2DSJr5ZA8dXqEiEbtKgTJKqC61
         rw+zcIcsOWYgGD+pYyZkcir4JZyiJlzTG1JZMgPD3tYHZG+pIiFTpuwOzSFFsJo/U89S
         a9LTwqk0qmDbJIybt/GrreGblYIr/tMoZOVjZGgWoZDmMQ+v+KHHCcg0sut1W/Qxc7Hp
         tUTxIgmVFc8/EHATgV3Rx7GkaTqj8gE3p++pj5FOcqYJSpjFflRpuU2x2xZ10GsP/U5h
         CA6A==
X-Gm-Message-State: ALyK8tKywX/D9sBjh4TXBeiFqioLkLwDPPudepNGk6AOK4u1TeZ6hC+ii95UWF/UMChYp81gxFc2gyQbwnD42g==
X-Received: by 10.37.198.133 with SMTP id k127mr3499132ybf.53.1467213066219;
 Wed, 29 Jun 2016 08:11:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.116.4 with HTTP; Wed, 29 Jun 2016 08:11:05 -0700 (PDT)
In-Reply-To: <2ad336745e1b2a610b20b7cfba169bd3e042c178.1467210629.git.johannes.schindelin@gmx.de>
References: <cover.1467210629.git.johannes.schindelin@gmx.de> <2ad336745e1b2a610b20b7cfba169bd3e042c178.1467210629.git.johannes.schindelin@gmx.de>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Wed, 29 Jun 2016 20:41:05 +0530
Message-ID: <CAFZEwPMw-Coq3vV+8o6MCDYCg9qN3aFBjHy9652mh_AFAPsJQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] t3404: fix another typo
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Johannes,

Very minor nits.

On Wed, Jun 29, 2016 at 8:01 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The past tense of "to run" is "run", not "ran".

Past tense of "to run" is "ran" while past participle is "to run".

Past tense: He ran.
Past Participle: He has to run.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t3404-rebase-interactive.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 66348f1..c7ea8ba 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -60,7 +60,7 @@ test_expect_success 'setup' '
>         test_commit P fileP
>  '
>
> -# "exec" commands are ran with the user shell by default, but this may

This sentence seems to be in present tense if I am not wrong (though I
am not a native English speaker).

> +# "exec" commands are run with the user shell by default, but this may
>  # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
>  # to create a file. Unsetting SHELL avoids such non-portable behavior
>  # in tests. It must be exported for it to take effect where needed.

The change introduces fixed the grammo properly but the commit message
probably reports it incorrectly.

Would it be better if the commit message is without changing anything else:
     The present tense of "to run" is "run", not "ran".

Regards,
Pranit Bauva
