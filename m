Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 867A21F424
	for <e@80x24.org>; Sat, 20 Jan 2018 14:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756071AbeATOYr (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 09:24:47 -0500
Received: from mout.web.de ([212.227.15.3]:56038 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755920AbeATOYp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 09:24:45 -0500
Received: from [192.168.178.36] ([91.20.48.24]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lb289-1f5PFz2Zk9-00kgGU; Sat, 20
 Jan 2018 15:24:34 +0100
Subject: Re: [PATCH v2 2/6] Add tar extract install options override in
 installation processing.
To:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
References: <20180119173406.13324-1-randall.s.becker@rogers.com>
 <20180119173406.13324-4-randall.s.becker@rogers.com>
 <1153e1c0-c7d5-3e0d-ce41-ffb1230164f7@web.de>
 <019601d391f4$dd367de0$97a379a0$@nexbridge.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9b7bf754-90bd-c25c-f5ae-124dcd97d281@web.de>
Date:   Sat, 20 Jan 2018 15:24:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <019601d391f4$dd367de0$97a379a0$@nexbridge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:05meyUMEtxDpgMuDM/xtb5MOjP1wYtRiXTgkZR2kLxudeb2SnmV
 72kpmHp0jUjlnJxNnchXkLFYJJLQHlV82j3G+nPyASwq5Q+ygLLaWCVMI4eMOOlPDXX83Pl
 pLPpoBNOoc7x2Mu/DcDb0yBkCSt3nMOxMV0ynl3C42ehB3OFPT/BoEAshQaBAmS2vIpNRPe
 rhsoit//ViMolKflnGJ3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q9y2M2RTv/M=:d9/5w0osmM2a4Xqof/Dhaf
 NSCb+bqOyQbVVbjvcCRk1neiFyMhIOTnE+Gs+GYYxkpat4q6PIzhZh9m2E+sEdp/XvXAPLenp
 B1DzzWgqcPsi8f6qqZH+pcFewZ0BGmNcHMoDC/INPNt7EWPHgi+cMFqnZAGR2lvAESA1E7bZP
 Zo2wnpYnbl2JvkLq+B4Im7Dof90Seo2flkTQBJfz2JEaAbV/Uvx9a9SapSV/X85vLBm9e3kZM
 xUIq8wA6cgTyoUngliDnrE4Ms9qjV2VwL8e3a+MTdIdFE6aVxdqDlysrMq/Uiy64ltzcCvGZd
 bH0o1ui5LMM+BZn/o5RLS0YZFnqOhMFtwWBjvVBGI1/sPznl2fdn1Ye3UKxBHMAX+DqaiJCI4
 tnpw9eG7krZCQ3Gc99w0BmnbBeLgIJ2AhL/2FYvzZgnuMpvg6zQPRTuONomt2+kLt6DVDPZ5I
 0OCNRGhgCVKdlgd7pE0dE96CGl+XzntW5TYPMIxRrLXy2IivB9KncUOmcVR9JGnGI4x38QNQN
 DL3oE7HUxW5/8Dah4O4wNtVPpl3xyWahkY/8orvg98z7BHiunB5lFadpIUpsAvAztCsmiM+ij
 /g64VTlbvuclyEgfSMMNEY162dyBlIrQaAO5iWEMe3hV40Oiw2eE4B8YuT0htVF47N8O5Y3mI
 BAEZMe1beISg5t4HTRTyY+brH+aWS+pQmxl4cv12yM3IVh8pP5zsUskno4lMGld2YgnbGo7Oh
 294NyO3cYWbnDFrBgfytv7lbJTtOcDR98yjlP7YiTPsrwwR6QJdE+8QcJlTgBR3EIuLND3T0x
 PbGBDlDF3Hyo6pSIcKD2CAXdsEhsNZs6ufkBiU2bFgc4tpnbF8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.01.2018 um 14:44 schrieb Randall S. Becker:
> On January 20, 2018 7:31 AM, René Scharfe wrote:
>> Am 19.01.2018 um 18:34 schrieb randall.s.becker@rogers.com:
>>> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>>> 
>>> * Makefile: Add TAR_EXTRACT_OPTIONS to allow platform options to
>>> be specified if needed. The default is xof.
>>> 
>>> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com> --- 
>>> Makefile | 6 +++++- 1 file changed, 5 insertions(+), 1
>>> deletion(-)
>>> 
>>> diff --git a/Makefile b/Makefile index 1a9b23b67..040e9eacd
>>> 100644 --- a/Makefile +++ b/Makefile @@ -429,6 +429,9 @@ all:: #
>>> running the test scripts (e.g., bash has better support for "set
>>> -x" # tracing). # +# Define TAR_EXTRACT_OPTIONS if you want to
>>> change the default +behaviour # from xvf to something else during
>>> installation.
>> 
>> "xof" instead of "xvf"?
> 
> When I look at the parent commit, it says xof, so I wanted to
> preserve existing behaviour by default. Our install process wants to
> see the actual set of files, so we wanted to use xvof but that hardly
> seemed of general interest. I was hoping an option to control it
> would be agreeable.

Preserving the default is good. I meant that the default is "xof",
but the added line implies it was "xvf" instead.

Seeing your actual use case confirms that my suggestion below would
work for you.

> 
>>> +# # When cross-compiling, define HOST_CPU as the canonical name
>>> of the
>> CPU on
>>> # which the built Git will run (for instance "x86_64").
>>> 
>>> @@ -452,6 +455,7 @@ LDFLAGS = ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS) 
>>> ALL_LDFLAGS = $(LDFLAGS) STRIP ?= strip +TAR_EXTRACT_OPTIONS =
>>> xof
>>> 
>>> # Create as necessary, replace existing, make ranlib unneeded. 
>>> ARFLAGS = rcs @@ -2569,7 +2573,7 @@ install: all ifndef
>>> NO_GETTEXT $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)' 
>>> (cd po/build/locale && $(TAR) cf - .) | \ -	(cd
>>> '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) xof -) +
>>> (cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) 
>>> +$(TAR_EXTRACT_OPTIONS) -)
>> 
>> Hmm.  TAR_EXTRACT_OPTIONS always needs to have f (or -f, or --file)
>> at the end to go together with the following dash, meaning to
>> extract from stdin. And x (or -x, or --extract) is probably needed
>> in all cases as well.  So wouldn't it make more sense to only put
>> the o (or -o, or --no-same-owner) into TAR_EXTRACT_OPTIONS and
>> enforce x and f?
> 
> This is a good suggestion, and I'd love to do that, if I could
> guarantee a modern tar, which I can't. The platform comes with a
> really old-school tar from some old (seemingly BSD4.3) epoch that
> only takes one option set. There is a more modern tar that can be
> optionally installed if the sysadmin decides to that takes a slightly
> more modern set, which could support your request, and my team also
> has a gnu port that is very modern. I can't control what customers
> are choosing to have installed, unfortunately. Your point is well
> made and I am completely on board with it, but it introduces a
> configuration requirement.

Long options would be nice to nice to have, but are not my main
point; I included them mainly to spare readers from firing up
"man tar" to look up the meaning of the short ones.

I just meant to say that something like this here would make more
sense because you always need x and f- anyway:

	TAR_EXTRACT_OPTIONS = o

	... ${TAR} x${TAR_EXTRACT_OPTIONS}f -

> As with the broadening setbuf (patch 2/6) change, I would like to
> consider this for the future, having a slightly different more
> complex idea. I could introduce something like this:
> 
> 1. HAS_ANCIENT_TAR=UnfortunatelyYes in config.mak.uname that disables
> this capability all together 2. HAS_ANCIENT_TAR=AreYouKiddingMe
> (joke) then set up TAR_EXTRACT_ADDITIONAL_OPTIONS above and beyond
> the default, so --file, --no-same-owner would always be in effect for
> that operation.
> 
> The micro-project would also, logically, need to apply to other tar
> occurrences throughout the code and potentially need a test case
> written for it (not entirely sure what that would test, yet).
> Is that a reasonable approach?

As long as old-school dash-less flags suffice for our purposes
(including yours) we can just keep using that style everywhere and
avoid adding more settings.  It would be a different matter if we
needed features that have no short flag, or are only offered by
certain tar implementations.

René

