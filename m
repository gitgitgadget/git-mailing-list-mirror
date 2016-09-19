Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A963E2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 13:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941095AbcISNZJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 09:25:09 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:38404 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938893AbcISNZF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 09:25:05 -0400
Received: by mail-it0-f43.google.com with SMTP id n143so70225133ita.1
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=imB+3ZjeDoxl33tNHoBmG6XOz1c+mda+LTGzHRXWo5E=;
        b=Qe0CO1bQMl/p41NDn6ntGCmNQNYgSVRrqJdGIeBNGMVNHVZAZD8iKfoYfHpaCBcCWA
         GVVW1KeAQfItAM0iI4TVqc3ZcJGxEycLx26oqUejx/f8ob3nwH/uASWrkpiiMx5T0apS
         vxz5lZbbsKKVr1VtVknrfFe7T1zVj1G9LLBr/qgBoH11LoOAYEBc3oHu0aoNz+3D3wzg
         2b3X7at5c2m5Z9+R3nBaoO7Sp6YjggZ41y78ScxuJJMBTV/+epql1toTSWuY3hcAiTag
         jzDlqMk9aCkKdsH4eotI3VHJovkPAPvJ9aodGEELDuUKGS0fmsI3+sIepvU6CFx3GNlF
         /AKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=imB+3ZjeDoxl33tNHoBmG6XOz1c+mda+LTGzHRXWo5E=;
        b=VS25OdyudEkHdoV9mfXpecI1tAI3xLQsM9m0m5ZQHYYXfGB/pm2YAAnX94srxFJ+YK
         EdkeDbOVz6HnGESrkaGhCAKSe2wp4CmQWbi+c8tE2CP89Syn+YJpUBCMXl/FuQaDpgSk
         YbsYq3qEhXN0/zucapLfnqtkKWe3k4gHrw7bR0gRL5p0+/uxdihAIDhyOsdUoU3UAW0c
         8B3dKJPsw9DggvDqH3ECAdHPRhtUY6DX57YGOjLGTFyuqUv3HM10ZpTfxP7/qyvMudFV
         3GSY2mhm6yS/sPbSvzlDVSQMNebNVeiEGNZFxSGy41iqz86Xx7jCiMtGleXPBqGwabv8
         4feg==
X-Gm-Message-State: AE9vXwPRIbbtPf2Bmn1vAuSlfRw7qg2kG/bZXxc8f0KWIoOx/aPvG5BlHsQrhPENasnz1RO7hq2neHsg53/A1g==
X-Received: by 10.36.53.214 with SMTP id k205mr10325073ita.85.1474291504906;
 Mon, 19 Sep 2016 06:25:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.6 with HTTP; Mon, 19 Sep 2016 06:24:34 -0700 (PDT)
In-Reply-To: <1473984742-12516-10-git-send-email-kevin.m.wern@gmail.com>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com> <1473984742-12516-10-git-send-email-kevin.m.wern@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Sep 2016 20:24:34 +0700
Message-ID: <CACsJy8CnQPPhwbhwG2jSzrCUJKin9+zoB5qjHb1AP0G+pEOnqQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] path: add resumable marker
To:     Kevin Wern <kevin.m.wern@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 7:12 AM, Kevin Wern <kevin.m.wern@gmail.com> wrote:
> Create function to get gitdir file RESUMABLE.

A very good opportunity to explain what this file is or will be (and
whether its content matters or just its existence). Either as commit
message, or even better in Documentation/gitrepository-layout.txt.
-- 
Duy
