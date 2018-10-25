Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0797B1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 01:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeJYJpg (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 05:45:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36269 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeJYJpg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 05:45:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so7480640wrw.3
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 18:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RezpTB2itf5ACh5upIRGrCeocv8Fx5Y8ceXHu+ZiHK0=;
        b=F5xpNH3N2fcqzwc55Q7p0xibvouXT6gzjdwe+oIMO56ZL99lpf08NTG4dcfUy7LQy8
         8lRLcEaritRwDVk4RPKcnkHy16lZW5usA5FAEZ1/EDnEU0rDP2zmdaaA/nNo3uYbQ1CT
         LsWmvyvA7F0/uoaOwYajaeHxEruC/uTk6oYS8/U5JmM7/rJ+tV1ecz46q9wQg7Uz4UaK
         sAakCR1UOWVRciuZ8PaSnIVFSkauz2ltr0Agz13pI0+ru/qSRHU8uHQPqDXSUbSNOTuQ
         /S0BjP9X02nBO29FM6BTNBrwetSOO2Y/tAXxn0vyLRAhgR42dVLAOAOW3rJOqAzGAsV7
         gSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RezpTB2itf5ACh5upIRGrCeocv8Fx5Y8ceXHu+ZiHK0=;
        b=B51LQDYbzLXnmU2ArzIf5JTszi3UbNrqJKN1N49ST7EHISmxlYayQWe3nx0JfDYlQC
         VZgxUqdIhcKlQOBOYLnErqih3pbiWq+j57D3dNpwG+geOYKvIY1mOgxpyeJaz+79mLiw
         SxBgJHb98a5KwS8U5eCMPBQ+8WBt1ZHAWnURF810oubykQTtGz2VqqzhSXmvrCXglhCW
         cuJY3BcTOXbeXMPLuIqK2OPIqV47zpk5jHadXQWjVV+dJnUdN7ux8H9GvYCdkdyXNf7I
         KBjLxZxCRDlAOn2n3JkmUQI+2w6vlC5DWMXhkm8VEXLACabOda8JMGD2+XrIGcVROcqj
         jSpg==
X-Gm-Message-State: AGRZ1gJ02beWV9Gpzzijh9jenBZ1bUhvhXL3Rd4JnQXKdTdatRx+yGFW
        dEetD0F9SaSis+mI2Ndej4A=
X-Google-Smtp-Source: AJdET5c72r66dK/NPrhwZ4F2IZIemSyXOhbWk3wyLR6tq95u/OUtQaLr282ANOFi0YO5Etjz8l+dyg==
X-Received: by 2002:adf:90af:: with SMTP id i44-v6mr1863616wri.77.1540430108772;
        Wed, 24 Oct 2018 18:15:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 4-v6sm1540384wrk.52.2018.10.24.18.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 18:15:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] t5410: use longer path for sample script
References: <20181024073637.GA31069@sigill.intra.peff.net>
        <20181024073705.GA31202@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1810241051440.4546@tvgsbejvaqbjf.bet>
Date:   Thu, 25 Oct 2018 10:15:07 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810241051440.4546@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 24 Oct 2018 10:53:31 +0200
        (DST)")
Message-ID: <xmqq5zxqn7xg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 24 Oct 2018, Jeff King wrote:
>
>> t5410 creates a sample script "alternate-refs", and sets
>> core.alternateRefsCommand to just "alternate-refs". That
>> shouldn't work, as "." is not in our $PATH, and so we should
>> not find it.
>> 
>> However, due to a bug in run-command.c, we sometimes find it
>> anyway! Even more confusing, this bug is only in the
>> fork-based version of run-command. So the test passes on
>> Linux (etc), but fails on Windows.
>> 
>> In preparation for fixing the run-command bug, let's use a
>> more complete path here.
>> 
>> Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>
> Thank you for the fix! I can confirm that the patch works, and the commit
> message is stellar, as per usual for your contributions.
>
> BTW since this breaks every single one of our Continuous Builds on
> Windows, I would be very much in favor of fast-tracking this to `master`.
>
> Thanks,
> Dscho

I should note to the public that this one, and the companion patch
2/2, owe greatly to you and Peff's efforts.

Thanks, both.

>
>>  t/t5410-receive-pack-alternates.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
>> index 457c20c2a5..f00d0da860 100755
>> --- a/t/t5410-receive-pack-alternates.sh
>> +++ b/t/t5410-receive-pack-alternates.sh
>> @@ -23,7 +23,7 @@ test_expect_success 'with core.alternateRefsCommand' '
>>  			--format="%(objectname)" \
>>  			refs/heads/public/
>>  	EOF
>> -	test_config -C fork core.alternateRefsCommand alternate-refs &&
>> +	test_config -C fork core.alternateRefsCommand ./alternate-refs &&
>>  	git rev-parse public/branch >expect &&
>>  	printf "0000" | git receive-pack fork >actual &&
>>  	extract_haves <actual >actual.haves &&
>> -- 
>> 2.19.1.1094.gd480080bf6
>> 
>> 
