Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1341FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 15:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932283AbcLSO0P (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 09:26:15 -0500
Received: from mout.gmx.net ([212.227.15.15]:61263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932853AbcLSOZo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 09:25:44 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LpKrt-1cmHHe3qr7-00f6uj; Mon, 19
 Dec 2016 15:25:36 +0100
Date:   Mon, 19 Dec 2016 15:25:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stephan Beyer <s-beyer@gmx.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 01/34] sequencer: support a new action: 'interactive
 rebase'
In-Reply-To: <f0762491-63ca-0814-0005-b2cbdd4dc505@gmx.net>
Message-ID: <alpine.DEB.2.20.1612191515000.54750@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de> <297140020a7312af03136848dcdd0353ee3abdfe.1481642927.git.johannes.schindelin@gmx.de> <xmqqy3ziwbpk.fsf@gitster.mtv.corp.google.com>
 <f0762491-63ca-0814-0005-b2cbdd4dc505@gmx.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eKFRI6SeWXhjwi6IeL+GYjgyEHmvNCgl55aIp17/5v1LQhde+2c
 MhBrnNP4g/M42j1wRx6INEgh7tiFvEoY8TULRx646jwoioLD02TRxrL5RwRSVgbdkA3qDiq
 5fRuxKPJ6dA0JorkjKN4s5S+o4VHkRWJ8W04DPvSw/qi3Yf3w12fM2llnks+gmYSQpADNMm
 mHdXeiG000T6jxK5BudFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8VBygJl8zto=:SJ8RphzfhX9HISk/uohg9q
 fgPpgKmU7TO4KHgFmH8KjUKjuT/pKugfcVhrtJ5JnP5Ont/uTuRdlCa/zCbary70EuIuOTeun
 ABR9AbSZ8NZDWwGwOAN7TiVsi1ddbh2n8KJNZPDpdKQZN+t4B/9lQFbN8q00C+I/1PWHEbZsB
 uvV8EQcExiS1gwbj6k2W2tt4yzGSNnYBHlmTPyYqvAsE4esBYXUTTccP/gJKlfkqLtynGbe4d
 dS6EhbElAyoQPXcI6OpFNLDEmebTVjOyNx09mJM060TCBtnErKbl3HDD0czM3BZmasCjSobVa
 dcbzzbHftwov1p9fzztvIZ2JbbBxKvZ8veobnYqr5gH51dTVaP7Z63GZtIwQB7Y5xgq96tx7M
 Mu1OilzjGgYFlPZRVaTeeU1FKtN6YaCxokDCJBpGi3yE/R0S7HWaFgt/L1XVMtpXjAG6UNGJk
 2KYgy4drSN4zfT71D66dC0sSmewJd5HjT5jRuJdpM+acVaFHkAYM1gBM29YhS2V3MJVhhzCol
 zqfMKlkjxSEz7ZVMMe6TqWVMizSeZL+kLyMa81jD17tMQORCQpJVcU2sRVljr7Tdyuz3WEkwo
 7ImAjymFgekpZES+kc6pPW6bp81aEnALmmmDYuCOFkcqhaUdht01cl/DE3hp0I5JXodG+wCgT
 JSUNTR+39AwxFTNdJEulzgVg667sSyMUK+FtyITD0fwiWfQY8YGaBS8gRXVB9MGQ4OnaAKW42
 LP26XsRqj/rpBJF/KnwObk8rrMweT2/q0DTX65fYw3eFp8CFokzpzSoJScAf8IVy0oa1+YV+Z
 lTqZTqr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stephan,

On Sat, 17 Dec 2016, Stephan Beyer wrote:

> On 12/14/2016 08:29 PM, Junio C Hamano wrote:
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >> -/* We will introduce the 'interactive rebase' mode later */
> >>  static inline int is_rebase_i(const struct replay_opts *opts)
> >>  {
> >> -	return 0;
> >> +	return opts->action == REPLAY_INTERACTIVE_REBASE;
> >>  }
> >>  
> >>  static const char *get_dir(const struct replay_opts *opts)
> >>  {
> >> +	if (is_rebase_i(opts))
> >> +		return rebase_path();
> >>  	return git_path_seq_dir();
> >>  }
> > 
> > This obviously makes the assumption made by 39784cd362 ("sequencer:
> > remove useless get_dir() function", 2016-12-07) invalid, where the
> > "remove useless" thought that the callers of this function wants a
> > single answer that does not depend on opts.
> > 
> > I'll revert that commit from the sb/sequencer-abort-safety topic (as
> > the topic is in 'next' already) to keep this one.  Please holler if
> > that is a mistaken decision.
> 
> It seems to be the right decision if one wants to keep the internal-path
> backwards-compatibility of "git rebase -i" (and it seems that Dscho
> wants to keep it).

You make it sound as if I had any choice there. But you probably know as
well as I do that scripted usage of rebase -i relies on the "internal-path
backwards-compatibility", and as one of my stated goals was not to break
anybody's existing rebase -i usage, well, you know.

> However, maintaining more than one directory (like "sequencer" for
> sequencer state and "rebase-merge" for rebase todo and log) can cause
> the necessity to be even more careful when hacking on sequencer... For
> example, the cleanup code must delete both of them, not only one of them.

That is incorrect. It depends on the options which directory is used. And
it is that directory (and not both) that should be cleaned up in the end.

Otherwise you run into a ton of pain e.g. when running a rebase -i with an
`exec git cherry-pick ...` line: all of a sudden, that little innocuous
line would simply destroy the state directory of the current rebase -i.

That's a rather big no-no.

> Hence, I think that it's a wiser choice to keep one directory for
> sequencer state *and* additional files.

See above for a good reason not to choose that.

> If we (a) save everything in "sequencer", we break the internal-path
> backwards-compatbility but we can get rid of get_dir()...

... and we break power users' scripts that use rebase -i. Making those
power users very angry.

Including me.

> If we (b) save everything in "rebase-merge" when using rebase -i and
> save everything in "sequencer" for pick/revert, we are 100%
> backwards-compatible, but we have to change every occurrence of
> git_path_seq_dir() to get_dir()

Yes, that is exactly what we have to do. And that is exactly what I did,
too, in the patch series I labeled "prepare-sequencer".

The only three uses of git_path_seq_dir() I left intact are:

- in builtin/commit.c, where it is used to determine whether a cherry-pick
  is really still in progress, after testing that there is a
  CHERRY_PICK_HEAD file

- in get_dir() (obviously)

- in create_seq_dir(), where we could technically avoid calling the
  function a whopping three times and use a parameter instead (not my
  construction site, though, so I leave this alone)

> and the GIT_PATH_FUNC definitions of git_path_{todo,opts,head}_file must
> be replaced by definitions using get_dir().

That is incorrect. The git_path_todo(), git_path_opts() and
git_path_head() functions need to be used in the cherry-pick/revert code
path. So they need to be left as-are.

Ciao,
Dscho
