Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAC291F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 19:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbcJKTyZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 15:54:25 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35473 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbcJKTyY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 15:54:24 -0400
Received: by mail-lf0-f49.google.com with SMTP id l131so22642900lfl.2
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 12:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=L+ntNZOfVn9raMKqy6kgUgr+wY7q7j2PJR5Lxk0VwN0=;
        b=WoRC8vMmkSa0gRiRv/6tFnQh1uochBmYTgM7eGYtSZZP358FDPX6Kj6rUQFX0ekiry
         PxKGoPyukx8RtAXkn6sQUkl74l5NFaDclv/9GJIfYVE1CZQlmJ2OaqPFb+RgrlbBPQZ9
         xmDrlJI9o3Cq6HPMY6/s9lJ44d7G1dFCTIyoqweN18FI9aWn44b7wCXVwpPxyxRS52Tt
         y0rJpChu6D2a1MU73DbL7AaZ/UVKGogAXgG9oQsmqm4IHy49vlYzBj6iwWgeb3MPkJiW
         kXFDisdLr69dQl7qDAu9DVToL7ksKtTBEaWeOilE40g0KHDfBEoeMChd56aFQyF328Is
         GM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=L+ntNZOfVn9raMKqy6kgUgr+wY7q7j2PJR5Lxk0VwN0=;
        b=KpJCKUOKQ6jYaSmW93QJQUwoElL00Qa/nP2nVQNdzyQFr7yUkTNWlQGUNuetwCzGGn
         258jN7ugrtYDw87SEeUNvE+9gqR0M3P8b81BnEKHKHLevQ/Sk8CRXbj9RP6TyVVcqRYy
         0sbD9bOKz3x9bDj3zMgOEG3OFYbo6S39xEzBCePgxd0grcRomItTHsrLNGs01twvgPqC
         vqlTuCb4ebgFNZf3b5xONqyD9DcJRj/cYMnTlptwtkMon9lpUBZeJdOO6qLUxM7YTHAN
         KMpOYEDWVR85Sqivg8X3me6GhW4W8O6uJjFTmyGG0WAEI1Hi/1RzCD40ylqGL+oh1zAV
         JZRg==
X-Gm-Message-State: AA6/9RnHgiKOowqPya9zmN82JHqy6Zgs0D3ffYjwmC/OvHyycTCxEyF469Cx+hur7/uZ7A==
X-Received: by 10.25.210.5 with SMTP id j5mr4003372lfg.14.1476215314439;
        Tue, 11 Oct 2016 12:48:34 -0700 (PDT)
Received: from [192.168.1.71] (78-60-211-195.static.zebra.lt. [78.60.211.195])
        by smtp.gmail.com with ESMTPSA id h73sm1453035lji.28.2016.10.11.12.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Oct 2016 12:48:32 -0700 (PDT)
Subject: Re: [PATCH] contrib: add credential helper for libsecret
To:     Junio C Hamano <gitster@pobox.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
References: <20161009123417.147239-1-grawity@gmail.com>
 <1476198080.3876.8.camel@kaarsemaker.net>
 <xmqqoa2q8ypl.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Mantas_Mikul=c4=97nas?= <grawity@gmail.com>
Message-ID: <c87e4dd4-7253-d7c2-010b-6d8c7f587093@gmail.com>
Date:   Tue, 11 Oct 2016 22:48:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqoa2q8ypl.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2016-10-11 22:36, Junio C Hamano wrote:
> Thanks for a review.  I'll wait until one of (1) a squashable patch
> to address the "we do not want unconditional overwrite" issue, (2) a
> reroll from Mantas to do the same, or (3) a counter-argument from
> somebody to explain why unconditional overwrite is a good idea here
> (but not in the original) appears.

I overlooked that. I can write a patch, but it shouldn't make any
difference in practice – if c->username *was* set, then it would also
get added to the search attribute list, therefore the search couldn't
possibly return any results with a different username anyway.

-- 
Mantas Mikulėnas <grawity@gmail.com>
