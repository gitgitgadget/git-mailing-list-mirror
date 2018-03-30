Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93DAE1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 12:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbeC3MOk (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 08:14:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:37797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751191AbeC3MOj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 08:14:39 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFdDB-1enqhP07bZ-00Ea7K; Fri, 30
 Mar 2018 14:14:22 +0200
Date:   Fri, 30 Mar 2018 14:14:19 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 0/9] Assorted fixes for `git config` (including the "empty
 sections" bug)
In-Reply-To: <CAGZ79ka41uD7A_64kz5oyrhCBci+oXmDGEVc6mHWyQd7d9avAQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803301411480.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <CAGZ79ka41uD7A_64kz5oyrhCBci+oXmDGEVc6mHWyQd7d9avAQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lT2KuEK8gDx0I+wRGiORWtPgS/3I5JtwiIpUEV2ZrOauI/YJTDG
 rkXBUW9fHCnao6t9ZnxnDH2AzfXX7iN2Qws4/8l+53ZOteOkC3hnlruTJOSpU34aqMRslRZ
 yai+PUl6KtumybnASZJohK767IDGPWpSt3Y74HO6AqHKKDPiVj2bC4gv7VwE1Cu9dYrXv7N
 5LSytuW+es9TYGQPhovIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oYUjAuoc+YM=:EROP2kRm0dXOBHkUeV5wB/
 KDAssKDG8ammI8opypm81t31J4UpO1aqHFYpp9H6IErqfJ0XCY3dwJgzbUoZ6LAwSGjenCzrE
 0icaZ6QOrd6+ognKCrcZcg7Hl08IhGCFP2s74RntjxMhAEd+GlL+jaY3MJJy/IgvsmvW3Frue
 J1TXzm35c9sIpsElXwdJ6Ks7RuCv//1bYJ2WhzEcDi/ncPlHlJwtUCsjdcroXfr8TmmQ8d40l
 oXBbtAeGqpch/uNdjtJX2tQKpPvDqv+JIk6jXeerwYuTomqeWckJ5HENFKvvCJRyQbmV+jk0l
 3D9hihVnx4e+f94Irr4Un6vbBv9+SDbxorNPHqWQ/ou2aLNTs6MC0Twa1z0yJjsKu/8w+Si/s
 IoHOscJgk0dVloUN1nKwIoz73eOD47alZ0BL66Kyma010oxI7dssrR1UFb0nRw3hnHrtE/lBl
 IittcBcm+9c7KHAD+GAJq2QSwVHZUAynRlh+9gGiKH9ITa2FIJ5Q3u1LW2NMNzYryXqF7Wiii
 a/WYsIGb1UXp1lJVvukznZMwwAUrb6tW55z/SNNexNhmhiZIZMEXgKpEfBXwNbVYNceG7ILHL
 zircO8XTn7IpFNgEyIMgqC8GtvfirmIq5UVzTZzaV3wvpdchHVYosO9HNZJwEKWfp70KAhfne
 37IPds0/BsSf3kUzr80471wyI2v8ZgDKcL+/0Fi35g09Ox7rcOVjFNuK4LuuzN47c6bDRAvFh
 QqqE6IfNXt16SGi9aWHeufBsoX1sOFh3E7YSPp9UQZjeP3BAqiag0Bivc9U61xPA06pv1dpHN
 jvKp8GbpbvEq0YWfz0TX3eaXhSi/niBGYKn+w4jn6eZZyUg5QIKLGp1GnmyJrRFpqGaAFV8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, 29 Mar 2018, Stefan Beller wrote:

> On Thu, Mar 29, 2018 at 8:18 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> 
> > So what is the argument against this extra care to detect comments? Well, if
> > you have something like this:
> >
> >         [section]
> >                 ; Here we comment about the variable called snarf
> >                 snarf = froop
> >
> > and we run `git config --unset section.snarf`, we end up with this config:
> >
> >         [section]
> >                 ; Here we comment about the variable called snarf
> >
> > which obviously does not make sense. However, that is already established
> > behavior for quite a few years, and I do not even try to think of a way how
> > this could be solved.
> 
> By commenting out the key/value pair instead of deleting it.
> It's called --unset, not --delete ;)

That would open the door to new bug reports when a user starts with this
concocted config:

	[section]
		# This is a comment about the `key` setting
		key = value

and then does this:

	git config --unset section.key
	git config section.key value
	git config --unset section.key
	git config section.key value
	git config --unset section.key
	git config section.key value

and then ends up with a config like this:

	[section]
		# This is a comment about the `key` setting
		;key = value
		;key = value
		;key = value
		key = value

And note that the comment might be about `value` instead, so reusing a
commented-out `key` setting won't fly, either.

I *did* give this problem a couple of minutes of thought before writing my
assessment that is quoted above ;-)

Ciao,
Dscho
