Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB28F1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 21:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfIZVoz (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 17:44:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33742 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfIZVoy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 17:44:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id b9so452782wrs.0
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 14:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YjUs9r43uZxol/ktZUQtBRipA/6b6E2jqOpS/5+5Xlk=;
        b=jeUUPvfe32C6U254+6Ta2MGdRN+RMHMbzRsO5xUj68vjprJlQf0Fl6E944HLxFZ50B
         dALCGUdeBCOyTPAGBQXY6Jj2ORyACeDo8DMKv58kgErbIDbUxkrZj7mq60pYZ3nVHXgU
         LfXtFDYrVjsCH3JT7V2FN+ZG+rOykSfmub66MdOCCnn57qnd9f6usdYpGZlVaxV3EaYV
         SfSwCWd9kj1/Fc4EwHyhw8TNhs33xCeh5ughcnX+6bHmc+Xlqnev2VA8SXWcqhEkQ4Ik
         ojgwYh1EjVvXY/AuGGzEeJ0Ec2cM6FTrOBsjNocbnhTFP0kETWj9qqtKzGtQcvMb3Pkx
         fydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YjUs9r43uZxol/ktZUQtBRipA/6b6E2jqOpS/5+5Xlk=;
        b=WUvTVgo76JwJwse2SeWbIJCr7/a8ENHRqdJskqx4vM/43jc3uPItOoTEuMFIEiZqbp
         dvfx7a6wzv2zXZAfQboG0lByoLhFNcfMs5/mz8LFK/qWJQAySZVzhD8Ft1HTQWBOWMxb
         AnQAnBL4IiG0Nw+tL5D44EvBqGG6CAaml/BPG3QUkUX5jkiywjNnFU9SaKiza1+i/E8v
         STiTHfDzLH6oJyQSJjgwrIdYOSKt9CjVbjM+1nAZyM5xwSfq46Ssx4QDuOt55nxWhvzW
         7ZV4nYc6wvRIZGCwMlaN/OeeFCO3AGAJBM7ReLD5uW++FZoct8bEsKJFF6A5SMII+Kc8
         JOCA==
X-Gm-Message-State: APjAAAUYiTzbK5oscQlO7Ij8coQ5GRWJxZGBlnSBDjwgjlL9cvzUMHzN
        tDwbDVa9tfFF7iyIZapbZTG47hwU
X-Google-Smtp-Source: APXvYqwaYOPjLPpC4ivw3NZoLzZKI0CkpX5XH198MSo2rg0UkhLAVw5kr6QACx3TTsac+hKSwtssXQ==
X-Received: by 2002:a5d:628f:: with SMTP id k15mr402554wru.124.1569534291908;
        Thu, 26 Sep 2019 14:44:51 -0700 (PDT)
Received: from szeder.dev (x4db9381f.dyn.telefonica.de. [77.185.56.31])
        by smtp.gmail.com with ESMTPSA id y14sm1013542wrd.84.2019.09.26.14.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 14:44:51 -0700 (PDT)
Date:   Thu, 26 Sep 2019 23:44:48 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190926214448.GI2637@szeder.dev>
References: <20190913200317.68440-1-jonathantanmy@google.com>
 <20190913205148.GA8799@sigill.intra.peff.net>
 <20190916184208.GB17913@google.com>
 <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
 <20190917120230.GA27531@szeder.dev>
 <nycvar.QRO.7.76.6.1909231444590.15067@tvgsbejvaqbjf.bet>
 <20190923165828.GA27068@szeder.dev>
 <nycvar.QRO.7.76.6.1909261257160.15067@tvgsbejvaqbjf.bet>
 <20190926132852.GF2637@szeder.dev>
 <nycvar.QRO.7.76.6.1909262138450.15067@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1909262138450.15067@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 26, 2019 at 09:39:58PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 26 Sep 2019, SZEDER Gábor wrote:
> 
> > On Thu, Sep 26, 2019 at 01:04:48PM +0200, Johannes Schindelin wrote:
> > > > > > > Also, things like the code tracing via `-x` (which relies on Bash
> > > > > > > functionality in order to work properly,
> > > > > >
> > > > > > Not really.
> > > > >
> > > > > To work properly. What I meant was the trick we need to play with
> > > > > `BASH_XTRACEFD`.
> > > >
> > > > I'm still unsure what BASH_XTRACEFD trick you mean.  AFAICT we don't
> > > > play any tricks with it to make '-x' work properly, and indeed '-x'
> > > > tracing works properly even without BASH_XTRACEFD (and to achive that
> > > > we did have to play some tricks, but not any with BASH_XTRACEFD;
> > > > perhaps these tricks are what you meant?).
> > >
> > > It works okay some of the time.
> >
> > As far as I can tell it works all the time.
> 
> I must be misinterpreting this part of `t/test-lib.sh`, then:

Ok, let me try to clarify.

There are a couple of things that we can't do in our tests without
BASH_XTRACEFD, e.g. redirecting the standard error of a subshell or a
loop to a file and then check that file with 'test_cmp' or
'test_must_be_empty'.  With tracing enabled but without BASH_XTRACEFD,
the trace of the commands executed within the subshell or loop end up
in that file as well, and cause failure (grepping through that file is
mostly ok, though).  Back then we had 23 test cases failing because
they were doing things like this and needed to be fixed, so
considering the total number of test cases we only rarely used such
problematic constructs.

Still, as I recall, Peff was concerned that these limitations might
lead to maintenance burden on the long run, so I decided to add an
escape hatch, just in case someone constructs such an elaborate test
script, where redirecting the stderr of a compound command could
considerably simplify the tests. 

That snippet of code that you copied is this escape hatch: if 
$test_untraceable is set to a non-empty value before sourcing
'test-lib.sh', then tracing will only be enabled if BASH_XTRACEFD is
available.

All that was over a year and a half ago, and these limitations weren't
a maintenance burden at all so far, and nobody needed that escape
hatch.

Well, nobody except me, that is :)  When I saw back then that t1510
saves the stderr of nested function calls with 7 parameters, I
shrugged in disgust, admitted defeat, and simply reached for that
escape hatch: partly because I couldn't be bothered to figure out how
that test script works, but more importantly because I didn't want to
risk that any cleanup inadvertently hides a bug in the future.

So that's the only user that piece of code ever had, and I certainly
hope that no other test script will ever grow so complicated that it
will need this escape hatch.  I would actually prefer to remove it,
but t1510 must be cleaned up first...  so I'm afraid it will be with
us for a while.


> -- snipsnap --
> if test -n "$trace" && test -n "$test_untraceable"
> then
> 	# '-x' tracing requested, but this test script can't be reliably
> 	# traced, unless it is run with a Bash version supporting
> 	# BASH_XTRACEFD (introduced in Bash v4.1).
> 	#
> 	# Perform this version check _after_ the test script was
> 	# potentially re-executed with $TEST_SHELL_PATH for '--tee' or
> 	# '--verbose-log', so the right shell is checked and the
> 	# warning is issued only once.
> 	if test -n "$BASH_VERSION" && eval '
> 	     test ${BASH_VERSINFO[0]} -gt 4 || {
> 	       test ${BASH_VERSINFO[0]} -eq 4 &&
> 	       test ${BASH_VERSINFO[1]} -ge 1
> 	     }
> 	   '
> 	then
> 		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
> 	else
> 		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
> 		trace=
> 	fi
> fi

