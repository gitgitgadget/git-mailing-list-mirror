Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB43211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 20:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbeL0UkT convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 27 Dec 2018 15:40:19 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41878 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbeL0UkT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 15:40:19 -0500
Received: by mail-qk1-f195.google.com with SMTP id 189so11493965qkj.8
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 12:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y5Q1jZ21VigH7wwI3Ffs6mUWm0PVdC3dwCZ6aOnR454=;
        b=b0nXAi4e53QpXO5QUri2X1mwA8DdnfQWYpXV7mmrCiwyt7JElu9PnoUR6qiji8mxcU
         6DmmTJteM36A24kquOmyMfpD4PYbf6xrEgPrB7p7lqXcdgM/Ff+TPP/NsmDmNuSQaZ+L
         tySKGhPbelcDqbT9cwpnA4C/+vKBGa3C91xYUou6kEuAOsTEZzx+D/LbEaajFJeE6W/j
         AZXRB83Umk2sWytKZwYO57gjdWo0nIvhJPsSBRO5WKeNzJt8ucLEDVpuXhtZ8MV+GmdB
         I1JQoTUufDlLINkZxlW4vmhYbGY3mCKwkAeUy6b/dynz9FV3+RowITdtpDYFFZaxAB5P
         qadA==
X-Gm-Message-State: AJcUukcvY3oJAui4IMeP/usGtqBI7eozHx6xbYOtDPWPf4p1x1BWLUky
        PN953APPnnTO6UbLKfXUKXm8QRDP2XoY5zZnqLA9FBU866I=
X-Google-Smtp-Source: ALg8bN7dmF+VqpbDV733hpAE3Wq9Sj9v7MXOVpEYZXkBEmf+kaQPc28ySn2acdE4p+nSCypi/eZIZFXprWZg+OiC+sk=
X-Received: by 2002:a37:a44e:: with SMTP id n75mr23281375qke.26.1545943218475;
 Thu, 27 Dec 2018 12:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20181227155611.10585-1-pclouds@gmail.com> <20181227155611.10585-5-pclouds@gmail.com>
In-Reply-To: <20181227155611.10585-5-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Dec 2018 15:40:07 -0500
Message-ID: <CAPig+cSZxUXM0RqDRnxsc7iF_kTPanew3aJA0FXXZpLNWT7SeQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] config: use OPT_FILENAME()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 27, 2018 at 10:56 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> Do not handle prefix directly. It's simpler to use OPT_FILENAME()
> instead. The othe reason for doing this is because this code (where

s/othe/other/

> the deleted code is) will be factored out and called when "prefix" is
> not available.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
