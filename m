From: Petr Baudis <pasky@suse.cz>
Subject: Re: CGit and repository list
Date: Fri, 12 Sep 2008 18:05:38 +0200
Message-ID: <20080912160538.GB10360@machine.or.cz>
References: <19449377.post@talk.nabble.com> <8c5c35580809120736x4170b2dbq3438bd619326ae00@mail.gmail.com> <20080912145804.GF10544@machine.or.cz> <200809121754.30277.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 18:07:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeBBF-0004lk-Du
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 18:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757182AbYILQFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 12:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757187AbYILQFl
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 12:05:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45458 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757153AbYILQFl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 12:05:41 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B801E393A2E2; Fri, 12 Sep 2008 18:05:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809121754.30277.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95745>

On Fri, Sep 12, 2008 at 05:54:29PM +0200, Jakub Narebski wrote:
> Petr Baudis wrote:
> > On Fri, Sep 12, 2008 at 04:36:11PM +0200, Lars Hjemli wrote:
> > >
> > > <plug>
> > > Current cgit also allows cloning over http using the same url as for
> > > browsing the repo, i.e. you may
> > > 
> > >   $ git clone http://hjemli.net/git/cgit
> > > 
> > > This has one advantage over just publishing the repo; you don't have
> > > to run `git-update-server-info` (thanks to the work done by Shawn O.
> > > Pearce on git-http-backend, which is shamelessly reimplemented in
> > > cgit).
> > > </plug>
> > 
> >   this finally tripped me over and I wanted to quickly add cgit as an
> > alternate viewing interface at repo.or.cz. [...]
> 
> Or you can wait a little while for "smart" HTTP server, which I guess
> also generates automatically or/and on the fly objects/info/packs and
> info/refs required by "dumb" protocols clients (including old HTTP
> clients).

It is more like that this prodded me to have a look at cgit again, think
of it and realize that it should be pretty easy for me to add cgit to
repo.or.cz. This is just a bonus. :-)

I have already mailed Shawn immediately after the original proposal
was posted that I'm willing to put this up on repo.or.cz as soon as
something tangible is ready.

> P.S. Could you please gather some statistics to compare the period
> before and after installing "smart" HTTP server (and after smart
> clients became widespread).

What kind of statistics?

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
