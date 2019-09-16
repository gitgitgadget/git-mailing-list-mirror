Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6291F1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 23:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbfIPXNw (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 19:13:52 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:37027 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfIPXNw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 19:13:52 -0400
Received: by mail-pf1-f172.google.com with SMTP id y5so864516pfo.4
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 16:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=e/4SGZx6cK2/Zm17ys68zgkrx//8lpuk2+e7iC0WFvE=;
        b=n0SfSXUcszKjJY3A+6jG2qxXAS4lIHe1DG6yHwenJ8snYWxxb4CnyRid1XhMWKtKoQ
         +QkwQypHWKTO51xGjROe/LSQVoxvXtbb/ANzL2Ubb0ClMsjjDPpgmyhZEoEaIztS1oss
         0bpW9ABXonGEeRNXd9relxzi/l4kwap9EY2tnA6oLcv+iiZB6HaykzYvxxKBhU/SzOyZ
         Elz5jiu7ucqToOqqUYq+WPxus6m+LeaIlFJ9Ly2o0t7+NClffq9Bs4uq5kuGejdTGCyT
         ScjboS9i9KAK0sLOAgVLFzwZ3mOqEVCkvq3N6Qhrb04FSgm0QgVWtUQcFGnTrOlwZkAg
         WySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e/4SGZx6cK2/Zm17ys68zgkrx//8lpuk2+e7iC0WFvE=;
        b=Ca76Ao2lg0JCqVmGrRba+oi7bKSEde5VWwGxpMONyC4moM6TA/TrRisU6M2VZwIVMG
         i9BsjIl/H8rFjzDQvbC1AN9fjSSoqWPSjdrm2zz5iPoxsltmUZeKPLWFtrKOc3THHgTZ
         /CngpqofjLr3i7DC4TZkt03tt7EVLGAmT6oneoysrWh+iScbLuAFnd2dD3Q/0lfRrk2x
         u7RFJY2GHfKOjqTJ4L0Ts0PoKg8Na1jqg0jsjWhJxBPM0DWnkPEJ7t0vrbfpPRxPOCRk
         u2aKxtJpjaeh+q7OGTYYYjZls6y9B6RYRSrbigRFRaoobYfzM372K7U6RNLJm2PkWkX2
         E8KA==
X-Gm-Message-State: APjAAAUkx+1Py5oKpdFJGyui/wYPpRUkOjsIkXHWtbITe8DdWRz8GK4w
        zNIZNcROEuUNa5fqtzc/SCs=
X-Google-Smtp-Source: APXvYqzZ8EFu2p3V6LTtKr8MJUaTTQ8Q4AavbAgu6H6qH91Vx0RxIue2lwOzvVHjJtLNJMM9orFp7g==
X-Received: by 2002:a63:f84b:: with SMTP id v11mr560661pgj.187.1568675631454;
        Mon, 16 Sep 2019 16:13:51 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id w134sm186405pfd.4.2019.09.16.16.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 16:13:50 -0700 (PDT)
Date:   Mon, 16 Sep 2019 16:13:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190916231348.GB67467@google.com>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190913200317.68440-1-jonathantanmy@google.com>
 <20190913205148.GA8799@sigill.intra.peff.net>
 <20190916184208.GB17913@google.com>
 <20190916214452.GC6190@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190916214452.GC6190@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor wrote:
> On Mon, Sep 16, 2019 at 11:42:08AM -0700, Emily Shaffer wrote:

>>  - try and make progress towards running many tests from a single test
>>    file in parallel - maybe this is too big, I'm not sure if we know how
>>    many of our tests are order-dependent within a file for now...
>
> Forget it, too many (most?) of them are order-dependent.

Hm, I remember a conversation about this with Thomas Rast a while ago.
It seemed possible at the time.

Most tests use "setup" or "set up" in the names of test assertions
that are required by later tests.  It's very helpful for debugging and
maintenance to be able to skip or reorder some tests, so I've been
able to rely on this a bit.  Of course there's no automated checking
in place for that, so there are plenty of test scripts that are
exceptions to it.

If we introduce a test_setup helper, then we would not have to rely on
convention any more.  A test_setup test assertion would represent a
"barrier" that all later tests in the file can rely on.  We could
introduce some automated checking that these semantics are respected,
and then we get a maintainability improvement in every test script
that uses test_setup.  (In scripts without any test_setup, treat all
test assertions as barriers since they haven't been vetted.)

With such automated tests in place, we can then try updating all tests
that say "setup" or "set up" to use test_setup and see what fails.

Some other tests cannot run in parallel for other reasons (e.g. HTTP
tests).  These can be declared as such, and then we have the ability
to run arbitrary individual tests in parallel.

Most of the time in a test run involves multiple test scripts running
in parallel already, so this isn't a huge win for the time to complete
a normal test run.  It helps more with expensive runs like --valgrind.

Thanks,
Jonathan
