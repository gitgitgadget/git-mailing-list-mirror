Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 455FE201A8
	for <e@80x24.org>; Fri, 17 Feb 2017 01:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754774AbdBQBQ4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 20:16:56 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34588 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754330AbdBQBQz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 20:16:55 -0500
Received: by mail-pg0-f68.google.com with SMTP id v184so3371822pgv.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 17:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=f75dHWh2ejzyT7fPwM/CvzZUBICfBQRChO6QAwFwt08=;
        b=Mxn56GsJj+ZLsqseHTsrmmVqhbFLb3qiH6z3prcai68hEQyNQUCzgK/dpgBcc+LI4p
         kmemK3EIvdIb5BkmkbPvt+lfh0p/VLfGhxGSoAYnBn3LKWTjVxFyg9EDgtEeQhBm6MYQ
         H3LwNeIRSciswDqr1CL0QOLGm1LEqoai3FEm0NvPxqxS5eLkcqp4dGV9+khX/tIbGNEK
         yl87gfR4n/bWqaYibFKLbv6NAuGToHZ5IX4i8IkepfCXL+NihVMGHXb0ft4cuMRGPWcp
         rAL7jsHlG/LlTNDeBdgwJv4/bi5IHdwe1Ks+LCuKKHidAX8OZGO2PiAVyT0uGHQIFY//
         hHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=f75dHWh2ejzyT7fPwM/CvzZUBICfBQRChO6QAwFwt08=;
        b=mPLH1Pcky/fXA8J8ARjmIjmlrnREH4uigKTius186AFH0nZvnR6wKrSPC7srRLc46o
         NDXu6X34qRv/p74p66pjEgjZ7nl4ZLYaTwsTpNFHYmaXoj7ijOUwtZ+NtQrQun+G2Z1Q
         mrKNWJFWnLdqomO2pi0ale+1nUCRr63Kkyb+/CU1zwSSh+qOK8EgaBy0UpG9zNirlS2o
         sFFpjZs3AWOwGBWpxf+TfNaPJ+xgbaqdAISVmvSBCEauNMKjD4A6IQOICve+SEtGPWSd
         Pok+qox/VYOoErYyvksel+jUAp0xyRVYGi7zEGaT3bWSSmYe65U8gQaQpcwAPFny4i6l
         I5jQ==
X-Gm-Message-State: AMke39nHvS8FFJ+iQKuwshklC5C06sX+ES9lgsWddOgxBZFmBI1qtoJ3an8TPtxXtXTzng==
X-Received: by 10.99.67.6 with SMTP id q6mr6673176pga.156.1487294214599;
        Thu, 16 Feb 2017 17:16:54 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id u14sm15750597pfg.18.2017.02.16.17.16.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 17:16:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     MM <franchesko.salias.hudro.pedros@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com
Subject: Re: [PATCH V2 0/2] Fix l10n
References: <20170216170713.10065-1-franchesko.salias.hudro.pedros@gmail.com>
        <xmqq8tp5vhgk.fsf@gitster.mtv.corp.google.com>
        <1487288237.25073.1.camel@gmail.com>
Date:   Thu, 16 Feb 2017 17:16:53 -0800
In-Reply-To: <1487288237.25073.1.camel@gmail.com> (Unknown's message of "Fri,
        17 Feb 2017 02:37:17 +0300")
Message-ID: <xmqq4lztvcoq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unknown <franchesko.salias.hudro.pedros@gmail.com> writes:

> В Чт, 16/02/2017 в 15:33 -0800, Junio C Hamano пишет:
>> 
>> Thanks.  Queued with minor log message fixes and pushed out.
>
> If is not too late, please check the version 3.

I already squashed in the change s/bufp/buf/ in the version I queued
and pushed out on 'pu', so we should be good.  I compared the result
of applying your updated patches and did not see any other changes.

Thanks.
