Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEC1C4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 17:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F4C1613C0
	for <git@archiver.kernel.org>; Thu, 27 May 2021 17:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbhE0RY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 13:24:56 -0400
Received: from zoidberg.org ([88.198.6.61]:33427 "EHLO heapsort.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236923AbhE0RYx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 13:24:53 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 May 2021 13:24:53 EDT
Received: from heapsort.de ([2a01:4f8:130:60a1::100])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,DHE-RSA-AES128-GCM-SHA256)
  by cthulhu.zoidberg.org with ESMTPSA; Thu, 27 May 2021 19:18:17 +0200
  id 00000000002210A5.60AFD459.000040F9
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 May 2021 19:18:17 +0200
From:   =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To:     Kevin Daudt <me@ikke.info>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?M?= =?UTF-8?Q?ichal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Should we do something with #git-devel on Freenode?
In-Reply-To: <YK6o/j7P0JIGW0Q0@alpha> (sfid-20210526_220104_053000_A173AE59)
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
 <YKViF9OVLeA95JPH@google.com> <20210520071141.GZ8544@kitsune.suse.cz>
 <YKaaBj0KmJ3K5foC@coredump.intra.peff.net> <YK6XvmrtrdkJvsnI@nand.local>
 <YK6o/j7P0JIGW0Q0@alpha> (sfid-20210526_220104_053000_A173AE59)
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <7e9683aee2c0fea2ff77b82bfa547e15@jk.gs>
X-Sender: jk@jk.gs
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a bit of an update on the situation.

freenode has, indeed, scorched the earth by destroying more than 700
channels, simply for mentioning Libera in the topic (before they even
added a rule that forbids this). I was willing to wait and see how the
"new" freenode was going to pan out, but with stuff like this happening
I don't see that as an option anymore. Basically I expect freenode to
keep destroying community with no prior notice whenever they feel like
it, and who wants to stay in a place like that?

On 26.05.2021 22:01, Kevin Daudt wrote:

> In the mean time, the ircops on libera helped us to register #git there
> pending the official namespace registration from Junio (they have a
> backlog, so they are working through that).

#git on Libera is already picking up steam, though the numbers aren't
quite on the same level yet. However, an arbitrary quorum of regulars 
has
decided that it's time to throw the switch.

* We've moved the gitinfo bot to Libera (which required a fair bit of
   code rewriting to support the differences between their respective
   ircds);
* The IRC logger has moved;
* The old channel's topic has a link to https://gitirc.eu/fnmove.html
   which explains the situation.

I expect that if anyone from freenode staff notices this, the channel
on freenode will get destroyed soon after...
