From: Shawn Pearce <spearce@spearce.org>
Subject: Re: How to resume broke clone ?
Date: Thu, 5 Dec 2013 07:11:15 -0800
Message-ID: <CAJo=hJuRTHEO6Mpaaa7b=_ozDq3UfVNEx6iabKP4xRVoRZLcUw@mail.gmail.com>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com>
 <5296F343.6050506@gmail.com> <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com>
 <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
 <5297004F.4090003@gmail.com> <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
 <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com> <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
 <20131128092935.GC11444@sigill.intra.peff.net> <CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
 <20131204200850.GB16603@sigill.intra.peff.net> <CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
 <52A07DC5.5090508@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	zhifeng hu <zf@ancientrocklab.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 05 16:11:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Voaag-0001dH-Ec
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 16:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780Ab3LEPLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 10:11:41 -0500
Received: from mail-we0-f177.google.com ([74.125.82.177]:41073 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756848Ab3LEPLi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 10:11:38 -0500
Received: by mail-we0-f177.google.com with SMTP id u56so928785wes.8
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 07:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ibGBgnVjrz1bmsb8786kD1SqZVT8TU7aI0w9lMmAaTk=;
        b=SzkWMKdIpdjdvmERa5SGvFyuSuKGKGlKO2qGaOLkVnRCiycDpr0LlESkLzGoMce1Lt
         hm8eCWbIP01ZoYfQdOM4Eqtcn520AYihYfplhuzDACO7ZJAAgdlvn16ZbM74Izqb0uk3
         nIGyfTE8RHFqHXvqit78Sgq6clFT62LkNOpok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ibGBgnVjrz1bmsb8786kD1SqZVT8TU7aI0w9lMmAaTk=;
        b=bsFBaU5n1CSzHc0V+PpkG2S+ZXRSToNHHUSyBG/XWI+3n9HykRQL2lwau3UbSNqWDE
         KhV+UXHMPAHZYROFD1ETRf3bvaDOq14CX95cOwbAHiybxD/pO4P+dXxrGB0g4X/n/U1R
         YyHoCytsWBfo5Osj+JNZt+3YuA013EMuIoBkThNySfNfp6oavMR0THbh1Z6GOXv0achZ
         iwyoOdEO5rwS0iCeyfF7wgQlnFvZmk0uDOY5tWjkilFjMtFpRQvmJdm2PogLva7huVa/
         5iHXPqGIafkif1i9WBtt0wyEvpXScc3rSEbcnvzYeqLpKNhqjZvVa13T1nqm8bmOAJfW
         eQrQ==
X-Gm-Message-State: ALoCoQlztJk6IZ77dXulsBQE1HYcFh/DixNcurSGBR+c2UYTJ02n2lEuAX9R+g6fQNDEQs1WZEuX
X-Received: by 10.180.10.74 with SMTP id g10mr12616682wib.11.1386256296807;
 Thu, 05 Dec 2013 07:11:36 -0800 (PST)
Received: by 10.227.192.198 with HTTP; Thu, 5 Dec 2013 07:11:15 -0800 (PST)
In-Reply-To: <52A07DC5.5090508@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238886>

On Thu, Dec 5, 2013 at 5:21 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> This discussion has mostly been about letting small Git servers delegate
> the work of an initial clone to a beefier server.  I haven't seen any
> explicit mention of the inverse:
>
> Suppose a company has a central Git server that is meant to be the
> "single source of truth", but has worldwide offices and wants to locate
> bootstrap mirrors in each office.  The end users would not even want to
> know that there are multiple servers.  Hosters like GitHub might also
> encourage their big customers to set up bootstrap mirror(s) in-house to
> make cloning faster for their users while reducing internet traffic and
> the burden on their own infrastructure.  The goal would be to make the
> system transparent to users and easily reconfigurable as circumstances
> change.

I think there is a different way to do that.

Build a caching Git proxy server. And teach Git clients to use it.


One idea we had at $DAY_JOB a couple of years ago was to build a
daemon that sat in the background and continuously fetched content
from repository upstreams. We made it efficient by modifying the Git
protocol to use a hanging network socket, and the upstream server
would broadcast push pack files down these hanging streams as pushes
were received.

The original intent was for an Android developer to be able to have
his working tree forest of 500 repositories subscribe to our internal
server's broadcast stream. We figured if the server knows exactly
which refs every client has, because they all have the same ones, and
their streams are all still open and active, then the server can make
exactly one incremental thin pack and send the same copy to every
client. Its "just" a socket write problem. Instead of packing the same
stuff 100x for 100x clients its packed once and sent 100x.

Then we realized remote offices could also install this software on a
local server, and use this as a fan-out distributor within the LAN. We
were originally thinking about some remote offices on small Internet
connections, where delivery of 10 MiB x 20 was a lot but delivery of
10 MiB once and local fan-out on the Ethernet was easy.

The JGit patches for this work are still pending[1].


If clients had a local Git-aware cache server in their office and
~/.gitconfig had the address of it, your problem becomes simple.

Clients clone from the public URL e.g. GitHub, but the local cache
server first gives the client a URL to clone from itself. After that
is complete then the client can fetch from the upstream. The cache
server can be self-maintaining, watching its requests to see what is
accessed often-ish, and keep those repositories current-ish locally by
running git fetch itself in the background.

Its easy to do this with bundles on "CDN" like HTTP. Just use the
office's caching HTTP proxy server. Assuming its cache is big enough
for those large Git bundle payloads, and the viral cat videos. But you
are at the mercy of the upstream bundler rebuilding the bundles. And
refetching them in whole. Neither of which is great.

A simple self-contained server that doesn't accept pushes, but knows
how to clone repositories, fetch them periodically, and run `git gc`,
works well. And the mirror URL extension we have been discussing in
this thread would work fine here. The cache server can return URLs
that point to itself. Or flat out proxy the Git transaction with the
origin server.


[1] https://git.eclipse.org/r/#/q/owner:wetherbeei%2540google.com+status:open,n,z
