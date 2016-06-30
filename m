Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72FE11F744
	for <e@80x24.org>; Thu, 30 Jun 2016 09:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbcF3Jq1 (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 05:46:27 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36539 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbcF3Jq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 05:46:26 -0400
Received: by mail-wm0-f44.google.com with SMTP id f126so214020856wma.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 02:45:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AI6YiUQ69wrggzGAbeXJWkZco5CzpdI027cjDk/RTTs=;
        b=zsO3Vusn7rQfFneYYrfp5On+hv149ILWNj38aO1zM7h7DjfCrjLvS9pHOpNKQmcRV6
         xzQND56+h1iSNq+ZOMTsd/F1Gn5X7Hy93G6pZJySwAkJKQGq14s0F1mk9+FPcz6V0KfB
         ucAZBIrhkpyE09Ye4vxiLCrvQ5rAByMVo5Pfmz2+9LsWztkGK9UyeBKviwqOR9eCBLUN
         lJKgjBBrxTi4k9lkibCvwuLDSj+8lajIdXEAdsHoNaNs4udX/6MSEUgxbTwvZCf+rv3t
         3Ui/SNTUZkZSrnlyqvAq5FCZK9lRXtOxm4UUdbyRFVMWcPLMcr2iL7Y3KwCyLOVPrblE
         hAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AI6YiUQ69wrggzGAbeXJWkZco5CzpdI027cjDk/RTTs=;
        b=CQhwNg9VF56iu/BqUnUZawL68AE/xDYx5N6aFHNJi4DsKR1s+XAzkMI/7Ou7Yzx30M
         8GVJhnVQMtD4HbkcCs5hIIAb9G+qCx3lKGfy8sZ6i1K211nH29M1Lp7K5KN4FQDEyX9p
         lw6LPQwRH1HydvuMv1ZtJrIrlU8FMT+vRmT1NwyDbuSBYH938mF3aheduwEFxJGsjwJa
         kCtR92LVePAdN92J7vfsqhZRkl8QItABw4P6TZLZpoR/38a6t4SdMSyMl5bdymIqbII+
         6kKUUHZdHPfQA3zi+iyFgJZSsCe86lTkn+adYFoVM85AaUXrpP0AbrrurDwpoCD3XCX4
         jZqg==
X-Gm-Message-State: ALyK8tLL84iPqw8Zr6N65G23NDjc0NtS8F7pAZTbIjYZ4Gts1Ep0w/0M5TnNmWjsC6hBeobqvrLDoDsiA2k5eQ==
X-Received: by 10.28.189.9 with SMTP id n9mr12795602wmf.79.1467279942507; Thu,
 30 Jun 2016 02:45:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.25.197 with HTTP; Thu, 30 Jun 2016 02:45:41 -0700 (PDT)
In-Reply-To: <57747A4D.9040701@ramsayjones.plus.com>
References: <57747A4D.9040701@ramsayjones.plus.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Thu, 30 Jun 2016 11:45:41 +0200
Message-ID: <CAP8UFD0PKJzh2Rfd-tJ_VTiTSj1jt8srhavU5w_W=UoYpKvKsA@mail.gmail.com>
Subject: Re: [PATCH] builtin/apply: include declaration of cmd_apply()
To:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Ramsay,

On Thu, Jun 30, 2016 at 3:47 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Hi Christian,
>
> If you need to re-roll your 'cc/apply-am' branch, could you please
> squash this into the relevant patch. Commit 95a3b0ba ("apply: move
> libified code from builtin/apply.c to apply.{c,h}", 22-04-2016)
> removed this '#include "builtin.h"' line, which causes sparse to
> issue a warning.

Ok, I will squash this.

Thanks,
Christian.
