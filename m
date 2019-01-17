Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A9A81F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 09:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfAQJgJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 04:36:09 -0500
Received: from mout.gmx.net ([212.227.15.19]:38759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726914AbfAQJgI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 04:36:08 -0500
Received: from [10.49.97.215] ([95.208.59.108]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lmqxo-1hR6U40S8y-00h4Os; Thu, 17
 Jan 2019 10:36:04 +0100
Date:   Thu, 17 Jan 2019 10:35:47 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] t6042: work around speed optimization on Windows
In-Reply-To: <CABPp-BGedyPLu+_=+CQhEonyyw74aMSF58tjLc2FjCLs8vyEmQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901171024500.41@tvgsbejvaqbjf.bet>
References: <pull.109.git.gitgitgadget@gmail.com> <598de6652cdb19b9772f322f17600c3845f208cc.1547645839.git.gitgitgadget@gmail.com> <CABPp-BHOkVKVpZy2RKj-ofoajGT0rgrb2TpQsXprk1_yZwtVfA@mail.gmail.com> <nycvar.QRO.7.76.6.1901162108140.41@tvgsbejvaqbjf.bet>
 <CABPp-BGedyPLu+_=+CQhEonyyw74aMSF58tjLc2FjCLs8vyEmQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QFqpnPRsxIZw6eooAQ1JfBceF8MYmZ6O6OrMRyftpcIETve9LLB
 f2fCBGdO+4aVRogJdhpOK6aC3dJ+AFsWgWd/QH37KXofEPuB+dcvRAFhG9Jm+ZE1QDMPN4x
 Iiwib4FB3+ME9x68BBFzcPpJMKoAbX8DPZYIe9Z4sLFG2oh3K06DZHhMfIzD4cVFvOFFyIQ
 GWHn9MQNYzblftheOCQPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uQeM5BXzFPE=:MhHbVYQKFXqyCGBT/1RoxY
 83NGkuGidxRPYTtfW2Npd699FtLRuuONBUq88a+bzbwSMHJmJ9+raiIjisbgW4jhbIJ9B19Nb
 gp6izOrLWSfEe/EQz5SZF6EQamA0ZG+cwjP+fGN4FPkjAlmtcZ4jWAX/4Dt1TrOFIARggGF6H
 nymcoS3VfVrzpqR/WlGyNTEbbn2k+zp4SkuJjzoEEOwVlqritB8YLDlKYx2cVI0WLKpcCiY3j
 j3+eKpJ4qFFRdZ3Jry6zhHRxLiQKigZ4+UD1JgPQ0olMC5Ev4u3+ahxXRat+wZVtqGpfPP9Ho
 wleejvmArCV+UcYlxwFV1kGWC2fczlQ/foBkTMzwrRLWoTW7RQvUZim2PCp+tqsCqLQQb8vkl
 0EvOv4h2B3qEGKl04p/qdMxJzRFiae1cY5zgBDjeTk+XCc3bl6e+ERmunI/EDMFCibqhv/LxG
 sWL7o9g2gIp5Log6ATexD33m3ndx02UEIYPbE1Bs26T8MI2rSVoKigxbdfXWY9wdCDO+Dk3J2
 JwOExVpGkf9ej+BGrDRf/EGtGv3FaqM04b47IWheZbgA9hQLz0zNWqT9yCgjs6RRcKSZwyLx4
 OSuLLCKrS0j5gseQzSXXCci7g8SpLqKg3hNUo9PMNgsPZFJGWHhOCzkoIZmjXjfl8iQUfLZ2k
 6HYHYmO/xlXp0BvAKIC48eG5S3w0c2Na1WaaMAwP5v7eJ0+V2a0aS8PR68TJpRO+jZPRnoNPE
 Liunl3XW573FP/d+hBC62U49tv1FwhqrWBRgDxjyON55Cfbli8mUYtMMA1tYoqd2UBuZYT25x
 WbwbEC+kg6YjiwLB/Gp1xHsPFZLrKR5oh8qhuMyWJAA3lpvLDQUwUdw7DXyAvi/vh17Vmqk8S
 ZvYEArTs6ZsKUXRcR4I6hvjJqbbjrJgMkoVqt9v9vbM4qNGKy+AM2nfLUHX+nSQoxuITiVSNe
 SbcO21GUcsGb647x1q5zo6qLgeetVyCzsPEahre/V4knmH0VsqWY0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 16 Jan 2019, Elijah Newren wrote:

> On Wed, Jan 16, 2019 at 12:31 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Point in case: it took me quite a good while to understand the code
> > that I fixed in this patch, because the underlying intention was not
> > immediately accessible to me. The test failure happens in the *next*
> > test case, after all. That was a head scratcher, too: the problem was
> > in a test case that *passed*, not in the one that failed.
> 
> Hmm...I had adopted this style based on my own struggles to understand
> regression tests.  I had gotten pretty frustrated finding a failure in
> test #87, and finding out that its setup was spread throughout two dozen
> of the preceding 86 tests, with another three dozen changes to the
> repository in the preceding 86 tests that happen to be irrelevant.  I
> like the setup for a test being separately contained.  Secondarily,
> though, there were a number of tests where I found it hard to see what
> they were meaning to test because of a huge mixture of setup and testing
> in the same test.  Putting the setup in one test and then the actual
> thing of interest being tested in a subsequent test made that a whole
> lot clearer.
> 
> ...or so I thought.  I'm sorry that it to have made it worse for you.  I
> was trying to make things clearer.

Thank you for caring. Truth be told: while it took me like 15 minutes to
figure out that the problem was in another test case than the failing one,
which is not my personal record (I forget the details, but I am fairly
certain that there was a test suite failure that I had to hunt for
multiple hours). So it is not all that bad.

And yes, having a single setup test case rather than dozens is definitely
a good thing.

I just miss the expressiveness of object-oriented test frameworks, where
you would define data structures with intuitive method names, where I
would have immediately thought: oh, so this wanted to merge diverging
histories, but, but, but, the first arm does not even have a change...
now, where should that have been changed?

As I said, your test cases are not the most convoluted ones, and it is so
good of you not to add more test cases relying on side effects from
previous non-setup test cases (there are quite a few offenders in the test
suite, and I am ashamed to admit that even I added some.)

> Anyway, with the wording change to the commit message you mentioned
> above, feel free to add
> 
> Reviewed-by: Elijah Newren <newren@gmail.com>

Done, thank you so much!
Dscho
