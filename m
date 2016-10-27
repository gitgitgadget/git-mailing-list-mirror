Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567F920193
	for <e@80x24.org>; Thu, 27 Oct 2016 21:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942184AbcJ0Vzs (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 17:55:48 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37934 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936489AbcJ0Vzr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 17:55:47 -0400
Received: by mail-wm0-f48.google.com with SMTP id n67so75941462wme.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 14:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pelly-co.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=jq+LNpK+kk4oMsxBlHfCzJX8xcdXpYlUfqFghXsK0Ws=;
        b=qqIoFu06PGSNHeMUtwwuBNEvZ9rCE9W8Ty41uIccWOtoieGB6OvEDbZ823/QVieVb8
         7Y2CKWdHpQR3jjiFh31vSvFPucyNG9fa7tHVXakM7X61RW1RRF4Wyiv3gMAxWOZY0IIs
         Iw0NqtjeFfVzLO/R1pmPnh9e0pSPlOGN8zCeBqS8w2k6gf1miiyLJdBYVw4/9ZbD4MxM
         WiMkQfmysJmxbyjh5OAnQrjNfUCTnTOwizJLKPn4v6Oew9EmxTYeB0BI5YrObYfqLm8U
         bRmPIEGAzpniJ++H9EQCNm/RiEKJ8M5I+2ynJvSHVIjFATENWLDgn2ck5mYWaQvO8/2V
         kJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=jq+LNpK+kk4oMsxBlHfCzJX8xcdXpYlUfqFghXsK0Ws=;
        b=D+Cx9c0hJOxBsNeKOWjP4m/Dp6z6Y70CwZevhzLl5EQigf6XVfvdszKCuEXiCj3+k+
         Fid4qRWicqLOSLDRkkMikxa2O55Kg+n2eQTcH9UwjIFLqRgXq4uVkX0Qdi2ZWAuPZRmk
         J2rapJqKkgEP+thzNR1ys3Nr+62KFeNIdHrJsShxI4MuZiCFIqu0KvTiRClycOe6ptUB
         dopuvPgJPRRX3XZqCnilXn5kjfLmOR2e2f0dz3lz2xDTDJ7ALoFz1v05kBcpw2afICpj
         7ojlDEVsZN2lORO/VSiZN9Pj+x/BEUq95l4K42klcDonC3RKoSTjcSt6ZjshweSmhJ0y
         oRng==
X-Gm-Message-State: ABUngvc+NwP9zrP+TizDOuGTzg6mq2Blke7zBvyymHyiO+LQW3tSMPnGn9OpwRRjVcqYDQ==
X-Received: by 10.28.20.12 with SMTP id 12mr744867wmu.61.1477605345821;
        Thu, 27 Oct 2016 14:55:45 -0700 (PDT)
Received: from [10.3.1.6] ([49.50.252.82])
        by smtp.googlemail.com with ESMTPSA id i10sm10712471wjw.1.2016.10.27.14.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Oct 2016 14:55:45 -0700 (PDT)
Subject: Re: Expanding Includes in .gitignore
To:     Jeff King <peff@peff.net>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
 <b20b458c-440d-df09-d2c7-e510ac20492c@pelly.co>
 <20161027205508.vqw44zlbnqpj2cvd@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Aaron Pelly <aaron@pelly.co>
Message-ID: <60a652f6-864e-bbda-7394-4751c92866b7@pelly.co>
Date:   Fri, 28 Oct 2016 10:55:40 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161027205508.vqw44zlbnqpj2cvd@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/10/16 09:55, Jeff King wrote:
> On Fri, Oct 28, 2016 at 09:28:23AM +1300, Aaron Pelly wrote:
> 
>>>   - we parse possibly-hostile .gitignore files from cloned repositories.
>>>     What happens when I include ask to include /etc/passwd? Probably
>>>     nothing, but there are setups where it might matter (e.g., something
>>>     like Travis that auto-builds untrusted repositories, and you could
>>>     potentially leak the contents of files via error messages). It's
>>>     nice to avoid the issue entirely.
>>
>> I understand the issue.
>>
>> It's not obvious to me how using a .d solves this problem though.
> 
> It doesn't by itself. But we are worried only about tracked .gitignore
> files (recall that even repo-level files in $GIT_DIR/info are generated
> fresh by the clone process, and don't come from the remote). If we apply
> the feature only to core.excludeFile and $GIT_DIR/info/exclude, those
> are already under the user's control.

The things you say make sense from this perspective.

I was hoping to employ this mechanism throughout the git ecosystem.

Thinking out loud for a minute:

1) I clone a repo with a hostile ignore file. It includes files from
/etc/ssl/private or some such. Change. Don't pay attention. Commit.
Push. Problems.

What is the use case for reaching out of the repo in the first place?

2) I fetch a repo with a hostile ignore file. It includes files from
$GIT_DIR/test-data/ssl/private or some such. Change. Don't pay
attention. Commit. Push. Problems if my test data comes from production.

Is this mitigated currently?

Not that git should be an enabler, but surely it falls on the user of
untrusted software to ensure their own security?

> It's true that we could make a similar exception for an "include"
> feature, and respect include directives only in those "safe" files.
> Somehow that seems more confusing to me, though, than doing adding the
> feature at the file level, as it introduces slightly varying syntax
> between the locations.

I'm quickly getting over the include file idea. But yes, that would be
non obvious.

>>> Whereas letting any of the user- or repo-level exclude files be a
>>> directory, and simply reading all of the files inside, seems simple and
>>> obvious.
>>
>> Apart from backwards compatibility, unless there's something I'm missing.
> 
> I'm not sure what you mean. If we make:
> 
>   mkdir .git/info/exclude
>   echo whatever >.git/info/exclude/local
> 
> work, I don't think we have to care about backwards compatibility. That
> was nonsensical before, and never did anything useful (so somebody might
> have done it, but we can assume anybody relying on it not to read the
> contents is crazy).

Seeing your perspective, now, I can see why you didn't understand me. In
your context this makes perfect sense.

