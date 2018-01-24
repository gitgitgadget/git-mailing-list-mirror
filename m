Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 056BB1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 19:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeAXTy4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 14:54:56 -0500
Received: from mail-ua0-f174.google.com ([209.85.217.174]:34195 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbeAXTyz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 14:54:55 -0500
Received: by mail-ua0-f174.google.com with SMTP id d1so3493884uak.1
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 11:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=HQCoYPoDF6hSwZEwWgTyNqqWrT60wJ6NzeTH9RXz+N4=;
        b=kh90WCv1OtMtYXnXqfWoKKyj8brJxFJksSZcihgMLfZE8e1Orv5S2FV+O4Ts/GLHvp
         4BD7wPkud6WnWI7+/zBAaYTrJti0gbOWlzjWXM/pvOWmZA93BD2b37ssLMP6flDls0wy
         sNPtoIsY9MmVO1vLuXQBQFQxMFQwY7GxT56jnRtH4XFtF949/QmRcR0eGZdRfp36YE2q
         4c+kHw7c+98BUL0WWXI06dY30wJDDYecWPj440+2Fcnx5bedyvezHAleEFdU5IseN321
         j2FqtEJjcUK9JR9TstEWL2gU2x3mMwpzBW8a+lW0fDapqL2M7cZZM6ZDqca3cyvQb6i4
         pWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=HQCoYPoDF6hSwZEwWgTyNqqWrT60wJ6NzeTH9RXz+N4=;
        b=B0JrNIo08UZFh/0aRMfojDd4j1FcK55yqVIUDDMta7CToLFhsXiu29wwIPEpE18rUb
         Oa+XoF9QCGO4zW/GzQMzPTbBiHQcST3vFFRvh9ffvEskzspkVcRF+pdUH5sKctapEewO
         +oljxF6N71dCrZkxTJy0M1EKTtlyYCTe54t2o96oo5Xe9IpH0UOEuaRstRrlyqC/eEtW
         jmcIOtgGR+0b2fq4JUGT9dJAm5UvqR99/oAFErlB+EuqNfsRdapUUXQJv7faMjmsz/CQ
         /0/CIiwLoy4Usy+Z7Aies3biOE/TXz9kjtLAachOiO0wOvLnlcC3XCb9tAcajE88hahM
         nQIw==
X-Gm-Message-State: AKwxytc4d1zQrwxumBTUZDo4jLYleT7SsQk6EbSPsKT/kpJagqRuuwdY
        9RmrMOQCNnj2Y+AFE9FxBrJlC+SDWHbii/ZX5DFL5w==
X-Google-Smtp-Source: AH8x224YA7VZbnaPtlj3Uv2oxlkiaiCcRkUqo4PrRk9n3VZPcBNgK1/14J8gRP1GTOVbh71d7KJ5SnO7PirSxtPr8+E=
X-Received: by 10.159.49.239 with SMTP id w44mr2520846uad.111.1516823694410;
 Wed, 24 Jan 2018 11:54:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.2.7 with HTTP; Wed, 24 Jan 2018 11:54:54 -0800 (PST)
In-Reply-To: <CAL664u+hWORhU32vkMDyfQgxJdf=V5Tb8G+AyNReG9DxfX1F7g@mail.gmail.com>
References: <CAL664u+hWORhU32vkMDyfQgxJdf=V5Tb8G+AyNReG9DxfX1F7g@mail.gmail.com>
From:   Raghuram Karra <raghuramkarra15@gmail.com>
Date:   Thu, 25 Jan 2018 01:24:54 +0530
Message-ID: <CAL664uJDzs1doHUMgUpSvC-1u-ANduHXrtLYx+_7wv5HYgkoFw@mail.gmail.com>
Subject: Re: [GSoC][QUERY] Regarding Git CI Improvement 3 microtask
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Everyone!! I have a query regarding Gsoc 2018 microtask. In the link
:- https://git.github.io/SoC-2018-Microprojects/

Git CI Improvement 3 task says to investigate if we can use pylint to
analyze git-p4.py. The term Investigate is not clear for me!

Even though, i have tried to run some tests in my local system i have
generated a log file from running the following command :-

>>> pylint git-p4.py > log.txt

the generated file is:- https://pastebin.com/ZGMbf5X5

QUESTION:
1. What is it that we have to investigate?

2. According to the log file there are many bugs regarding coding standards
e.x. (bad-whitespace). Do we have to rectify them?

Thanking you,
tejaram15
