Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CECC20248
	for <e@80x24.org>; Tue,  5 Mar 2019 22:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfCEWh4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 17:37:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40436 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEWh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 17:37:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id h1so6804784pfo.7
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 14:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rYxUi01CFU0Vx040ch9uqvX3GKZInSoHaVK4Kp5Rkz8=;
        b=KfwUAaHRTnt1EKh7sbnZNjyXkFFenFnsDqoWWgESPvpH+dEddh6/gHAF2h0E4QdRdp
         tnK916b3pVMLbWQvvi+jntWplN+MevZ4Tt7XNE8d9xpjN07GXU25yS4521YfbyW/nRa/
         cwr/MUA9epS36h84XGcNg8LlQ6og54srSK5xQQb3rci0SScm4wCZGHh/qVjon+0RjVlj
         Q3DVECblc+k5AUXu4PH7c9iB/PXDHpNwN+N3IFbNIDhVI5dgMiQHckWLZPo8ra5YlfNN
         wSLaOW7FTQi7nmpq5npcye4EILLQTr9Q2THHvjCyIJKE+bsjc6kIkzIq4l4xY+1XwpX5
         VeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rYxUi01CFU0Vx040ch9uqvX3GKZInSoHaVK4Kp5Rkz8=;
        b=T2SNAjcTURKedIGNy4ISzBwd5SmBm/Aev2k4Y23OoghPRNcR1zHCJ66J3SXRAc12QW
         VBLJL9FUvQLVN2c3E4ljudhe576jmMN1TbH7W4bM9oCL+Wl/PqakEbA3LkKTvrgH//+s
         P7tLUDWmPw9kdLZkGifjUH1A7z3tCQNkEfdPICOvUwIiS3S3NCYFttcUx81wmuw1lxqS
         KplTkaWBnJnu7IkfCx1C3RVINJwEXxOyn4NMiueAWHl3/YTQ6nvJPWu4BmNMjuetI1OQ
         2IQFsIywyvIIcjjZ0aWwWlt+bzpsv9Bw+AgqLhZcdTWkKduXtswf3FlmFmIaHKyXml01
         h2RQ==
X-Gm-Message-State: APjAAAUXaewnYA6b92u+k726NLf9ID4eoMySD1+jVYLlACI0jtF2T5up
        xNDio/cVoD2ioXqVdF+2k/c=
X-Google-Smtp-Source: APXvYqxrB1COVBpdLJNk41HNO+h+tIoMUoV/+VML19GFIRuL/fvmHyxmFGVDyBTYbq2d4AzAiiuoyw==
X-Received: by 2002:a65:6546:: with SMTP id a6mr3485685pgw.296.1551825475443;
        Tue, 05 Mar 2019 14:37:55 -0800 (PST)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id f192sm15414pfc.180.2019.03.05.14.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 14:37:54 -0800 (PST)
Date:   Tue, 5 Mar 2019 14:37:53 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-reset.txt: clarify documentation
Message-ID: <20190305223753.GA18006@dev-l>
References: <20190305185423.GA22260@dev-l>
 <xmqqh8cht0mn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8cht0mn.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Mar 06, 2019 at 07:30:40AM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > git-reset.txt contained a missing "a" and "wrt". Fix the missing "a" for
> > correctness and replace "wrt" with "with respect to" so that the
> > documentation is not so cryptic.
> 
> Could you try again without unrelated reflowing of the text?
> 
> Thanks.

Should reflowing the text be done in a separate patch or should it just
not be done at all and just be considered noise?

Thanks,

Denton
