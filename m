Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4531F404
	for <e@80x24.org>; Wed, 11 Apr 2018 20:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755752AbeDKUvo (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 16:51:44 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:53127 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755730AbeDKUvl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 16:51:41 -0400
Received: by mail-wm0-f52.google.com with SMTP id g8so6897516wmd.2
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 13:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=5Y0Mu5ko+V2+JEONgBir8rv/mQu3cSWsVzcapPBoe/A=;
        b=ZlvuyXNsN04dyxZAHb8ChWSztxUj1Urvzt/BQaH3FjzAcp+08ZnKT6F6fpUTLMxdwV
         H+2k6ShCUXKOxA7d7R556bzIlpREpePQ9ruHxPuyFUapw0eL2cOOnBcfgO1Wtn2M7lrN
         sLqCVzOd45j8HaNgqerv1PQR0YbL1W4gT+XrzzwTOXxEzKMIRyRUoow7/m0F4K6Zw2xO
         NyhFp6bdFZvOVj4GAcIjAIJiw8SoOejXvhEp32uOEu+j/iaBb8RJmUhCFOH24duWnsMm
         GWbvwZXPMjHV8PzN/KiIYKFDXio5ahoCitDwvVc1A49uulqyuYU33oMJ0sC5j2M8wdUH
         5/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=5Y0Mu5ko+V2+JEONgBir8rv/mQu3cSWsVzcapPBoe/A=;
        b=odwrx2tm2BGRp/CcoZOZOHxwETYnstCA5RU5RT2OoDd+yYlC6+hxXvzKReKzypVY64
         iMMxGfeYF8H8TyDe3YyB4283MKnCcJmrNCID35LXnGBuQToIapizzUCgBAqSPDBtLczV
         pkzztIZwWqSIyvr5DdYSWN6dbVhY+HDPPlNysnNXqX/N+Tz+iFwZ69WzHPS9Oh8HR4Iv
         HRzIegf66Ce3vi73slkE+637r12JH0zSNip9nztjLR2kZPy1hV8Nywpi8SUS2EKF7EWS
         FMuUsLMXO+pLgJ7e4XIQ6sQRpZA3CoIsaqK//+kibyoH0wcUeRk7wgIk0KHOl4xD45lu
         owPQ==
X-Gm-Message-State: ALQs6tBixXHGj5YX1YuiX0MGUdq/YzskLjHAvRyYJaGERco/Wts/9CiA
        HJ7jombqeaJp/6ME7ih09bw=
X-Google-Smtp-Source: AIpwx49rUUbSr8s071rjzIfaGWcy9oEwtrrTVfSU7syosw+BjYph/xY6d3BlF6gvTiKcKuljjt7z/w==
X-Received: by 10.80.162.230 with SMTP id 93mr5407211edm.121.1523479900788;
        Wed, 11 Apr 2018 13:51:40 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id j89sm1245672edd.37.2018.04.11.13.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 13:51:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2018, #01; Mon, 9)
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com> <86d0z560m8.fsf@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <86d0z560m8.fsf@gmail.com>
Date:   Wed, 11 Apr 2018 22:51:38 +0200
Message-ID: <87in8xbh5x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 11 2018, Jakub Narebski wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>
>> * ab/nuke-emacs-contrib (2018-03-13) 1 commit
>>   (merged to 'next' on 2018-03-15 at 13eb4e2d8b)
>>  + git{,-blame}.el: remove old bitrotting Emacs code
>>
>>  The scripts in contrib/emacs/ have outlived their usefulness and
>>  have been removed.
>>
>>  Will kick back to 'pu'.
>>
>>  There were some noises about better migration strategy that lets
>>  git.el to nudge users to magit or something when used.  Is it
>>  something we want to pursue further?
>
> Maybe simply delete all files, leaving only README pointing to Magit?

I've just submitted a v4 which should address the issue raised in v3,
which was that we don't want to delete the files, but instead have a
boilerplate *.el file that errors out, thus helping e.g. users of git-el
in Debian to migrate.

See
https://public-inbox.org/git/20180411204206.28498-1-avarab@gmail.com/
