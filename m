Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D1261F453
	for <e@80x24.org>; Thu,  1 Nov 2018 14:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeKAXpn (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 19:45:43 -0400
Received: from smtpoutz22.laposte.net ([194.117.213.97]:55648 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728175AbeKAXpm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 19:45:42 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout010 (Postfix) with ESMTP id BEC2B4AD6FA
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 15:42:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1541083344; bh=VabUfkhCB6OX0/m61Mqf8Nz7wFLOODS1kmoFlSzRNJU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=GJwN1fjC1qJ80WD7RU0VusAgCdJ2VV9ogygq0oYMNOTGG8gcj3BL6wSICoqrUxAcp
         uMlKEiS+37MpUKOrknA7U7XKqISY0af6vEyZQzGNmUjlDWGXzOanY+kv2JyDBiNhoY
         p0YVIfhhMKmofxdsFuViPvzfUrAiEfY3KGxokMI8cUscwB1q7oNCs+L1sMlnIdEEWn
         o+w8YnLrkX5zNVYHu1ae+HOvPx9+n/9jg4Y0v2XyF9+bsaQzGV5Xihm3wMexv1fDAf
         j8OSqd4is1V9aLMDvyou3eZnbADemlmcH7jFmIzmlC7u8MufE5fiIvVXNWbsvCO1Sk
         /cCc4M27mppQg==
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout010 (Postfix) with ESMTP id B05A44AF218
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 15:42:24 +0100 (CET)
Received: from lpn-prd-vrin002 (lpn-prd-vrin002.prosodie [10.128.63.3])
        by lpn-prd-vrout010 (Postfix) with ESMTP id AB8FB4AD6FA
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 15:42:24 +0100 (CET)
Received: from lpn-prd-vrin002 (localhost [127.0.0.1])
        by lpn-prd-vrin002 (Postfix) with ESMTP id 9BECD5E822C
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 15:42:24 +0100 (CET)
Received: from arekh.ddns.net (unknown [82.64.49.105])
        by lpn-prd-vrin002 (Postfix) with ESMTPA id 87FBD5E81E8
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 15:42:24 +0100 (CET)
Received: from cerebro.okg (box.okg [192.168.0.1])
        by arekh.ddns.net (Postfix) with ESMTPSA id 68485220057;
        Thu,  1 Nov 2018 15:42:24 +0100 (CET)
Message-ID: <62bf61555a6c2789e959e4f085bfedf28b60f268.camel@laposte.net>
Subject: Re: [RFE] Please add name and email to git credentials
From:   Nicolas Mailhot <nicolas.mailhot@laposte.net>
To:     Christian Couder <nicolas.mailhot@laposte.net>
Cc:     git <git@vger.kernel.org>
Date:   Thu, 01 Nov 2018 15:42:24 +0100
In-Reply-To: <CAP8UFD1rTJNOZzFMryY9BNKHUZKE8FUEgw+4jFfnZ7G8KGNrkw@mail.gmail.com>
References: <6d8ef01ad9eb08d90cb9848eeaeabe6784b7b3e3.camel@laposte.net>
         <87zhutjb3t.fsf@evledraar.gmail.com>
         <6f3d8c49e1d44ab20d4169e5254364cba707f1af.camel@laposte.net>
         <CAP8UFD1rTJNOZzFMryY9BNKHUZKE8FUEgw+4jFfnZ7G8KGNrkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.31.1 (3.31.1-2.fc30) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-VR-FullState: 0
X-VR-Score: 15
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedtkedrieehgdeijecutefuodetggdotefrodftvfcurfhrohhf
X-VR-Cause-2: ihhlvgemucfntefrqffuvffgnecuuegrihhlohhuthemucehtddtnecuogetfedtuddqtdduucdludeh
X-VR-Cause-3: mdenucfjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpefpihgtohhlrghs
X-VR-Cause-4: ucforghilhhhohhtuceonhhitgholhgrshdrmhgrihhlhhhotheslhgrphhoshhtvgdrnhgvtheqnecu
X-VR-Cause-5: kfhppeekvddrieegrdegledruddtheenucfrrghrrghmpehmohguvgepshhmthhpohhuthdpihhnvght
X-VR-Cause-6: peekvddrieegrdegledruddthedphhgvlhhopegrrhgvkhhhrdguughnshdrnhgvthdpmhgrihhlfhhr
X-VR-Cause-7: ohhmpehnihgtohhlrghsrdhmrghilhhhohhtsehlrghpohhsthgvrdhnvghtpdhrtghpthhtohepghhi
X-VR-Cause-8: thesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-VR-AvState: No
X-VR-State: 0
X-VR-State: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le jeudi 01 novembre 2018 à 15:13 +0100, Christian Couder a écrit :
> 
> How can Git know when you commit where you will want to push the
> commit afterwards?

You have an url in the repo config. of course you can change it between
the commit and the push, but that's not the general case.

Nowadays, most git projects have a preferred git hosting, and your
name/email with the project match the credentials you use to push
(otherwise things like gitlab/github issues trackers would not work at
all).

> What if you want to push the same commit to 2 different places that
> need different credentials?

Then you do not use git credentials and have to configure all by hand.
Which will usually be a major error-prone PITA, so you’ll end up pushing
to the system that matches the ID you want to se in git logs, and then
push from this system to others.

-- 
Nicolas Mailhot

