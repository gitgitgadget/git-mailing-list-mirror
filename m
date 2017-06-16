Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 773741FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 12:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753554AbdFPMr4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 08:47:56 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36649 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753782AbdFPMrx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 08:47:53 -0400
Received: by mail-it0-f66.google.com with SMTP id 185so4977983itv.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 05:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wniEyHeCnGJbuywqujpT3D1mARCXo3mOfR9z9kiPpLY=;
        b=nH6KEE34dzp+zXjj0l0u/1E+shV+Dm5sS4Trjp95my5fmcmDLq7Y2mviLHIzH9I26z
         /2F6aBrWR7aVB1VodtcfDBxD5Zvxh89Tf1jnnqdIJN2vTSNG8SN2zTQW4B0+dDvGigQg
         82SRZx65KECD/ed/5ZRWTze45NDSGYhd5kUnikPx/KUFIb3C5H6kzW57OStcC03PPW3B
         vg8EY2ausQ3px1YbAYscXDtS8Cyxz4iynXx0yE7AsQPb9mXqDDfP3XCA3zKtcQfID4jt
         nxFIuyrwH46i8pYcy1pS3ZzNK3YhQIn1wpTb3dttcM6demecDZS+yrxCf2/g9ebxYngG
         jZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wniEyHeCnGJbuywqujpT3D1mARCXo3mOfR9z9kiPpLY=;
        b=WAiFkCdZDnGUysS9LuHgAnTCesTZd1HR9RhvaO/towtdVG8F5U3D/1Iv/JmMvuU5pW
         CUodOofM6xvR6zTjXd5dT4i5m5QvTMzXchElrQcV8PeuzWMbMeU7I7cWSzTw7Jcq99yt
         eMh1+BTw+WWYXYXDM7CGsuz9GUB4WrK3v8s26+o8QYRLgeiYV+Qn+ohwboxkQowc8rRV
         ykWfHvCyqMlI6pfYCceQASDDYfRbSP3lZpdJxaOWtTMDD/RGfGDnoh6QAwVz+VgXOALc
         AnwE5+VZA76bU+Bc4qgiwozrV7r0dAZn3KRxcinLrRsdU457Zf0PdVK0o9etr5CwPUfJ
         PHkw==
X-Gm-Message-State: AKS2vOwfB3zlPqoCGAhQOPiH0hnhxqrjrztPdkBJ0ilaOT1lrBA0B7pI
        1BFSsVC7Hkf/Kw==
X-Received: by 10.36.33.69 with SMTP id e66mr10123661ita.11.1497617272840;
        Fri, 16 Jun 2017 05:47:52 -0700 (PDT)
Received: from [192.168.2.102] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id x29sm1355211ioi.14.2017.06.16.05.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2017 05:47:52 -0700 (PDT)
Subject: Re: [PATCH 0/3] add stash count information to git-status command
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, houstonfortney@gmail.com,
        kostix+git@007spb.ru, sxlijin@gmail.com
References: <20170616043050.29192-1-liambeguin@gmail.com>
 <20170616121642.jqsua5sw2u2iccdf@sigill.intra.peff.net>
From:   Liam Beguin <liambeguin@gmail.com>
Message-ID: <55aed88d-f0ba-0d5a-9dcd-cda137a426b9@gmail.com>
Date:   Fri, 16 Jun 2017 08:47:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170616121642.jqsua5sw2u2iccdf@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, 

On 16/06/17 08:16 AM, Jeff King wrote:
> On Fri, Jun 16, 2017 at 12:30:47AM -0400, Liam Beguin wrote:
> 
>> As discussed here [*1*], this allows `git status` to show the number of
>> entries currently stashed away.
>>
>> I also tried to update the related parts of the documentation to use
>> 'stash entry' instead of 'stash' as we agreed that it was a bit better.
>> I don't mind dropping the documentation update and using something like
>> "You have %d stash/stashes" in the status message if it makes the change
>> "too big".
> 
> I like the overall direction (including the documentation update). I
> noted a few minor problems in the various patches, though.

Thanks for reviewing! I'll try to send an update later today.

> 
> -Peff
> 

 - Liam
