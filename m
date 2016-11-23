Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EB891FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 17:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936447AbcKWRaL (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 12:30:11 -0500
Received: from mout.gmx.net ([212.227.15.15]:64632 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936445AbcKWRaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 12:30:09 -0500
Received: from virtualbox ([89.204.155.1]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhRI2-1cNGMf0JfO-00McHb; Wed, 23
 Nov 2016 18:29:59 +0100
Date:   Wed, 23 Nov 2016 18:29:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] difftool: add a feature flag for the builtin vs
 scripted version
In-Reply-To: <1479912693.5181.27.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1611231824530.3746@virtualbox>
References: <cover.1479834051.git.johannes.schindelin@gmx.de>  <598dcfdbeef4e15d2d439053a0423589182e5f30.1479834051.git.johannes.schindelin@gmx.de> <1479912693.5181.27.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wvgF/VVZc81ApYhjTsFMnLWwGMGP9O7C+KDO1LG79mAALrztHb5
 dmAVNshBM4dChQoSJptH/vlDBB4JboUzT4yYQHi1RMk3Y6eWe+aU74oYB6LXAA30XnCkzNv
 JGD9OtooTQaScQivAtXs2F9bU2frj6eAOTm7Kdxa2eilL5P74EAL1oHNyId7mlrKT4RZths
 Ke/L192HOIQioWh19rlhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5DEJUNBEyqs=:wPRl5zuRiso9TkOOKkhpQK
 1xTzG3WnDSMpj9yekDQsMDtW06A/FsdIW5Zpa/68vlAfXYkolVsQr4kuYmCt5Me94oZ+b475u
 lKtJXR2BOfhgoE36mHeC1/W4FfxeVLw4E+hIpp3MpaPCr2ZVqBjnw2Ha7Ryp3UqHHY3dIDB28
 H4P2ko8Qfrr1hHlrg8HoQsa00MTU/M/ihDWBvHc9p0IZ8DHqA4KCYur4aKnA1SnZQhoFqeFlk
 4dW7QT0UiB27f0DmifEIRptDsXG+Pd3EqhrMo/iRQWH51IccF4dE0U1AJHLYhqYZEVrlaLfo4
 dHDcDIgnLvfqn5jve6NIOmCi72L4f+OKFemiMIE6dtQnAjTPUxkJNgw6XtJ4Zz3Rr781yNZ9y
 Lp6ExCtdz4Fny3DOoe0lvQnJID8gPMyk7EdPl3D77DrvYBEqOtFfAOG0ubcksZQeQcYYY6fTS
 j46kHZA/kwVJpdfFtespE5QIHSvLxY9m1WUVxLRVryfy97OFFDejXc0RExUKH0wMtQkq0ssCB
 BE1nNNKWtp7PmT0clWzaUaslq757jAyEK7+LbUhLIMnQxi2s5pCTij2X+Qlze96ZkEppMrKro
 6xJObo4MXbQljuZm1ANswDYlCHy5ooRkpB9Z8UqTCKVtGZ4By6/2oz7FrlDLekV0G/oNdC48C
 bVLU5PZchVZ4oRD1MFl/BrXGH6dTwx0EbjMZRk51GU9Q70szmOCdSQv8Dqeo/CZ20BTuMQbOi
 j2i6NC9uZ02zXK/oHlcvZH7fP0rOjWQbo1UBYk6gdb+X835YlY2yhgYdhcF1UW+BBlx8laMID
 UiM0Bj06EXiibsCX1bqRU2v87e4pQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dennis,

On Wed, 23 Nov 2016, Dennis Kaarsemaker wrote:

> On Tue, 2016-11-22 at 18:01 +0100, Johannes Schindelin wrote:
> > The original idea was to use an environment variable
> > GIT_USE_BUILTIN_DIFFTOOL, but the test suite resets those variables, and
> > we do want to use that feature flag to run the tests with, and without,
> > the feature flag.
> > 
> > Besides, the plan is to add an opt-in flag in Git for Windows'
> > installer. If we implemented the feature flag as an environment
> > variable, we would have to modify the user's environment, in order to
> > make the builtin difftool the default when called from Git Bash, Git CMD
> > or third-party tools.
> 
> Why is this not a normal configuration variable (as in git config
> difftool.builtin true or something)? It doesn't make much sense to me
> to introduce a way of configuring git by introducing magic files, when
> a normal configuration variable would do just fine, and the GfW
> installer can also set such variables, like it does for the crlf config
> I believe.

I considered that. Adding a config setting would mean we simply test for
it in git-difftool.perl and call the builtin if the setting is active,
right?

The downside is that we actually *do* go through Perl to do that. Only to
go back to a builtin. Which is exactly the thing I intended to avoid.

If we do not go through Perl, we have to set up the git directory and
parse the config in git.c *just* to figure out whether we want to
magically forward difftool to builtin-difftool. That is not only ugly, but
has potential side effects I was not willing to risk.

In any case, this feature flag will be there only for one or two Git for
Windows releases, to give early adopters a chance to send me bug reports
about any regressions.

To be crystal-clear: I never expected this patch to enter git.git.

In that light, I am okay with taking the heat for introducing a temporary,
Git for Windows-only feature flag that is implemented as a "does the file
<xyz> exist?" test.

Ciao,
Dscho
