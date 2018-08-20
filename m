Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235081F954
	for <e@80x24.org>; Mon, 20 Aug 2018 17:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeHTVFa convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 20 Aug 2018 17:05:30 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43562 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbeHTVFa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 17:05:30 -0400
Received: by mail-qt0-f193.google.com with SMTP id f18-v6so17143514qtp.10
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 10:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nFY3nrSiRfWCpDVpQdFIbFqpmFELAfLremXzxZToOjg=;
        b=l6s4OEiWh367j/HUSe0H+MzISZlJQLxt0rGkUdIM+NQOzlO7ZnDEWYlXbbVzoNmL/G
         LqWJNdattn05GdzPG5OwkLAK/pUxfsp3H3ZDCP7Q0zOukrVzZcDdsOxnhwGRdPYXXxOa
         Qw8IOi+Jz11diDzgSWPTdZiSM/BdSqTd7MP3ndhC3iL15bAG1ig+k4AWEvTtgm0TDAH0
         hPQo0uWKKoOl1SHHAXd2MEa9wCsaz4G2P6HIHH/tsnqgcpnKfozGevIKDBY69+bxPmTn
         2NyvM2imnwtRJwdDUWFPWG+SFqVinjIR5qwa+lebG/ft7ALJDTLtsYodW2tq1MxrpDEU
         2U+Q==
X-Gm-Message-State: AOUpUlHQDB3pU/+Ll033YqhW6BgGapFSuWGo1ZvL9yfXnQ+D5XXyaK1i
        Qz+8M8lvJDx6vkntHIhD8rmqojotvc8ozLuBXMhWZQ==
X-Google-Smtp-Source: ANB0VdaKjmieM6byfO8/imkmeX2BBWrtKTNdwscHPT22gX8ix03gJuyxlRo6kU39dKcL75go8GPlLP7IUbmvCRnBwo4=
X-Received: by 2002:ac8:5191:: with SMTP id c17-v6mr2421229qtn.35.1534787334672;
 Mon, 20 Aug 2018 10:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180820154120.19297-1-pclouds@gmail.com>
In-Reply-To: <20180820154120.19297-1-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Aug 2018 13:48:43 -0400
Message-ID: <CAPig+cQycxSEH-yrSQs39S=YdpvmbCQMBRb4hay7XKKwS1zpHw@mail.gmail.com>
Subject: Re: [PATCH/RFC] commit: new option to abort -a something is already staged
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 11:41 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> One way to deal with this is some form of `git undo` that allows me to
> retrieve the old index. That's not a lot of work by itself. The problem
> is designing that `git undo` interface because there are more undo
> options that this.

s/that/than/
