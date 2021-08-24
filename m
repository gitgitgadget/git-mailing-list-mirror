Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9D1C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B04C6128A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbhHXPUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:20:10 -0400
Received: from mout01.posteo.de ([185.67.36.65]:52015 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230341AbhHXPUK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 11:20:10 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 599F1240029
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 17:19:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1629818364; bh=4jtXcgd+RdpfIkHOxBLD9USHa7YhjoF8rx1fyosevas=;
        h=Subject:To:Cc:From:Date:From;
        b=aVdxewyV0OdRisl7ZOhcE2WK2BnGCzhqtr0z8CkBFUpctBV+xiFH4Tl6xkuo5dPi6
         ztRFtbD9/CyG2rDSoS65kzck2dPyKQUmZX+s3Upf0jc2bpxNqgLMMebS1GnFcKkldd
         VX3VXQBWwaiLuWHOCaeE/Ak/rimIr/923YUTN7tPOA7VUtmWBlIhbRe9ym06FUbM/J
         4H6M86MlBUUEwRZUHPSsUaXf6ho+3+MY1wRtFCn8PX01GrPFtlhb/9rIOVANBCVbX/
         1oI3ZCZBNEbUIku3dGzJzMbjD8WxUdgMETjt5QoOi4IjceWPaBS6khrHx6WTJvTvY9
         8ALGFBqp9GfGw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4GvCSq4W3lz6tmQ;
        Tue, 24 Aug 2021 17:19:23 +0200 (CEST)
Subject: Re: [RFC PATCH] send-email: allow fixing the cover letter subject
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     tr@thomasrast.ch
References: <20210824114135.54810-1-carenas@gmail.com>
From:   =?UTF-8?Q?Marvin_H=c3=a4user?= <mhaeuser@posteo.de>
Message-ID: <5a38e420-eea3-a5f2-38c5-64682bd1ba2e@posteo.de>
Date:   Tue, 24 Aug 2021 15:19:23 +0000
MIME-Version: 1.0
In-Reply-To: <20210824114135.54810-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/08/2021 13:41, Carlo Marcelo Arenas Belón wrote:
> @@ -1719,7 +1719,6 @@ sub process_file {
>   	@xh = ();
>   	my $input_format = undef;
>   	my @header = ();
> -	$subject = $initial_subject;

This change from my patch is still controversial, and I'd rather not 
submit the addition if it's immediately removed again.
Why are you dropping it here anyway, does it break any related 
functionality?

Best regards,
Marvin
