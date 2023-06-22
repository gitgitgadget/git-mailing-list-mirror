Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88445EB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 10:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjFVKKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 06:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjFVKKa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 06:10:30 -0400
X-Greylist: delayed 406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jun 2023 03:10:28 PDT
Received: from out-57.mta0.migadu.com (out-57.mta0.migadu.com [91.218.175.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BEEE9
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 03:10:28 -0700 (PDT)
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com>
 <20230602102533.876905-12-christian.couder@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
        t=1687428220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G6AiRSNwxWp9v7vpfNk8RmBFhgrxPnWU47N93eu8d+E=;
        b=s9cgicUycjNkrX97bQQ1FDXweeRoWHOvx0U0Er9X/W22lGzvQnT57zhsGAvoyN59RsAFtT
        W0xQ/nahAkLmRGgwyAy7Ujl5+DI0aq42RLufyi1sXmxLYW2E6iCFVUWo7TOXtC7qctdCNt
        makZd3aNTga15dcEoNxEl4LiOvPxOSI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Toon Claes <toon@iotcl.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 11/15] replay: use standard revision ranges
Date:   Thu, 22 Jun 2023 12:03:03 +0200
In-reply-to: <20230602102533.876905-12-christian.couder@gmail.com>
Message-ID: <87legbsths.fsf@iotcl.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Christian Couder <christian.couder@gmail.com> writes:

> +DESCRIPTION
> +-----------
> +
> +Takes a range of commits, and replays them onto a new location.  Does
> +not touch the working tree or index, and does not update any
> +references.  However, the output of this command is meant to be used

Small suggestion here:

Takes a range of commits, and replays them onto a new location.  Does
neither touch the working tree nor index, and does not update any
references.
