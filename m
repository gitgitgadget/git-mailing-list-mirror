Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F92C1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 11:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeKCU6M (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 16:58:12 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:46105 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeKCU6M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 16:58:12 -0400
Received: by mail-wr1-f54.google.com with SMTP id 74-v6so4495387wrb.13
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7aowrgmDUUBdBjDOPXh/RDpdm2KxlLTe6FE4kwrwBBg=;
        b=q6SaC62B22IF6rO0zF6dfvsdmugZnNxE7U+3HkQSaooOzR/9tOiKWMutWBDbQF2+lw
         b+RxQzflSf3r+2pvDTno94BaIEziwbqep+G5C8KU3b3PjwCjMxTQj9KcROwFHIrSSnxy
         e5KaB6gYJPRtTqnNAvFPi/D/ONC5Hc1oZpesxqnvcEpFzmKboYeFk///bEB99EdYezp/
         sYS3DQEMQRY2IwooBzJgwM8wkfdzzjHl4kbOj6gOxgxlEGYPdCRxig6sNe70cEbzQeWs
         OBPPCt7eZFjvBLR32TiwyUcgwylLl3BB7NvMFKU9a1VKYCwj3F2S7i2oLFVug+MkWU+q
         Aoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7aowrgmDUUBdBjDOPXh/RDpdm2KxlLTe6FE4kwrwBBg=;
        b=dlPJoG+zkCMd0/uHuzv595nOjt3P0Zguit9/XGgZJaHwjhbO3bp5psESHOi8XEamx2
         biUVHoNSh4qDA1V1jlIQH2LPxw0AK2YM6BxrLSGEnG+zVvR8J9lKFPd23xTf31R1/u1I
         nN6dsRZVmLuG74CdhWTrlggxwWsnWyNrI1uuE/DljjZXSxgZ+aqXF+P8/m+G/Z+J+MpR
         ltujCc4ButFfdH8SO/3kcss7m9a3POLQfUjTN3OUg0CQT21NJ5qozm0uxAYJIhuMtse6
         /mjFpuslq1LLgBlJf8I2WWcED1Dkmyv9xBReJ1kCIRqABYFPcuLohdt3QMUdvzkkrKtm
         LXUQ==
X-Gm-Message-State: AGRZ1gL1xm3qnzbF0u+Ag8hnbLJ/DIMtgDPXC5bZTW1tq9V/4gWYzmz8
        ujxAOli/lKqbLeDk+PBxT5LeabC3
X-Google-Smtp-Source: AJdET5doJfciOb1mug5+qljqvdcHD5WEEMrtZmiFo2ruDDLF8/bP2+/OEdANe86ALs28bvm6pmT0rw==
X-Received: by 2002:adf:92a6:: with SMTP id 35-v6mr13907561wrn.137.1541245627955;
        Sat, 03 Nov 2018 04:47:07 -0700 (PDT)
Received: from szeder.dev (x4db2c91c.dyn.telefonica.de. [77.178.201.28])
        by smtp.gmail.com with ESMTPSA id w11-v6sm9311979wrr.96.2018.11.03.04.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 04:47:06 -0700 (PDT)
Date:   Sat, 3 Nov 2018 12:47:04 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Friday, Nov 2)
Message-ID: <20181103114704.GZ30222@szeder.dev>
References: <784741be-6045-12bb-75b9-0df6f4c612b7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <784741be-6045-12bb-75b9-0df6f4c612b7@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 02, 2018 at 10:16:48PM -0400, Derrick Stolee wrote:
> Here is the coverage report for today. Some builds were timing out, so I
> removed the tests with number 9000 or more from the build [1]. Hopefully
> this is a temporary measure.

I think it's the Azure CI patch series, see:

https://public-inbox.org/git/20181017232952.GT19800@szeder.dev/
https://public-inbox.org/git/20181021112053.GC30222@szeder.dev/

