Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EC7320285
	for <e@80x24.org>; Wed, 30 Aug 2017 14:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbdH3O4Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 10:56:25 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36466 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdH3O4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 10:56:25 -0400
Received: by mail-oi0-f48.google.com with SMTP id t75so53221925oie.3
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 07:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SKHlDBZhMho0VMGe4lTPqcC1hCL2RXy919IGXJBodUs=;
        b=Qni9lpxVpiYgYoyAyjor+A/KDCXKtPL27rZiiBBDT1RMsNdqdFmWO4WJxcnJ+LD6nq
         zZY5AiaVEsUy5QcIsnEGwC9Z36gQOosG5tBPtM5nMAH3L7xCQN22F/ek5jZB1CVpxkRd
         Worwmcrt62UkPAzwrafbQ2Lq6Ay/kfcfB9/JgI2d2HnK+GylzcsaPoJAEYcOA5oEk8Pz
         synR1TV9HOkqyMJuEFayCH6JU7yV8E2v3kdYjMVhrmWZoc4iQkCtn/0fdi20IOJQPK+0
         F52WpWF/l6t+UhhvyqPy7YmKyHarQDagG8xxAwxpa9wzew667bSskuUB/Ytb7O2YXT+Y
         v7Dg==
X-Gm-Message-State: AHYfb5hgoVAi3ESUCLoDjncxR5UKvs9jKVCb/45UHTaIWC0WDQtHGnh3
        gPhOt67K19oNpkwLfJzPKKRLpCUCn2HG
X-Received: by 10.202.79.7 with SMTP id d7mr698169oib.71.1504104984242; Wed,
 30 Aug 2017 07:56:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.45.88 with HTTP; Wed, 30 Aug 2017 07:55:43 -0700 (PDT)
In-Reply-To: <df9cb4e8-13f7-54b9-b737-be4e56977867@redhat.com>
References: <5a9e4efd-8c48-487e-4a9f-9362a944c992@redhat.com>
 <CANghgrS9hZyA4vWU=4PZuYue3iLsLx7ObbT_VgRGSXpACwNkcg@mail.gmail.com> <df9cb4e8-13f7-54b9-b737-be4e56977867@redhat.com>
From:   David Lloyd <david.lloyd@redhat.com>
Date:   Wed, 30 Aug 2017 09:55:43 -0500
Message-ID: <CANghgrTFjybxfmn=DzKwvoqRP3GA3sWiGFtYdEfPZtWmyznq9g@mail.gmail.com>
Subject: Re: Produce contents of index with existing directory as cache
To:     Florian Weimer <fweimer@redhat.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah, does it not?  Perhaps add a "git clean -d -f" as well.

On Wed, Aug 30, 2017 at 9:18 AM, Florian Weimer <fweimer@redhat.com> wrote:
> On 08/30/2017 04:15 PM, David Lloyd wrote:
>> git reset --hard ?
>
> That doesn't remove unstaged files.
>
> Florian



-- 
- DML
