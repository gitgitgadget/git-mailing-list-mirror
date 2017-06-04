Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 556C920D09
	for <e@80x24.org>; Sun,  4 Jun 2017 18:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbdFDSlT (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 14:41:19 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:33409 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbdFDSlS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 14:41:18 -0400
Received: by mail-wr0-f175.google.com with SMTP id v104so28369621wrb.0
        for <git@vger.kernel.org>; Sun, 04 Jun 2017 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=j5mffu7mwmg2dTrjKdcQsiwdRMGmB4XTP/KqPhNhvuA=;
        b=dyDo9TROAlRxVpmmIjBNeAP9zeKN64+MJX2A7qKTlNtPtIQEUFuXjE+sE7yfE2s5BV
         hAKVyUDdM8nGiPJSG7Hdjl8fgv1K1lecWQTQuZOhk84sCg3sJLsI9vONo/XDDCLI1kdK
         VwBXLIMEalAUKY0Uc0LwgCZ/yhq6Zi6YLoYfE5RwSjwBA6KWIGYLiD56QA+t7D8BFZd6
         sNIwTULYSILFh1q3KOyC5YWHfAqGrRqmvHLBfmxR2GIU2eNsyti8GRWHC0Q+6hryfgig
         ofEmACHe3R0K7q1WBikC/IX8vYOaaELCfgSrVeg/eDHN5ebmWj50yfYcpIQNsC3WAmJO
         QZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=j5mffu7mwmg2dTrjKdcQsiwdRMGmB4XTP/KqPhNhvuA=;
        b=BqB5/dawsWuV6ZqQjxX4dmd16Y1Amzh+xd0cG7XBTkCfwrAUg+NyR2jE99id8n2nUY
         1m6Z6oqk3LRkrBnSFHRW07KCd0GYMZD6OFNywJF/yqs38crG9HdoWQ43TSq/XClY3g1A
         +wFTy8Hvenf+8OaUpY3cAu1A7HD1MZ7t4fDD2vJEezeE/cLoG7gboqiZ/kaaI2AlwMO5
         O/C91SNOCEvW9tLECEfPTOhqW4wTDq9dJUyn/i+s9e3Cb1znFx++adMZF9VJNBkt4Btt
         /T3chncl6kgxpKn7qUDPuVBC84SyP4YewNPumhslfhKFVOtkH94K/D/G5/3Z5+5aRlQj
         v1VA==
X-Gm-Message-State: AODbwcCpoaOyNLo+GPSVDiSOvm/FqB716YIG/gqBrQFVZqDosmQNsMp8
        bHhJ8/3iti+dtQ==
X-Received: by 10.223.163.208 with SMTP id m16mr11187209wrb.61.1496601677163;
        Sun, 04 Jun 2017 11:41:17 -0700 (PDT)
Received: from localhost.localdomain (x4db199da.dyn.telefonica.de. [77.177.153.218])
        by smtp.gmail.com with ESMTPSA id 202sm7871411wmq.27.2017.06.04.11.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Jun 2017 11:41:16 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] Some more git config completions
Date:   Sun,  4 Jun 2017 20:41:10 +0200
Message-Id: <20170604184110.26804-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.420.g54001f015
In-Reply-To: <CACBZZX6aGkBaQtjKNx09-XEbhXNubOnhJdVXYkNq419wetDvqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> As an aside from this series, has anyone ever proposed some method of
> semi-automatically keeping this up-to-date?

For configuration variables, not that I know of.
For command line options, there was an attempt to enhance
parse-options to dump all command line options and use this in the
completion script on-demand to lazy-initialize command-specific
variables holding the list of options:

  http://public-inbox.org/git/1334140165-24958-1-git-send-email-bebarino@gmail.com/T/#u

> Seems we're in a continual
> cycle of adding flags/config, forgetting to update this, then updating
> it. At least the command-line flags should be easy to parse out in
> some test, ditto config variables from config.txt maybe...

A couple of thoughts concerning configuration variables:

 - config.txt includes other files listing configuration variables,
   too.
 - There are many config variables with subsections, e.g.
   'branch.<name>.description'.  That '<name>' is not good for
   completion, of course.
 - Some config variables are not listed with their full names, see
   'advice.*' (this is easy to fix).
 - Perhaps there are config variables that are only mentioned in the
   docs of the relevant command, but not in config.txt (or in the
   included files).
 - There are definitely config variables that are not mentioned in the
   docs at all, e.g. the 'bash.*' variables controlling __git_ps1().
 - The completion script is currently self-contained and ready to be
   used as-is.  I think that's quite nice.  This wouldn't be the case
   if we want to include an automatically generated list of config
   variables extracted from config.txt during the build process.

