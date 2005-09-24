From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Sat, 24 Sep 2005 13:13:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509241302450.23242@iabervon.org>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
 <7vvf0r6x97.fsf@assigned-by-dhcp.cox.net> <20050924125001.GB25069@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 19:10:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJDWb-0006xs-SH
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 19:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVIXRJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 13:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVIXRJF
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 13:09:05 -0400
Received: from iabervon.org ([66.92.72.58]:55813 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932197AbVIXRJF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2005 13:09:05 -0400
Received: (qmail 5206 invoked by uid 1000); 24 Sep 2005 13:13:29 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Sep 2005 13:13:29 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050924125001.GB25069@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9238>

On Sat, 24 Sep 2005, Petr Baudis wrote:

> Dear diary, on Sat, Sep 24, 2005 at 04:00:04AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> told me that...
> > Petr Baudis <pasky@suse.cz> writes:
> > 
> > > It takes loooong time, unfortunately - scp -r takes its time itself on
> > > many small files, and then we have to make a separate call to
> > > git-ssh-fetch for each tag. Isn't that braindamaged... :/
> > 
> > I think you could run git-peek-remote to find all the refs and
> > then run git-fetch-pack to slurp all the tags (and heads for
> > that matter) at once.  Is there a particular reason you would
> > prefer the commit walker?
> 
> Actually, probably not, except consistency with rsync and http handling
> - but that's obviously not too good reason. I did it this way since I'm
> going to be a bit busy again from now on.

It wouldn't actually be very hard to rewrite git-*-fetch programs to fetch 
with a bunch of starting points. The main reason I haven't is actually 
that I don't have any ideas for a way to extend the command line argument 
format to include it.

	-Daniel
*This .sig left intentionally blank*
