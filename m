Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C0902027C
	for <e@80x24.org>; Tue, 30 May 2017 23:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbdE3XDY (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 19:03:24 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35380 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdE3XDY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 19:03:24 -0400
Received: by mail-pf0-f173.google.com with SMTP id n23so183087pfb.2
        for <git@vger.kernel.org>; Tue, 30 May 2017 16:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=IjXmpIwYx3BPd0bNeDYGx9eWI/QsHzht+DMlsKPVPyA=;
        b=b8IZJr4L2q4k13kaUFOXIlrZ4GeMCUqOl5XRRwTJk07KVHR9oEP5lOFVqdMLmD2NSC
         Bwn32WPJ8CRibObFmYybIngCRFj0anr3zHpLoNHM7rVCuDN4P3Pqva6vSWl+VX2LINdp
         cfsnTQJ6OMcmAHiM8S0xuzHGHv+p0zYrgNAtojN5xtjVqwVSsRZDyl0EMy0X9gpZ/dGg
         9xVOnCi09RA600AYML9Qpg8nOfz4+rVUQViwbl+9Yj4IhqLWbOHhbrtMLwSMJisYoebj
         DVPSqXgIyNK5xMMRnaENX+/Qp4Yv4ZI960qxJ5AIAczioTJ5BiSewt1DFsWuErwn05ot
         86WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=IjXmpIwYx3BPd0bNeDYGx9eWI/QsHzht+DMlsKPVPyA=;
        b=sW1DD82liKHD+VbywepsgpfWHa2w6IMNpUUtYv6/Y/u2nRRMactnJYB19xH9bsC3+8
         NN0XFlM4SuIX6utVZEx/S7GuZu8ND7xnG3BfccZUyp8jd+vMcf/IN0MOkLlFrYiONNAa
         0NgIy1Eh7ds8o3VlvMdc8xYs8vc6zitavgVXLypLGv20QcQhsSyGJrMTHc+cVXWI8sHa
         T7WmgSYeXnzuoQ8YTXKi78iZ5CociAp05WCHsi5aneLZ202Ige6mvL/gaBZwtBeD4NlD
         OpZSfZ7uAScn6xnVL5jYOHzaM1qqO/y5ydX4fZoZxaeeHiB6z/4tuRoeINM47dgSGGRB
         6qOw==
X-Gm-Message-State: AODbwcAA8c4ZXlc3tCzgVkQ1EnhaJeuBEWoHXgCOwyAv36SygcOIjCcs
        y11NUW3/ciBq9Q==
X-Received: by 10.99.147.68 with SMTP id w4mr28879603pgm.189.1496185403438;
        Tue, 30 May 2017 16:03:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d156:5238:7809:132c])
        by smtp.gmail.com with ESMTPSA id k9sm18665122pga.40.2017.05.30.16.03.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 30 May 2017 16:03:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH] C style: use standard style for "TRANSLATORS" comments
References: <20170511204334.GM83655@google.com>
        <20170511212012.6782-1-avarab@gmail.com>
        <CANYiYbH=EJy51yAdiMg6R_yDzZ3PLUuLMsLxdkf9zXJPhLcwKA@mail.gmail.com>
Date:   Wed, 31 May 2017 08:03:22 +0900
In-Reply-To: <CANYiYbH=EJy51yAdiMg6R_yDzZ3PLUuLMsLxdkf9zXJPhLcwKA@mail.gmail.com>
        (Jiang Xin's message of "Wed, 31 May 2017 00:02:18 +0800")
Message-ID: <xmqqwp8y9ccl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> 2017-05-12 5:20 GMT+08:00 Ævar Arnfjörð Bjarmason <avarab@gmail.com>:
>> Change all the "TRANSLATORS: [...]" comments in the C code to use the
>> regular Git coding style, and amend the style guide so that the
>> example there uses that style.
>>
>> This custom style was necessary back in 2010 when the gettext support
>> was initially added, and was subsequently documented in commit
>> cbcfd4e3ea ("i18n: mention "TRANSLATORS:" marker in
>> Documentation/CodingGuidelines", 2014-04-18).
>>
>> GNU xgettext hasn't had the parsing limitation that necessitated this
>> exception for almost 3 years. Since its 0.19 release on 2014-06-02
>> it's been able to recognize TRANSLATOR comments in the standard Git
>> comment syntax[1].
>
> My gettext version is 0.19.8.1.  I applied this patch and checked the
> new generated `git.pot` file, all "TRANSLATORS:" directions are well
> kept as usual.

Ævar, sorry that this patch fell through cracks about 20 days ago.
I'll queue with Acked-by by Jiang.

Thanks, both.
