Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4946208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 16:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeHHS7l (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:59:41 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38283 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHS7l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 14:59:41 -0400
Received: by mail-ua0-f193.google.com with SMTP id o11-v6so3079333uak.5
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8pQekOUaxm1v79t23LGpg9buMIllPOKvI0tl/kPZgSc=;
        b=LxoG2THCxQfeb8RixjevI2nGnFHZ+hCAlbAsIHkXDU7dgA5gcpaLyWu75Ish0kS95h
         uU7cM+c5dbfPpUFXvjmgwKNU6x5JdXdF5lqhgtoay6fJkw9r/PIts1GlhaIwso8GCxsb
         /91nAcaDhv2uDMg8i01/OBfedHTulNQbzXD01c4P92qQ8d7jZ4M5VTI8gfjp4mlniCst
         UB0si4wq0EBl+CrJhfnX6oOKvAsnl47YAAxdPEq4aIuOHMOoh1cTMOPwj0XJL7rQU7UK
         9ydfv/EP15KgB1TtUVungVnaF7BPrjQcT/cxno8luSdstzFT9UMcLnLu7woWSKPk0R9s
         cvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8pQekOUaxm1v79t23LGpg9buMIllPOKvI0tl/kPZgSc=;
        b=Qqg9+TcWJt4HL4dhOBZmg8Xt7iGkXWHedqHxH/6XY59dcyEq9MbpvoBtJF8RFf+V97
         GZBdjU1mpjHj5FRLVNToUcOAow3IHh9V/AosNCgtE82DqYF7LKdJeFCkYxnYmm3IoTow
         hr/9HYJQOV54BoSPLcIuuzRKXHIHEsgHzBGrU4otKlCq715p7JLz4tmVtKNnDhl8+aGV
         OEt7vCtkB7PqFEbk5F060pVpsrhKCxIpOJR7MPsFA6b/HqQuCJ0sxGos2tALQJR/KjUT
         mZfTQJde7vKCv0Un2UQWXtU3XqbUGPKgerjjR5tR96obG+KYNvpzY0IvULmNb+mC5qnY
         JJ5w==
X-Gm-Message-State: AOUpUlGDk1IijbJ1yMnE1Vlx87ffVTBVojB2CHH543Zw8zkEzCw2lvlB
        ExzsYc7QoVzJNMyUF+2jyLBWidMx/GYKFEsD5D9lew==
X-Google-Smtp-Source: AA+uWPy1+JxqyfehuD1r/7yxxPocJkLu88Tl6GUXiodk3ShVwrEgg5vNPYPtwysalDMcnCQIfCZ70zbmL/60PLjlhQc=
X-Received: by 2002:ab0:4eef:: with SMTP id x47-v6mr2504838uah.23.1533746352046;
 Wed, 08 Aug 2018 09:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.16.git.gitgitgadget@gmail.com> <d9fa5b855ba2805d5afced4795c7d6e87f7e41b7.1533728995.git.gitgitgadget@gmail.com>
In-Reply-To: <d9fa5b855ba2805d5afced4795c7d6e87f7e41b7.1533728995.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Aug 2018 09:39:00 -0700
Message-ID: <CABPp-BGnGeJ-9y5gM-_E90hUJPQvJTngy4DhPZ=6ZaCb+RMtpg@mail.gmail.com>
Subject: Re: [PATCH 2/2] remote-curl: remove spurious period
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 8, 2018 at 4:52 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> We should not interrupt. sentences in the middle.

I love this. commit message.  :-)

...
>                 /* The client backend isn't giving us compressed data so
> -                * we can try to deflate it ourselves, this may save on.
> +                * we can try to deflate it ourselves, this may save on
>                  * the transfer time.
