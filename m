Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69AD620248
	for <e@80x24.org>; Thu,  7 Mar 2019 00:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfCGAYg (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 19:24:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38536 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfCGAYf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 19:24:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id a188so7535287wmf.3
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 16:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QAHa7lxNev21Wm5s5FQSfW2eojoQYHOeFaCHa/VZMls=;
        b=HTisE2F6j6xB8AsXgOMAQw0ukUjFwH8Y/ZzsQe6ykzewm5wyh089P059bgaD7tVntp
         NR8yQwX+BgDXJVFjCbASc7MtT9iOvcFJMmI9eIumpjxf8lwzEeODsfFBMmTEdsg+htgn
         WJyBIdhJTXkr+WCIlnTUNgZLF1+3mLgjk0v7zlKdo4EPj7FOmO9luK5A7E9RTtS56VRt
         A2sSGezRzSB1GG2tviCn26Y1d7+eKvBJtXFZpyrluQ0a/Z9S6JekW588BGTWuXKAAGM3
         lqUXjR6ZjL4rFMkayQatPyFmyEmUFX+XxqXdpvMIG7dBtzMYs7yv06nbXByEAdBsHtl2
         IaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QAHa7lxNev21Wm5s5FQSfW2eojoQYHOeFaCHa/VZMls=;
        b=RBbIhXBC+52/h4AiptCOHJJMFDcWYZpeZ1tjz1zYcaU+F+VYpW/H0YyUlGfgScO+g/
         7duBzzYJdL3aIqufeePV02eKLApoaNcB7gMjP7QvI8dr31EOBM/Tdj2bPMnMNFlpmKda
         0W0hXCc5/MbW87/JCxSAK4MEsJUWVbvRQVF2AFvJBtxNLaqBNOVEeX5mSsKtPsep4JMR
         Fern5poeiqCLRuW3k/fctmG7iWilGrWYyQZfA5LztvxD/TbSMS5eBkjwX1Gg9nCHfRuo
         P9Uuwx18NoVD9oy4UcVOy3nCxxKBmJuIM9QdXTkqxoNdVWC4qwDc5QR5At5z7RM3yM30
         8Jdw==
X-Gm-Message-State: APjAAAWwLx2nSRkEy9DpWUZpBqRnFBE3XTCE280pXUasfvrOnX3SpjfP
        i8eIMqaAdpJqy6VGCQhcFnjmnyWris4=
X-Google-Smtp-Source: APXvYqy3w+l4HP5/j+uKK7uR5PxhTWlvihCnNlol0WasDJBRnXuJOqyCPgk4zXzd5Tp/8ClvxY5axA==
X-Received: by 2002:a1c:a9d0:: with SMTP id s199mr3856615wme.142.1551918273888;
        Wed, 06 Mar 2019 16:24:33 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q5sm4063707wrn.43.2019.03.06.16.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 16:24:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, ybhatambare@gmail.com
Subject: Re: [PATCH v1 1/1] gitattributes.txt: fix typo
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
        <20190306052310.31546-1-tboegi@web.de>
Date:   Thu, 07 Mar 2019 09:24:32 +0900
In-Reply-To: <20190306052310.31546-1-tboegi@web.de> (tboegi's message of "Wed,
        6 Mar 2019 05:23:10 +0000")
Message-ID: <xmqqva0vo7jz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

>  Use the following attributes if your '*.ps1' files are UTF-16 little
>  endian encoded without BOM and you want Git to use Windows line endings
> -in the working directory (use `UTF-16-LE-BOM` instead of `UTF-16LE` if
> +in the working directory (use `UTF-16LE-BOM` instead of `UTF-16LE` if

Thanks for your attention to detail ;-)
