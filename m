Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B11720899
	for <e@80x24.org>; Mon, 14 Aug 2017 22:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbdHNWCM (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 18:02:12 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:36403 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbdHNWCM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 18:02:12 -0400
Received: by mail-yw0-f181.google.com with SMTP id u207so62907439ywc.3
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 15:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kggfu1IkcXlTSbAyS6K8e8S3BmDNqpAlNtQmXo2rL0w=;
        b=pTowJk9mHiBrteWiV6yU0CWLWSBKdP+cvtXgSnueD0Oap3PJyKysNMXQn/8+Q1liRi
         mJBpLCT+pKA7XC9MOWXfDOvW2+Srun7anqldfYoylWnLw4KgwzlGYAKIC/BapxZOCbEW
         oDnr3bKe4Se9wAvTUV0BOJIxmGc9k95PlQyjf6O3ash/1KKFx8AQH6GSM8pews3LlWJb
         F5yOra80ejUfiRNihLJp3Q4ExuOTjOUVHBdbaihcd0fUNND4W499WPPl/EV5xev4zNmZ
         TCcDTK2F35ekL+UBdpBK2j4O7NLuN8WFZDr0oi80pauOIWFmzm/kbAujK9KPMlBJXAHi
         ECfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kggfu1IkcXlTSbAyS6K8e8S3BmDNqpAlNtQmXo2rL0w=;
        b=BSAd53I7g8lYjkkhK4sF3zWGC8iAnG0tAjk/jif7copP6D9pZwRzlIydQz3QLRoTU3
         SR0m602qpXdVe+miR6qzxOnL+N6TBxtDmtIUXPrikzoG4CZRC6xef+ub4rLc4whnoD12
         MmchiNZ/R5zmeYT4lU1Rn3TX4C9bCcpJPJm3evbfmm2+Czr8DBWFhoEkRpj8wL5w0Vor
         JICEccDX6nQlzFAvObn7rMDf4CzO+OtabJeoz77BJZdQkgnxGOyP9JH2y1igVWqXH8gK
         i05A2Bt0yUCMGFnlf/jl6rGPLmWSHhhEj5rrRc9xwGomRTbvsFNv9wBFbfQLNB1lQcDx
         Mrng==
X-Gm-Message-State: AHYfb5hvLculSlnmaSyix9kdWmSxqUW6+BVMH8Iz3E72YeiNHSaRlRJe
        DLMB9ZJN6aezh9VhX0kGHulPeoGT16uO
X-Received: by 10.37.183.130 with SMTP id n2mr10390966ybh.353.1502748130779;
 Mon, 14 Aug 2017 15:02:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Mon, 14 Aug 2017 15:02:09 -0700 (PDT)
In-Reply-To: <20170814213046.107576-2-bmwill@google.com>
References: <20170808012554.186051-1-bmwill@google.com> <20170814213046.107576-1-bmwill@google.com>
 <20170814213046.107576-2-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 Aug 2017 15:02:09 -0700
Message-ID: <CAGZ79kau6_XeEQqYDhFC2FmyJiqWY2+SuRzvGFrfmLdhAaQS+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clang-format: outline the git project's coding style
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>, Ben Peart <peartben@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 2:30 PM, Brandon Williams <bmwill@google.com> wrote:
> Add a '.clang-format' file which outlines the git project's coding
> style.  This can be used with clang-format to auto-format .c and .h
> files to conform with git's style.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

Applying this patch and running
    clang-format -i -style file *.c *.h builtin/*.c
produces a diff, that I'd mostly agree with.
This style guide is close to our current style.

As noted in patch 2/2 we'd now need an easy way to
expose this for use in various situations, such as
* contributor wanting to format their patch
* reformatting code for readability

Thanks,
Stefan
