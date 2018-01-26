Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476FE1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 22:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeAZWHJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 17:07:09 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41946 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbeAZWHI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 17:07:08 -0500
Received: by mail-qt0-f195.google.com with SMTP id i1so4983523qtj.8
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 14:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=FuIKUaY8xI9vg8F8XKWZX6BdX6z5i/dwPn4lOzrLrxg=;
        b=lqlBnBk89FpG3FTN288KGUlEeS9OPi7QnVmiB3HwKjwRoENo1iSCHWkwkDxjQXKdQS
         DaVEyp/lABXWjCQnnJYpKp/ReVZYTNtKKmJWMMc3A1FL3wFgB/7+GqEZzzGN2AhWNdLt
         7i0hZlp4rDUl0YbEepqwqqqLKkz2lMR+swpsJ0Csi1dmtuTCX92S5pYZ21oJwLOqljx8
         81MScu+JxTZkWW6pig0mvKYumdejrmTEATKn7GHIeWJ5wVdxN9nzAAp85mKUDrVKvbwN
         BY2dna1HRivNAaQQAVLn6trt5x3LrlVYUYDkRuokt6TfWQ3NEZeNdlsa5FhztfHKAWmX
         Kung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=FuIKUaY8xI9vg8F8XKWZX6BdX6z5i/dwPn4lOzrLrxg=;
        b=fRZMJf8qPdU7kBiWFTZOtrxuPQ7JbEsr2yXc9QZAqeupfs8Hdk8Xw3qUOrFe0Mira1
         xe1Zn6FLua/oDeIB8QwRB/vy3o9IBLNQMjXhWIo8NySIuPFKx1aNmlgNL/Klss/uzla5
         XBbn7IRK/UZwZQqvkRUF3eqLk3VgjT+52rDR4GO2NNyANPElJ9v4LjmGjpvOU6YA9TSS
         qkWAVBbzBbnK+yGeix6zs4Of3l0EtCMlgvqUwfUbc7GyEoz+tr2nO5kLR3K7Da8sa8B+
         mV7Z7XBmBu7eq7vTBI2HOjRUFtmzTr1L1K4Vxx+X+roi/16jwXdVhKO5ZPjZog7o3KcM
         BkaQ==
X-Gm-Message-State: AKwxytcj8PeedjdqmfMsNmDINOmuiNbC1G3sHgh4ele0RIbbSVMfddgr
        4nYtOOenu6NdUbkCY7P5t8gBAYkUBRGDKEJQ8wc=
X-Google-Smtp-Source: AH8x2260BubZZWjjSonEPoi1kRIyT4CoH79Os3Oj9/k25yXPEpjReYiMtCRftSNPMr0kKPOEmG1pD0cku1YppNRhJrw=
X-Received: by 10.55.204.18 with SMTP id r18mr22801435qki.212.1517004427997;
 Fri, 26 Jan 2018 14:07:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 26 Jan 2018 14:07:07 -0800 (PST)
In-Reply-To: <20180126123708.21722-10-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com> <20180126123708.21722-10-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 26 Jan 2018 17:07:07 -0500
X-Google-Sender-Auth: rXtuEJxGRnhva1OdD7uTKu92Frg
Message-ID: <CAPig+cSHQn3va8a47FzPRAzRX_uYKmJLpAmvp9vnv2HYi3G9pg@mail.gmail.com>
Subject: Re: [PATCH 09/10] t: make sure that 'test_i18ngrep' got enough parameters
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 7:37 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> Two of the previous patches in this series fixed two bogus
> 'test_i18ngrep' invocations that had neither a filename parameter not

s/not/nor/

> anything piped into their standard input, yet both managed to remain
> unnoticed for years.  A third similarly bogus invocation is currently
> lurking in 'pu' for a couple of weeks now.
>
> Try to catch similar mistakes in the future by ensuring that
> 'test_i18ngrep' has at least two parameters, not including an optional
> '!' to negate the pattern.  Perform these checks after we made sure
> that there is no data on the 'test_i18ngrep's standard input, so if
> the filename parameter is missing because someone is piping a git
> command's output into this function, then they would get the more
> relevant error message.
>
> Note that this is not quite perfect, as it doesn't account for any
> 'grep --options' given as parameters.  However, doing so would be far
> too complicated, considering that patters can start with dashes as
> well, and in the majority of the cases we don't use any such options
> anyway.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
