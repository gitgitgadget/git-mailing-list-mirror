Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87D6C1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 10:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfBHKLv (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 05:11:51 -0500
Received: from mout.gmx.net ([212.227.15.18]:38125 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfBHKLv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 05:11:51 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LzskF-1hEPR53Hut-014zwj; Fri, 08
 Feb 2019 11:11:44 +0100
Date:   Fri, 8 Feb 2019 11:11:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: clear and mark MAKEFLAGS exported just once
In-Reply-To: <20190208001710.GS10587@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1902081111230.41@tvgsbejvaqbjf.bet>
References: <20190207183736.9299-1-szeder.dev@gmail.com> <xmqqbm3npgox.fsf@gitster-ct.c.googlers.com> <xmqq1s4jpgh6.fsf@gitster-ct.c.googlers.com> <xmqqsgwzo0ib.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1902072331060.41@tvgsbejvaqbjf.bet>
 <xmqqh8dfmawn.fsf@gitster-ct.c.googlers.com> <xmqqd0o3mac5.fsf_-_@gitster-ct.c.googlers.com> <20190208001710.GS10587@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1948207574-1549620706=:41"
X-Provags-ID: V03:K1:ft+RmCKooHE2M21NA6JmFf8k7zH1mY9ayxYGy+ZaDsWJ/J7wFns
 /EYqZ0iBYRlhtycIHzMlWVLvl1/lenqC4tKPU4G8ZohwlurctaARpuFiMImkitNTTlqPSY0
 2vN3dOMZS7C6AjIkY7MiXc9/Edr0ADbKxM5lNhtodnoH8Eg4rs9sMuHxQYeUo9C0TMlLWPc
 cR/sqbjSfToiwIbzWKqiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JjwNnvOFIeU=:ifAnMLP0u3n/O0C6UHsbPF
 uEjvF7QSAP6cpxn491vOyoeaTcHyGI3MavfiFnd4XIth3GnYlB4J/5ccAn42CONsqqN55ArVo
 2rOZ59eoxncWDCP9CndYjjeaRzWQmESv6KwyvQMNPUK/AWbpk2ROkABDch6AdNTW3Dd26AzC8
 UwD2utvALrt6vIJHJxxzFQDwh/nFLU4DlEMoXjLTcb7d1OB+JGob8wO5eQpcTLtGZO4i4b9xd
 P/D+CUz5rqrY0rp4JBY+u3B3KZVyEgqwEyQ6pA5lTk2ADzt66evLWa9+0OwRhU3iMuVvlT1t9
 wTFNNEGVKv9LVaCTbK/1s6EQbnYnx7TvRJ1o8V/MQ8oDD1PupoTUG7iUUhcbTUPBlUwpNkNpu
 At9yQbzhIGhegfbpY1sk0Xzzu8q8GwQvjGy6qZxpBUFZOBCjX7+9IUKOS8hDXj+ukgRoK8gEQ
 Ot0A+NYbXILksJRfh+yP6/IaPnnLdadyRbQBsGS1I7AinF2muY4At2YiNpX8XtNKCaXKE2DH2
 xFaxW8mFPtUeBh5g+SJQk2B+DF7gjZwOkKFC9rTgLRNNkF7j+u41Zo8PDNjsFadykpxi2ov1Z
 EA2EYsovFT6Ae3qHxC4ulsnKBwuYMlEEgHRESlu3TDjAGL0bq+8iD8yuz6DQMtVycKnKQ9C+M
 lnkIFj4ZCVTLAEixZBWG3HdFDfMsdgqvDm301Dqizp60nSqwrG/Ntt1QIg/obEJFK5NsocAaU
 Xy9BWOk6/410RczCUceE/Ix7VgYlv29DbpPuisK7PmSJXwnAOfCn6KA2xecGrvwSEKn1C5a+o
 15qomPs3K/5+lJF8fwge09VGX77odzCNW0wGMfjaByFvG6Wj1kVS63lD+KFHEdxNUAuqnXEVK
 RUZyCnJ5wqT3zm/RWL90y7N3yS77cfpiVBl9knCFumYnn94xDxZxsYrwpyw21nD2Ys94R+8aJ
 RNFGOrW6/2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1948207574-1549620706=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 8 Feb 2019, SZEDER Gábor wrote:

> On Thu, Feb 07, 2019 at 03:45:46PM -0800, Junio C Hamano wrote:
> > Clearing it once upfront, and turning all the assignment into
> > appending, would future-proof the code even more, to prevent
> > mistakes the previous one fixed from happening again.
> > 
> > Also, mark the variable exported just once at the beginning.  There
> > is no point in marking it exported repeatedly.
> > 
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >     >> So I'd rather clear `MAKEFLAGS` at the beginning (i.e. where
> >     >> you `export MAKEFLAGS`, I'd simply append a `=`).
> > 
> >     This time in proper patch form.
> 
> Makes sense, and the patch looks good to me.

To me, too.

Thank you,
Dscho

> 
> >  ci/lib.sh | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index cee51a4cc4..288a5b3884 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -74,6 +74,9 @@ check_unignored_build_artifacts ()
> >  	}
> >  }
> >  
> > +# Clear MAKEFLAGS that may come from the outside world.
> > +export MAKEFLAGS=
> > +
> >  # Set 'exit on error' for all CI scripts to let the caller know that
> >  # something went wrong.
> >  # Set tracing executed commands, primarily setting environment variables
> > @@ -101,7 +104,7 @@ then
> >  	BREW_INSTALL_PACKAGES="git-lfs gettext"
> >  	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
> >  	export GIT_TEST_OPTS="--verbose-log -x --immediate"
> > -	export MAKEFLAGS="--jobs=2"
> > +	MAKEFLAGS="$MAKEFLAGS --jobs=2"
> >  elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
> >  then
> >  	CI_TYPE=azure-pipelines
> > @@ -126,7 +129,7 @@ then
> >  	BREW_INSTALL_PACKAGES=gcc@8
> >  	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
> >  	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
> > -	export MAKEFLAGS="--jobs=10"
> > +	MAKEFLAGS="$MAKEFLAGS --jobs=10"
> >  	test windows_nt != "$CI_OS_NAME" ||
> >  	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
> >  else
> > @@ -185,4 +188,4 @@ GIT_TEST_GETTEXT_POISON)
> >  	;;
> >  esac
> >  
> > -export MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
> > +MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
> > -- 
> > 2.21.0-rc0
> > 
> 
--8323328-1948207574-1549620706=:41--
