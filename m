From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Corruption: empty refs/heads in otherwise filled repo: cannot
 clone?
Date: Mon, 30 Jun 2008 15:33:50 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806301528500.19665@iabervon.org>
References: <200806301149.18115.J.Wielemaker@uva.nl> <200806301344.09938.J.Wielemaker@uva.nl> <200806301403.57900.jnareb@gmail.com> <200806301420.12872.J.Wielemaker@uva.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jan Wielemaker <J.Wielemaker@uva.nl>
X-From: git-owner@vger.kernel.org Mon Jun 30 21:35:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDP9V-0001hh-HQ
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 21:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643AbYF3Tdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 15:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764250AbYF3Tdx
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 15:33:53 -0400
Received: from iabervon.org ([66.92.72.58]:47905 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932092AbYF3Tdv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 15:33:51 -0400
Received: (qmail 30438 invoked by uid 1000); 30 Jun 2008 19:33:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jun 2008 19:33:50 -0000
In-Reply-To: <200806301420.12872.J.Wielemaker@uva.nl>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86933>

On Mon, 30 Jun 2008, Jan Wielemaker wrote:

> On Monday 30 June 2008 14:03, Jakub Narebski wrote:
> > Jan Wielemaker wrote:
> > > Summarising, I think the conclusion is that git pack-refs has somehow
> > > been run on this repository, and being a bare one this is not a
> > > particulary good idea right now. I have the impression I should `unpack'
> > > them by putting the appriate files in heads (done) and tags (now still)
> > > and (re)move packed-refs.
> >
> > If you use new enough git both on server and on clients it should
> > not have problems with packed-refs. I would rather check permissions
> > of $GIT_DIR and $GIT_DIR/packed-refs.
> 
> There is no permission problem, as a I proved by doing a recursive copy
> of the whole repo (cp -a, no errors) and the problem prevails on the
> copy. A serious scan for permission errors was my first step. Almost
> looks like something in the environment, but I can't find anything weird
> there either.

That's a "cp -a" as somebody else, I assume? (If it were as you or root, 
you'd generate a copy of the repository with any permission problem 
unchanged, since -a includes -p.)

	-Daniel
*This .sig left intentionally blank*
