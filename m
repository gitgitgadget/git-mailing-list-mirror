Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B2001F597
	for <e@80x24.org>; Wed, 18 Jul 2018 12:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbeGRNBZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 09:01:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:42027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeGRNBY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 09:01:24 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYfJW-1fapnu0rNC-00VPMw; Wed, 18
 Jul 2018 14:23:28 +0200
Date:   Wed, 18 Jul 2018 14:23:11 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/16] Consolidate reachability logic
In-Reply-To: <20180716161821.GB18150@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1807181420250.71@tvgsbejvaqbjf.bet>
References: <pull.10.git.gitgitgadget@gmail.com> <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com> <20180716161821.GB18150@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:USsqhB3gERLDVXGgLA8151+jcKnpvaR+ddNKLPYxbJDwNq3AQC7
 5OuQ+cvJQ13yAGrW5td2KtnT3tVxUw0acg2SWM5VY4xPvDw89RlMdzXH9tvwz0meeJvRGh6
 nnIrMGJZdnBjlbhx5tOvshpNz34D9OtzXFBrWujeKYq/KlX8Zje2EA/UQ58Okl5w1sTC79Q
 Zl2LflOgoTb3MjyQ0oAJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OKZoGlN3AjY=:gmnYqrC+WuR+Glima9OIj5
 edxuVBzeweKLI9KyAOUzbe4NIyy0KfI0jmzjIrQuWs23NASEURFBHR8pdHGWJViE1l8ornVA1
 973LQftf+9K6F1LWZ8CUC6V2pPvRpJgh41pr3DpWpuoGohSoUUYmN1/XkHA1Kiw59SEWB1BjX
 D+91JDClco+ltWPrNZi6dlv7rYLES1YM/3+vUy0+bu7gUNqUZH/DLMoqhstCO+YBQZNfYMNqP
 Vd9q5Myjl4ZC9XRpgOsOiMFOUu2nZBGPW5zGPnl+QGXjlmpqP9KLYLwKE2Ef6oUKLaAz+rlkN
 Hq2bubcC5N+XfyEqf+yN5UJhUWzY1Gwn43t3vG8BR5D/ZKevLkaqK/rGWhmO6Sb8Y6RvG8H7z
 JNJg5TyrH3+65Ko+TmOmTApdgIjdDALLivPHn3i/2gYxUVJFizZfE9umLYAJhGsTchpmsN7Ka
 MtJ+hkjKgOrjGDuZb3cS22KkzsTs3CDQ1oviI7PKJH+WP8kixi0ICpsNM4OEMlEEn9HUMrlt0
 VxJR92MxkfbfrfuWZpAVCmFrL3zWiGEtNPCFBo6WAwgunKn94MFFDH4xA5rFZ+nVtaKHu3yiz
 Y5BYOo9tMih7/HjEP+cvrXI0Wp9xo8IARL2RkDac7dS6QzG3/bzCS7mvzFgT6Cs/cVt7LZhlm
 zxR9ROLGGjtyIg8osohF64QchGhpIhN9tCz/uSjCVABa1/Pj9zXiLi6IXpkhD8zz+J0sXpDGB
 Zc2DUzGlSA/Yq65W/L4lUnGHUbt7a4D6FIrbAyH4+oWdwuLUsICV3j0r8FiZJQOD/6D/x2zpb
 lv7MQkg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 16 Jul 2018, Jeff King wrote:

> On Mon, Jul 16, 2018 at 02:54:38PM +0100, Ramsay Jones wrote:
> 
> > On 16/07/18 14:00, Derrick Stolee via GitGitGadget wrote:
> > > There are many places in Git that use a commit walk to determine
> > > reachability between commits and/or refs. A lot of this logic is
> > > duplicated.
> > [snip] ...
> > 
> > This is not your problem, but I find these GitGitGadget
> > submissions somewhat annoying. This series has been spewed
> > all over my in-box in, what I assume, is commit date order.
> > 
> > So, patches #4,5 dated 19/06, then #1,2,3 dated 25/06,
> > then #15 dated 28/06, then #6,7 dated 12/07, then #8-16
> > dated 13/07, then 00/16 dated today.
> > 
> > No I don't use a threaded display (I hate it), be even with
> > that turned on, the patches still appear in the above order
> > under the cover letter (but at least all together).
> 
> Yeah, they're out of order in mutt's threaded display. And the
> back-dating means there's a much higher chance of them getting blocked
> as spam (e.g., some of the dates are from weeks ago).
> 
> git-send-email uses the current time minus an offset, and then
> monotonically increases for each patch:
> 
>   $time = time - scalar $#files;
>   ...
>   my $date = format_2822_time($time++);
> 
> which seems to work pretty well in practice. It does mean the original
> dates are lost. The committer date is not interesting at all (there will
> be a new committer via "git am" anyway). The original author date is
> potentially of interest, but could be included as an in-body header.
> AFAIK send-email doesn't have such an option, though, and people are
> fine with date-of-sending becoming the new author date.
> 
> +cc Johannes as the GitGitGadget author

Thanks for dumping even more work on my shoulders.

I wanted to help with that insane process we have here, but in a more
collaborative manner.

This time I fixed it, but please do keep in mind that the decision to use
the email transport for something it *was not designed for* (it was
designed for humans talking to humans) is the culprit here.

Next time, I will ask you to jump in, instead of putting the onus on me.

I mean, seriously, what is this? "You can use *any* mail program to work
with the Git mailing list, *any* mailer. As long as it is mutt. And as
long as you spend hours and hours on tooling that oh BTW nobody else can
use."

Hopefully GitGitGadget will make this situation better. And hopefully not
on the expense of my sanity.

Ciao,
Dscho
