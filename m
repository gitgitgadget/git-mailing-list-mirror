Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69BF11F453
	for <e@80x24.org>; Tue, 30 Oct 2018 15:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJaAXd (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 20:23:33 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:53662 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbeJaAXd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 20:23:33 -0400
Received: by mail-wm1-f41.google.com with SMTP id v24-v6so2378708wmh.3
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rIsdPzQlzAe1JP9BihbKpww3fyHduIIgDHsMt7YaWTE=;
        b=fG8qpvqp5C1On0C2SwDs3hfqFD/pgRZxQWn1n8gkPGTTp0rmrT5dPO3BlH8f9gXyPp
         ezC9hCn3Cs5P4QzlhKlMu5lzD+DLR1qj6HWfoih1BVm2LDfmkqc1DBSDT7OUVLQBClEo
         6ZtxZzAVAglEZs/JQltaptUhQ0GviaCFb/TKZo3Gnz/QQUCiVKHdtWpPhjYWULfdEo+a
         +ecZgzYaseMN7G5DTCS7DbEaKZJm20DXrnUE2GVMWvH1iKnmA4dwHqLemWwjKzhXd+gb
         eHMMACGHykQ5jUerlqsHocYACm8hWZtWFORiJCuk6u2/ZS/YlNvJvwfuStjcvNQyfVS8
         T58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rIsdPzQlzAe1JP9BihbKpww3fyHduIIgDHsMt7YaWTE=;
        b=k0kAUl11ohXaKu73J1LihTC+FYo3t6FqfYfKrUGGCN+A32I6ENyxVGQAJbFMSpoaLH
         57y8i3zW45IplhxwG3VEIY20+Mzwyp0JLTQwWa/QAkWvwDXjv/sJuWHM6iN40+rYnYLI
         Zy6VuotgvreLWJmIaKjidNRIz1mhK514XU+Ln31RR3n+YUhLk/Srf79ZU0fkOaERHgBB
         +rp+lGcATp5wVn/nW5njUgNXFgTNsyBsBE+YA4KVgHK6PFBWQkxJMm0QQ9Cc5EtaSX5l
         QN3CHdt+J6UHBQps5eBlZ4FrTbmwMhVU/6F25GgT1e0q+M5tCuLNTg6SuQI/Rs7S/eEq
         1/sQ==
X-Gm-Message-State: AGRZ1gLv27wywbqJp31M9PnRsV2V1Cysndf7WXLppd7UZgXysgHk+/Wr
        KrwOM2k+qaUIa0HtPn7fDCRJQYCx
X-Google-Smtp-Source: AJdET5fFV+Yot7G0HJlxgD+5nNuQ47oti1rIdngrrVDNQPCQNQWXBBU9eJHWZ7tBBc+3GjLEKigDUQ==
X-Received: by 2002:a1c:9f01:: with SMTP id i1-v6mr2117410wme.8.1540913375913;
        Tue, 30 Oct 2018 08:29:35 -0700 (PDT)
Received: from rigel (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id b137-v6sm307528wmf.10.2018.10.30.08.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 08:29:34 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:29:29 +0000
From:   Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>
To:     Gray King <grayking.w@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Lost changes after merge
Message-ID: <20181030152929.uxxf3r6gsslr4vpp@rigel>
References: <CAP1N1j7P83XVPx6dDGMSeRbwjdixAdBNZab=TP94=9LSfmsrRQ@mail.gmail.com>
 <20181029141804.GC17668@sigill.intra.peff.net>
 <CAP1N1j7AbiYLfe4EiFn-4zdBd-nD2paXx1hZhqiUCOq4iLh9zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP1N1j7AbiYLfe4EiFn-4zdBd-nD2paXx1hZhqiUCOq4iLh9zw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commits you mentioned are not present on the new pastes.

On Tue, Oct 30, 2018 at 03:46:28AM +0100, Gray King wrote:
> Sorry, seems the link has been expired, here is the new one:
> * Before merge run `git log --format="%h %p %d" -n 20 --all --graph`:
>

One thing I noticed, is that you're using %p with --graph. And --graph
enables parent rewriting. Which may surprise you if you don't know what
it does.

But apart from that, and assuming you only did `git merge f087081868`
everything looks normal between those two pastes.

Cheers,
Rafael Ascensão
