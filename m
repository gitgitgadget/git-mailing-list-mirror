Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76CB91F404
	for <e@80x24.org>; Fri, 16 Mar 2018 18:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeCPSIG (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 14:08:06 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42717 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeCPSIE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 14:08:04 -0400
Received: by mail-wr0-f196.google.com with SMTP id s18so12526572wrg.9;
        Fri, 16 Mar 2018 11:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NPju5njJ4y54+1ROSgol3yQdta2beAWUKc7QGXGZdm0=;
        b=udG/NOhAtzIMfZf0HwEeJk0IQNAfmlsu9wF9S+H2kz8XInqvOaLdI3vheeJGLWQ9Ow
         /4DUSQ+6Jo9B9B/JY7/iD+AXh+6VqgIqx5Qq8afSN7V2ODcGnLQmZOExy6ye4PfDTLfe
         dwCwPNbc62OpGFrV0dzBQeXiSHK0F43/On5vQseTwmJNhOTw0bU4J3ZH/4PbtyoUZFHy
         mGq0mYCqvId0QJRCDSmAghfnVoViLVERNVisq61GVkGw07Lr9eQiepzoGrnCjSz0RdRs
         Tftj7I1i9kcBQD7+lI7qWj4Be8eqCXjNCEhNKpTz45xAaVQmGGoQ2bEmOc6SL5Yy6bxp
         c2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NPju5njJ4y54+1ROSgol3yQdta2beAWUKc7QGXGZdm0=;
        b=ArGy7JOiydJMn+HwppSLyzkbsOLjEPHUuFM5M9jkWY8c7HhkpK2Hm+39s4O9sS4emV
         qJdWkRGRkhvKOVJQ1sjNeSETZDzV9TLkmFuDn+PPhAy2OLubXcftsKhOfr1tEHQPllwU
         /ub+OlJHC2bU7cjAxCudVZ6IP5Q6jNRcqddST4AH1SRiuXm47urUZS4CpezcxHQNNBgh
         cgoHqF//CmqQP4EpX5hS6mIfkg9XLqTme+dH0b93VQU28tD7J0Vj4qkH2UyMj8cX9M+v
         mjlyL67HpDOBJC9TfMlZOTXr11BJ/BdqC7LoQUC8KJUm5gEQcrZQZFqo6YTE7RpJ21eg
         LLYg==
X-Gm-Message-State: AElRT7EouEtcxPoXMcDlcLzGRRFkbpj/SMX0C5zzhX5X93Ye0inNnBox
        cs9+KSt4dB7eakhvtBFTOBI=
X-Google-Smtp-Source: AG47ELuiMBAps2l9OBaEnznceqJirdiIYAjkS4UD2Ks6qQAPagkWb6tIJvqTg7/ZH+TV8Bt9OF1rlw==
X-Received: by 10.223.173.207 with SMTP id w73mr2601332wrc.234.1521223683188;
        Fri, 16 Mar 2018 11:08:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y6sm6722419wmy.16.2018.03.16.11.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 11:08:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.17.0-rc0
References: <xmqqwoyc3kir.fsf@gitster-ct.c.googlers.com>
        <87fu50e0ht.fsf@evledraar.gmail.com>
        <xmqqbmfn3ngm.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 16 Mar 2018 11:08:02 -0700
In-Reply-To: <xmqqbmfn3ngm.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 16 Mar 2018 11:05:45 -0700")
Message-ID: <xmqq7eqb3nct.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I haven't wordsmithed it fully, but it should say something along
> the lines of ...
>
>  Documentation/RelNotes/2.16.0.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Eh, of course the addition should go to 2.17 release notes ;-)  I
just happened to be reviewing a topic forked earlier.
