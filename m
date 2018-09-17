Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 579421F404
	for <e@80x24.org>; Mon, 17 Sep 2018 17:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeIQXTf (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 19:19:35 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:38804 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQXTf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 19:19:35 -0400
Received: by mail-ed1-f53.google.com with SMTP id h33-v6so13637496edb.5
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=l4MvlDjeGOyxm0XCJZBkHewSRQ35e/zT+OUSq0joktI=;
        b=PUR9/olaOrZsahV5AsmZ+oY2WDFYkillOnGoz+nC5hm7+hrQVG7x8M2B2+whMU5vbm
         GyhkbwriPpg8iu3ICFPh/Td7KvXB5trFfkjobCallAPSaOoUSjgmmfNZ+rGkyiSOGlsr
         Rf5lz5LPH1dtb4UyCl3lB5xrKoQEFa3jFoqD9Q9DGI5PiKjWUOX25vwwzjcRPDFvudd3
         21d+1cy4IQpB4T/zvWTeK1YZ0l+aWEyz+IPjhHLWm5spEQYPY2i8pSb42w/PLMVaxmE+
         U2CnGI2pfxbR4JI8E9BWVY5e5eDjcb3BTPjhHhjfeBk7tPwzm4EszRbSkR8ZCjFLzf3x
         rTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=l4MvlDjeGOyxm0XCJZBkHewSRQ35e/zT+OUSq0joktI=;
        b=XIlnt/+NUk8HyR0iS7fMlgNPSb8LvoNAFflBEkmPV2giwnQqly4g4L4iH3Guxo3BzD
         44Q4GxTy2QvoXPtjvVjbd/E/a8MFHP/bfBsIj1DmHjKJYrAHndkMsOzxj58fZOaQYq9B
         Xs4Mgej9xGRTP2U9rmVTdB2fxSdSt/QpFehPDEwu+eTMT1HqSJwZQ0DJHnR5QQ84sSX5
         mTsGcM+j3fb21Z4auOFF4q4U+P+BKWYlPaFcW4XtPQQUf3uqu4IS0d28L9ENu+x1biKa
         Y/yxT8AHzABn4r1Tzl9UrZ8Yle3PndEz8Q/LM6MNZ48veirlwgvysGVvmMrimzgiEU3I
         bn6w==
X-Gm-Message-State: APzg51Bbzql2I0lvfyRYUFh0vfP1s+ye4W+6knyLXbtO8jsbw9Qwfv1y
        2GwpSIdoi0zdX5K52Eg76ecsYFLYJeo=
X-Google-Smtp-Source: ANB0VdbkyeeQkQcQ42Vx/J58KJhLvpHBmenHj8CA/R1xlCNbYAESj3RiBVPWRqjuzI8LYV4xngMgdA==
X-Received: by 2002:a50:984b:: with SMTP id h11-v6mr23341787edb.26.1537206670040;
        Mon, 17 Sep 2018 10:51:10 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id i19-v6sm7212756edg.64.2018.09.17.10.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 10:51:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Brandon Williams's E-Mail bouncing
References: <20180917015259.GA26339@sebastianaudet.com> <CACsJy8CAyXAaax8dSPUUzTFvpKVG19FDives3JthL4hBxgf=6A@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8CAyXAaax8dSPUUzTFvpKVG19FDives3JthL4hBxgf=6A@mail.gmail.com>
Date:   Mon, 17 Sep 2018 19:51:07 +0200
Message-ID: <87zhwgj9mc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[Sorry about the double send in private, forgot to CC the list]

On Mon, Sep 17 2018, Duy Nguyen wrote:

> Brandon, b0db704652[...]

I noticed a few days ago that CC's to bmwill@google.com bounce. Has he
left Google, and if so is he still interested in being CC'd on Git stuff
(maybe he'll chime in), or not interested?

Aside from that particular address bouncing (or not, maybe Google's MX
just dislikes me), it would be nice if git
{format-patch,send-email,check-contacts} & the .mailmap format would
support and understand some way to map addresses to
e.g. noreply@example.com, and prune them out appropriately. We have a
lot of addresses from past authors which bounce, and where no current
contact address is known.
