Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F06120248
	for <e@80x24.org>; Wed,  6 Mar 2019 14:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfCFOQk (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 09:16:40 -0500
Received: from mout.gmx.net ([212.227.15.19]:39025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfCFOQj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 09:16:39 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXZ4Q-1gV1yW0x2E-00WZ9D; Wed, 06
 Mar 2019 15:16:34 +0100
Date:   Wed, 6 Mar 2019 15:16:33 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Duy Nguyen <pclouds@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
In-Reply-To: <20190306044955.GC6664@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903061515140.41@tvgsbejvaqbjf.bet>
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com> <CACsJy8DhDe+28z2=3v1dBqco7q2Zj12hdKKT==yWFPui8SBkiw@mail.gmail.com> <20190306044955.GC6664@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:c93iNj0Awa29wrfwLv4PFJP6jGZGzy8RJ24sM2Ll30bdCybPGjy
 zDgGbkNizl/NuIZ0b5wv6YM6bv25+196dxuXglQ7zCeS9xYr1LkrE0j/ZmWcFIhpJDxu3UQ
 TVG7HAjlr/WgB18Q1TfsqKLQxa2VJtr7dHgrfdg5sDJpFh2UJ6dGl/EQFvolP3QkY4KO6KC
 Yf4wAXvj2IbcS/Zbo1t6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r7fU6bT+ECw=:bmH4WpHGZrVAjOoyHwxzFc
 CCm7LLiglhYsocKIwGSirnpoAr1x9A1B9kiSWex4ccXa0E6Byd6LtRDJlOqOYP3Mx9nrJb+oz
 CTFt3qZJSAFc2v4mjk+E2g+jXEHqcwIY3hCpKI54d61i1Z49aaLEVbsaJpCcEvP/Plh6xAmdA
 zqPZSl1Fmo2vXEMzhKOvrblP98jgWoEcHy2udp2/SBHJNHeVFOCjGe1uEkvU9HFdUEHF0CTy5
 /VsyNAy+2VXr+tnd+KVNsjd/sNkJAY0463+Pa/KlUq2cHJ360NEySfY9eLiybLE170gzmGCl8
 4D4A0adUdUJEu5OnxJ+N8xoYbeQuO2+9IABxAW7IZjbHruMCpyZdt9fXABrBlem3AzNYK1NNd
 jeKjb33yJVTJ9XjgsHh2XgGZi860P5R2MjJznMUmHzqvJP0+9mtV7wGfn/Kjf1S6ks1EaIzbu
 eFI4nQjOBKPu42U+KWLY4fHguA1pCgJMtzcBgpg9RTRGmWodRUvYB+yLDq8Z5g+HdOTOmGkk1
 4CqKhRR0oxIO4xRpRgKOkz2CD0b3DWdPdGybADMrKGwRUiQOXr9uBVqzfFMYtXo97GFaCpnb8
 zqWfjnwtKC56xfQdWQQ5/kGmt6Yi8f0wWNlshIbfCaJQZgCoh2ALCpgfqzdzq/80UJY/fO7T5
 PSnSnfsqas80mNGmqkftks441FQ9gtEZmCTxYnHPDRDHb91ni4pglPznZwM59jsMyWBl6Baiy
 GS2Q/s6pt6p+BC1+q7W+/wwefmNeeRhNWuxOtRaD1myxq/BtsNA6JL1nFWujYnD0RqGeR3Jbv
 oGHd3G1wF9Oawq9Rq33dI53pQJnAk6ktoeFBXjUbd2ln5XAKe7xmFs4jLGbectqpQQR6yfFIP
 92JEh4WpGENidnwtViVY8+EqAEciraGbtuRZjuTNM7SGzQ1wqOcMeYqOG67hC+kfuVxB4uFlj
 sgTobeFkivg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 5 Mar 2019, Jeff King wrote:

> On Tue, Mar 05, 2019 at 07:04:59PM +0700, Duy Nguyen wrote:
> 
> > On Mon, Feb 4, 2019 at 4:17 PM Christian Couder
> > <christian.couder@gmail.com> wrote:
> > >
> > > Hi everyone,
> > >
> > > There are now ideas, micro-projects and organization application pages
> > > for GSoC 2019 on https://git.github.io/
> > >
> > > It would be nice to have a few more project ideas.
> > 
> > Not sure if it's too late now. Anyway this could be something fun to
> > do: support C-based tests in our test suite.
> > 
> > A while back I noticed some test running very long because it was
> > trying a lot of input combination. The actual logic is not much, but
> > because of the increasing number of test cases, overhead goes off the
> > roof. The last part is probably not true, but Windows port I think is
> > hit much harder than what I experience, and I think Dscho did complain
> > about it.
> > 
> > So what this project does is somehow allow people to write test cases
> > in C instead of shell. Imagine replacing t3070-wildmatch.sh with a
> > binary program t3070-wildmatch that behaves the same way. This test
> > framework needs to support the same basic feature set as test-lib.sh:
> > TAP output, test results summary, maybe -i and --valgrind... To
> > demonstrate that the test framework works, one of these long test
> > files should be rewritten in C. I'm sure there's one that is simple to
> > rewrite.
> > 
> > I'm pretty sure I had some fun with this idea and made some prototype
> > but I couldn't find it. If I do, I'll post the link here.
> 
> In my experience, it's nicer to have a tool written in C that can be
> driven by arbitrary input. That makes it easy to write new test cases,
> because you just have to write in some easy domain-specific format
> instead of embedding the test data in C code.
> 
> And many of our tests do work like that (in fact, many of the Git
> plumbing tools function as that). E.g., test-date gives you direct
> access to the low-level routines, and we feed it a variety of dates.
> 
> That doesn't help with the cost of invoking that tool over and over,
> though, once per test case. I wonder if we could have some kind of
> hybrid. I.e., where t3070 is still a shell script, but it primarily
> consists of running one big binary, like:
> 
>   test-wildmatch <<-\EOF
>   case 1
>   case 2
>   ...etc
>   EOF
> 
> but with one added twist: test-wildmatch would actually generate TAP
> output for each test, rather than just returning 0/1 for each success or
> failure, and being embedded in a test_expect_success.
> 
> It seems like that would even be pretty easy to do, with the exception
> of the numbering. It would be nice if we could intermingle this kind of
> "chunk of C tests" with normal tests, but we'd have to figure out how
> many tests it ran and increment our shell-script's counter
> appropriately.

Oooooh, that sounds like a very nice idea! Eventually, we might even be
able to specify our test cases in our own, extensible language, where we
do not have to pay attention to &&-chains, or portability, because our
test runner does all that for us, under the hood, as it should be.

Dreaming of that future,
Dscho
