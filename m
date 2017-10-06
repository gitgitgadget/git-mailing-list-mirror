Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99DC91FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 17:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbdJFR6Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 13:58:25 -0400
Received: from mout.web.de ([217.72.192.78]:50248 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752746AbdJFR6X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 13:58:23 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MK1s1-1dz9Rd1U6X-001UG1; Fri, 06
 Oct 2017 19:58:16 +0200
Date:   Fri, 6 Oct 2017 19:58:15 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Line ending normalization doesn't work as expected
Message-ID: <20171006175815.GA31970@tor.lan>
References: <958c9b03-062c-0bea-3b25-939a36659f32@web.de>
 <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
 <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de>
 <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
 <CAHd499BCMOcur6NRbKfwd81zpnyzoiVCY54d=UmGpAhbD7AVTA@mail.gmail.com>
 <20171004211734.GA25379@tor.lan>
 <xmqq7ewa9xw6.fsf@gitster.mtv.corp.google.com>
 <xmqqo9pm8e4l.fsf@gitster.mtv.corp.google.com>
 <20171005214248.GA31593@tor.lan>
 <xmqqa8156rok.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa8156rok.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:0o6gQBp4kYueJoRpdTijppk8ywNDvFcMy9QvC5z3fMiqi7mIjvB
 BgtVaRWTgj/rusxYg7y5P3NW8o0dUJzNeqBoc0I6TX/sdz4qmX47Sq8rv7N+NiYR0RfId8g
 8PLvzxlp7XHZg3eGWWtTx6GAeKSdbUqJ1uUHJ/r3wDX0zIBAby+MwzzlaE1z/BNSu8T5Xav
 VRXihUILTe2sPVQE0d78g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BcnedS8Apek=:wCpS2V9IwMsqjpSAeJ7p+V
 oyRIs2d2IETjOSV0PxBKFpOxF9Hcr+Ij9MNDnjBB/rTz4BJBV33zz6yWK1sqHyd2rTPoQvEtx
 bRgL+1H7NJUo66epva09K2U/evbOdmYgqDxRjAEYhbpSsnsRqvl4z5vZ5KuKU0ZUWb/aHyK8W
 zDcYhtuomTZ4Ql+fUstHdtg/2cBnFyo+rLldnPNHa/l+6HbCKFCAXNBoNaHYXA8zd3QJNNOYh
 FTr5yDy5fHUJX19FjzjMHXATlcHU4PjMporNu83g/Crz5HsqzM5g4itImXHyI8UH9hZj29mpR
 JvqSrxU/YsJNWsps3OG049d2jFkny44o//P7Swz3jZyQRbRhQ32wpLZfQe9bjHX1BhzbfVYnH
 C1+nx/Xpk0/RRYpHMUkejUIc/O9igJLPPEytM0CBygBJCqSQvWrSIwabAN9MjPHYScWbA80bg
 7S1rGva084lzZIZMic3FPDgwnWg/HJzaAR335c0pzTeMeZrzegeV+Ep1SXsNQbKGEOjxDHsQh
 84DkGRwJLrMsSa4QWQM8tKOzuYEyoZseIQOVPdMZwksIXSg1ziJjqyGGCqrJyXAgec9pLd3SM
 0Xqs2Z533XqgY7RV4U2hEn/BtXNtzDc+9ov6bXEl62u2naH8JgZolWmRxMun25n2rjxgUkvdk
 d0EGzykJIJNC/QFgDXksfjc3Ew6WahI+XQ4e9WxuD4zhGo+KhNWz7I5YJgULXtr4JMKdXx3sy
 5OywxOrDzneEXrGk+GTJke6uUogTRp9HQHsifDY+DlZuyeUa7wyk6rG6qJA4BaT0K6JALNUKM
 PmZ6tEzjLJGag1s1B64VsCMmoKv6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 06, 2017 at 09:33:31AM +0900, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
> 
> > Before we put this into stone:
> > Does it make sense to say "renormalize" instead of "rehash" ?
> > (That term does exist already for merge.
> >  And rehash is more a technical term,  rather then a user-point-of-view explanation)
> 
> I do not mind "renormalize" at all.
> 
> As to the toy patch, I think it needs to (at least by default) turn
> off the add_new_files codepath, and be allowed to work without any
> pathspec (in which case all tracked paths should be renormalized).
> 

OK, then I will pick up your patch in a couple of days/weeks, and push it further then
(Documentation, test cases, other ?)


