Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 624A7202A0
	for <e@80x24.org>; Fri, 27 Oct 2017 05:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbdJ0FHp (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 01:07:45 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:45246 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbdJ0FHo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 01:07:44 -0400
Received: by mail-io0-f178.google.com with SMTP id i38so10167624iod.2
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 22:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T+0XE8Bwi17k9xuKE+iNF4k2rvFcHm37S2T15V/QE4M=;
        b=I4q+VVO9Dwx/zs1HA375LGQ9lNI/URn8Kxuc8cR5M3WhaTv9moMHXZuRKq0ScCxNIw
         WX6VsMVAPJILjNvqWemXto8oPdISC4tfC5c86OUb0CrjQHNKogZhUIw4Pht91RVOeWNY
         t9kM7vK05CYeJdO4lH7OWvRseZeKCHDyGcUasmooRnCSwaMztrRfu7+hYjk4w/k1y6u5
         Dj08QBl0YVL6Yq5IOyB8BiF+uOd31eDnHuZDu4kNfIumvgD1DBGxEdnxOUUfc9I9GDMT
         5scyB/oReST1aXOCfpKLvcDwQZ8ue/wdgiSoW4ryNYc3/p9vqz4x/P2prBIsKglYW1iw
         y4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T+0XE8Bwi17k9xuKE+iNF4k2rvFcHm37S2T15V/QE4M=;
        b=tzxlVJHJODQpNaKF0p1tfDqnf5kKILKIy6o0PNyYhjwifwi5CeNZzIAedj8y4VjMSo
         k3QdV8yK9JDdQM/rC5iBmNxairwjIfhyzQCc5ZdOCNO2r5diOORO05HccMV1hSkTXsFc
         ak2Hj+je6aTAV80DJYHwMSSPOpnxWvvKfGYoZxtjrrTkKauGXvjFETsSA7HBSUUgz8+b
         VqeAGkca9eAmvGzCPVdEmZpM3qTYnHtebaw8K4Yd3rzCLidzNz9zkXrDOLkP1UK9oH8j
         M/JxFb+qul8/k5xMcG7w3KQJKb7jot06zS3qwQc1opXTplD6eUeROj120eJkGFtmYf5X
         F6RQ==
X-Gm-Message-State: AMCzsaVU3aMib51R1DyO9plsiuZ6YHULo0CmP6Qb+RAroa1B6LglrFyy
        DXUWG/gDsIUfkmcNe8A0UchkPxYyqd7pqBR4bONYEA==
X-Google-Smtp-Source: ABhQp+TcmPfFc3vo2K1xSZ5akxir199HgTghWA3OkEyUvizksrGrsFl6ObSbu68jKgSLEPYajDys73po/ys5Vtbgqu8=
X-Received: by 10.36.53.15 with SMTP id k15mr1665083ita.75.1509080863382; Thu,
 26 Oct 2017 22:07:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.7.10 with HTTP; Thu, 26 Oct 2017 22:07:42 -0700 (PDT)
In-Reply-To: <xmqqr2tpcn6g.fsf@gitster.mtv.corp.google.com>
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
 <20171019123030.17338-5-chriscool@tuxfamily.org> <xmqqvaj8dlyz.fsf@gitster.mtv.corp.google.com>
 <xmqqr2tpcn6g.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 27 Oct 2017 07:07:42 +0200
Message-ID: <CAP8UFD34O7RyXo0QErrQ0A-gbKRy8m6ChP_osQm-SdmD3qtx9g@mail.gmail.com>
Subject: Re: [PATCH 4/6] t0021/rot13-filter: add packet_initialize()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 27, 2017 at 4:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> It is fine to leave the original code broken at this step while we
>> purely move the lines around, and hopefully this will be corrected
>> in a later step in the series (I am responding as I read on, so I do
>> not yet know at which patch that happens in this series).
>
> Actually, I think you'd probably be better off if you fixed these
> broken comparisions that does (@list1 eq @list2) very early in the
> series, perhaps as [PATCH 0.8/6].

Yeah, it's better to fix the comparisons first.

> I am sure Perl experts among us on the list can come up with a
> cleaner and better implementation of compare_lists sub I am adding
> here, but in the meantime, here is what I would start with if I were
> working on this topic.

Thanks for the patch,
Christian.
