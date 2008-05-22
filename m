From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 22 May 2008 18:02:55 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805221649240.19665@iabervon.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vwso85qkf.fsf@gitster.siamese.dyndns.org> <7vwso5r87q.fsf@gitster.siamese.dyndns.org> <7v8x0992hy.fsf@gitster.siamese.dyndns.org> <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org> <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org> <7vbq4j748l.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0805221212200.30431@racer> <7vlk22urtt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 00:03:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzIt4-0006Sz-QD
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 00:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759209AbYEVWC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 18:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758473AbYEVWC6
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 18:02:58 -0400
Received: from iabervon.org ([66.92.72.58]:58043 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758179AbYEVWC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 18:02:57 -0400
Received: (qmail 24985 invoked by uid 1000); 22 May 2008 22:02:55 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 May 2008 22:02:55 -0000
In-Reply-To: <7vlk22urtt.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82657>

On Thu, 22 May 2008, Junio C Hamano wrote:

> >> * db/clone-in-c (Tue May 20 14:15:14 2008 -0400) 11 commits
> >>  + clone: fall back to copying if hardlinking fails
> >>  + builtin-clone.c: Need to closedir() in copy_or_link_directory()
> >>  + builtin-clone: fix initial checkout
> >>  + Build in clone
> >>  + Provide API access to init_db()
> >>  + Add a function to set a non-default work tree
> >>  + Allow for having for_each_ref() list extra refs
> >>  + Have a constant extern refspec for "--tags"
> >>  + Add a library function to add an alternate to the alternates file
> >>  + Add a lockfile function to append to a file
> >>  + Mark the list of refs to fetch as const
> >
> > Fingers crossed.
> 
> Rather, uncross them and type a few more tests ;-)?

There are a few tests from Johan that didn't get in, which I'd had in my 
tree but didn't send because I don't have a good process in place for 
sending patches I'm not the author of. I'm pretty sure they pass, but I 
haven't checked recently. I'll send them in a moment.

	-Daniel
*This .sig left intentionally blank*
