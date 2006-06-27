From: Martin Hicks <mort@bork.org>
Subject: Re: bisect help
Date: Tue, 27 Jun 2006 18:59:44 -0400
Message-ID: <20060627225944.GB16658@bork.org>
References: <20060627201302.GA16658@bork.org> <7vy7vi70bm.fsf@assigned-by-dhcp.cox.net> <20060627220421.GA7234@coredump.intra.peff.net> <7vu0666x2r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 00:59:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvMX7-00005w-Rb
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 00:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWF0W7r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 18:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWF0W7q
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 18:59:46 -0400
Received: from galileo.bork.org ([134.117.69.57]:35522 "EHLO galileo.bork.org")
	by vger.kernel.org with ESMTP id S932561AbWF0W7p (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 18:59:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by galileo.bork.org (Postfix) with ESMTP id BAD89404C;
	Tue, 27 Jun 2006 18:59:44 -0400 (EDT)
Received: from galileo.bork.org ([127.0.0.1])
	by localhost (galileo.bork.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 21240-04; Tue, 27 Jun 2006 18:59:44 -0400 (EDT)
Received: by galileo.bork.org (Postfix, from userid 1000)
	id 9322C4197; Tue, 27 Jun 2006 18:59:44 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0666x2r.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at bork.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22762>


On Tue, Jun 27, 2006 at 03:41:16PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > Since 'test' is a throwaway branch anyway, might it not make sense to
> > clone master to test and then rebase satadev onto it? Thus you would end
> > up with the linear history:
> >   o---o---o---o---o---o---o test (satadev')
> >   |           |
> > 2.6.17      master
> >
> > You know that master works and satadev' doesn't, and the bisection is
> > simple. After you find that bug, you can throw away the test branch.
> 
> I've considered suggesting it before looking at what is in
> satadev.  It is merged up in the Linus head right now, so you
> are talking about really _huge_ changes that are not yours and
> with a lot of merges.
> 
> It usually is much easier to rebase your own code than other's.
> 
> BTW, I really hate MUA's that does Mail-Followup-To to somebody
> else.  This message for example would not help Martin more than
> it would help you, but your MUA somehow redirected it to him.

I think the rebase idea is going to be painful.  There are a *lot* of
changesets in between 2.6.17 and satadev, due to the post-2.6.17 devel
cycle opening.

I rebasing quickly, but it would require a bit of merging.  I'll try
tomorrow to see how bad it really is.

Thank you both for the ideas.  I think I've got enough information now
to continue.

mh

-- 
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE
