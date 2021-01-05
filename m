Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B80C43332
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 01:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20FA22B2A
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 01:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbhAEBAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 20:00:11 -0500
Received: from mail.aerusso.net ([104.225.219.13]:44108 "EHLO mail.aerusso.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbhAEBAK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 20:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aerusso.net; s=default;
        t=1609808369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HkaiRIvoEssWoUNTWbq5sX3mYG/ySQqrvYRKHaLCVC4=;
        b=X4M/VS2Fi5JRi8y4++l6sHqRu8oqPVC1f5Tuht4e5g4WNb4tB6s5Of7/NFyTTHw5vGGNOc
        Hd635zmw9OlPx+KziPMTwYbe3cL3qNQ8yRjkq8WamSjkDmJ0IlkUvROOI+F1p/BKOgxOZp
        aw0ULgEmlljRfVcSbS6/y7m/u8QhA0LBhbxV6wMMjTRJtjScwK0WpqMpzwLFL8GldmpjMc
        j/OhQD4T0n2KjYEtlAxc3hZw7F9Dc7tWjBgmd/uYql1acC/CtQzBb10HB5ms6WNuYCTpbF
        ZKVQtczISTZkAjUExXSKtfsYKveWj1sVGbp5fS5nQpNzoxg6jpt29gTzWip3gA==
Subject: Re: [PATCH] t6016: move to lib-log-graph.sh framework
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
References: <6dc37f6b-1afd-544d-126e-2be9422571c6@aerusso.net>
 <X/K1BgP8tpsgNe2x@Abhishek-Arch>
From:   Antonio Russo <aerusso@aerusso.net>
Message-ID: <b147caf4-de4c-dc2c-ec3d-6efd611becf5@aerusso.net>
Date:   Mon, 4 Jan 2021 17:59:14 -0700
MIME-Version: 1.0
In-Reply-To: <X/K1BgP8tpsgNe2x@Abhishek-Arch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/3/21 11:26 PM, Abhishek Kumar wrote:
> 
> Glad to see others using `lib-log-graph.sh` as well!
> 
> The changes look alright to me but maybe you could have split the two
> changes into two different commits: Using tags directly instead of
> environment variables and using `check_graph` instead of manually
> `echo`-ing to an expected output and comparing with the actual output.
> 
> Other contributors would have a better idea whether it's truly required
> or not.
> 

Thanks for the feedback!  I can split this patch in two if that's desired.

[snip]

> 
> Thanks
> - Abhishek
> 

Best,
Antonio
