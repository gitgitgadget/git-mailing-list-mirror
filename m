Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C711F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 21:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbeKOHaL (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 02:30:11 -0500
Received: from mout.gmx.net ([212.227.15.18]:35917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725756AbeKOHaL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 02:30:11 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2tXS-1fVd1V0Gpi-00saNv; Wed, 14
 Nov 2018 22:25:11 +0100
Date:   Wed, 14 Nov 2018 22:24:55 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] rebase: validate -C<n> and --whitespace=<mode>
 parameters early
In-Reply-To: <ce8e2f7c-cded-0c9d-1306-330711a29021@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1811142224110.39@tvgsbejvaqbjf.bet>
References: <pull.76.git.gitgitgadget@gmail.com> <pull.76.v2.git.gitgitgadget@gmail.com> <4c2ba5276636097a1c3bb2207c7537831e9079bc.1542212726.git.gitgitgadget@gmail.com> <ce8e2f7c-cded-0c9d-1306-330711a29021@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/4wlVYyuQIYEybMXmFk4G0Z5NlxaSZArD7k52AIz687Iiv9QyGE
 abPbabvYunNa8K7EBIYFwNbyTEbLjO3nUfRbegIn9bzCmhEhgirQyufJKA/IUm5Jdj67H5m
 y9rHurQC1Qt82ok0CMMNwAheeD4mSfRBLhn1urq4EQp7UgEp6EvSTLqjS6H1znTVJS7pV/R
 RKsPxyRTPpMdy3FRl+E+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q4GbFyXrvGU=:kIV2FYVr1/HST/TFUyNJEL
 WHvF78dTFzxGedp7IxfirSE0yCx88+LM9+RE48RpbK+arCqIeBBZYcSDHXiH9uHPIJUg3/ED4
 c2iJZxS/UkxZQ4v+2GT8znBhJYCX4F4398/cnpHwoaW9SJr+Dv+ZtVCXCKOjNdPkPya5XfMpi
 ebhs1r59SIVJ+Cx8YjSHjJWVJW4QySQmmkbybQR4tJruCcxauY25UepRALMsylm8nnpLXchYa
 fmBa9rjXYvgTipguB/s+r2rXyhu/RkDCCMIH6/u0FocKt/RgxRgzWi7jrAp4hlp4QLfqZAKH+
 FC2BPFnRp8Kb1OJiWF2KWRjYcxFGQLc73tQIhyciAtIhIM51+NhDY6WA/HzWBhli97dU6yBwI
 +wJoy/pJSYuZi0bIXFbzJtpgDQzbvct5l6VkEvklqPgkKn3auVY3/8GRToIdTDznJSPec0KGT
 G9c8dCBF0c83RFRHzuWUUZD/hSHmfxwQ+HNsWD6MgjciGTpaCpoNl6pHkEkvpNaT60doGHKt4
 cx8dk5J/WdHrLJk87lxkwFo+FvFsbGwOsgvFXH/RXRV3r+/JLC9RDQdq5Du5vqYm/am8TRHgn
 xlP2PC+I4WCXiITtbwJHGyJkFsPfLu0rtbdN8Z5oS2n1yRV2ZMNtLh5Rd9tT4cOZ/3fBDitHt
 C/4st10dKGPchGE4qzY36khqgAz9ZPxARx3J4GuBjcRfzd5einXiPIeEOlD6SKCGkg/iE91z0
 h9eLfZj1P/SISQ2+kKSa43Y257t8nzud5+dwzu8IDCundlX+eCHM3x7B4WsUsv92n20bhN/dn
 sTxjpswqLFRPsnjtOTtr1vlrgsJyyqz6QuY/L4qIQolkxzF+K6/jC8+UaNc3jGxwpuAM0Xh1o
 09Y+dhkFgZkD1fQLUyi0II8Fg5MD8FClBWe+KCbkWiKdpwsZ+CAwg0sy5UIidQFXFkIJL9KD4
 CppUowfI/oA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 14 Nov 2018, Phillip Wood wrote:

> Thanks for doing this, I think this patch is good.

Thanks!

> I've not checked the first patch as I think it is the same as before
> judging from the covering letter.

Indeed, that's what the range-diff said. Sorry for not stating this
explicitly.

Thank you for your review,
Dscho

> 
> Best Wishes
> 
> Phillip
> 
> On 14/11/2018 16:25, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > It is a good idea to error out early upon seeing, say, `-Cbad`, rather
> > than starting the rebase only to have the `--am` backend complain later.
> > 
> > Let's do this.
> > 
> > The only options accepting parameters which we pass through to `git am`
> > (which may, or may not, forward them to `git apply`) are `-C` and
> > `--whitespace`. The other options we pass through do not accept
> > parameters, so we do not have to validate them here.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   builtin/rebase.c          | 12 +++++++++++-
> >   t/t3406-rebase-message.sh |  7 +++++++
> >   2 files changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 96ffa80b71..571cf899d5 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -1064,12 +1064,22 @@ int cmd_rebase(int argc, const char **argv,
> > const char *prefix)
> >    }
> >   
> >   	for (i = 0; i < options.git_am_opts.argc; i++) {
> > -		const char *option = options.git_am_opts.argv[i];
> > +		const char *option = options.git_am_opts.argv[i], *p;
> >     if (!strcmp(option, "--committer-date-is-author-date") ||
> > !strcmp(option, "--ignore-date") ||
> > !strcmp(option, "--whitespace=fix") ||
> > !strcmp(option, "--whitespace=strip"))
> >   			options.flags |= REBASE_FORCE;
> > +		else if (skip_prefix(option, "-C", &p)) {
> > +			while (*p)
> > +				if (!isdigit(*(p++)))
> > +					die(_("switch `C' expects a "
> > +					      "numerical value"));
> > +		} else if (skip_prefix(option, "--whitespace=", &p)) {
> > +			if (*p && strcmp(p, "warn") && strcmp(p, "nowarn")
> > &&
> > +			    strcmp(p, "error") && strcmp(p, "error-all"))
> > +				die("Invalid whitespace option: '%s'", p);
> > +		}
> >    }
> >   
> >   	if (!(options.flags & REBASE_NO_QUIET))
> > diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> > index 0392e36d23..2c79eed4fe 100755
> > --- a/t/t3406-rebase-message.sh
> > +++ b/t/t3406-rebase-message.sh
> > @@ -84,4 +84,11 @@ test_expect_success 'rebase --onto outputs the
> > invalid ref' '
> >   	test_i18ngrep "invalid-ref" err
> >   '
> >   
> > +test_expect_success 'error out early upon -C<n> or --whitespace=<bad>'
> > '
> > +	test_must_fail git rebase -Cnot-a-number HEAD 2>err &&
> > +	test_i18ngrep "numerical value" err &&
> > +	test_must_fail git rebase --whitespace=bad HEAD 2>err &&
> > +	test_i18ngrep "Invalid whitespace option" err
> > +'
> > +
> >   test_done
> > 
> 
> 
