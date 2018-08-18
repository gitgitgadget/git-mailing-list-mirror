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
	by dcvr.yhbt.net (Postfix) with ESMTP id D84F41F954
	for <e@80x24.org>; Sat, 18 Aug 2018 11:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeHRORx (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 10:17:53 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:46191 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHRORx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 10:17:53 -0400
Received: by mail-ed1-f45.google.com with SMTP id o8-v6so5851874edt.13
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=cbPVn7G78jLhtJd50la9QoGfVuz0B3wl4d8IppHdbNo=;
        b=k+rnYDlvbTMgrCQD+xJ0f6fGvE1EDPxRBTM92OXar7OHPhVMd9ZPe8E0oXO490+cXr
         LmutWPQyEQr16F3sES+gAXASE/iUylB7SxP9CVAjJPQa/TplXzJPmlqxqxptBBEuiyq3
         8Ez/2pVpPMbg2iledzlYQI0819JU200CEt6GlPE9HsJb9rYXtoOIiCzAyph9p1HQjbDe
         xGsFkY/2zeQt+/8mhZBt+SVYceFW3OGDA8aAqYoNfGwysoqbE6A9MEcnyh9Sx5KKu/MH
         d22svCM5Een47HzQHBNhRVOwVhLcOyiRNxyB2P1SoG00uaQOLf5nPNUQlew+lrn9kQIx
         ZPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=cbPVn7G78jLhtJd50la9QoGfVuz0B3wl4d8IppHdbNo=;
        b=B2cirTRqHQVMVNae9w3oIURDzTN5PO1ZZZsp+UfvxM9wO5CJ8XpZxxo2SRqLVzEud/
         1w28GNrwpxwKxr76hohLr2/MikbD0H/LKfH4k+caQAkuIv3bouNpUAOqXwlW7T4o9hem
         ijH5Rk2+kht4/Mdb/rhdmRrrzxI9d3NRlbtlDLjc2A+Ej8pusEiQPISvlM6Sks2qkuJ2
         mFnL5m7bBvGl5lhO/BcujF5eb/ZW40pKAwLUvmqW0BW03RPXBwk3UIykv2nbUtQ542FZ
         84nMdTMb40dKSQvuHOXVJHfv0ynRJNDBW0+kvs2V/JYxyfK5BMKVFeX5K2Zcs6ELQk4b
         qaEQ==
X-Gm-Message-State: AOUpUlH45tGiWQTAFQQMycDf5JEUHfrqBG7kCMFysrxsnDc251uOfJc7
        w0CWfxp0m6ZyOCzc8FpTj5qIieT8wso=
X-Google-Smtp-Source: AA+uWPxQKw63zHivBoTvEun08kr9znHUiodhl0hLpecjLpRJyJ4DAxXuDOoGs676FFztTBLNNm5spQ==
X-Received: by 2002:a50:b306:: with SMTP id q6-v6mr45265973edd.264.1534590636698;
        Sat, 18 Aug 2018 04:10:36 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id a8-v6sm4290433eda.27.2018.08.18.04.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 04:10:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2018, #04; Fri, 17)
References: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 18 Aug 2018 13:10:34 +0200
Message-ID: <877ekoq6ad.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 17 2018, Junio C Hamano wrote:

> Usually, I refrain from merging larger topics in 'next' down to
> 'master' when we get close to -rc0, but I am wondering if it is
> better to merge all of them to 'master', even the ones on the larger
> and possibly undercooked side, expecting that we collectively spend
> effort on hunting and fixing bugs in them during the pre-release
> freeze period.  If we were to go that route, I'd want everybody's
> buy-in and I'll promise to ignore any shiny new toys that appear on
> list that are not regression fixes to topics merged to 'master'
> since the end of the previous cycle to make sure people are not
> distracted.

I'm very much up for this. We have some very useful things (like
range-diff and midx) sitting in "next". I think if you merge next down
to master now we'll have plenty of time to smoke out bugs & regressions
before 2.19.
