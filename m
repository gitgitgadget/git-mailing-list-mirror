Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 565392022A
	for <e@80x24.org>; Mon,  7 Nov 2016 17:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933208AbcKGR4I (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 12:56:08 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35452 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933197AbcKGR4E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 12:56:04 -0500
Received: by mail-qk0-f169.google.com with SMTP id n204so175860858qke.2
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 09:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=krH7QkPo6CLGUKdV0p7lC93n6HImrhTGGTwsbLMQYm8=;
        b=SEHvqQebQi7+W5yUauCUVX7IAzZX74OC9RoQPmm0fWERFzrVbk8dhmzcZ+lxUQEEkR
         7b61Qy+8mVVZbcEi0tGVQuVjEPZja+h5EuRShes4Pqdi/KxUmhH5X41Tc5FJ2tPrk2rI
         X5gCnpSTuAwPtdjUZMOfSQsJX+LsdR+VPd7FyOcKrpgio3Swnnq5z1OQd7dS7RQp/BnO
         3GsKJgGrO4n1iBE8ZErNji7AqTbSiv77/6opr/1p34e1loXFxoe8cHP4fxbUv5BOQDvg
         VwJLRNfQfBsK5yArBokFo7eqSkTMNDUaKNlLhojEQAm7g24tzRQ9bhygkcf3Rk613BPk
         bEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=krH7QkPo6CLGUKdV0p7lC93n6HImrhTGGTwsbLMQYm8=;
        b=AxaehJn18VnKYHme+b2XEGazeXxTP86Kihl0IotwkZysfegsi2hSji8Ovj8LW/6JWl
         N3MY89uhc8Bq+Rq4lo2bZS3MmvJ+o9A0zB/hjTGTDZMtX7+g4MCzsHk8oGG79+Ri8AUf
         +ndlZyhCwni6pz8NQxuqaiNad6atGVJO2jazChFO6MvEYjvBaM1cq9fBbeCE5Fl7df0+
         JhqKYeJaZ+MABWwNxhiB6MlxaRTgdS0NJDSFe57DUg/GeSm2uFnCDNQsdz38Q8wyvFCR
         NZlIRZpEjmca2FJqiqEQjYpgEsw2EwGn+BQelXojDYSKie4bUsFaqz0vW3IM3umfmj0A
         6vrQ==
X-Gm-Message-State: ABUngve0u7E5DZenaWUqnFRTZ68f7aQZ99RkzS/nVEXRNNZ6Bugvkn7oE+2RjDpFtoD+FoOuL1Bny4GBxIM7iDt3
X-Received: by 10.233.216.196 with SMTP id u187mr7774280qkf.220.1478541363215;
 Mon, 07 Nov 2016 09:56:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Mon, 7 Nov 2016 09:56:02 -0800 (PST)
In-Reply-To: <CA+dzEBmP2aUit00ukJyQeg=iqUJJLVaovafo2gngf9MvEqZDPA@mail.gmail.com>
References: <CA+dzEBmP2aUit00ukJyQeg=iqUJJLVaovafo2gngf9MvEqZDPA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 7 Nov 2016 09:56:02 -0800
Message-ID: <CAGZ79kYbrDu=9Hw+SBnubSHKOc8HmGPb721ZJQxGWW2egqmuDg@mail.gmail.com>
Subject: Re: git submodule add broken (2.11.0-rc1): Cannot open git-sh-i18n
To:     Anthony Sottile <asottile@umich.edu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

    $ git --version
    git version 1.8.5.6
    $ if [ "$LATEST_GIT" = "1" ]; then
    ...
         export PATH="/tmp/git:$PATH"
     fi
    ....
    make -j 8
    ...
    $ git --version
    git version 2.11.0-rc0

So you compile 2.11.0-rc0 yourself, but you do not install it, instead
the $PATH is pointed to /tmp/git instead, however the later calls fail with:

    Can't open /home/travis/libexec/git-core/git-sh-i18n

which is where 1.8.5.6 is installed.

So you're running into an internationalization problem
between 2 very different versions of Git (1.8 seems to be ancient)

Not sure if i can offer advice except from
"Don't do that, instead install Git properly". ;)

Thanks,
Stefan
