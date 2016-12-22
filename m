Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94D841FCC7
	for <e@80x24.org>; Thu, 22 Dec 2016 23:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966343AbcLVXVo (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 18:21:44 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35690 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759682AbcLVXVn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 18:21:43 -0500
Received: by mail-wm0-f68.google.com with SMTP id l2so13162665wml.2
        for <git@vger.kernel.org>; Thu, 22 Dec 2016 15:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=2hU0JqTFaw9sKRdZrVGZkKmGE1QPTuDgqgz93TMbGz4=;
        b=FKyviW73JeifYdkf4+XVcAE1pnWEOPbN5Sh0eQ/tmIE+gkZEf3Ogm23xSBvKHh6VWd
         /ye4KRw5Wxhj9pXcR62FSsM3+KWEyQh4EiDolMsHYGSKFAjzpx96bGNmmnr9e66L6gCA
         prlYKMv1Ux712auMuQDAsZuAxTCTcylAm9KqU+nJDuIGXIdu+YIKaCOwj0R+d8UNJkEM
         uL8wrEyoWwtiIyDyBSi5Si1EI0/z8dowzWTJ74P5bsI/QeoAwHn5PcB0ONw+PIaTHW/P
         pRoW3tt/h6slakrvPpG6shk4JF/RSAMhnSpDv72cJap7LOngvgsjWZhexkhXlITjQNre
         t+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=2hU0JqTFaw9sKRdZrVGZkKmGE1QPTuDgqgz93TMbGz4=;
        b=nA4SLvJVSHhbR3ka1TnXFRZ83yeuy4bKvtDFULPXMPohKNzMGQZUH8SIW/hFKNT/Gf
         M5ywr24xkKYF/wpsf1UACcNq9S7six4AYDpKYzKfvf3P99ORsgRtVgRchu0+TyVCoJDD
         kx96qG5+yWzeC+XN3/aqEOw7C+xFKzOE8BPo1Y7dFeJWYo/VM0ndcMy/gEkWl1je5EIT
         hUjPb0NIBwZJ9I/6CnibG52xQAcHFEEVv4kGsSQUz91uYBpVjo8O/tn259rDc4YV/+tU
         mTIhK/+Zu9TWF92oyEGuDFheU9Yf/ZtqsI9vwgjr4SJngvY0iJg1gxQbWbrEuUUqZWvH
         HZdQ==
X-Gm-Message-State: AIkVDXKj4BrbN/P3j6HmosamY7QOtb3A4lfAp7A/GVJIms3QvY2hpIEaIqdQGdxqtKvHAA==
X-Received: by 10.28.104.213 with SMTP id d204mr13051632wmc.101.1482448901475;
        Thu, 22 Dec 2016 15:21:41 -0800 (PST)
Received: from [192.168.178.20] (p508BFAB0.dip0.t-ipconnect.de. [80.139.250.176])
        by smtp.gmail.com with ESMTPSA id s20sm10583456wmb.9.2016.12.22.15.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Dec 2016 15:21:40 -0800 (PST)
Subject: Re: Feature request: git rebase --no-edit --continue
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <6ff2c5a3-fe81-0bec-ad9a-d62bdb4a176f@gmail.com>
 <alpine.DEB.2.20.1612230006530.155951@virtualbox>
Cc:     git@vger.kernel.org
From:   Daniel Chumak <chumak.daniel.dev@gmail.com>
Message-ID: <78a45ce4-a0c0-9a45-70fa-6c1bd9eb99dd@gmail.com>
Date:   Fri, 23 Dec 2016 00:22:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1612230006530.155951@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uff, I forgot about the CC of my last reply.
>
> Why not
>
> 	git commit -C HEAD && git rebase --continue
>
> ?
>
> Ciao,
> Johannes
Thanks this is a cleaner solution. I guess because I was too fixed upon 
knowing of the existence of the no-edit option from other git commands 
that I forget about this, even though I am using it quite often.
