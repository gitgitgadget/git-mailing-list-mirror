Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD0B22022D
	for <e@80x24.org>; Thu, 23 Feb 2017 21:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbdBWVWA (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 16:22:00 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35138 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbdBWVV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 16:21:59 -0500
Received: by mail-lf0-f50.google.com with SMTP id z127so1503746lfa.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 13:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=9+FHtSxyhe1YEm+fF9qg/MDeNYP6uV0F4pLY8wV4jmw=;
        b=uIpB1MIT1OSaaYbyyI98KZ2NahfMWp9J+ug2pZByYyG0sdZE8UzNpVZtxEUUZjIrJy
         UwCvM65qFdOnhwmIRUHcQa1bFqH9FrHU//uvD1l2s2YCIBkOtfa10iMcnHrlPlIQbKB/
         RKlUxp/dihVNXasyJ644ixEQI3FjfuMyQ/Ksa/McZ/r6zPOEQIpocVGCmFQ39rYGS7wX
         /ZdY5ms1sYCM/zkF5O0lcoDqS1YX3345bH/KSWO1Da8Fmy36cLSqyRHeJe5Rx1vzrDL4
         fN1avXYxm3ygzE0fbErI8rhDfhMC0hcZH1olDBRtnk5AUfx9JqGTrp5qNvvgD5ZeHcwI
         U/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=9+FHtSxyhe1YEm+fF9qg/MDeNYP6uV0F4pLY8wV4jmw=;
        b=gB8ryb1PZT0ROf2WA3dsDk29OVEWmzBDrsFs3hoamTGeoNNw7M3YxQDgxF9Ut3cBfl
         eglug/TzYq4QVupLvjhr0QIJkEu6NTeRLQwdnaeiO8tyxQkgtTq6PiQbRq0G3r1bs8pS
         Ug3LW8MRogVKXUD34a2IrK+1zEAem4w0uSs7pUnXDLBqHF6Ue/Z6LTGKvHEiAQQtRf7c
         kVrzg4Ox+wBw6f9aQLE66LUJQTbEIJxvw/olgeKHoIAyAD41TI/tTWzRv1DyEcsLtySI
         XU2ofh/YCDoajdizwCMyuAcPaeQDjvnddtv0AFnq7STcNgnIB2moTn/RTOpPOxcI+/ru
         V55g==
X-Gm-Message-State: AMke39nZ2Dd5KAyxju4XcZ6BqvtOLnMMcA6bvaMuvb4nXjq6Ug1XtvpG+X1eJgSPS2U4JQ==
X-Received: by 10.46.84.84 with SMTP id y20mr10999390ljd.94.1487884852778;
        Thu, 23 Feb 2017 13:20:52 -0800 (PST)
Received: from [192.168.1.26] (elt110.neoplus.adsl.tpnet.pl. [83.21.213.110])
        by smtp.googlemail.com with ESMTPSA id 13sm8360625ljb.57.2017.02.23.13.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2017 13:20:51 -0800 (PST)
Subject: Re: SHAttered (the first practical SHA1 attack)
To:     Santiago Torres <santiago@nyu.edu>, Git <git@vger.kernel.org>
References: <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <50935d5f-9d73-9f76-32d6-0e9d053274b6@gmail.com>
Date:   Thu, 23 Feb 2017 22:20:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 23.02.2017 o 16:50, Santiago Torres pisze:
> Hello all,
> 
> I ran into this website presenting the "first practical attack on
> sha1"[1]. I don't recall seeing this on the ML, so I'm sharing this just
> in case. I know there are proposals to move out of sha1 already. I
> wonder if this affects the timeline for their adoption?
> 
> Thanks,
> -Santiago.
> 
> [1] https://shattered.io/

This is already being discussed in "SHA1 collisions found"[1]
thread.  Let's do the discussion there.

[1] https://public-inbox.org/git/xmqqk28g92h7.fsf@gitster.mtv.corp.google.com
-- 
Jakub Narębski
 

