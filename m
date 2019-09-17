Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E120D1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 12:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfIQMCy (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 08:02:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37961 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfIQMCx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 08:02:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id l11so2865423wrx.5
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 05:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eeh7Isy/tIsUWc7F3dOfSEqzU0vbRYrg8CjCzZeEdwY=;
        b=FdHWqSdR31DQyR1UJcGxK4ylS6tI/C2K6iivb9clXOXPGzlGgnVfz5Ll5HEeY3Sgyf
         jCa/qCrpdh+07yY8aTiWkaVEAczXQ8drIIUEaCeFitTVADcdw1YmQo76MqenukO+3Mxu
         5tlug9m1OaOoc3LMYKDH0oz8mPVcxjY9hY2Lt1pYMQJgGVklw75FI1YAYEBBS+mlO1En
         /LiSHn2jjiBrdIY6WXhjjjHJczmlNspeVCN7v8qmr2W9BGsjC0hqC3BFogAjZxxK8nf3
         MTCUmFarZsJQ3QDjPCn/X6QfSL5BgZONJiCrI6b810sxToeadQhb+TLozgZ9JRzrMnQH
         IoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eeh7Isy/tIsUWc7F3dOfSEqzU0vbRYrg8CjCzZeEdwY=;
        b=ZpZ6J9lXaDUMfjDFcsRDfcSpoBeJ/bNkiktJyrNmMVKwamtzmHLXvspnR0rj6F7XBY
         gXw1rujkGi5pOzsoe9crvf0mw9kWFwC2x3eGI1zCNZBrP/TycyjEs+e7hi6JSUld4T/x
         Vb9pf9zj3P98VwRnFx/epdfLjCxCNfkNbeMJEq18gYNWO2EH685rvxvvy65AO2Hza/Cg
         /sJCz/2kkzhqu6v5W0P02ZVc1bqnd+pHsZo8HBddGDHCNa+xpDZjNleGif+bxxfaraRO
         YmiAIlkcYlfNMVneNfdn9FtG1uJrnBB4HmarAwiI0GyLCblcw3UYEQo6yKCY7o/LMD05
         D43g==
X-Gm-Message-State: APjAAAXDFZjdOcNWYcjbf/7goUxU8/2JdbIpyXngw4Wf9jkCIvTfNATn
        WeM9b0n36bw1gYhF/dmRP5Q=
X-Google-Smtp-Source: APXvYqydKaEu6pmPyn76ordjaHnlkbIGBLuH3CM9rWd9uvt4wUatpkqsEnb7LW7yn1Eg3zIu5RwQsg==
X-Received: by 2002:a5d:4742:: with SMTP id o2mr765269wrs.253.1568721771834;
        Tue, 17 Sep 2019 05:02:51 -0700 (PDT)
Received: from szeder.dev (x4db91871.dyn.telefonica.de. [77.185.24.113])
        by smtp.gmail.com with ESMTPSA id g185sm4838967wme.10.2019.09.17.05.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 05:02:50 -0700 (PDT)
Date:   Tue, 17 Sep 2019 14:02:44 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190917120230.GA27531@szeder.dev>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190913200317.68440-1-jonathantanmy@google.com>
 <20190913205148.GA8799@sigill.intra.peff.net>
 <20190916184208.GB17913@google.com>
 <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 17, 2019 at 01:23:18PM +0200, Johannes Schindelin wrote:
> Also, things like the code tracing via `-x` (which relies on Bash
> functionality in order to work properly,

Not really.

> and which _still_ does not work
> as intended if your test case evaluates a lazy prereq that has not been
> evaluated before

I don't see any striking differences between the trace output of a test
involving a lazy prereq from Bash or dash:

  $ cat t9999-test.sh 
  #!/bin/sh
  
  test_description='test'
  
  . ./test-lib.sh
  
  test_lazy_prereq DUMMY_PREREQ '
          : lazily evaluating a dummy prereq
  '
  
  test_expect_success DUMMY_PREREQ 'test' '
          true
  '
  
  test_done
  $ ./t9999-test.sh -x
  Initialized empty Git repository in /home/szeder/src/git/t/trash directory.t9999-test/.git/
  checking prerequisite: DUMMY_PREREQ
  
  mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
  (
          cd "$TRASH_DIRECTORY/prereq-test-dir" &&
          : lazily evaluating a dummy prereq
  
  )
  + mkdir -p /home/szeder/src/git/t/trash directory.t9999-test/prereq-test-dir
  + cd /home/szeder/src/git/t/trash directory.t9999-test/prereq-test-dir
  + : lazily evaluating a dummy prereq
  prerequisite DUMMY_PREREQ ok
  expecting success of 9999.1 'test': 
          true
  
  + true
  ok 1 - test
  
  # passed all 1 test(s)
  1..1
  $ bash ./t9999-test.sh -x
  Initialized empty Git repository in /home/szeder/src/git/t/trash directory.t9999-test/.git/
  checking prerequisite: DUMMY_PREREQ
  
  mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
  (
          cd "$TRASH_DIRECTORY/prereq-test-dir" &&
          : lazily evaluating a dummy prereq
  
  )
  ++ mkdir -p '/home/szeder/src/git/t/trash directory.t9999-test/prereq-test-dir'
  ++ cd '/home/szeder/src/git/t/trash directory.t9999-test/prereq-test-dir'
  ++ : lazily evaluating a dummy prereq
  prerequisite DUMMY_PREREQ ok
  expecting success of 9999.1 'test': 
          true
  
  ++ true
  ok 1 - test
  
  # passed all 1 test(s)
  1..1

