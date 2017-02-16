Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C178A1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 18:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933620AbdBPSld (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 13:41:33 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:36585 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932694AbdBPSlb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 13:41:31 -0500
Received: by mail-it0-f43.google.com with SMTP id h10so710937ith.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 10:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FTN13AAAGCZlmKP1le0HpvYMrptu3xtY0lj4l/wBw3M=;
        b=KiI8W0VWHkj1afH3Wd1XAhS1ThX0L5eRw23rR0h1nCkMzXZ7z7D2iry77pXugGVVMn
         vLmpge+TRO+EsAjda5clY1bObplmlIEE5jQxuUbGMZWfkf4TdGQYm6jo4m9cc7L1LdOh
         ye2dCt7WMeQiOVWK14TXNNq4Zw7l/+El1BzSxZoES/frU6LiYmTqkWduJGFpS+gDWVtu
         BS/34sI9ki3eim4PgrSQaB8Sp+3Hvdx3tffozDtc+oRtyZhEul+/KKvH9Iy9yeOzceqq
         g+NiU9OqapjrCeOjn2eH4UFEEAi2Pi+tv5REpF0dEZJ+0eRMeGsHn1HcLxTMsnSIxD/T
         KYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FTN13AAAGCZlmKP1le0HpvYMrptu3xtY0lj4l/wBw3M=;
        b=pFu6le9iJKjY+jYC6WgjeLmw98ZZY3w3P2o2vFQ/jfktV710I97uL09fsfEkPuJkQo
         fLiH38SqFqUGmzECJuLKeSqEPkGN6txl/BkWsGDQRby0/7a0/DZUkVgYSAQDpxcc/dOJ
         NG35hyGTBJdRaf67i9ka/ekNwkrDZjKIhwCUiofIFuV2tnefjbiBNELOOODkbOAoahBl
         fLJdC6zN6W/+9BYFHFhBRas77hi1tV9HbW2RJZwT7wSsuzJIbve05KDRDQSwgZ5r79Sm
         9s/a0xvxGrA9K+woebQN//vcpr35epKrLK8aGyOOjSQeAEOnKJDI08QzKPmr111cPH9m
         bOFg==
X-Gm-Message-State: AMke39n1Iif9XmIMftV7FVy9ILbDKFofL3/m5obCdT44O8OdnGlWGc88qoCmQ5U/EpYUvgphTnsl7R9i2OG3ZD/Q
X-Received: by 10.36.34.79 with SMTP id o76mr3339496ito.116.1487270491027;
 Thu, 16 Feb 2017 10:41:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Thu, 16 Feb 2017 10:41:30 -0800 (PST)
In-Reply-To: <20170216050535.64593-2-david.pursehouse@gmail.com>
References: <20170216050535.64593-1-david.pursehouse@gmail.com> <20170216050535.64593-2-david.pursehouse@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 16 Feb 2017 10:41:30 -0800
Message-ID: <CAGZ79kaPFP3aQB8=gZ+BvRUqJa+NPuDQ+5kvKNqqYs3S28EEew@mail.gmail.com>
Subject: Re: [PATCH 1/1] config.txt: Fix formatting of submodule.alternateErrorStrategy
 section
To:     David Pursehouse <david.pursehouse@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        David Pursehouse <dpursehouse@collab.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 9:05 PM, David Pursehouse
<david.pursehouse@gmail.com> wrote:
> From: David Pursehouse <dpursehouse@collab.net>
>
> Add missing `::` after the title.
>
> Signed-off-by: David Pursehouse <dpursehouse@collab.net>

Thanks!
Stefan
