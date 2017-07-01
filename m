Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF31920209
	for <e@80x24.org>; Sat,  1 Jul 2017 22:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbdGAWPX (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 18:15:23 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37158 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdGAWPW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 18:15:22 -0400
Received: by mail-wm0-f46.google.com with SMTP id i127so75801803wma.0
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 15:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=M+AVs07M6zhaVVlm9PKEECAfcrGVDTVWwFg8xsmS5io=;
        b=C4IGZyhF3VeV3uwlygK7ELlnvSjCAnrv1Nd6B23tFrYNwyx3WlxNCjiJ8cNDeCYAsJ
         igCBwlhmYLdafpqwOPaJ+BUocodjvNagbtqvwofNMhlhlcQv2glDVoZVh2ZOk+aI61OK
         EXspUwoYkLZnB/toTzhrEyDl+dWbhrMAguQbf2Db+8NkIlJYei96w6ffpu4fk31hai4E
         3gUflLk+MWkKmw/vwxEBHVVcueNxdynmWfWgst9MtQLwl5oOa3lvWWsP8ZHSKgISEl0N
         K56BQ3ihIR6N19K3Q2tOt4yaMxExP0GSOW3/oXcOrcGu6wuwUv8r0sv0Cswiu2qV+VKO
         3E6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=M+AVs07M6zhaVVlm9PKEECAfcrGVDTVWwFg8xsmS5io=;
        b=dGHtpFxlYE5CXQUMY9pCRZmTWOUwuB798BKNi4oHSc07ztIHtJzVWCnCcpv5+56fwR
         pXt1N9vydfVt3T3dk0MYZXlmrmw5IAyJ7x5HmSBAKbYVxhpLndOutszG08h50HBIsDW5
         wWc1hyosMrT2VOodGsh8Oj1YGdMjW+8eO88ysmed3bM8EEMogxrcOjOWh3PVONNkhCCX
         uIgyjpx6oWRcY9Sh+tgGu5CmV7kdCRY419uZBhLqWFCloJhB1KIrt8BuDiD/4bg57Hdi
         sx6sXPd+lYXuDSQxFA7ds7RjZQLp6n+BYuWy/PU5WDJdRfAWX9kKog4hk9ormfWZYCDY
         6AoQ==
X-Gm-Message-State: AKS2vOw4vIX6zvnGOImSsT6JTqqjgfDtcdCCT8Qv01wEYznmWZQVaqs/
        IMNFik0/3zc+dm56cxg=
X-Received: by 10.80.181.165 with SMTP id a34mr9635392ede.167.1498947321477;
        Sat, 01 Jul 2017 15:15:21 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id o15sm4618239edo.68.2017.07.01.15.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jul 2017 15:15:20 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dRQff-0000vT-H6; Sun, 02 Jul 2017 00:15:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dan Kohn <dan@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Request for git merge --signoff
References: <CAHv71zK5SqbwrBFX=a8-DY9H3KT4FEyMgv__p2gZzNr0WUAPUw@mail.gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAHv71zK5SqbwrBFX=a8-DY9H3KT4FEyMgv__p2gZzNr0WUAPUw@mail.gmail.com>
Date:   Sun, 02 Jul 2017 00:15:19 +0200
Message-ID: <87fueferd4.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 01 2017, Dan Kohn jotted:

> https://github.com/coreinfrastructure/best-practices-badge is a user
> of the https://github.com/probot/dco bot which checks that commits
> have a signoff. The issue is that there is no `--signoff` option in
> git for merge commits.

I think it's fine to add such a feature, but it seems like an obvious
bug to me in such a bot[1] that it's enforcing the DCO on merge commits.

The entire point of the DCO is to certify that you have the rights to
submit the patch etc., it's quite dubious to be applying that to merge
commits which contain no original work (most of the time, although of
course a merge commit can have significant conflict resolution).

So yeah, it would make sense to have a --signoff option, especially to
use when the merge actually does contain original work, but your stated
reason for wanting this just seems like an easily solved bug in the bot:
Exclude those commits that have no patch contents.

1. https://github.com/probot/dco/
