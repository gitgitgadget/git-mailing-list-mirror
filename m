From: david@lang.hm
Subject: Re: Performance issue of 'git branch'
Date: Fri, 24 Jul 2009 15:46:29 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0907241545340.28013@asgard.lang.hm>
References: <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain> <7vtz146mgr.fsf@alter.siamese.dyndns.org>
 <20090723160740.GA5736@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain> <20090723165335.GA15598@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain>
 <20090723195548.GA28494@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain> <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain> <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain> <alpine.LFD.2.01.0907241505400.3960@localhost.localdomain>
 <alpine.DEB.1.10.0907241518120.28013@asgard.lang.hm> <alpine.LFD.2.01.0907241529420.3960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 00:46:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUTXS-0008Ik-KS
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbZGXWqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754933AbZGXWqq
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:46:46 -0400
Received: from mail.lang.hm ([64.81.33.126]:53493 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754930AbZGXWqq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 18:46:46 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n6OMkUIl017894;
	Fri, 24 Jul 2009 15:46:30 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.LFD.2.01.0907241529420.3960@localhost.localdomain>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123966>

On Fri, 24 Jul 2009, Linus Torvalds wrote:

> On Fri, 24 Jul 2009, david@lang.hm wrote:
>>
>> what does the performance look like if you just do a static compile instead?
>
> I don't even know - I don't have a static version of curl. I could install
> one, of course, but since I don't think that's the solution anyway, I'm
> not going to bother.

I wasn't thinking a static version of curl, I was thinking a static 
version of the git binaries. see how fast things could be if no startup 
linking was nessasary.

David Lang

> The real solution really is to not have curl support in the main binary.
>
> One option might be to make _all_ the transport code be outside of the
> core binary, or course.  That's a fairly simple but somewhat sad solution
> (ie make all of push/pull/fetch/clone/ls-remote/etc be external binaries)
>
> 		Linus
>
