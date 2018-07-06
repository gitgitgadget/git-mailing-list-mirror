Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF5A51F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 05:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932323AbeGFFl4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 01:41:56 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:37205 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932199AbeGFFl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 01:41:56 -0400
Received: by mail-yw0-f196.google.com with SMTP id w76-v6so3783221ywg.4
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 22:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SS9dAuMaOIFbr0iJc1KWVQP8B1UWzjvnj3qtwkKAYH4=;
        b=EOawW8iUe9uydZkmt9fNo0sOGG3XR3Ib1TlDZUrtno+3Geo+KjwPijw/yK0iARF7bB
         tJxd6HZq0I0JD41Vi9SdrG4JLjFK+uayjoWSaCSg1SEcjirLaoMfA00pUC02EKmvDF12
         6rLCZ4rzQslpfFrjEuxAeTVt8uLnKIyDyH55xMbAgo+n++wiXOMqXNbw9IMXPKzQKuzj
         RP2kGCPOuZwMZ1ZlAKm6Af/BUVds7TluD/xd8k+7zJs5KEacN+jGW4sNhLbyZWOwWm93
         CFItsfU9yExFUu25dK6vV2T2mD9KJuvAEpFlt5WB4Mn/IoqTwYyJiFe6KirdNpzW8QKR
         vcJw==
X-Gm-Message-State: APt69E2o5hQ85hf/1qIqE6HB3NQh24H7wYPCiQoxvXrdRtmFKy8k2u7N
        jDpYY3hB0JSaAlyaK/2WRWGebqbcBjzUohHmhQs=
X-Google-Smtp-Source: AAOMgpcW+0zWVr+Y3ivoFRiwyP9x26qbKo+DJWxlQa4SfG/eiKDCiygPPTnFbt/EiE1dsrgq9k6C62ef5UsmoCJU6QI=
X-Received: by 2002:a81:ae66:: with SMTP id g38-v6mr4294737ywk.74.1530855715720;
 Thu, 05 Jul 2018 22:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180625143434.89044-1-dstolee@microsoft.com> <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-18-dstolee@microsoft.com>
In-Reply-To: <20180706005321.124643-18-dstolee@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Jul 2018 01:41:44 -0400
Message-ID: <CAPig+cREC9Qt7NBjFe3MH2zr_P-aykGJhN4G_diqkm6RaeUJxg@mail.gmail.com>
Subject: Re: [PATCH v3 17/24] midx: prepare midxed_git struct
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 5, 2018 at 8:54 PM Derrick Stolee <stolee@gmail.com> wrote:
> midx: prepare midxed_git struct

What's a "midxed_git"? I don't see it in the code anywhere.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
