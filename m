Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5981E1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 13:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbeKNXpQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 18:45:16 -0500
Received: from mout.gmx.net ([212.227.17.20]:39973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731585AbeKNXpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 18:45:16 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M85r3-1fb1pc3ofp-00vf4t; Wed, 14
 Nov 2018 14:41:50 +0100
Date:   Wed, 14 Nov 2018 14:41:48 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] tests: do not require Git to be built when testing
 an installed Git
In-Reply-To: <20181114125206.GA32308@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1811141441030.39@tvgsbejvaqbjf.bet>
References: <pull.73.git.gitgitgadget@gmail.com> <316e215e54b921330b91c763255eb25f475a64ae.1542030510.git.gitgitgadget@gmail.com> <20181114125206.GA32308@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:y+2kW9HWOm748l0nudKWYLuU+RcJ6mN6ZKyGsE2pyMjwdk3Mogk
 /t0lspugvxPB/QP5FJDtweyIAYxY8c7bfGJdceJKIVULHqlUZ3F5sGkeWZbPx4wIafrhAeK
 i2eIMANKFsDOd/N7IUCXam1EZSaW0wQODm0Q4gUf9bNtjoXUlTIhF5Ht0L5P7S2UGx5o4e9
 iIlzv40zAOZtnYFqMvBZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RgDIGaKOph0=:41ZP4XA3A5nzP4v5QBk89Z
 +B1E2bFqZaRpg+LHQ91hOTTdO9K8GBhZgOBbgnCryvZ84glUZ1DTTv+uXwm9nsdmsGo2lgwHb
 ecRl69tQ5gRssjXybdzQeqbzdx87n1SGGNhb3j6X7nrZAlygvfwrRRC05VSWmSplEK+qPU0co
 6OoLC4BQ+gtzG7tSWQTxKNEcxJwIxTiNgvNwwQtG2iaHC32AlcrVqR9U00O8eGCpG78pIVEhy
 VVOcQUAbGDV4qQC/Bujx7yqbdPbDZtpidoFnTtqx56tQ5YPfhMYyw8DXPu1bGcI9a2ee2D1Jh
 AQeghmLFeyag/y/2KlGRWfZRKuc52isQLySvVlt6HRHhPD+N23oG7KJK1zZVAAykZG5gioy3+
 sQt7DM4zE1g95BiWz1NA9EJtzJPEvOr1cKomPvehN1B1Ajc9LVVNqPR5tYvbeZTZ8dOBMJXmT
 F3tw6yuoOzbzwCB7UcIreKhiMmLuvpG6cSor8gQTMuKV6AYnYIZu+2gB/m/Hpbt03n0GkUlNC
 W28LZXGAJrsNCJcqX3VflAn3Iymn5kKkZgkfp8v/8F1f2feV4qAbfQEgfHIRY1GFP6u48O7xn
 b+UvR0z14Hh0R11wVykgcJKAvbh3AomMwM5DrXkk+N1V33aFEY3ddfSVB6ABzGA1CTrUv+dsl
 MEvFM52nHVK7L8mvb/cD3uLxEkXn2tas5V0p2QO1vcDoQcKXj6zUdioObgGJoveisIf3HPK39
 Xj2P8h/GwaUuL0z33B1sY6RPYC3uK4eHWcmrEeS0FbgBRG9db4gp8J7rlh24+FrjIr6HVLX5J
 zABO/zXGxIqap0KzyZ+OkpfKXxkBuqI29npVkU64f88LHiBX+u9lyLvHbnF5EWx5HbjlyKX4N
 jD2wwnpkHtVGXlBoIiBst22J5qAc7utmVH57CSNZsz2FkHYN4zqYKaLzVhMCrs9N7M8zssvgC
 7+XtQ8Tz/yg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 14 Nov 2018, Jeff King wrote:

> On Mon, Nov 12, 2018 at 05:48:37AM -0800, Johannes Schindelin via GitGitGadget wrote:
> 
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 832ede5099..1ea20dc2dc 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -51,7 +51,7 @@ export LSAN_OPTIONS
> >  
> >  ################################################################
> >  # It appears that people try to run tests without building...
> > -"$GIT_BUILD_DIR/git" >/dev/null
> > +test -n "$GIT_TEST_INSTALLED" || "$GIT_BUILD_DIR/git" >/dev/null ||
> >  if test $? != 1
> >  then
> >  	echo >&2 'error: you do not seem to have built git yet.'
> 
> The original runs the command independently and then checks $?. Your
> replacement chains the ||. I think it works, because the only case that
> is different is if running git returns 0 (in which case we currently
> complain, but the new code would quietly accept this).
> 
> That should never happen, but if it does we'd probably want to complain.
> And it's pretty subtle all around.  Maybe this would be a bit clearer:
> 
>   if test -n "$GIT_TEST_INSTALLED"
>   then
> 	: assume installed git is OK
>   else
> 	"$GIT_BUILD_DIR/git" >/dev/null
> 	if test $? != 1
> 	then
> 		... die ...
> 	fi
>   fi
> 
> Though arguably we should be checking that there is a git in our path in
> the first instance. So maybe:
> 
>   if test -n "$GIT_TEST_INSTALLED"
> 	"$GIT_TEST_INSTALLED/git" >/dev/null
>   else
> 	"$GIT_BUILD_DIR/git" >/dev/null
>   fi
>   if test $? != 1 ...

You're right. I did it using `"${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git"`
and I also adjust the error message now.

Will be fixed in the next iteration,
Dscho

> 
> -Peff
> 
