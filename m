Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38E102022A
	for <e@80x24.org>; Wed, 26 Oct 2016 22:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933396AbcJZWmm (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 18:42:42 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33072 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754883AbcJZWmY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 18:42:24 -0400
Received: by mail-pf0-f180.google.com with SMTP id 197so4313799pfu.0
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 15:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=QdvkTjJ31mmuZx6X6Pq2koBc78Wms1q1vfHR0f5A6Vs=;
        b=XA6a5go0mvNBQ1/d6clkLdI+PQMc5lPaKi7u6ogqFImICdz1SPMfyrO3LbznKKVj5o
         zGa4uQdDpC6grS49ToY4lNtt/Bgh39tC78TNPdAuPwhXlsCcdFcmOkroGCW788oLi3J6
         oePl5+G1F6BwWLZ8MGsI59U5vKoF9e/VvKLAWbrU4sPJt56QYXOLcKhYmcXE8wNDpZPt
         wbdrg3nSNISlRelBKNLxFd3t0wvvY4JWjgdhXkBNXDruhvdy3K6ak8JtxUavoXn7xTFu
         oboxNewZ1VdgNGHNfXTVoLjM8wNKgV2mNTTwGcTdyLfyRbVy+A1xr+2Rh6XvGzxY0nW0
         RIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=QdvkTjJ31mmuZx6X6Pq2koBc78Wms1q1vfHR0f5A6Vs=;
        b=RKZSRXYl4P2moZ1iX0KMllSSjg/xD+oowtRLidlv9fq1CgclZvhUWMzKh0IeIgZGZi
         DX6duOhdkHoDeBHUkqLJxjdb3WE1pvKJ6O2u7Vni77JNOCr19/iOIBK/wkg9iNJFGT7W
         vc0yRFXxBIhs+edrZ+LemKfb1s5gjmX0b3kZ9cuaqdEV83zVw+KFqwjRHUhlMvkLfLiN
         lS35YYwV5Bu7Uui+HPyG375Fs52EzkdAslwWXqAUvH8bsT4zoZ4RW7KuWgoNL9yV1CJ8
         /2YazWN3lk6sTWPdDH2NiBhCCh+emRuI3vdk0LZEo6jhCbas+Qb2BEh0YvDY44NflL2b
         YMtQ==
X-Gm-Message-State: ABUngvegumje2F6CUrkPJPQzZc6RFIwwS+lE7UeoM6GN6q+LPgXjA5kLyuPoqNcwD9T6tcMC
X-Received: by 10.99.122.87 with SMTP id j23mr6859427pgn.134.1477521743921;
        Wed, 26 Oct 2016 15:42:23 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:c1de:fe8a:cd48:938d])
        by smtp.gmail.com with ESMTPSA id z87sm6424689pfk.67.2016.10.26.15.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Oct 2016 15:42:22 -0700 (PDT)
Subject: Re: What's cooking in git.git (Oct 2016, #07; Wed, 26)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq4m3ybv7h.fsf@gitster.mtv.corp.google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Cc:     Stefan Beller <sbeller@google.com>
Message-ID: <50f4e0b0-c044-be57-4e08-08d9970fe4a4@google.com>
Date:   Wed, 26 Oct 2016 15:42:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq4m3ybv7h.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/26/2016 03:29 PM, Junio C Hamano wrote:
> * jt/trailer-with-cruft (2016-10-21) 8 commits
>  - trailer: support values folded to multiple lines
>  - trailer: forbid leading whitespace in trailers
>  - trailer: allow non-trailers in trailer block
>  - trailer: clarify failure modes in parse_trailer
>  - trailer: make args have their own struct
>  - trailer: streamline trailer item create and add
>  - trailer: use list.h for doubly-linked list
>  - trailer: improve const correctness
>
>  Update "interpret-trailers" machinery and teaches it that people in
>  real world write all sorts of crufts in the "trailer" that was
>  originally designed to have the neat-o "Mail-Header: like thing"
>  and nothing else.
>
>  Waiting for review.

For this patch set, should I look for another reviewer? In the e-mail 
thread [1], you and Stefan seemed positive about this patch set.

(I've also checked [2] that this is not merged yet.)

[1] <cover.1477072247.git.jonathantanmy@google.com>
[2] git log --grep='jt/trailer'
