Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1097420958
	for <e@80x24.org>; Thu, 23 Mar 2017 16:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933388AbdCWQnh (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 12:43:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:65330 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932210AbdCWQng (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 12:43:36 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvPgd-1c81mY0Ppb-010g7D; Thu, 23
 Mar 2017 17:43:17 +0100
Date:   Thu, 23 Mar 2017 17:43:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: USE_SHA1DC is broken in pu
In-Reply-To: <20170322220246.GD26108@aiede.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703231724350.3767@virtualbox>
References: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com> <2B1DE627-11C8-4FA5-A354-76B6C475666A@gmail.com> <FFC0EFBD-C4D9-4FB8-A45D-7B10689724A1@gmail.com> <alpine.DEB.2.20.1703212105030.3767@virtualbox> <xmqqh92mo06a.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703221530040.3767@virtualbox> <20170322220246.GD26108@aiede.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:G9ME0ixl11cpcdNLwohQ/3WGYXgPzY48ECVg2Icn4CCxxEaKYEJ
 ZMQe8+g7Hh2+vWfOalInQ/HPURMSNMPuXV3WSsqsROdEDc8DTdKelE5GrUp9VfSKlLgLv//
 YRdXRyepG4O1O4WDym/7++zM0/LY/ppVRWPeNaXSHJIsa5JA1qILOtaCueyUs0GicfYRXlH
 a1SrXMcCMnt9d5RuJRVuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NEhGJn9A2sU=:OlMf/aD73XQMIrcTiPJZdu
 wK+yhg9robdx/RlTw6DSKf9Sh6XUSBEhzdUgdS/VH1B+Z1nh1PC61maawWgmpw2Y4RGrn0rHH
 6CgkgmvuXlm7k14TFqr30mjDZfHjwppUO61lTzL20TeWsF7DjzAgYHrplTN2LtsM7yoFO08Dk
 AWjTGFmBdesauOgnEagyeWXU8QzX27WhCUR5bA66TUHozUJeSJMI7smHVQhm19uTY+t+OI54F
 WVaKFTztlGox1bwYRS6Mrt0CyCBmcyLYOfbBfd7AAzVPZmYA/HkPAvUMu7BuKD4u9G+J1kuxG
 R2C1UP2XjZLaDkSa1eSEknqiSJ+ddiJlbat6jwXn4hkP3VQOGJtUo1stgmYqj7ouVKcpCCF7p
 UVSWPmB8pfSE+G1fDWtoiTZhNjfM9xmLbsKhUW+FSPsqpTfNXYd4qJdGA8B3wfzRAxT/Gn79b
 uJjGeuaa7kpdHN4spcxirXUZPf7LtkZNqL7Y1dGCL+ZWMail2uksSmAEsR+3jJonnNTX6R3of
 OtYuhl2FNXF8KiwGHuHpVlSK6wYmem1K7vRuKn/CS9PQGll15zOXbbxrbgOrC9W2d1s/bZrMW
 H0tAjyar1gguQBG1pVD6oqQOq1lkxE8mWa+4tNOw6Ytp5D6JV59O8hgeJGMfFzx5W85BIQSiq
 Io+Xugx6fQadzbFwmYtTB4NcFkxZHQmkvWkHso0kA2XJGq6Ly03OQHJ8MC3PTEOJ3t4bRD2K2
 Bp8C94H6J0xLh4eJTMrIXh1RCuWkKFi6ra0Kg9L3cjNXl+tSzSg/CtvZIW1gp9NIW85ErBj8+
 1aCL0BSWusqFHSPptGmM3ThBwvSig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, 22 Mar 2017, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> 
> > As to the default of seriously slowing down all SHA-1 computations:
> > since you made that the default, at compile time, with no way to turn
> > on the faster computation, this will have a major, negative impact.
> > Are you really, really sure you want to do that?
> >
> > I thought that it was obvious that we would have at least a runtime
> > option to lessen the load.
> 
> It's not obvious to me.  I agree that the DC_SHA1 case can be sped up,
> e.g. by turning off the collision detection for sha1 calculations that
> are not part of fetching, receiving a push, or running fsck.

And in those cases, using OpenSSL instead is *even* faster.

> To be clear, are you saying that this is a bad compile-time default
> because distributors are going to leave it and end-users will end up
> with a bad experience?  Or are you saying distributors have no good
> alternative to choose at compile time?  Or something else?

What I am saying is that this should be a more fine-grained, runtime knob.

If I write out an index, I should not suffer the slowdown from detecting
collisions. Because I implicitly trust myself and everything that I added
(and everything that was checked before already). This may not matter with
small projects. But we know a couple of real-world scenarios where this
matters.

Imagine for example the insane repository described by my colleague Saeed
Noursalehi at GitMerge. It is *ginormous*.

The index is 300MB. If you have to experience a sudden drop in performance
of `git add`, even by "only" 30%, relative to OpenSSL, it is very
noticeable. It is painful.

That is the reason why we spent considerable time trying to enhance
performance of SHA-1 hashing even by as little as a couple of percentage
points here and there. The accumulated wins are noticeable, and
I assume that those wins are completely annihilated by the heavy-handed
switch to detect collisions always.

It gets even worse when it comes to fetching, let alone cloning.

And please note that the gigantic repository I mentioned above is a
company-internal one, i.e. the servers/repository are implicitly trusted.
Having to pay the price of a full clone going from 12+ hours to even only
15+ hours *hurts*. Particularly when that price is paid for no value in
return at all: the server *already* will have checked for crafted objects.

I could imagine that this problem could be addressed to everybody's
satisfaction by introducing a tristate config setting where the collision
detection can be switched on & off, and then also to, say, "external" i.e.
collision detection would be switched on whenever objects are retrieved
from somewhere else than the local repository (e.g. git-receive-pack).

If fetching or cloning from a trusted source, this config setting could be
switched off on the command-line, otherwise left at "external".

And by "switching collision detection off", I of course refer to *not*
using SHA1DC's routines at all, but what would have been used originally,
in Git for Windows' case: (hardware-accelerated) OpenSSL.

Did I manage to clarify the problem?
Johannes
