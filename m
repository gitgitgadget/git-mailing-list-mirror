Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0601200B9
	for <e@80x24.org>; Fri,  4 May 2018 02:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbeEDCcK (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 22:32:10 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:41418 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbeEDCcF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 22:32:05 -0400
Received: by mail-wr0-f182.google.com with SMTP id g21-v6so19468602wrb.8
        for <git@vger.kernel.org>; Thu, 03 May 2018 19:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eeecLlA4t63in3MpNIhoCFB9H8SLfXVZkYJx8UK2i8E=;
        b=gEwPKmpk7do31dAtNGiq7JSMODCPRpw2UlSFeafMw8fl7GwdxCRQQgv+KFWSxYLRXG
         kbJfxQWePzPc7VwDp3Y5wMQhJax+uDUwa6jBdjgmueGnJEjZo+b5qSdl8Q2kwemEfWc4
         MGiK0AAfeWl4BriDpzaKvFEYghi9lQ9XZ9KDjF3h3RXcucOYz+N+4Q3n37LMATpHVq88
         QZRwSlRn+ee8eGCiPUr1uvEwqg90FS7DVRQOqfeu/+o7SUClJ+n3Wlau5tTJOISSiN8V
         bJeMjIfCdpv+hhItBBW9K+L62O7LDVUwpejD2/L6g2S5ZKB2xm7ctUbeq63z1xDeC/xv
         b+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eeecLlA4t63in3MpNIhoCFB9H8SLfXVZkYJx8UK2i8E=;
        b=b0r3nXpmQ1KaVHbqE3+j/vSKwxmvvOaZaveMumdALEGeX5JhUt8loaWtR+NF9bpq+M
         uhDBozOYe7kBmiJfhg+M86l5NnjClSUyT8Oy7RsPZWCYtlrcijYnlOevXiOJuWDrL8gs
         JiZqn/25o793/S797MeBoDiAsQE8G8uwV8KNcvQilz+JyKLcCBMHXU8a69HU8uEDPagT
         eqjTy30hVQw7OHNQ8VNrm9lcDpCUSmEcso2yKePMAbWzlzoudfrWh/qS9DyNDeycDQvw
         Elo7nzopXxBmI/ByqBHdzzWOAT6wq+ckx1rPPjlS799HKjZpER9l0HJEUubzTL7ZcDTI
         pDaA==
X-Gm-Message-State: ALQs6tAVS2Qz2sI4e3b280Sk5fGTh3IB/6lE/Q0zJ9ir2yuIV4j1K2Kp
        bEMhlSBwAbhY9so9qVQxhTQ=
X-Google-Smtp-Source: AB8JxZomLdzzviLXrW9vcdOW8U0zPulJKWnRDlZFOj+kKDevdwAlMrg8KSYKnJPjM+UPUBf9aspBcA==
X-Received: by 2002:adf:9003:: with SMTP id h3-v6mr15767114wrh.188.1525401124139;
        Thu, 03 May 2018 19:32:04 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n23-v6sm529010wmc.23.2018.05.03.19.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 19:32:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] revisions.txt: expand tabs to spaces in diagram
References: <20180430210430.14611-1-martin.agren@gmail.com>
        <xmqq7eomwtid.fsf@gitster-ct.c.googlers.com>
        <CAN0heSqeMFq4yVHX=8Ug3wOTEzrLXwE=PcF7UFWTRg_AbZEWWg@mail.gmail.com>
        <20180504015202.GP13217@genre.crustytoothpaste.net>
Date:   Fri, 04 May 2018 11:32:03 +0900
In-Reply-To: <20180504015202.GP13217@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 4 May 2018 01:52:02 +0000")
Message-ID: <xmqqmuxgtal8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> ...  We can help both AsciiDoc and Asciidoctor do the right thing
> here (and keep our 8-space tabs) by enclosing the diagram in a block
> like so:
>
> [literal]
> --
>    Args   Expanded arguments    Selected commits
>    D                            G H D
>    D F                          G H I J D F
>    ...
> 	  = B ^D ^E ^F          B
>    F^! D  = F ^I ^J D           G H D F
> --
>
> and using the tabsize=8 attribute when invoking Asciidoctor.  I can send
> a patch tomorrow which does this, which I think may be a bit nicer than
> having to give up tabs.

Yeah, trying to forbid indent-with-tab has been shown to be
unworkable so even if we tried to give up tabs, it is likely we
would break it by mistake.  Allowing indent-with-tab and ask the
tool to do the right thing is obviously the right direction.

Thanks.
