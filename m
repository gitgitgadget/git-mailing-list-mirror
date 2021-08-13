Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B045DC4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 18:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8282E610A4
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 18:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhHMSAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 14:00:47 -0400
Received: from out2.migadu.com ([188.165.223.204]:24445 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhHMSAr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 14:00:47 -0400
Subject: Re: send-email issue
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benaaron.dev;
        s=key1; t=1628877619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lzKB5S+aV0GXweRze5mS7zMnAkSTC5uMlty3hApiEUk=;
        b=th8j0wHKdsfqsfwtgD3pmqakkUvm5pskEGzyChNCnCff+LR1oB6WopoQB6devmiVfUb5xY
        8QUw37n96a+kcs+WwesTf6Holcx0z9dJ6Ieknrhz64XxfFiMD8uJCzM7NGCf16Uf6LYtBj
        Gi05OO1UU3P5/VkBW/pdnu0kChsOs3vy4e99A/bPkl9HqqXi7gscqFZwtZtD9ME7+nFIxv
        VXm1l9GKPUBF9P2cyZZAyZf29i62YSNPQ4wvIc2cOCymuJLiQ719PHG/UXIgupvxSYuh5A
        M1EQckB40UAjZjjZhNNHV0zl85Do8M/eYWosZKSb4VcGIgwcmKqOwbFmSJfKlQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Ben Goldberg <ben@benaaron.dev>
To:     git@vger.kernel.org
References: <24a88faf-5339-8449-80c4-f6085bd1e098@benaaron.dev>
 <b4b1dda4-6bf7-f4b1-88c5-9d579a7c56d3@benaaron.dev>
Message-ID: <9207c356-6c5f-d5d8-4862-a6131b4db8dc@benaaron.dev>
Date:   Fri, 13 Aug 2021 14:00:18 -0400
MIME-Version: 1.0
In-Reply-To: <b4b1dda4-6bf7-f4b1-88c5-9d579a7c56d3@benaaron.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: ben@benaaron.dev
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh, and I'm running git version 2.32.0
