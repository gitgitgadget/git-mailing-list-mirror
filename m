Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 231871F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 14:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfAOOGQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 09:06:16 -0500
Received: from mout.gmx.net ([212.227.15.15]:50913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730305AbfAOOGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 09:06:16 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBWo2-1ga1xw3rE6-00ATwY; Tue, 15
 Jan 2019 15:06:07 +0100
Date:   Tue, 15 Jan 2019 15:05:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/6] commit: copy saved getenv() result
In-Reply-To: <20190112102635.GA16633@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1901151502130.41@tvgsbejvaqbjf.bet>
References: <20190111221414.GA31335@sigill.intra.peff.net> <20190111221539.GB10188@sigill.intra.peff.net> <xmqqsgxywp3w.fsf@gitster-ct.c.googlers.com> <20190112102635.GA16633@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZwOVy5IR0TYged5peqm+OmqigNPuPUtNhKGNG0gpCFl9YMhvSE1
 BSKoM4xSkNme5EQtW2bfR/MTpUyW80k8eRQU+H9lgqqDTMwDCygrkFYdLPo2XbTKjnzy4DD
 BEufJUPDeRvNRoBTdEqpgWf9ZUUKtLYs2fXd7usxPf4iM8tec/o6slbWxZ0xO0cSpERnMC9
 wq7Cho71v7syHWM+1ny5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tddw7TXJAew=:F7zOYBA+lhzxbbB1iTry9W
 YaRSNVn8fl9KIsx9vvsSQvNK7PWkrmcyzTp2QD1ojec8wQ0QQCncJo1hvUCZ+wGLJsEPtMiae
 YItRQuunCdBoDJXsUH1IuHb27CgQAvJ6cyT99UgNNfHtXm2sBnQ3oOCp6jlvcJqQBzebqHp92
 woztzYxEn0XreDAnjb/p54/eBR+ceyfAzD3cR62TBTQR0hw9A+SvnLpdoHbzPO9Da1zkgUfRP
 d0R31cwTSuOa4qfEMWLRikOJZKEkjF8slpvxlnfosV6iqx7yshWqIq9MCnb8r2im02e4EHLL9
 BB5cqrdWpD2M965bX/qWgMdf8QR94gBH9rXeJE16eED1QpH6NZppMOaYFcQsizS5ol5wjzog/
 P8UQz8pViUUe87iZF1S9uQYMjZnBzWdCp3Eo5pDyOiXSj6nbpoJ9sYttDqP7coWsMAc3plB5j
 B58ZKa8KWRbfwc5OlHS3/+DvNjzfbnuCNnwdDe4zq1Qx2tFwKENFH0vcsF6smJpg4718Af0uL
 /+VTKA020ubhjleX+aI+AGl4PsD8rfjSLNo5xqQ0qgL0cWyKh9eYvp0rzyD0JYkO3aXr6nkC6
 U21syMJKNqapXc3xPV6A/Mg4m0RuOqXlgjL++dt5TZQgieZ9qEPwLW/uN3BZXNSmoj0erR/jb
 +05Hxmapqa66GSIj2sqam2YPGxZSYrOh1xHkitIhoKti6pl+2lPha7ejnuZRwPQMqm4hMMTm6
 uV/I/jkrrwdlITpNCmgqjv3kUZnsXzxkkRr30o7bSPqbQU2rCULfQ7B81v+8sQWlxVH9a/ezW
 1AczoEFS0Nmoq40D4DknfAk+2U0/chb0KIPq+fm4p0VJm9vQrukoSgoLAUhKOQD+7xxDm3RXD
 N9qZ+QPuM+15fyiiB0e59j9u5gTnVXb6+QewT5NHdCtOEb4LKdu5raD7uGWMtAoJA/CDft8ac
 D+HClUr/8Zg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 12 Jan 2019, Jeff King wrote:

> On Fri, Jan 11, 2019 at 07:07:15PM -0800, Junio C Hamano wrote:
> 
> > > diff --git a/builtin/commit.c b/builtin/commit.c
> > > index 004b816635..7d2e0b61e5 100644
> > > --- a/builtin/commit.c
> > > +++ b/builtin/commit.c
> > > @@ -351,7 +351,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
> > >  		if (write_locked_index(&the_index, &index_lock, 0))
> > >  			die(_("unable to create temporary index"));
> > >  
> > > -		old_index_env = getenv(INDEX_ENVIRONMENT);
> > > +		old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
> > >  		setenv(INDEX_ENVIRONMENT, get_lock_file_path(&index_lock), 1);
> > >  
> > >  		if (interactive_add(argc, argv, prefix, patch_interactive) != 0)
> > > @@ -361,6 +361,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
> > >  			setenv(INDEX_ENVIRONMENT, old_index_env, 1);
> > >  		else
> > >  			unsetenv(INDEX_ENVIRONMENT);
> > > +		FREE_AND_NULL(old_index_env);
> > >  
> > >  		discard_cache();
> > >  		read_cache_from(get_lock_file_path(&index_lock));
> > 
> > Even though it is not wrong per-se to assign a NULL to the
> > now-no-longer-referenced variable, I do not quite get why it is
> > free-and-null, not a straight free.  This may be a taste-thing,
> > though.
> > 
> > Even if a future update needs to make it possible to access
> > old_index_env somewhere in the block after discard_cache() gets
> > called, we would need to push down the free (or free-and-null) to
> > prolong its lifetime a bit anyway, so...
> 
> My thinking was that if we simply call free(), then the variable is left
> as a dangling pointer for the rest of the function, making it easy to
> accidentally use-after-free.

FWIW I thought that was your reasoning (and did not think of asking you
about it) and totally agree with it.

It is *too* easy not to realize that the `free()` call needs to be moved,
but a segmentation fault is a very strong indicator that it should be
moved.

> But certainly it would not be the first such instance in our code base.

Just because a lot of our code has grown historically does not mean that
we need to add code that shares the same shortcomings. FREE_AND_NULL() was
not available for a long time, after all, so it is understandable that we
did not use it back then. But it is available now, so we no longer have an
excuse to add less defensive code.

> In theory a static analyzer should easily be able to figure out such a
> problem, too, so maybe it is not worth being defensive about.

How often do you run a static analyzer?

My point being: if we can prevent future mistakes easily, and it does not
add too much code churn, why not just do it. No need to rely on fancy
stuff that might not even be available on your preferred platform.

Thanks,
Dscho
