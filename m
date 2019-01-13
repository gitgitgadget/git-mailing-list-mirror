Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF6E9211B4
	for <e@80x24.org>; Sun, 13 Jan 2019 09:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfAMJCt (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Jan 2019 04:02:49 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41624 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfAMJCs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jan 2019 04:02:48 -0500
Received: by mail-qt1-f193.google.com with SMTP id l12so23496488qtf.8
        for <git@vger.kernel.org>; Sun, 13 Jan 2019 01:02:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OuJqCTVQrcRJ+6w5i+wyqmTkvb7eGqvsxoOgcZn1RUc=;
        b=LP1xuEfgHwKdp5Ksl0SZQvh42YEcRAJHHreXiVq+6Mq++ThRGzueelFUK6Vy4r+mYh
         MSPiIWNxMw41g0QQNGxvRwB13eJwLRV6J4gZok/Yrx3stkEzYUZIQ5zppVRVwGrhWfdI
         SfSe2tqcTMLeAEUWO5DcytrDHPTtr1KBV/Jl85W50m69q8S2t3jXpwOYAIiiljrGE7Hg
         k9SaBxCboZNbYgmBZj4ZsMlJ5fgp9cSot2oAOlASbvf+CwCttislZHz6mBKEW8xufkZ+
         bvnyKaHt/EUsfwThwle/u4kLRVKgeRIfGRtud5M/36f3fRdHHmD1aHuuXI0DTLQVY0jJ
         RtMg==
X-Gm-Message-State: AJcUukc/2Os9b+m41/5dJ1ZPpBKswRYpxK0J0tCU+fOAzkb9QKYalzNn
        6s9xlER+hK5fmm9DCKeA/JS2vCgvb5/1CuUZwno=
X-Google-Smtp-Source: ALg8bN7RjWvQ6aVOaMIdSJts9Py7tnJ9zsbJMVAw/MzwitO+PD0mDQWlgOhsTlYE42rZtH84U0/k6MqlfRc+VXzVCHw=
X-Received: by 2002:ac8:36ba:: with SMTP id a55mr19597322qtc.236.1547370167748;
 Sun, 13 Jan 2019 01:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20190113085219.22993-1-chriscool@tuxfamily.org>
In-Reply-To: <20190113085219.22993-1-chriscool@tuxfamily.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 13 Jan 2019 04:02:36 -0500
Message-ID: <CAPig+cQ+Wjif5R4gxXCcOO7ctwU-m190E6q5xi8tWLpC6JJgfA@mail.gmail.com>
Subject: Re: [PATCH] fetch: fix extensions.partialclone name in error message
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 13, 2019 at 3:52 AM Christian Couder
<christian.couder@gmail.com> wrote:
> There is "extensions.partialclone" and "core.partialCloneFilter", but
> not "core.partialclone". Only "extensions.partialclone" is meant to
> contain a remote name.
>
> While at it, let's wrap the relevant code lines to keep them at a
> reasonable lenght.

s/lenght/length/

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
