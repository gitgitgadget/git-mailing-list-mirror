Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3163D1FF76
	for <e@80x24.org>; Thu, 24 Nov 2016 21:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966233AbcKXV5F (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Nov 2016 16:57:05 -0500
Received: from mout.gmx.net ([212.227.17.20]:53351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965905AbcKXV4q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2016 16:56:46 -0500
Received: from virtualbox ([95.208.59.199]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSY2q-1cHdGs0fyu-00Rcrs; Thu, 24
 Nov 2016 22:56:30 +0100
Date:   Thu, 24 Nov 2016 22:56:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming
 builtin
In-Reply-To: <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1611242211450.117539@virtualbox>
References: <cover.1479938494.git.johannes.schindelin@gmx.de> <cover.1480019834.git.johannes.schindelin@gmx.de> <3a10fd72cf336743891d6bc9a003cfeb5c3f0063.1480019834.git.johannes.schindelin@gmx.de> <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wZj+Vgd1fdd5TjcSWMobKPRjnSO4CSY4HXlYt0n/4oVgYT0y6d7
 xOl7Ue0o43dHgRqQVBdJTY3Jl0zES/1iBlDwr7L9khQy0aOrl3qPU6/iX3uD1Yypz9/xq9E
 yvUfECmCrPawU2k+Iy5xu3HT34BJ0wpST/l8IY7sFdHdciGyC0VqQZWz+CzWureoHwP9pTA
 v0csqBjxexbmcCSZvxVsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4oI/BT8NasM=:0u6elttyhKQ4lCt7JZeVc4
 munD7T5XU5KFcfbZF4SqAcmBK+QrpqyTaSpywUVDMwThGLWScFa+cPrQ7d+f0fhVoUkXoxfNF
 4BILmPT9h3GIDDnM6UYGg6KEa2ClGeNApvZbBufbiL2CrjJkjsvsedmiAoKD7AzEPyolLshv7
 NMt0sKMmqKEkZx4WGnxVd+C0GssgiGv1JnqzUzbNCxNgeiT2ZFtO2cd6iOc+1ZVCituVDtgPz
 N0dNWM6Twyd2h4gU3SOqkuEDtSBzJ0RvW6DnuiQF0WhHGRmB+18pedOoiKdm6HsyA7VZmJwg/
 uzg5xvB+7RCkr01qAzE6UneJ9/AtEU+ux1vRMQBcs2kBH0SbZ2qpk4K+HKEhvkbjTEU4qVGYT
 MQhfRIRytnC+RYwzkXklNCQzdQvPYUs0e6Sb9cUohX8J33cT/vmVOP58s3onbmBr+I68jeSAv
 qFTwPH/EgRhRSBIom0LkcqZC599Tim632g7cjQwoOpflD5xb41AK8Wj9EBs8GtItIgOXBEn4L
 lG4K6KnT/gaOT/QF2IwGV6wPfw9HOcRNAGc+9k5+JWucvLyi1wn9Z7waFxr29QIIcChpD+6dM
 HUIBYxq9D6swr7JJ0DyNaCsTJgHxJgbzNdtaCAnoRYEuW2VVF/aDtF1eWs7iNhbbqGX7d89Rp
 CtIKVQ5tOd1FaqL4vhneyXQTxafTjuS33LJmK1oiCqzfdHXAN6ACBD9HVGKVKM4kjuTVhTewe
 V8iK3r1nfsxfSemeuxfSWemI0UuvnRv2tJbDQ+OiD7zxhRXVQ+Z2IGhovd0tmP9PVTiRTSGPq
 uxcH6WX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 24 Nov 2016, Jeff King wrote:

> On Thu, Nov 24, 2016 at 09:55:07PM +0100, Johannes Schindelin wrote:
> 
> > +/*
> > + * NEEDSWORK: this function can go once the legacy-difftool Perl script is
> > + * retired.
> > + *
> > + * We intentionally avoid reading the config directly here, to avoid messing up
> > + * the GIT_* environment variables when we need to fall back to exec()ing the
> > + * Perl script.
> > + */
> > +static int use_builtin_difftool(void) {
> > +	struct child_process cp = CHILD_PROCESS_INIT;
> > +	struct strbuf out = STRBUF_INIT;
> > +	int ret;
> > +
> > +	argv_array_pushl(&cp.args,
> > +			 "config", "--bool", "difftool.usebuiltin", NULL);
> > +	cp.git_cmd = 1;
> > +	if (capture_command(&cp, &out, 6))
> > +		return 0;
> > +	strbuf_trim(&out);
> > +	ret = !strcmp("true", out.buf);
> > +	strbuf_release(&out);
> > +	return ret;
> > +}
> 
> FWIW, it should mostly Just Work to use the internal config functions
> these days, with the caveat that they will not read repo-level config if
> you haven't done repo setup yet.
> 
> I think it would probably be OK to ship with that caveat (people would
> probably use --global config, or "git -c" for a quick override), but if
> you really wanted to address it, you can do something like what
> pager.c:read_early_config() does.

The config setting is already overkill (and does even make something much
harder than before: running tests with the builtin difftool used to be as
simply as `touch use-builtin-difftool && make -C t t7800-difftool.sh, now
I have to edit t7800-difftool.sh to configure difftool.useBuiltin, and
without the repo-level config even that would not be working).

Imitating read_early_config() would be overkill deluxe.

> Of course, your method here is fine, too; I just know you are sensitive
> to forking extra processes.
> 
> Also, a minor nit: capture_command() might return data in "out" with a
> non-zero exit if the command both generates stdout and exits non-zero
> itself. I'm not sure that's possible with git-config, though, so it
> might not be worth worrying about.

As it is, I spent way too much time on a feature flag *that will go away
real soon*. And not only I spent too much time on it: everybody who even
bothered to think about it spent too much time on it. It is a temporary
feature flag. It will go away. If it is inefficient, or inelegant, it
won't matter in a month from now.

In other words, it was not really necessary to spend all of that time and
all of that brain power to first discuss the shortcomings of having the
presence of a file in exec path as a feature flag, then converting it into
a config setting, only to find out that this *causes* problems that were
not there before.

Frankly, that was not what I was hoping for. I was hoping to get a decent
review of the *difftool* functionality. David did a fine job to provide
that review. All that discussion about the temporary feature flag was
really a side track for me, and I hate to admit that I let myself get
sucked into it, and it cost me quite some time that I would have rather
spent on release engineering the preview based on v2.11.0-rc3 (including
the difftool with *any* type of working opt-in feature flag).

Maybe I will write more explicitly in the next cover letter what I intend
to do, and what parts of the patch series is intended to be throw-away
material (hence "good enough" is good enough, and discussions about it are
really wasting all of our time). Of course, I cannot dictate what other
people find interesting to comment on, but at least I will have a good
excuse to ignore suggestions that only distract from the work that is
really needed.

My only solace is that I did some substantially more intensive testing in
the wake of this discussion, thanks to the test suite breakages incurred
by switching the feature flag to a soon-to-be-abandoned config setting.
That makes me much more confident about the builtin difftool, which is all
I wanted in the first place.

Ciao,
Dscho
