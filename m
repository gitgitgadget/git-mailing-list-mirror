Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 691E51F859
	for <e@80x24.org>; Tue,  6 Sep 2016 16:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936614AbcIFQj3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 12:39:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:52237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936586AbcIFQjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 12:39:25 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0ML7NR-1bhaNm474D-000OiN; Tue, 06 Sep 2016 18:39:08
 +0200
Date:   Tue, 6 Sep 2016 18:39:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael J Gruber <git@drmicha.warpmail.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Unbreak interactive GPG prompt upon signing
In-Reply-To: <ced7502d-0095-bd90-19e3-c14d0e4d4f07@drmicha.warpmail.net>
Message-ID: <alpine.DEB.2.20.1609061834490.129229@virtualbox>
References: <0b8196564ac9f1db7c59b42d7e0973ba1399ec52.1473148900.git.johannes.schindelin@gmx.de> <ced7502d-0095-bd90-19e3-c14d0e4d4f07@drmicha.warpmail.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nEsj6YzdBbfYxm7/1/59wGbKF79sZm/r2+UKYkZdO6knwlBKlz2
 WQIgoUy6xqxtkRf2/bQHJNa+tYpjx9PapIRuWPPl6w8uLQXhwekF3kRqHBzDDeoCWIRtLDV
 aH2tH7tLsQ25eWWN0nIeWbOHd5Pen0cTbooPZf+yhp7KQzg+E3zvuahpz0U0k5PcSaFM/S8
 eIoOAF39hUmP4cvANjLgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KLQgo1y38+I=:x2g+/w3sPDm6KzEnq45kKe
 iJjgC5jH9Iuign15+Ig1gkffmj8KUECZAmSARUW9kwXQI9Koh/AUgqNwwXZdBfCeEHW3CEqtd
 +rMWep+pB71f9R7euKgJK8QAIMCVK43dqxdmX92LIeuOfxjrM5QiHr5fN8gkV/fzTG8M34j02
 8dZyZrc3yWZpBdlV19IPSczfmVsRXCRvaTszOuQaTxWPErIIz13JFX3/aQJTOszyAM+BIoplN
 uG0tkHUWEMjZfm3wntIef5Q3bQByAOj/mgV0sev0eYPxg3kjZCyPnPBXPN9OmxLWydlvP4E4w
 a1LsESIiLJ6pguqoB7Ldpf/CiGQ7dfMilW3SG4fKRI1g4mWCVbpNQy2/G6ZdW6mEN+F2AOZDp
 PiUP687FVPQdxoKKwV6vms1wE9BbnAsK16Zrk1VIsxPGWYRTJAyag6cT8VCeHcnB3maLiw6pm
 Ri1xL2UDgRABIxxGsjW8a1aMHsmb6l57HC6Zrs+NiIrlw5xfdh9oQCTxqtKePPlwdCZzXx3V6
 2gZGy/S6frwreWCxiuyDiSXwu6gD6FF8+OJOw+hECEK1txUsUEp08YL0ugiPeEOJIJRcxbiIs
 cemaiItqVmT9xzr/LxIrOtR3mx/38L/PYH2bcgsfE5+U2uYD05k23FGoGw1tNW7+KkM+KjTVs
 jEqcb/Y1u1Ul5sASVhF4kouCuPQd1GpfRzBqeKvVZR7dsk1i/q0BekuLlaLaku8DtOSf4ykr3
 ZMtuddqOnAgPEVWBU8x8Ay4qWDWvsbuSOuIF2yor3h8yXjy5JVuG/BLtVsNhnCBgc5qjZITIz
 UrCeW7k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Tue, 6 Sep 2016, Michael J Gruber wrote:

> Johannes Schindelin venit, vidit, dixit 06.09.2016 10:01:
> > With the recent update in efee955 (gpg-interface: check gpg signature
> > creation status, 2016-06-17), we ask GPG to send all status updates to
> > stderr, and then catch the stderr in an strbuf.
> > 
> > But GPG might fail, and send error messages to stderr. And we simply
> > do not show them to the user.
> > 
> > Even worse: this swallows any interactive prompt for a passphrase. And
> > detaches stderr from the tty so that the passphrase cannot be read.
> > 
> > So while the first problem could be fixed (by printing the captured
> > stderr upon error), the second problem cannot be easily fixed, and
> > presents a major regression.
> 
> My Git has that commit and does ask me for the passphrase on the tty.
> Also, I do get error messages:
> 
> git tag -u pebcak -s testt -m m
> error: gpg failed to sign the data
> error: unable to sign the tag

That is not GPG's error message. It just leaves users puzzled, is what it
does.

> which we could (maybe should) amend by gpg's stderr.

Right. But then we still do not solve the problem. The problem being that
some platforms cannot use getpass(prompt): it simply does not exist.

On Windows, we do not even have a /dev/tty (technically, GPG, being an
MSYS2 program, knows about /dev/tty, but we spawn it from a non-MSYS2
program, so there is a disconnect).

> > So let's just revert commit efee9553a4f97b2ecd8f49be19606dd4cf7d9c28.
> 
> That "just" reintroduces the problem that the orignal patch solves.

Right. Which is: when some user misconfigures gpg, causing Git to run
something different that simply succeeds, there is no signature.

This is a minor issue, as it requires a user to configure gpg, and do a
bad job at it.

Not being able to input the passphrase on Windows is a major issue, as the
user has done nothing wrong.

> The passphrase/tty issue must be Windows specific - or the non-issue
> Linux-specific, if you prefer.

Sure. Let's talk about semantics. Oh wait, maybe we should work on
resolving the issue instead.

> > This fixes https://github.com/git-for-windows/git/issues/871

To reiterate: this is the problem I need to see solved.

Ciao,
Dscho
