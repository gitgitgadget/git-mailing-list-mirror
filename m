Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AC93202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 09:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750996AbdJBJh4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 05:37:56 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33600 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbdJBJhy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 05:37:54 -0400
Received: by mail-qk0-f196.google.com with SMTP id z12so345526qkb.0
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 02:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QFNgIBdVAF18DOqsYdFj4iJ+Jy+2ISKkopEbnQ+awFY=;
        b=r2zkFeUMOthtQKBGS2mIgP5dN4NprlPRR+JgP5/V2YC/Qqsjy7Wyg1AmQiHXvKzS2r
         zRckAaY6ZVzJGig89TS+FbLybOPD874Fn+dgDgDTUwtAa8GHP8Aeb/f/OYtgNtqmnGId
         LPhXdE2mJXx1uH8CnYk7Y+3wjtIYpGDHb4TIH/LtVS7v/rodKHs8XuS/Ut34eK1ETXJJ
         zdJgn1OrsQO3mygFByvBY8TRtMtwlM4RbBize9P6X3oDoPXUVUBT+P0v2fEAjgqj4WFu
         RkeIMWMrcVXljaC9UDE9AOfbi/YuQOwa0G94oqF8K7xxYq+oRY58P9H725j6H4a6oWa2
         sAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QFNgIBdVAF18DOqsYdFj4iJ+Jy+2ISKkopEbnQ+awFY=;
        b=Yzy1lwDiDulCm8b1uaFhjV/D+NlqHmowLjFK8M9ux14PbCbgsszdCWqSikuBfTFYIH
         Tf7l1E2T+rN9Oy/jJdyJzM6yKvleFFwk+Imu4WXWf7kXLoPhlMVrSWVdfM5q1ohJe3G4
         faq3QZZ2EJzctqlX7HN2ndddjnFP0lqgkY9hNkyOPPBokwdi73nnykuuIsTC9kqY0PO6
         xG+KtJAHRkhMElnrs5B8KJaB8H++GI6VWp7c8MjQzituExLQIhnEpjeuUxaIGBMDxgNc
         TqdNi6e8NR4Zdse/TWC7FUqHp240POKVM6nZ7fvXNn27lTyNUZderxPPW9NRmcaNsERu
         qaYg==
X-Gm-Message-State: AMCzsaWGprsIekVh10puyBRb/FKlOSK03M98FQnYB5fzQSoNkIm3USpm
        zcJoZAFL4RUMpMcClzxZVS8FIVdwJRhQCFoAs34=
X-Google-Smtp-Source: AOwi7QDYphEfxm/V5cNh71gPJlktDEUKAjpgmSCWeBhrNGu4bURSTCIKc+9+ymJ+SBpYDgj5QaXNgDn0wkPxSXIpR58=
X-Received: by 10.55.112.65 with SMTP id l62mr10564534qkc.357.1506937074125;
 Mon, 02 Oct 2017 02:37:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.20.23 with HTTP; Mon, 2 Oct 2017 02:37:53 -0700 (PDT)
In-Reply-To: <20171002082020.c7ravpwgz45osrmz@sigill.intra.peff.net>
References: <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
 <0102015ed3e9b1a8-74821a55-aa9a-4e5a-b267-c3d2462e3eed-000000@eu-west-1.amazonses.com>
 <20171002082020.c7ravpwgz45osrmz@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Mon, 2 Oct 2017 12:37:53 +0300
Message-ID: <CAL21Bmn+-2PwkXtK19fvVw-kEx_nftAx9QwvR=h-B-O-ofTqQQ@mail.gmail.com>
Subject: Re: [PATCH v2 Outreachy] mru: use double-linked list from list.h
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Simplify mru.[ch] and related code by reusing the double-linked list
>> implementation from list.h instead of a custom one.
>> This commit is an intermediate step. Our final goal is to get rid of
>> mru.[ch] at all and inline all logic.
>
> Thanks, this version looks correct to me.

Great! What is better - to complete my application now (and say only
about this patch) or to complete it in last days (and say about
everything that I've done. Maybe there would be something new).

> I do think there are a few ugly bits in the result (like that
> initializer for packed_git_mru :) ), so I'd prefer not to merge this
> down until we do that final step.
>
> So the big question is: who wants to do it?
>
> I think you've done a good job here, and this would count for your
> Outreachy application's contribution. But if you'd like to do that next
> step, you are welcome to.

I was thinking about starting my small research about main task of the
internship. I could postpone it and end with this task, there's no
problem for me.
Or, if someone from the newbies wants to have a small simple task -
it's a great opportunity for him/her. By the way, I am ready to help
if he/she will have questions or difficulties.
So please make a decision on your own, I will be happy in any scenario.
