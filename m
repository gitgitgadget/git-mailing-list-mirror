From: Jeff King <peff@peff.net>
Subject: Re: disallowing push to currently checked-out branch
Date: Sun, 15 Feb 2009 23:05:29 -0500
Message-ID: <20090216040529.GC12689@coredump.intra.peff.net>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <20090216035027.GA12689@coredump.intra.peff.net> <alpine.DEB.1.10.0902152057500.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Heikki Orsila <shdl@zakalwe.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Feb 16 05:07:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYul1-0005MN-Cv
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 05:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051AbZBPEFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 23:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755967AbZBPEFb
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 23:05:31 -0500
Received: from peff.net ([208.65.91.99]:37368 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755948AbZBPEFb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 23:05:31 -0500
Received: (qmail 13119 invoked by uid 107); 16 Feb 2009 04:05:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 23:05:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 23:05:29 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0902152057500.14911@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110133>

On Sun, Feb 15, 2009 at 09:05:33PM -0800, david@lang.hm wrote:

>> I'm not sure I understand your argument here. If you have a machine that
>> needs to do _exactly_ what you have tested, then wouldn't you be
>> concerned about upgrading git 1.5.6.5 to (for example) git 1.7? Or since
>> you are probably looking at a more macro-level, upgrading Debian 5.0 to
>> Debian 6.0?
>
> two points
>
> 1. someone running Debian 5 who then upgrades to Debian 6 should get the  
> warning, not the refusal, then when they go to Debian 7 the refusal can be 
> the standard (and substatute redhat enterprise version numbers for debian  
> if you want)

So people doing major version upgrades of their OS don't need to read
release notes or re-test behavior?

What about people who skip straight from 5 to 7? It's OK for them not to
see the warning, because two major versions means they should read the
release notes and re-test?

> so a warning can go in at any time, but changing the default in a way  
> that's not backwards compatible needs to be done over a _very_ long  
> timeframe. so long that it's worth questioning if it's worth changing (as  
> opposed to either just leaving the warning, or trying to figure out a  
> different way)

There has been a lot of questioning, and a lot of discussion of
alternatives already. Please check the list archive for some of it.

I don't think there is a timetable set at this point.

-Peff
