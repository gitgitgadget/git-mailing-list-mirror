Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72FB21F597
	for <e@80x24.org>; Mon, 30 Jul 2018 18:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbeG3UYa (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 16:24:30 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:47039 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbeG3UYa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 16:24:30 -0400
Received: by mail-yb0-f180.google.com with SMTP id c3-v6so5151330ybi.13
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 11:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Q55ATMxRqdx8iPpk/dyojAY6pAZRpVZPTG5A1b4GrU=;
        b=WmUZ4SJbFB8ppOfR/h819U8pb2KY91laktQVF5//MKirir1Tl0vrlAt5VyHBB4/SKn
         lMB8cwVp60aWk/tfxyu4SKKlnoxj2kXF9ESfT/oL29IH9kx6uQN4gndgVU2xTH/4BrS3
         p7o9yT1ueEJjtFk7Zx2TJn4oyNS7q8okIeB8cSBeY0/+sQnnAQV7iBuFOipfeSIXEGtb
         8PydDJCK+FDmBSTC30upzOQA2E2arETLoJ/hWa5uu2Ru9fpQhX1zny0kz0C8yotxV58Z
         gaEiSUrijtq8CkyhF158JLXBdLw7g+joe9yfE8A9kmFjcUSjoM3RwG+JVBvPzVLZRcIG
         oV8g==
X-Gm-Message-State: AOUpUlG6SUcIHkwQsQir4U0IwefwvpK3XPNXiHvWjR2OJNgtFgWjSvcs
        nz77nZ57PCqlIgLmvW9CZms9dYvATZDnwYahXxM+1w==
X-Google-Smtp-Source: AAOMgpf+slVxUOx7q4F5f4XFRsg3jtf+S6A/+goifZUs6n51QC36RH3CP3ClIuND0N3zkrlth/SaJ+RDCIfwItST6lM=
X-Received: by 2002:a25:8b04:: with SMTP id i4-v6mr9872641ybl.12.1532976491270;
 Mon, 30 Jul 2018 11:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180730122609.57058-1-hanwen@google.com>
In-Reply-To: <20180730122609.57058-1-hanwen@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Jul 2018 14:48:00 -0400
Message-ID: <CAPig+cQkFHtOw=gJ1Y5vjQipeAgRon214tUs09o3k3LkevHu4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] Document git config getter return value.
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 8:26 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
> ---
>  config.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Missing sign-off.
