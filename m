From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 09:56:58 -0500
Message-ID: <20061022145658.GV75501@over-yonder.net>
References: <1161487417.9241.220.camel@localhost.localdomain> <20061021233014.d4525a1d.seanlkml@sympatico.ca> <20061022100028.GQ75501@over-yonder.net> <20061022074422.50dcbee6.seanlkml@sympatico.ca> <20061022130322.GS75501@over-yonder.net> <20061022092845.233deb43.seanlkml@sympatico.ca> <20061022133336.GT75501@over-yonder.net> <20061022094041.77c06cc7.seanlkml@sympatico.ca> <20061022135702.GU75501@over-yonder.net> <20061022102454.b9dea693.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 16:57:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbel5-0000kR-Ni
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 16:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWJVO5A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 10:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWJVO5A
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 10:57:00 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:40902 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S1751091AbWJVO47 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 10:56:59 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id 0BCE22842F;
	Sun, 22 Oct 2006 09:56:59 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id 6401E61C52; Sun, 22 Oct 2006 09:56:58 -0500 (CDT)
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20061022102454.b9dea693.seanlkml@sympatico.ca>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29758>

On Sun, Oct 22, 2006 at 10:24:54AM -0400 I heard the voice of
Sean, and lo! it spake thus:
> 
> Light goes on.  Okay.  So a bzr "branch" is only ever editable on a
> single machine.  So there is no distributed development on top of a
> bzr "branch".  Everyone else just has read-only copies of it.

Ah!  Yes, that's exactly[0] right.  Mark up another of those "so
obvious we never think to state it" thought-patterns   :|


Distributed development proper only happens on 'projects', not
branches.  In practice, we say "we're all working on branch X", in the
sense that we use it as a base to work from and intend to merge our
stuff into it, but strictly speaking we're all working on our own
branches that just merge from/into X from time to time.

That's also why we use the phrases "merge from" and "merge to", rather
than "merge WITH".  Of course, where possible, we could 'fast-forward'
to X rather than merge from it, at which point we'd then momentarily
have exactly X, but culturally we don't seem to like doing that.



[0] There are a few very special-case exceptions, notably around the
'checkout' concept or where people are very carefully manually
maintaining sync, but they're irrelevant in this case; and they ARE
star-pattern developments that could be said to be 'centralized'.  Now
I grok where that's coming from.


-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
