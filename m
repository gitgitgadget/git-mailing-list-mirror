Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9025220958
	for <e@80x24.org>; Wed, 22 Mar 2017 07:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933615AbdCVHJY (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 03:09:24 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37842 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933141AbdCVHJW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 03:09:22 -0400
Received: by mail-wm0-f41.google.com with SMTP id n11so28615370wma.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 00:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aylUekcroEX0Xxb7x/n7gjBksUEY+I4mXKOCwGjOBSE=;
        b=Eh2arxgA/l+F0fAT2akXocNlOqxKbdFFZvaxYFUkn0Pm8R8EhSu71GE4NQbSld32Pv
         agsfufr3lylaFVIH3CJmuVyF6m0lYGSEcN3CSkVkOAffQG7CBTEPIK0hg7W4aQHSD39+
         IsG3F10l/T0nQfW6NqWyNnhPh/xK79zn+nT3LGGSFXCAmcnpGRme675rVonbZnYeCFaX
         BjXIQVlpUARR0Y4W4REzXZ1Dlsu1fvDrEL0J4z6s2le+/qEBAXVLsks0zLrApcCP7SgI
         cxFVcjzG4brvBVFJ64IoBJcdESvZM/OmX5FAnF8G7gCtjAZsu+RyOwSj8ovlaNPwFxoV
         eqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aylUekcroEX0Xxb7x/n7gjBksUEY+I4mXKOCwGjOBSE=;
        b=renPtk5j8vmdNKI8MBsXCfCqtxMYqYzbVr8KZHoEo/myWWISEl8uI5DwkyAMW/g8QY
         SxBricv+Z2ZL4GPriIOY0u4T0woDpnx3WwWx3iq34w95mSFz0o8hwsHsUIKy715xfJ5A
         iViE4AlIzclSZ3vynPsKk87AyUJ6mX7L82NSMY5GibgV+nzLrlCFcDCh3/XtLSiVf4yv
         2rTMaNYxfU/vBF66ukdTuKxfMMcYwYWJlfGobLixGYzto6NZsNv8DQHMeGo6k4qCFlNn
         tJNwGHJb5QDPMvoBEiLjNNkgfsgDWHHC2Mem+AvcunX9wRWMv7sSZ93bFnxaF2gulBQr
         /eRQ==
X-Gm-Message-State: AFeK/H1woL0ipqgQx9iZ/nLI4L/tRQjwMvPN1ReE6TBVAEC4U20p2UUMkh/xXYFlT151jw==
X-Received: by 10.28.10.209 with SMTP id 200mr6404334wmk.126.1490166537862;
        Wed, 22 Mar 2017 00:08:57 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4341.dip0.t-ipconnect.de. [93.219.67.65])
        by smtp.gmail.com with ESMTPSA id g43sm649836wrg.35.2017.03.22.00.08.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 00:08:57 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Mar 2017, #02; Fri, 3)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqd1dasez2.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 22 Mar 2017 08:08:57 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <10A7B711-C5C7-4F57-AF08-E748FB35FD0C@gmail.com>
References: <xmqqh93a6iy6.fsf@gitster.mtv.corp.google.com> <5C8A09B2-0C99-4BD9-A82B-B333EF1F155E@gmail.com> <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com> <BA6E546F-3594-4673-A43B-7E4D4CEA8F68@gmail.com> <xmqqd1dasez2.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 21 Mar 2017, at 18:43, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> Agreed. Would it be OK to store the "delayed" bit in the cache
>> entry itself? The extended ce_flags are stored on disk which is not
>> necessary I think. Would a new member in the cache_entry struct be
>> an acceptable option?
> 
> I'd imagine that those with thousands of cache entries in their
> index prefer not to bloat sizeof(struct cache_entry) for something
> like this, that is _only_ used during the write-out phase.  Would a
> new pointer in the "struct checkout" that points at whatever data
> structure you need (perhaps a "string_list"?) work?  As long as the
> pointer points at a constant thing, you may not even have to loosen
> the constness of "struct checkout *" itself?

OK. I will try that and post a new round soonish.

> 
>>> Within such a framework, your checkout_delayed_entries() would be a
>>> special case for finalizing a "struct checkout" that has been in
>>> use.  By enforcing that any "struct checkout" begins its life by a
>>> "state = CHECKOUT_INIT" initialization and finishes its life by a
>>> "finish_checkout(&state)" call, we will reduce risks to forget
>>> making necessary call to checkout_delayed_entries(), I would think.
>> 
>> Agreed. How would you want to enforce "finish_checkout(&state)", though?
>> By convention or by different means?
> 
> We can start with "convention", just like "if you did STRBUF_INIT,
> you must do strbuf_release() at some point" has served us well, I
> would think.

OK!

Thanks,
Lars
