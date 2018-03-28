Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2304B1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 16:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753195AbeC1QeJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 12:34:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:35013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752936AbeC1QeI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 12:34:08 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lj1Xa-1eQFZt2cKk-00dEiE; Wed, 28
 Mar 2018 18:33:55 +0200
Date:   Wed, 28 Mar 2018 18:33:55 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Thomas Rast <trast@student.ethz.ch>,
        Phil Haack <haacked@gmail.com>
Subject: Re: [PATCH] t1300: document some aesthetic failures of the config
 editor
In-Reply-To: <20130329195155.GA19994@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1803281220100.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAD7mMPW=jr6PaAc50h-Wpf42-UPrn0A5KmisqXNXqqLv78AEgg@mail.gmail.com> <20130329170032.GA3552@sigill.intra.peff.net> <87ip4ayvfn.fsf@linux-k42r.v.cablecom.net> <20130329172307.GA11099@sigill.intra.peff.net> <20130329175058.GA13506@sigill.intra.peff.net>
 <7vobe2nins.fsf@alter.siamese.dyndns.org> <20130329195155.GA19994@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:g+BPd/6NRYgWOP+OTl/B6r0GJ2NHZmwmm8D3dJwiZiI7m8Ygl1m
 b1Yl/3IseDX6pW2+DEhpuAdBiQ5NpaEOp8nsK5VAvbThhFZTPhIX+LmudY28Rco93sl4Sni
 7iOxOdvEKudz6y/ecHYK6o2GLFb2eTB/LzNU5UcK+4P7NgHGl1TcTG/dz9iW+BnJP6bTL3N
 UvHyQ43BJ+h9QLFWhRNhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aHWQfWHWQ+c=:rjfaplIZgxIxddMaA1nKn+
 ITJlndk80Y3DR0+PB+7PRFqthoPYRgj+M5zgFb09AT5xBniLx5lMhdnJzU9/OJk25x/LC1FrS
 UltT8H/ABOKbsX6DSlZX9qxFpIW2PIcZkk4EUsxID0P7+GSA6zrAJTKAfJiTCjlOUYdA0t1ae
 vuy9JZYHdRIEING+Sx5newZaM1s/qzuPVM0KvDLkwmPLX4ocucRtVpas5d3u6lSIB7Ge0PVRE
 Kvjn39A6GxnK1pTcUaugjvV0iuKUFuKC6YRHqVZqkhrPYSmsu8GmGszfiFSY6pM9BLbCXLYJw
 UQKTEzoWDTvCRQ9IB0cbIIXPmRygQI2Zws92n2uAlPxs+TZHnEDTNZWcOrY5GsUJNXjKRpaGn
 Xa6//UMnEiTeAFgU6Ll5JmjUs077AXfrKKpn9EZ8jaNSuxCHMypKyiR3Dx+kbtLEDQIaOhQVs
 11BHsWUf1cuViVZxLIhpcCTio2yUHm5bfKLP2oJAKVBXy3+Y0GfkmbOQFZK7PHS9NqX72DwVS
 hF6p4xMD2OsKUYC78N7yPjVyOnCb75B4YM2LsW1m4vYTYdQMVqsXt2ZTC9lUt2UVtY950aKLQ
 nbu7DAZ6mDzWX+LRCaW0WIs4lhKS6EWexnrP5hYgJpfRXngwSieZo8zyxbyGcn7BT/ZMAgtR3
 APwdQzXsSXegApVsBS9QBU59nKY9DDX8JoOJbVJJEe0N65myJTvPFx4cbjFkXVaC+8N9iwa0g
 1Qgb6WYvLQ7FI26ohr2OPy1nJV4CRqfTSlqSBun/tYaSas6uLmUu0wyccacpfJApGyQLIqzAx
 n/ex/yOkqCLmMJpDbmGLcYtLqrVcJ5F230oRcH1MABarJJaHvJ5dM/8sRj/7k4/voNkIRje
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 29 Mar 2013, Jeff King wrote:

> Subject: [PATCH] t1300: document some aesthetic failures of the config editor
>
> [...]
> 
> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 3c96fda..213e5a8 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -1087,4 +1087,34 @@ test_expect_success 'barf on incomplete string' '
>  	grep " line 3 " error
>  '
>  
> +# good section hygiene
> +test_expect_failure 'unsetting the last key in a section removes header' '
> +	cat >.git/config <<-\EOF &&
> +	[section]
> +	# some intervening lines
> +	# that should also be dropped
> +
> +	key = value
> +	EOF
> +
> +	>expect &&
> +
> +	git config --unset section.key &&
> +	test_cmp expect .git/config
> +'

This would have been good on its own. This documents what a user may
expect, and it is a reasonable expectation.

However, Junio, what you suggested in addition *and squashed in before
merging to `master`*, is not a reasonable expectation. If you are asking
*code* to determine that in a config like this, the second line is a
comment belonging to the section, and the first line is not, that is
totally unreasonable:

        # some generic comment on the configuration file itself
        # a comment specific to this "section" section.
        [section]
        # some intervening lines
        # that should also be dropped

        key = value
        # please be careful when you update the above variable


Worse: it does *not* demonstrate a known breakage, at least not precisely,
as what you ask here *is not technically possible*. Not even with NLP, at
least if you drive for 100%. It's just not.

And your example is not even complete, as this is a totally valid config:

	[core]
		; These settings affect many Git operations; be careful
		; what you change here

		key = value

Obviously, your example gives the impression that `git config --unset
core.key` shoud *delete* that comment (that obviously is intended to
document the section, not the `key` value).

And this is bad, really bad. And this comment does not make it better:

	I think we may not attain that ideal without some natural language
	processing of the comments. But hey, no reason not to shoot for the
	stars. :)

There *is* a reason, a very good reason *not* to shoot for the stars.

Think about it. The `test_expect_failure` function is intended to
demonstrate bugs, and once those bugs are fixed, the _failure should be
turned into _success. And if somebody looks for work, they can look for
test_expect_failure and find tons of micro-projects.

What you did there was to change some valid demonstration of a bug that
can be fixed to something that cannot be fixed. So if an occasional lurker
comes along, sees what you expect to be fixed, they would have said
"Whoa!" and you lost a contribution.

Let's avoid such a "shoot for the stars [... and get nothing, not even an
incremental improvement in return...]" in the future.

On a positive note: I just finished work on a set of patches addressing
this:
https://github.com/git/git/compare/master...dscho:empty-config-section (I
plan on submitting this tomorrow)

Ciao,
Dscho

P.S.: While I am already raising awareness about unintended consequences,
let me also add this: that "cute" feature that unambiguous abbreviations
of options are allowed bit me royally today. Try this: `git config
--remove section.key`. And then be surprised that it does not work, even
if you have that entry. The reason? The option `--remove` is a unique
abbreviation of `--remove-section`, so even if I clearly meant `--unset`,
that feature (that every Git user I tell about it is very surprised to
hear about, so it is not like it is helping a lot of users) has the
unintended consequence of being completely wrong. It would have been
better to tell me that there is no `--remove` option.
