Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5362F1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 17:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbeGMSA5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 14:00:57 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:46241 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbeGMSA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 14:00:57 -0400
Received: by mail-yw0-f193.google.com with SMTP id e23-v6so11521708ywe.13
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 10:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6Pf3fh5aE6BjCNHnPiHYYrTSvM9DDm1/2qZe7xzaQY=;
        b=YLwwcJDTGejgPjbS3pRVpRS2McDzKDUEWUvBhYJJXi3tV8JFw8pGkEZrC6uSTF2wVu
         UhSUZ9ddQESM19uFuF8aTA17aV5Uqu4Bi1iEo3Xmz0thGehPOOewcEZjHEvgkYD+gico
         ePF46/Cr+RtS5Fvdmz7v2/u86/RNag3yoykRgE2P0Emoachht62m9Wb/AYH5imubCY2e
         zNDjgJyG6zMuo4xYtFMX5DWB/3x7/2uCXpCqHRVIsgKIhYN7ixI6E5m/rRNEs3mZj33a
         jq+9BMZEPM4Dhqfiv0rNKnIBEbdM2FKH3hcPopocYl9b6SLNiEXeyaDCfAzUUCqbfA+V
         TpKQ==
X-Gm-Message-State: AOUpUlHL/XVhljR5UCFeCpF38agFvkVTNV1amfymsnbxoFh0DnjMxmZu
        yFW/b+6vDSCkYmkbnSfidDzbvPZzlJUIzUo+kyM=
X-Google-Smtp-Source: AAOMgpfcmtI1QVHwSBRrvVIN2NrIEfzdjHBgPOvhJximb9M9WdvN+flQBagZJO7htcubomdeENLnaoGE1ZkvjUjmkWk=
X-Received: by 2002:a81:ae66:: with SMTP id g38-v6mr3875004ywk.74.1531503920341;
 Fri, 13 Jul 2018 10:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180711093822.2123-1-szeder.dev@gmail.com> <20180713163033.110497-1-dstolee@microsoft.com>
In-Reply-To: <20180713163033.110497-1-dstolee@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 13 Jul 2018 13:45:09 -0400
Message-ID: <CAPig+cQezN26oebER5wno0ENHdZ3+nKKW6avhW5ZsPo50bJ+ew@mail.gmail.com>
Subject: Re: [PATCH] coccinelle: update commit.cocci
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 13, 2018 at 12:30 PM Derrick Stolee <dstolee@microsoft.com> wrote:
> A recent patch series renamed the get_commit_tree_from_graph method but
> forgot to update the coccinelle script that excempted it from rules

s/excempted/exempted/

> regarding accesses to 'maybe_tree'. This fixes that oversight to bring
> the coccinelle scripts back to a good state.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
