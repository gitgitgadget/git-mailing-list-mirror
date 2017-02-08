Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2257D1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 14:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754323AbdBHOa6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 09:30:58 -0500
Received: from mout.gmx.net ([212.227.15.18]:55751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752515AbdBHOaz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 09:30:55 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1Ee8-1cHs1N1cLY-00tE9r; Wed, 08
 Feb 2017 15:29:01 +0100
Date:   Wed, 8 Feb 2017 15:28:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Shawn Pearce <spearce@spearce.org>,
        Stefan Saasen <ssaasen@atlassian.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git clonebundles
In-Reply-To: <xmqqzihxyb66.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702081521290.3496@virtualbox>
References: <CADoxLGPFgF7W4XJzt0X+xFJDoN6RmfFGx_96MO9GPSSOjDK0EQ@mail.gmail.com> <CAJo=hJsS6FmL9iNScaXqkWJumALfGr8Od5QkbfZ+ZG3osxkp7Q@mail.gmail.com> <CAP8UFD2ffeHr0-z3xPFFODqRTTgVnrrWcYRbASpUOrp0QGnp6g@mail.gmail.com> <xmqq4m070xua.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1702071303370.3496@virtualbox> <xmqqzihxyb66.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/U8Of0KN+Nzr+3nLcWzV/9IxR+/Eq+ezlKzHf19wIGSZRCG7Xcg
 BJ7cCs26ydl1yQ0gA/K89ZLaP9YJ1GyesuGgtjc0WqAQOBpwWU4zMyx+HTnUo9B8D1AG+Ax
 p+gFmqltnT6vs6qWdP9BTV9e/YuWvsUjtFWw3iTP5g335nnDF8lTJgeQ0Gh+2cBcR7b58hi
 YKgTiQD/T0hruQlHANvLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d6/7jq46rU0=:OSrbaOTU+/Ye9lYNaDqMCi
 9aCuVv5fFsHRn6jc0OWz4+AqWxhYX5GRpfVDSRa0QIJHvqrkduCfJQsIgho1/Xaj7WAkBJq9l
 CfhpibNbU+u/0dpMPShkFR65p72ULir8fRPMgff4M9R9kwFmGGwnOsU3eUdnn53WKoXfukD4O
 gPx8gyoqv6dipEQI5DiK8/qhM0Iya3R2Hl9mWP0XVBQfCdEjbyXyEk33CLpCmGpk4ZJd5uyc2
 5kHiCAJJ/7IzZCAMTQAaOcdS9OD/JKJthqdG/1rqLwqlaAQ40u/iESEE7njXw5ZbxxVpRKlH0
 94clrHLJaOs9tMH90GwCiRcgRBOlx4qFOGkZXzojWzFGxjbXL0Xsnz1wUULNO+vMwKdwlHZUV
 Mdk61MZD0G9H5+K4Odj8Djkvh7v8jMHEyEfkytjLYf6euU3A54DhOi2ZeFrP7qMlJu9TR8hEE
 Gir7iSqMGD6m2ioookI8f0QWcY8zeBm9jgoJAJPJ/gNv+JUJwC3t53gJhPchLdFnlSxsdCYqW
 C9jvhTVxQJTHJDiRhcC3347ajbego9PNtxDHv+iYaC1u9ru6f0UjriHbp3WRahE6TZTzL4fK5
 fSHt3I3ikvqCNNlRlD81kVI2tC6xh3GeqxecfGQTgSXnwP5CYh+8rao1hs96RdW5Hubi6dVYS
 nXlfcOa/2/BvRQ09n85OtwLVoqa69eKbAYDdjNnqofnbPJyQ7CJWiLObuw+lPCjI61ZmYuAlG
 DqCL/JF9BeAlUOgJvZrx3SlB4CEqJND74fR4A7fKRlPQGq9/HTAv/m3JBDcTJ8E2B5qw+qdaW
 8k8O5Yx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 7 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> If people think it might be useful to have it around to experiment, I
> >> can resurrect and keep that in 'pu' (or rather 'jch'), as long as it
> >> does not overlap and conflict with other topics in flight.  Let me try
> >> that in today's integration cycle.
> >
> > I would like to remind you of my suggestion to make this more publicly
> > visible and substantially easier to play with, by adding it as an
> > experimental feature (possibly guarded via an explicit opt-in config
> > setting).
> 
> I do not understand why you want to give this topic undue prominence
> ovver any other random topic that cook in 'pu' [...]

Since you ask so nicely for an explanation: clonebundles got a really
lively and active discussion at the Contributors' Summit. So it is not
your run of the mill typo fix, the bundle issue is something that clearly
receives a lot of interest in particular from developers who are
unfamiliar with the idiosynchracies of the code Git development.

And I got the very distinct impression that Git would benefit a lot from
these developers, *in particular* since they come with fresh perspectives.

Now, we can make it hard for them (e.g. expecting them to sift through a
few months' worth of What's Cooking mails, to find out whether there has
been any related work, and what is the branch name, if any, and where to
find that branch), and we can alternatively make it easy for them to help
us make Git better.

I would like us to choose the easier route for them. Because it would
benefit us.

Ciao,
Johannes
