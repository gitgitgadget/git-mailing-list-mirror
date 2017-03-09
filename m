Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90E89202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbdCIWFA (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:05:00 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35620 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdCIWE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:04:59 -0500
Received: by mail-pg0-f44.google.com with SMTP id b129so31057416pgc.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 14:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KRg9YxBzPdtLkjwzRLX7EeFOc179Td/tvsTPbU4QS5U=;
        b=klaHQ+E3J/apV0YQEHO4GqR3G/p7eS/iCErZfTbImARorlykol/2leV1Umbs8JZpQx
         mMv7gkParfjG10ku4UJIX/6O1zl9dmIMfCe+VlpdS7URty5M7QlAvfbITNRio1KZOcej
         TzTORbYB1o5qmg+s2G1AHJYZFOQJLmFp3f2906uJGw0ALfLUgxfoBcwn9RS9o1j3rbZb
         OFW3o17W3h+GtQ7dwFZiDRQIonDVBApGfbd5O8TNImwisJ5iGi47R8l8IGQs5yWJV3em
         tWyOY7y6fEc90ONqAT6nleT0rhQGOiTUxogQ5q+4akWh6fC59lch/pBHFAcM0wZyVO01
         7/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KRg9YxBzPdtLkjwzRLX7EeFOc179Td/tvsTPbU4QS5U=;
        b=qrMzE8JT+ZvamdKgpx3dN/HF/cGsRdOvoQuU7Tv1vbwR842JeKpAlIEYd7sWRMu6XY
         TYosoN8EDeq8nvpiMmLbBBR0Ykrrdc8S9Qatb2G0WIt6PsNukWY34ztDQdd9gRj4ygwA
         h0YTG48rczXk5qV8yJJuWclFIkp9fq7rNzHd1Ekl1x/9X5WSS70h9RKpKKHzoE5ruqGb
         6nUh4Rkgin6McdHLAWu4yZfsC1M0LYHyJdkp/sN4hHeLVdHiYDRxQAjWD3ZteirlbL/Y
         RYRJCfBJINmf0xPolCXMbWvjNhf5+KSCH+Nr25q5RL2xt29j45/jQ3u83lXG5pmH7sxc
         2CmQ==
X-Gm-Message-State: AMke39n8Z36zhD9n9saCPR9oZAAC6qeMJ36rVFbz+oa/XUHFZO11DeisvJRL27DtvJW/D0LC
X-Received: by 10.99.54.140 with SMTP id d134mr16090798pga.91.1489097097967;
        Thu, 09 Mar 2017 14:04:57 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:24ad:64a3:afd2:c7bd])
        by smtp.gmail.com with ESMTPSA id u69sm14267677pfg.121.2017.03.09.14.04.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 14:04:56 -0800 (PST)
Date:   Thu, 9 Mar 2017 14:04:55 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Valery Tolstov <me@vtolstov.org>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC] Git patch flow
Message-ID: <20170309220455.GB52558@google.com>
References: <1489096859.3286.1@smtp.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489096859.3286.1@smtp.yandex.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/10, Valery Tolstov wrote:
> In Documentation/SubmittingPatches it is said:
> 
> > (4) The list forms consensus that the last round of your patch is
> > good. Send it to the maintainer and cc the list.
> 
> https://public-inbox.org/git/20170309181837.GF153031@google.com/T/
> 
> I assume that my patch is at stage 4 now. Now I need to do what is
> in p.4 said exactly, right? Asking this question because can't find
> good examples in mailing list archive.
> 
> Thanks,
>  Valery Tolstov
> 

Watch for the maintainer to send out a "What's cooking" email to the
list.  If you search the archive you'll find many such emails.  In the
"What's cooking" email you can see if your patch has been picked up by
the maintainer and what the status of the patch is (if it needs more
discussion, if it has been moved to next, or graduated to master, etc.)

-- 
Brandon Williams
