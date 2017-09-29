Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C603220A10
	for <e@80x24.org>; Fri, 29 Sep 2017 03:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbdI2D1m (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 23:27:42 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38277 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbdI2D1l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 23:27:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id a7so107673pfj.5
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 20:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mxVdX1g6xCMrZbTiHlqNU8Fi7YBdLcwCuaDExwSBFak=;
        b=moANO+/Q4W/kDSioFMU4Ne+tz7K5DGuaF55qkj+Dx7S3iXFbksH93ip+rCRdA0HXK7
         cYMpxlgE3fuzuC7aJ8ocoKaG2P/Jf09QVyNP+BpBR5WMSoafmpw/PhVsbriFSru8JbWf
         F58xbXKEiKClyniNTwCqgp9zKgmpZNBFL8cxCug2hJkimEN9E5maWADR68RLohrqtURu
         RNtr/Q1v7mI/gTyDqbe5cmgRoqrfgFlWmANderYb03+o3BsHlv9DMUqRxYWm30nWEHQ7
         s4/uUOsL6uqKL9kjyJLmj0EJtJNsTSGcPoLPfN4a50+Ssj9rN/L7JrR6QZenDf2f7J9u
         fLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mxVdX1g6xCMrZbTiHlqNU8Fi7YBdLcwCuaDExwSBFak=;
        b=TlGWnHO86IU8Kd42CbnDbfcGbfgWKVbRR72Tt27iDCXmi37lJKKJxD0M1mi+kBw6wq
         kyv/uW60vs2q9yBrkhqsgy+rRjT52aUS6pxPVDbu1f83NciOuGT5loeiwa+7jLIrlKMD
         gIsDF09MvtgV1S+iRlCwrU9cmvJCKvSmX1geRC66mkULUg7tCYJ5kHIy6ZySBS2EDPb1
         4FQkOHITtBFmJI0QQk7PQ+zLnLf/Y+0aJ9xl7Q3mioF82P8YGYRC0dYlTWayhOKdq4l1
         RTj9xh1UE63UPKdgglhZi9zcw+Eq3vA6SrhPRtLvLp9I0wPGD1wLws6yBHhEkFE6Zkvr
         7J4A==
X-Gm-Message-State: AHPjjUh9oMfmkbd27UrTa3voHmKJWJRQNj+Y/v1GMWMnQ2DpCYoSrRHk
        u+6EjCmbzQvuzOBfGATGnwI=
X-Google-Smtp-Source: AOwi7QCdUlZxmAz2i2NebjD+pYsMIx3vHVkmH26jLYmr6IkMjbYKB2a6YeEoU4ICZgWThMeXKF56aw==
X-Received: by 10.84.129.226 with SMTP id b89mr5488812plb.78.1506655661026;
        Thu, 28 Sep 2017 20:27:41 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c47c:760e:a02b:2eef])
        by smtp.gmail.com with ESMTPSA id q67sm5824472pfg.160.2017.09.28.20.27.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Sep 2017 20:27:40 -0700 (PDT)
Date:   Thu, 28 Sep 2017 20:27:29 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
Subject: Re: [PATCH] doc: correct command formatting
Message-ID: <20170929032653.GA28303@aiede.mtv.corp.google.com>
References: <20170928140648.GC9439@dinwoodie.org>
 <70decbc2-093c-9f9a-3661-ee6500cec641@gmail.com>
 <20170928193412.GB174074@aiede.mtv.corp.google.com>
 <xmqqk20iz2w9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk20iz2w9.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Andreas Heiduk wrote:

>>> +1, Thanks for spotting.
>>
>> Thanks for looking it over.  Can we add your Reviewed-by?  (See [1]
>> for what this means.)
>
> I would just do "Acked-by: Andreas" after seeing such an obvious
> admission of guilt & appreciation for fixing in the exchange.

Oh!  I had missed that context.

Your instinct would have been right (and is born out by Andreas's
reply to me).

I was just fishing, but in this context there was no reason to fish
for more than the Ack that was already there.

> Would we rather want to make it more formal like how Linux folks do
> the Reviewed-by: thing?

Separate from this example: yes, I think adopting Linux's Reviewed-by
convention would be a good thing.  When I see a positive reply to a
patch, I often wonder whether an ack or a fuller reviewed-by is
intended, and Linux's way of formalizing that appeals to me.

I'll try sending a patch to add it to SubmittingPatches tomorrow
morning (Stefan had also been hinting recently about this being
something worth trying).

Thank you,
Jonathan
