From: david@lang.hm
Subject: Re: Why Git is so fast (was: Re: Eric Sink's blog - notes on git,
 dscms and a "whole product" approach)
Date: Fri, 1 May 2009 15:11:03 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0905011503400.15782@asgard>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3ocugod96.fsf@localhost.localdomain> <m3fxfqnxn5.fsf_-_@localhost.localdomain> <20090430142244.GA23550@coredump.intra.peff.net> <alpine.LFD.2.00.0905011431460.5379@localhost.localdomain>
 <20090501190854.GA13770@coredump.intra.peff.net> <alpine.LFD.2.00.0905011420580.5379@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 02 00:12:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M00y5-0006zm-Mz
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 00:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbZEAWMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 18:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbZEAWMV
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 18:12:21 -0400
Received: from mail.lang.hm ([64.81.33.126]:35261 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbZEAWMU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 18:12:20 -0400
Received: from asgard.local (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n41MB3hM007195;
	Fri, 1 May 2009 15:11:04 -0700
X-X-Sender: dlang@asgard
In-Reply-To: <alpine.LFD.2.00.0905011420580.5379@localhost.localdomain>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118102>

On Fri, 1 May 2009, Linus Torvalds wrote:

> I bet we could probably improve git large-file behavior for many common
> cases. Do we have a good test-case of some particular suckiness that is
> actually relevant enough that people might decide to look at it (and by
> "people", I do mean myself too - but I'd need to be somewhat motivated by
> it. A usage case that we suck at and that is available and relevant).

I think that a sane use case that would make sense to people is based on 
the 'game developer' example

they have source code, but they also have large images (and sometimes 
movie clips), where a particular release of the game needs a particular 
set of the images. during development you may change images frequently 
(although most changesets probably only change a few, if any of the 
images)

the images can be large (movies can be very large), and since they are 
already compressed they don't diff or compress well.

David Lang
