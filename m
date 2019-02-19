Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B50D71F453
	for <e@80x24.org>; Tue, 19 Feb 2019 11:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfBSLXQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 06:23:16 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:44859 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfBSLXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 06:23:16 -0500
Received: by mail-ed1-f50.google.com with SMTP id b20so16361950edw.11
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 03:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=iHIsR9c0qL/74l96fgpa1F9X0OtjKzrGKUwZim66Opc=;
        b=PGQVlJjoGKNyTkWNMVrYLx2xWDBsbgQtEeIzRhzIzR50hjPPv1KJ8lgiwwKhSlGUov
         +Y9Wa+ZWZN2gHwaPXGHT1ElUSAx0BVq0nmoWI06bUVGWrEyTHLbDkKGSW1bgRE7O/J+N
         kqeaJv03sftwqJc+mi2UKeuephXiXVL+RGJmPabgAj87JLmq+hVrqbbwojRnP7HBLLcj
         Z/xPw3fopx707CbJamFY/BN+Iu1kQm4+PEGifhHLLxuXB57m8vz/8N659+1UpYXsYN13
         MIZSs66zgjleZ2kog5kwKQyfoezq8CtxfBm58ntVQPcimMRYpzbGOf4XikC4MqoomCQ5
         6cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=iHIsR9c0qL/74l96fgpa1F9X0OtjKzrGKUwZim66Opc=;
        b=bvgKh90bmBxUq65LqlIGNTpwrtUdy4ulAN6pRuQ/ANVXHRrq7o/tiH1JoNewnc3FXb
         wEAjyl9/613xVEGhHn7DlYBxxhfOwBhJfTY0plvRtN8gIkpc0DNWDwxYLb1DXmnA20u5
         rlT87Fm2AG68KjfrbEU6K6Froj2Yd7VVTGNKsJxw20f/RODKff6nqMeDr4k/qmhc8IPL
         KBWdvdrV1he7niccoz1vFChEDnSa6ZKWssQcmy0E3QDGQ8FiVReH9DbIV0ec12nXwnA8
         kMISWkLxvymPimrlZ4lMxH7cAdQn9NCPhTIxsC1Wk5532hnVLp/p7vvjxZnp1SxsV6dj
         gibg==
X-Gm-Message-State: AHQUAubSCDWZBVWrYFip61mdPYRFK/bKNu5ExhOVfcOMoMs2eV1BLinQ
        q+Euq4OSjvpwbYetLvBWfWo=
X-Google-Smtp-Source: AHgI3IbYuqcui+XCQl+WAyQyLcm5yFYxnC2eg0/O81L1vHiB63RMWr2Xf3DG/1xoz70GGq0SSZ4hpw==
X-Received: by 2002:a17:906:3543:: with SMTP id s3mr20145892eja.108.1550575394384;
        Tue, 19 Feb 2019 03:23:14 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id n12sm3531083ejx.23.2019.02.19.03.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 03:23:13 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: why no mention of "hooks.allownonascii" in any man page?
References: <alpine.LFD.2.21.1902190544470.23739@localhost.localdomain>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <alpine.LFD.2.21.1902190544470.23739@localhost.localdomain>
Date:   Tue, 19 Feb 2019 12:23:13 +0100
Message-ID: <87mums58f2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 19 2019, Robert P. J. Day wrote:

>   was just perusing the sample hook scripts, and the sample pre-commit
> script provided with git does the following check:
>
> # If you want to allow non-ASCII filenames set this variable to true.
> allownonascii=$(git config --bool hooks.allownonascii)
>
>   but that config variable (hooks.allownonascii) is not mentioned in
> any man page. its entire existence in the git code base consists of:
>
> $ grep -r allownonascii *
> templates/hooks--pre-commit.sample:allownonascii=$(git config --bool hooks.allownonascii)
> templates/hooks--pre-commit.sample:if [ "$allownonascii" != "true" ] &&
> templates/hooks--pre-commit.sample:  git config hooks.allownonascii true
>
>   technically, there's nothing wrong with that, i just thought it was
> a bit weird that a sample hook script refers to a config variable that
> is not referred to in any way elsewhere.

The hook itself spontaneously introduces it and uses it. There's nothing
magical about config variable, e.g. it could also be "xyz.abc" instead
of "hooks.allownonascii".

But perhaps it should be documented as the functionality of the default
hook in githooks(5), similarly to how we document
hooks.allowunannotated. Patches welcome :)
