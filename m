Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8343F1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 12:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeH0QRl (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 12:17:41 -0400
Received: from mout.gmx.net ([212.227.15.15]:47969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbeH0QRl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 12:17:41 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LiTF6-1fODht21q0-00cfL0; Mon, 27
 Aug 2018 14:31:05 +0200
Date:   Mon, 27 Aug 2018 14:31:04 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Stefan Beller <sbeller@google.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH 04/11] builtin rebase: support --quiet
In-Reply-To: <xmqqsh3ofy4f.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808271416410.73@tvgsbejvaqbjf.bet>
References: <20180808134830.19949-1-predatoramigo@gmail.com> <20180808134830.19949-5-predatoramigo@gmail.com> <CAGZ79kah=sGgzJS1rL6Bx1Vkd6RVFLUNEk_o4iqKsjDx5_arJw@mail.gmail.com> <xmqqsh3ofy4f.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:34NgeXCT9cbsuOFazMPFdoTCpWN3d7SZZywa6JTi8i9rvM/b2Rl
 YXdvZCZlG/49SmOsBiowGYlysQugF6l0ehngry/5u+muU/p4VEkGyt8sn9he8251i7y6HjQ
 u0TXf2mctGQ/8eV2NlewryrHTjGpQs6+uVGkY5hpsBZQBJbEKGiHNL5/t+9xiukXfS/uyAJ
 MZ8hhKbxlCvBjd5upz9dQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2ZRvLP8vd78=:AZAHJSBvSa4FTT812ZOFe0
 ATHcWHC4DhDhonHA0mHqWee26YGGU7ZpTGn8Oa2imnwtAapUqnlF/LQL59Ggls9UyXums8qnX
 1BFwN5QA9sw3X4BE3aDKEP7zo1C8Ep3ufIyQvejI85mnlaSgkLVDB+7q9XzdSKYRALx2f8R4Z
 3MmHYgyEkP/4mSVMN5he4AJUXdvXGR2o8WVhN2Oc7yPrpZOyeeq6c8WgKZh/MCfVWIwxXamvv
 0WzDLQalA/HNvDkNCRiYvJmyShepbGfxyuxDnLyixFnLfJduuPph57pIwl/lexzO575xz8TDU
 ijBMQrmy8AiQSnvKppCwum1M4UTYErnfy8xw5OShuuk2j1GXbJfK/WZwlND+8GmeqFTVlCqNt
 DVae0omM4vB4WDr3IeeDwrYL4p4oxAXeTHK2taw5QO9xE0KC0ZMqpltX6SwwSDXFeivonZ1Aj
 c8a1jXloLHIy8qQUcPIRcUmSpODDgElCaWpAFU7cdByjdJjEnP9/tWnjxm6qs6sGlnGNdtjuW
 veb/Ly4TKQJ3d3a/97JxZd7zqUpss9677pFlvI/XFtfy3VdbSvOcrC2a5frzUOgTmvFmLpU3s
 rNMP2caSnE9TvLrnJm4XxqwXfyXAenyi9LvjhRBrKFRNzhZOu+ZChz/rhRbHbp210zhnbISF4
 OKZ7CTjqKlL2v+N4lk9GuI+c77LwjCbPn5QXJdRU1fsk79jYuoKwq4Eyhjsaf/f7V41AWHPp8
 6ekifEC1o950wQJ12Ftl/uhg637/k5bHh7nuO5GSL5i+2eALCRX6rYgmeIQRNA6AUsoscQDDc
 XoQPVx8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 8 Aug 2018, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> > On Wed, Aug 8, 2018 at 6:51 AM Pratik Karki <predatoramigo@gmail.com> wrote:
> >>
> >> This commit introduces a rebase option `--quiet`. While `--quiet` is
> >> commonly perceived as opposite to `--verbose`, this is not the case for
> >> the rebase command: both `--quiet` and `--verbose` default to `false` if
> >> neither `--quiet` nor `--verbose` is present.
> >>
> >> This commit goes further and introduces `--no-quiet` which is the
> >> contrary of `--quiet` and it's introduction doesn't modify any
> >> behaviour.
> 
> Why?  Is it for completeness (i.e. does the scripted version take
> such an option and addition of --no-quiet makes the C rewrite behave
> the same)?

Ah. I mentioned that an explanation for this is needed in the commit
message, and I guess that it is a bit too subtle. The part you clipped
from your quoted text says:

	[... `--quiet`] switches off --verbose and --stat, and as
	--verbose switches off --quiet, we use the (negated)
	REBASE_NO_QUIET instead of REBASE_QUIET: this allows us to turn
	off the quiet mode and turn on the verbose and diffstat mode in a
	single OPT_BIT(), and the opposite in a single OPT_NEGBIT().

I agree that this is a pretty convoluted way to express the issue. See
below for an attempt at a clearer commit message.

> >> Note: The `flags` field in `rebase_options` will accumulate more bits in
> >> subsequent commits, in particular a verbose and a diffstat flag. And as
> >> --quoet inthe shell scripted version of the rebase command switches off
> >
> >   --quote in the
> >
> > (in case a resend is needed)
> 
> Meaning --quiet?

Yep. I should have paid more attention in my pre-submission review, sorry.

I changed the commit message to read like this:

	builtin rebase: support --quiet

	This commit introduces a rebase option `--quiet`. While `--quiet` is
	commonly perceived as opposite to `--verbose`, this is not the case for
	the rebase command: both `--quiet` and `--verbose` default to `false` if
	neither `--quiet` nor `--verbose` is present.

	Despite the default being `false` for both verbose and quiet mode,
	passing the `--quiet` option will turn off verbose mode, and `--verbose`
	will turn off quiet mode.

	This patch introduces the `flags` bit field, with `REBASE_NO_QUIET`
	as first user (with many more to come).

	We do *not* use `REBASE_QUIET` here for an important reason: To keep the
	implementation simple, this commit introduces `--no-quiet` instead of
	`--quiet`, so that a single `OPT_NEGBIT()` can turn on quiet mode and
	turn off verbose and diffstat mode at the same time. Likewise, the
	companion commit which will introduce support for `--verbose` will have
	a single `OPT_BIT()` that turns off quiet mode and turns on verbose and
	diffstat mode at the same time.

Ciao,
Dscho
