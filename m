Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 246811F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 08:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeKTSmV (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 13:42:21 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46489 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbeKTSmV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 13:42:21 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so1447460qkf.13
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 00:14:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/On/HZXA3udtDZWK38muz9tr6RR5qtPn8AWSpqgLEo=;
        b=k5VNIUJCoWnUGXsUfxJ61cIaSWtl+IgCu1uchhJMB7hYUNxMuHMwB5pf4+uDU1zWeA
         iaohmCpfY0pskUkDwWg7G9JM/mUvsyH72uAAUtlN23Od+C9aLdcjHLaVH7EkbG/k0vUq
         Htb9SV81UFbC/bs6R7v0pAkbFWnI3EMwaMxfTBhROAWM1tbjhV8aMxtYRFJVHpPE9yWF
         l16YINmvXsf0R3PdAWzmSRrn991YUa4WIH6xVoG7aGQPvm/gESnhxDRQ9Mw0E+qRocrx
         /IhZhMkuJa7noZk2xi1IA10DlZO0luJNBcpZR9mqgYf6S4X/EDdgLgwuoxSuTnMz+D9a
         zLNw==
X-Gm-Message-State: AA+aEWZfVqHVhLdfbu+AGgjP9ZJbAJhgf0b89mYer+jTio31497AaVjL
        c3mh+RKFC1+eQbc1skfVAIi4Clzc2inStHRk+XM=
X-Google-Smtp-Source: AFSGD/UG/wY/It/cUtrIzDv9hJKX+Yrvcd6Rra9pddCRlKaWBfQ+XZ+uEHLfXpj/jRuihvt618nUElUArTz/vzcuZe0=
X-Received: by 2002:a0c:9d81:: with SMTP id s1mr981634qvd.82.1542701670520;
 Tue, 20 Nov 2018 00:14:30 -0800 (PST)
MIME-Version: 1.0
References: <20181104152232.20671-1-anders@0x63.nu> <20181118114427.1397-1-anders@0x63.nu>
 <20181118114427.1397-4-anders@0x63.nu>
In-Reply-To: <20181118114427.1397-4-anders@0x63.nu>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Nov 2018 03:14:18 -0500
Message-ID: <CAPig+cQru=h9tdyW9MDmhXgCWG5oNWrSKEzduv-sDHVprE5+Zg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] pretty: add support for "valueonly" option in %(trailers)
To:     anders@0x63.nu
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 18, 2018 at 6:45 AM Anders Waldenborg <anders@0x63.nu> wrote:
> With the new "key=" option to %(trailers) it often makes little sense to
> show the key, as it by definition already is know which trailer is

s/know/known/

> printed there. This new "valueonly" option makes it omit the key when
> printing trailers.
>
> Signed-off-by: Anders Waldenborg <anders@0x63.nu>
