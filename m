Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FB8D1F437
	for <e@80x24.org>; Thu, 26 Jan 2017 12:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753789AbdAZMBd (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 07:01:33 -0500
Received: from mout.gmx.net ([212.227.17.22]:60469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753263AbdAZMBb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 07:01:31 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFxwA-1clYBw2t9y-00Et3s; Thu, 26
 Jan 2017 13:01:06 +0100
Date:   Thu, 26 Jan 2017 13:01:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH] connect: handle putty/plink also in GIT_SSH_COMMAND
In-Reply-To: <xmqqinp2939j.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701261259260.3469@virtualbox>
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de> <xmqqy3ym1dsc.fsf@gitster.mtv.corp.google.com> <xmqq4m1911mf.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1701090825510.3469@virtualbox>
 <xmqqh958y44c.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1701091207480.3469@virtualbox> <xmqqmvf0wc2h.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1701251327090.3469@virtualbox> <xmqqinp2939j.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ESM6hMqI7JPgPHgXYD/K+JJfntEyuGKTty3LBsRwxRF9aHjvcFX
 cargzPHXvmgKF78XDJ2rPj43zqhYBh59+aOwWZZ7ATkA8SWmxXUhXgozIp49kpYA1039YCv
 wHququ53x3H6Q/guIvQEQbrxyvZUnBMqI+CnMFff0yqVJmC6rmpcFOSBPoWtl64a2jQHg7v
 W9dBb67jVqORj8bOi7Shw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DqhlkQWF34Q=:krOgFc5gu1rqhvxSXDvXha
 2b6w4nNkhYAwJMN+urJcD0l+cBgDPjKO12bbFoIQbipyGbWh8qgk3KU/DM67a61ipJLDLrSqz
 Nryj+/wfjwbSsKmA7C9/ALgR11WXqDg23isoJKOXCUkxm7doihDb48qcM+qIZ2YgB3FjzZ/JB
 EqOY5YVK/CdmEEyGRkdpSeC5oCv7ESH7X5cMNE8rRgA44P6COT62mOmCqHUEYNgFMwaxYynod
 F3wpkRqAk2W0sRURQM6h5PZ3NpwwmHuz0+LurXVFxvGlcXqdhBSqchcCddek32n6Yal3qxp69
 j/hfypZ9EgdbIviWl2GAb340ZKJzqNtCYZ7yp25g8GBcpo7npNsFYs99un3BXzs0vqOJ2JJFY
 f1GLe3hbQ44+X12NTBKwfeFyjxm/eGRNcV3hVAzsQN86lhVCJZAN7YRI7COYVdzTeJFrJvUF6
 U0XGKHaMQfEm1GdZ0NijvWFdElj8DOm+tas2jPv0RiYE9xxvCSaB7CQpPXsm5ZclfgunWhdjD
 f+192F45OG7jcGiZH+rtF8shjT2jeA8KWfPtqS95yECL2e5Mv688BOUYHesZ1OVtF93BscIHm
 RZcVCH2yAZIc6VGFc+ozl4DRQNdZ3Wy3wYHSJ6Yn99jl5U9BfyAMn7frcXrsHd/Hdmdja0GNm
 UFVUoeDj9R9ApD1Yb3S7z60sXkLpkPVGKdr9Vq4EaJktFUdMQObSgI0xcqrYRS6+IBbC5spTP
 LHgmrAyrVe5gIE1MPTpz7nUsOa9TCauPt/eyrUKdduv5L+cKJkOeY4oVvHkWuiMM0BD5mqKqU
 To1EM2n+lR/9lo71SPr97LQspzBUl9mp+u3ttwIx/A1AsSB0RPP+WRd+bobxjkXS5shTviwsO
 9BcDjwaut3hzKvNXOB58DHJ7dd9CwJJk/00TXWGMjeijYv+H02sw+HGjMZSOKxwafKgMbfJwd
 FZHpyJLyYZ4k8PBZv18IMJcg3jP43wFX0FP+IGZnfj6RgaJhaLY4bX4wLk+uUtleCL6bFs8Z3
 kiLbDOWE8ICX2ZJS8ZiXMjcrts1Q38E3EWtFYEhoRoz3iy2wuKqKw3dYqhjwklTr3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 25 Jan 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Now, with the patch in question (without the follow-up, which I would
> > like to ask you to ignore, just like you did so far), Git would not
> > figure out that your script calls PuTTY eventually. The work-around?
> > Easy:
> >
> > 	DUMMY=/plink.exe /path/to/junio-is-a-superstar.sh
> 
> Think about how you would explain that to an end-user in our document?
> You'll need to explain how exactly the auto-detection works, so that the
> user can "exploit" the loophole to do that.  And what maintenance burden
> does it add when auto-detection is updated?

Fine, you do not like it. Saying so (instead of asking me questions) would
have been helpful.

> I think I know you well enough that you know well enough that it is too
> ugly to live, and I suspect that the above is a tongue-in-cheek "arguing
> for the sake of argument" and would not need a serious response, but
> just in case...

It was not tongue-in-cheek, I was being serious.

> Yes.  Here is what comes on an obvious clean-up patch (which will be
> sent as a follow-up to this message).

I'd much rather prefer
https://github.com/git-for-windows/git/pull/1030 than your patch.

Ciao,
Johannes
