From: david@lang.hm
Subject: Re: disallowing push to currently checked-out branch
Date: Sun, 15 Feb 2009 21:18:47 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0902152113380.14911@asgard.lang.hm>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <20090216035027.GA12689@coredump.intra.peff.net>
 <alpine.DEB.1.10.0902152057500.14911@asgard.lang.hm> <20090216040529.GC12689@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Heikki Orsila <shdl@zakalwe.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 05:17:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYuuk-0007KS-PQ
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 05:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994AbZBPEN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 23:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755948AbZBPEN4
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 23:13:56 -0500
Received: from mail.lang.hm ([64.81.33.126]:44071 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753440AbZBPEN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 23:13:56 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n1G4DmYP020528;
	Sun, 15 Feb 2009 20:13:48 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20090216040529.GC12689@coredump.intra.peff.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110134>

On Sun, 15 Feb 2009, Jeff King wrote:

> On Sun, Feb 15, 2009 at 09:05:33PM -0800, david@lang.hm wrote:
>
>>> I'm not sure I understand your argument here. If you have a machine that
>>> needs to do _exactly_ what you have tested, then wouldn't you be
>>> concerned about upgrading git 1.5.6.5 to (for example) git 1.7? Or since
>>> you are probably looking at a more macro-level, upgrading Debian 5.0 to
>>> Debian 6.0?
>>
>> two points
>>
>> 1. someone running Debian 5 who then upgrades to Debian 6 should get the
>> warning, not the refusal, then when they go to Debian 7 the refusal can be
>> the standard (and substatute redhat enterprise version numbers for debian
>> if you want)
>
> So people doing major version upgrades of their OS don't need to read
> release notes or re-test behavior?

when was the last time you read the release notes for an entire distro?

they will test behavior, but if things that used to work just fail it's 
not good.

> What about people who skip straight from 5 to 7? It's OK for them not to
> see the warning, because two major versions means they should read the
> release notes and re-test?

for the 'enterprise distros' you would need to upgrade from 5 to 6 to 7 to 
remain supported. if you go directly from 5 to 7 you have been in 
unsupported territory for quite some time (probably measured in years).

and it's not a matter of reading the release notes. it's a matter of them 
running a version that gives them a warning before you feed them a version 
that will cause their existing stuff to fail.

I recognise that not all software is concerned about backwards 
compatibility, but if git wasn't concerned with backwards compatibility 
and a graceful upgrade process, this thread wouldn't exist.

David Lang

>> so a warning can go in at any time, but changing the default in a way
>> that's not backwards compatible needs to be done over a _very_ long
>> timeframe. so long that it's worth questioning if it's worth changing (as
>> opposed to either just leaving the warning, or trying to figure out a
>> different way)
>
> There has been a lot of questioning, and a lot of discussion of
> alternatives already. Please check the list archive for some of it.
>
> I don't think there is a timetable set at this point.
>
> -Peff
>
