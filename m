Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3797B1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 17:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753715AbdLMRV6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 12:21:58 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43340 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753687AbdLMRVz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 12:21:55 -0500
Received: by mail-wr0-f193.google.com with SMTP id z34so2757780wrz.10
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 09:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YSKQxaoirvboC5B6PoxuPwaemwEQWLv+Ik5e5q5FgnI=;
        b=kDP3fPVqC02Zyj8DoRL0aBdrSJ8nRtr/JtHkbWh8Hlos7pW56bTAL9BsfjpjMbWsga
         JhLBbic4EhPN87hcVDrLfqvJKSxKUDboIav3hnYPksNwwnj1VKPki+Qbixp2HlHHfzXb
         IjB3OTcvoa3SoR2yjNHojTiyAxL5JyV1UjRpgBHawW/Jx47n6HEr2w6uaIjtvF7L7Exr
         jgbm4dDJqVMemjO9wjAyMlBuPMJzwkj+BqoAQmspHF4VxB67uauCm9ge/09bqE3gQjUW
         Ij73DkfqDFkfaCY0Ak1wLrN//maamYBDMMvcR/+BWP4Vnii/0Sjik39pH99h38Bh8zJb
         TDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YSKQxaoirvboC5B6PoxuPwaemwEQWLv+Ik5e5q5FgnI=;
        b=qQ5dGnVP9MEq+ky4xpiV07y2lLWI8QNDCmQDsldFHJWUMD56SLKDWrrI7KyRFbMxze
         gLFpJ5sR+vz17lWf4lIfw8M73IeQ3v2r7rpX/K9wrZAmPt43ixMZSVti1Zt5VIoKev6b
         cNJJaOLqVFlHv7XErZqHRGZIRJ8boqAt86ywT7r5GXTLXf/bGLandXlk/6HDQYJ3baGd
         K+5iIfiIRwJfVbvGEviMdXsLmgGjzg6DECPmmkSZMfCxjeZolew3eeOksOlaOy1a1S5e
         DBC5rnlox+TfqZIeH93UafpE4jwkO8Sc+SRju+C/Z5FLc+3lXLCryEI4Zv88tdkT8p3o
         W+wA==
X-Gm-Message-State: AKGB3mLqH5mIqhcjyAFz5gjaNLCymbgOqDvahsEmlJB9FU2dcntoEA4G
        +QDvSSQtFMUmko7dQXKtx6Y=
X-Google-Smtp-Source: ACJfBovBvTHrswbALIjJ5A+UnqDruz+GHVhCMtc5jCnjZmr7dFOE6VlDn/jYomzT7gdzQdvFaP0O4w==
X-Received: by 10.223.196.6 with SMTP id v6mr3025088wrf.236.1513185714188;
        Wed, 13 Dec 2017 09:21:54 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r3sm2269871wmg.31.2017.12.13.09.21.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Dec 2017 09:21:53 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq609b3gi3.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 13 Dec 2017 18:21:52 +0100
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <09E575DE-ED7A-40FA-9A47-0ABB61452C28@gmail.com>
References: <20171210212202.28231-4-t.gummerer@gmail.com> <20171211210948.6867-1-szeder.dev@gmail.com> <20171211214255.GA24597@hank> <C5F93DFF-D3DF-4507-8546-941BFA768705@gmail.com> <xmqq609b3gi3.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 12 Dec 2017, at 20:15, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>>> You're right, it's my first time using travis CI and I got confused
>>> about how the .travis.yml works, thanks for catching that.  Will
>>> re-phrase the commit message.
>> 
>> Szeder is spot on. If you fix up the message, then this patch looks
>> perfect! Pragmatic (= very good!) idea to combine GITTEXT_POISON with 
>> GIT_TEST_SPLIT_INDEX :-)
> 
> I am failing to guess the real intent of the smiley here.

No real reason. I was just happy to see that Travis CI seems to
be useful for the Git project.


> If split-index code is so easy to break, I do not think it is a good
> idea to combine it into the poison build.  In fact, the poison test
> is useless on a codebase where other/real breakages are expected to
> exist, because it is about seeing messages meant for non-humans are
> not passed to the _() mechanism by sloppy coding, and the way it
> does so is to corrupt all the messages that come through the _()
> mechanism.  If we do not even produce a message when a correct code
> _should_ produce one, poison test would catch nothing useful.
> 
> I wonder if it makes more sense to update ci/run-tests.sh so that
> its final step is run twice with different settings, like so?

Agreed - I didn't think it through. Let's keep it separate then.

I think your solution points into the right direction.
Right now we have the following test matrix:

1. Linux - clang
2. Linux - gcc
3. Mac - clang
4. Mac - gcc
5. Linux - gcc - GET_TEXT_POISION
6. Linux - gcc - 32bit
7. Windows

AFAIK your solution would run the split index test for 
1, 2, 3, and 4. I think that is too much.

1 runs the fastest and I would like to keep it that way
to get a quick "general" result. I think only 2 should be
extended in the way you are suggesting. We could run
the tests with different env variables there. What else
do we have besides GIT_TEST_SPLIT_INDEX?

Would that work for everyone?

- Lars


> ci/run-tests.sh | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/ci/run-tests.sh b/ci/run-tests.sh
> index f0c743de94..15a5f5a6cc 100755
> --- a/ci/run-tests.sh
> +++ b/ci/run-tests.sh
> @@ -8,3 +8,4 @@
> mkdir -p $HOME/travis-cache
> ln -s $HOME/travis-cache/.prove t/.prove
> make --quiet test
> +GIT_TEST_SPLIT_INDEX=LetsTryIt make --quiet test

