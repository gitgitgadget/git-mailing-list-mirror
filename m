Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EC861F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 07:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeJJPUS (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 11:20:18 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:44753 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJPUS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 11:20:18 -0400
Received: by mail-wr1-f54.google.com with SMTP id 63-v6so4546147wra.11
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ADq/aLw6xTtSUg/Q++WasvIBvTSl5u1/MMjYqDe7q6A=;
        b=WSlzCe39IbzN8W7ABXPLsvBlsm3jS0DCitb7TayJwXClftDNNgdEsnC115+wd0l3gK
         tRXDZGPWVs/uE8z1PoTXH4HqpiUTR7/lt7rjGuoKUsnpgysZiPTqF9cduKkFonLRpIUw
         kM2034o9RCxpQYjIxx4LNck0Qmjk/8cRqPslhJPz1RcA0WSsNkIF4VcMaOOYHSsvX4um
         QfLuuKxqTe87fGXJei0Wk1Hl28wodWNvyOIpr6+fIPLN6pZ7jWvR7xcDZ9LJ36AbDv2S
         RLSNHQl25kGmpc3AkIPGhGa1tluy9ioq7jdeXRQfTv2XUDJRVMC/TNN0TS7lRVd7lWiK
         NcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ADq/aLw6xTtSUg/Q++WasvIBvTSl5u1/MMjYqDe7q6A=;
        b=ZV7/41Y28g0784d2dVPhjBf1M4rFltd19W8G+Rl+Jn9Py7s4LVgrFVko+XNwl0XIp+
         ATljWi8flu98u021ZykbOj9PU6pHXt4ILBHL7OyTkYCCjJ98uVWtubkjCjy8d9WH/+F2
         nIpc+9DmBipcn0R8QimB0G+QXMWIFOZUWWDz78UWwWG3oKvC8jkpguqRI/KUTZTJnr7S
         PvIMfzd6iTpmj8hddjQvUzR+u6Qg9pY2502VW5CQpIXVNICVPX1e3SmrZXOAA7wzwlG+
         ZUKxhc+tGWZ/Qp8KHbW5IUlPpIBJ0GCV3ni/Lu8wtvKJFm+idrRyg+9XM6lCOu2gT2I3
         dlYA==
X-Gm-Message-State: ABuFfogauRVmslaemhbK56/2jOL4JBsdwSYMUo78KYgmXIEpZ5R4LvS1
        /5F3psGzXJ649osj0mZwgS8=
X-Google-Smtp-Source: ACcGV63tYYROitW8bEhECVI1+lDrFXFd8S6orYsnR2IYxTXZ5iPQ9OmpEWYo+CcvBvuLsUFQ2QJafA==
X-Received: by 2002:adf:fd83:: with SMTP id d3-v6mr4274789wrr.25.1539158358852;
        Wed, 10 Oct 2018 00:59:18 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id h18-v6sm19689725wrb.82.2018.10.10.00.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 00:59:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 10 Oct 2018 09:59:16 +0200
Message-ID: <87efcyfd0r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 10 2018, Junio C Hamano wrote:

> * jk/drop-ancient-curl (2017-08-09) 5 commits
>  - http: #error on too-old curl
>  - curl: remove ifdef'd code never used with curl >=7.19.4
>  - http: drop support for curl < 7.19.4
>  - http: drop support for curl < 7.16.0
>  - http: drop support for curl < 7.11.1
>
>  Some code in http.c that has bitrot is being removed.
>
>  Expecting a reroll.

There's been no activity on this for 6 months since I sent a "hey what's
going on with it" E-Mail in:
https://public-inbox.org/git/20180404204920.GA15402@sigill.intra.peff.net/

Maybe it should just be dropped?
