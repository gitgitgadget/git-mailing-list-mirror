Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 634D31F404
	for <e@80x24.org>; Mon, 17 Sep 2018 01:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbeIQHSa (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 03:18:30 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:34533 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbeIQHSa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 03:18:30 -0400
Received: by mail-pl1-f169.google.com with SMTP id f6-v6so6641462plo.1
        for <git@vger.kernel.org>; Sun, 16 Sep 2018 18:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YG1aFL8bAt5xyiu39zfKLIoa7YxI1G7TefxtN2o8c7Q=;
        b=WBPBz4RK28Y7K4ReNO1/yIqtU8xXF6BuVKgXpjkaQKPzHrYllM7SiPrUIVmK8oWsrf
         BABCMiUMYbJ4TX+vMnKZlAPVIO+F7G/HfHJcAsbf/pvd6wWdUJaH0quuKsnFAloz7v+t
         mHfIazYHICzJT4C+2pRG/mCEkV6GbjCz0UJxOIyJpOAHUr7e1LNO7raCP/YX/CuCqHGj
         i62N9muiheBhrfvpzfXa2srV59VZ5qNG7tiRN6FuO86fYMZ/dcU8s1RQ3g0szU+qzgZL
         ab2t2FvhppOXOBjrxD6AXIy3lKXUkCp6py1GI5jnP7J79qv6j4IDdRKXV5h5VYlJ/htp
         pY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YG1aFL8bAt5xyiu39zfKLIoa7YxI1G7TefxtN2o8c7Q=;
        b=Sk7bnD3eVS59L2vdPSmaUX6rBIDXKaGCecjJwZC5maaG/U2RJ8d/M9NmRiHEfuHndf
         6KB+1+zU0oPPHGFJptBrJQ5pisC+yw9A3xKEGzozrOt5iz5Ke1DPYNzJ3xU+9y2OG+so
         HcKqrydl7nzljj11fiVbDO2OIZl3mEfTFOfSvL+XhsS1zCYjlrsdwNiruoZBSBF0PCA7
         j5oXnK0hADJHrgjjym4BoTNBvEFUv7XdyVIMAUVa7xMxXT5C8W+sKyJDPv8jV89cKXcA
         wUVGVlx3AOvs6w4QNipLRiSTzOELIPloN2sRLglXIXVp/kvaqOvyUUaxofvPWfpgM0Tb
         QT3Q==
X-Gm-Message-State: APzg51CoqwOYvG0aNicOvU/bdPJOVQIRrGC5Qsppk+PTR3LkSAu879cN
        JbiKfV7h2Mw4ezAy6kFRe2k=
X-Google-Smtp-Source: ANB0VdYSxFd53yId0J+ilgNSOyxt2EfMzz6NU3cH/XTMywfP1q0hKbrgfWmJCRgSPnZqmrK9eBqP8A==
X-Received: by 2002:a17:902:ac97:: with SMTP id h23-v6mr18392845plr.174.1537149207026;
        Sun, 16 Sep 2018 18:53:27 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id o10-v6sm13912289pgp.70.2018.09.16.18.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Sep 2018 18:53:26 -0700 (PDT)
Date:   Sun, 16 Sep 2018 18:53:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Chris Coutinho <chrisbcoutinho@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Question - no space in smtp-server-option
Message-ID: <20180917015324.GE154643@aiede.svl.corp.google.com>
References: <20180917010244.btmlczam5m75rmto@tumbleweed>
 <20180917011657.GD154643@aiede.svl.corp.google.com>
 <20180917012721.akyclbcmeqw5dv3x@tumbleweed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917012721.akyclbcmeqw5dv3x@tumbleweed>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 03:27:21AM +0200, Chris Coutinho wrote:
> On Sep-16-18, Jonathan Nieder wrote:
>> Chris Coutinho wrote:

>>> Currently my gitconfig contains the following line:
>>>
>>> 	sendemail.smtpserveroption=-a<myaccount>
>>>
>>> Whereas, the following results in an 'account' not found error:
>>>
>>> 	sendemail.smtpserveroption=-a <myaccount>
>>
>> Do you mean that your ~/.gitconfig literally contains that exact line?
[...]
> Yes that's the exact line in my gitconfig file, which correctly mails using
> the non-default account I'm after - I'm assuming you're noticing the lack of
> camelCase? To be honest, that came from zsh autosuggestions, which are all
> lower-case for some reason.

No, case shouldn't matter.  I'm noticing the it looks like

	foo.bar=baz

instead of

	[foo]
		bar = baz

(i.e. it seems to be some syntax other than ini syntax).  E.g. I tried

	echo a.b=c >test.config
	git config -f test.config -l

and get

	fatal: bad config line 1 in file test.config

Thanks,
Jonathan
