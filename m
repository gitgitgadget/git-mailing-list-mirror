Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D6B2047F
	for <e@80x24.org>; Wed, 27 Sep 2017 19:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbdI0TxQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 15:53:16 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:55505 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbdI0TxO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 15:53:14 -0400
Received: by mail-pf0-f170.google.com with SMTP id r71so7766431pfe.12
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 12:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=np8uI/OXzddBFUgyVp6VirHjEG3sD2X5c9NRmWRfTqs=;
        b=d1G+assztBcbk/Y1Wg7TtlSCbiXjfZgA7s5yBJaynB/ZJZ+DrWJN7JLPN6g2ji5+f0
         kUsKuf8a0HlqU+3Z+kUWYPhQU4+FkIAM2M2NrNLugyArqpI1qxWQqpxqDoo7lZR1qJEO
         vIpEPJTkv538mhRb27VRfeS0uba+E5lDyDU+HktjmOHRF+Bc/+wz7LGvKAHcZZgtdmzI
         tByIyvzOeCXtBHHngGQre7GbdyK33nBLVGiXelOvPdC506dEVw3GEtifcS1mcaJilep6
         GlgAyJAdSJ96DN6oqmK5Vhzx/uS3A6fyrA4UMhp/d6pVgLz2jx5jr0O7m/BASq45HZKg
         BWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=np8uI/OXzddBFUgyVp6VirHjEG3sD2X5c9NRmWRfTqs=;
        b=s8v/S9AnayZDWwvbbn9y45Uqe5ExVk7kBD5FOdT9sylrf6eiM5VS/IDFj/2n4vrc2Q
         Vjs49cu7Os/m4CPkxxGvmOnu7s4DHAS14pc0RZmeGRJIN9WJDXaMzYo5quw5J57/T/d7
         grnQ4VEN+d/E4FexVxxA/SCnycNdtCARzlM9oUkrTVGZA6bcUNf3qQwk8Fb/fLh7PV9r
         QX3d3i+1tEY/Xn+ir6lrjkzRVMqHGF5JuShjWyStj8QY1fCxRT5Oygs/0zfubRFh4l7J
         0xEH+kdlm2vwot8Wd5tvJvMUK/da2rtdsHWMQGb3VX/C6dQk1EIwAjd5OvZdb6zukPs/
         0MUw==
X-Gm-Message-State: AHPjjUgw7S5qf7Cgu5QBbobX9Lr66yKvmjlnXGKm/RuOKmvX7wHmgCk8
        k51iRCWamQraVV1wFgVpTHU=
X-Google-Smtp-Source: AOwi7QD1DZxySr7PpM43ioLfc5Lsp9lRWVQOpFBpFHFdCtBdTOgeug5ojaR99VSW1Cq2YftP+g2l4w==
X-Received: by 10.99.111.194 with SMTP id k185mr2276351pgc.424.1506541993394;
        Wed, 27 Sep 2017 12:53:13 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:1558:8bd:d6aa:64f8])
        by smtp.gmail.com with ESMTPSA id i84sm21880169pfj.105.2017.09.27.12.53.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 12:53:12 -0700 (PDT)
Date:   Wed, 27 Sep 2017 12:53:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
Message-ID: <20170927195310.GF19555@aiede.mtv.corp.google.com>
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
 <20170927170716.slqxje2tkh5ws5ak@sigill.intra.peff.net>
 <38D148EC-B77D-426E-A7E0-128509590407@gmail.com>
 <20170927180127.khwqwmv74tsji5im@sigill.intra.peff.net>
 <20170927195159.GE19555@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170927195159.GE19555@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Jeff King wrote:

>> There aren't a lot of changes to the script between v2.13.2 and v2.14.2.
>> The most plausible culprit is d5addcf522 (add--interactive: handle EOF
>> in prompt_yesno, 2017-06-21), but I'm scratching my head over how that
>> could cause what you're seeing.
>>
>> Are you able to build Git from source and bisect the problem? It would
>> help to know which commit introduced the problem.
>
> How about this change?
>
>  commit 136c8c8b8fa39f1315713248473dececf20f8fe7
>  Author: Jeff King <peff@peff.net>
>  Date:   Thu Jul 13 11:07:03 2017 -0400
>
>      color: check color.ui in git_default_config()

Uh, I think I was thinking of another thread when I wrote this.  Sorry
for the nonsense.

> Toni, what is the output of "git config -l"?

I'm still curious about this.

Thanks,
Jonathan
