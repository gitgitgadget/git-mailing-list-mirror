Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,BODY_SINGLE_WORD,
	DKIM_SIGNED,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D9820401
	for <e@80x24.org>; Thu, 15 Jun 2017 21:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750830AbdFOVPK (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 17:15:10 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33961 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdFOVPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 17:15:09 -0400
Received: by mail-pg0-f45.google.com with SMTP id v18so11735408pgb.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 14:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B7d8ySsjr4QTi1Xl0oTp13tAc0DvFi67hqDNlHpCELI=;
        b=jNy/DDvF7q/he0CrHRmpB0BX/zkWDG/dU1LP03+eFuBoEafwZ1poiKU0fueK07zDH+
         tIe5JG2rv7pDfoBwHFV0WLmhJAeBOfnSMlFkof9TwrxsffwlGn6fTwkVwlQy0Is3KdtQ
         wBkYbuiGpRkEmr3U+oQmJ1Y0VZ/ytOm1iHCNFkRMH6zsEi8QJGMQfmiQ8YB+b4OjYFNT
         asrybZDtmOtFUSGAVG62QeRoU5eBdCpy/nI86TZGyoG6UUN/u4swH8SjdE+tHUybmUgo
         ZVwvSaBJAx3e9pdSNHhXnUfsJLIptXWAhj7TPAeeHVZqEHY4umRY3L101xLLZ8D9lq9L
         eyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B7d8ySsjr4QTi1Xl0oTp13tAc0DvFi67hqDNlHpCELI=;
        b=NZNbZ4hp309LT/aLCfKs+nYbXZ9/cRRS3Mi+UteYoofiKwGOx37mCkWCp6u8pZAFv0
         S2takZwXLRLGZmjwnKKShtUtpYCl0iOD4bRzrIcRTd4nU/LI8ZT4FamGVMfWrFDPjUhx
         RRMbu7HNCwZwZLq9xYj2RPPGgtTeU6NvP9m5BZzKp6BVnLQ5m1IWnswWdtarWXmJYX+e
         U1Tc4HsMQwlkfZVK7Wb+F2ZcE1d3ZQk4liThrPbdA4EHwDCVcl7lqa+oZH8+PH4WePs/
         vxhlaOVl4eDDqIYn4MHkfT7QLI5fdvjXzpoD2hSAt/XAP7cq+i59rjsQl5Jsv62qkL8J
         AR6g==
X-Gm-Message-State: AKS2vOycI55yiuAjAA0k7NLaqGucmJI5YtwEkugCAfZmt9yxQ0IVAW97
        UpRrYw3ik4fzRQ==
X-Received: by 10.99.0.209 with SMTP id 200mr7354787pga.208.1497561309088;
        Thu, 15 Jun 2017 14:15:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id z71sm383745pfd.45.2017.06.15.14.15.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 14:15:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-svn: document special options for commit-diff
References: <20170614093138.11861-1-asheiduk@gmail.com>
        <20170615012130.GA4829@starla>
Date:   Thu, 15 Jun 2017 14:15:07 -0700
In-Reply-To: <20170615012130.GA4829@starla> (Eric Wong's message of "Thu, 15
        Jun 2017 01:21:30 +0000")
Message-ID: <xmqqr2ylymuc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.
