Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D49BF1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 17:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932492AbdBPRKx (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 12:10:53 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36150 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932193AbdBPRKw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 12:10:52 -0500
Received: by mail-pf0-f171.google.com with SMTP id 189so6901470pfu.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 09:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=K25zXFLuw8eHVbpnwlmfvGV7xHhk7XC1LVOUKiUIugg=;
        b=EqLEVfOfZfp+eVxfSvvJsYbVE/l0eypLL+r/ObPulFwegOCQrU5vNB1fNES3GrKn8P
         6OLmQubbAE3mPMHS4vKbYXXOCQ4T/nbqBN56M9l4G6EbBNCxSO7SXX4emqrKEDfUGQ4U
         gTg09JdfcqkFbseXsj17ooWH8aOIpF/bteTLHpA4ZNB/DkPtYwOaXiHb12fbqHhvidSi
         Rj6POIp8bi9razG5Xlw2W45M1Bh+awWf6guZ5e1/p1aeaD6vXnhcPsooe53C68QC8nrO
         aw7/1WZwlvgaqqEN2NTxVVbfYUVgcK2Z5mz6L2/kgMbVAr0VTVGWl+tLPvCGbOe4oZ4M
         iUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=K25zXFLuw8eHVbpnwlmfvGV7xHhk7XC1LVOUKiUIugg=;
        b=Xjzl5XtrWoxTrb1ttQ1ObSi1SXsjbKG4GrFTqLFBBM3KGEdkwYjDgMN/R1daNlCOKK
         Ujn9Dwft09gcU8DNxZCp1/IVb0t/iM1Q2M8uQjSXTC5S6lwavgjZ/PSzBl9iEiy2+W+H
         /qyA1p5h+QnIOYEL+yAuwRiXVXidmVpt2SC0Ll0ltwbXkjuyHV6amzn4exhqHZOlKo9W
         4RHtILsi1JGeCv5p3o7NyRgc6L6G2bd74STwqSDaFXw6WX3VQ8tsXalev2haMiePU9DK
         YgmlXICQAkABm2lauOm3Ms3FANihoKYuCKYXQ7GpbxVqqmQRyShUJVjuLMQnQIYMl99o
         P0Sw==
X-Gm-Message-State: AMke39m2axpYsaTheAXPTq/Y6R9Vn0rMBPlje1Dcyom5DPiCVvUloC61o2WQIlqjzhn4QQ==
X-Received: by 10.99.178.89 with SMTP id t25mr4046419pgo.183.1487265051697;
        Thu, 16 Feb 2017 09:10:51 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id q19sm14798641pfl.21.2017.02.16.09.10.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 09:10:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2017, #04; Tue, 14)
References: <xmqq60kc750b.fsf@gitster.mtv.corp.google.com>
        <df42ec26-d1b1-e31b-b16d-554441a335f0@web.de>
Date:   Thu, 16 Feb 2017 09:10:50 -0800
Message-ID: <xmqqa89mysbp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 14.02.2017 um 23:59 schrieb Junio C Hamano:
>> * rs/ls-files-partial-optim (2017-02-13) 2 commits
>>  - ls-files: move only kept cache entries in prune_cache()
>>  - ls-files: pass prefix length explicitly to prune_cache()
>>
>>  "ls-files" run with pathspec has been micro-optimized to avoid one
>>  extra call to memmove().
>
> Nit: The number of memmove(3) calls stays the same, but the number of
> bytes that are moved is reduced.

Blush X-< you are right of course.  Will fix to say "... to avoid
having to memmove(3) unnecessary bytes."

Thanks.
