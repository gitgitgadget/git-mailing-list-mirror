From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 17:49:04 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808191647320.19665@iabervon.org>
References: <alpine.LNX.1.00.0808181628420.19665@iabervon.org> <7vtzdiklbw.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181839390.19665@iabervon.org> <7vy72tit90.fsf@gitster.siamese.dyndns.org> <20080819175220.GA10142@coredump.intra.peff.net>
 <alpine.LNX.1.00.0808191407160.19665@iabervon.org> <20080819184525.GA17691@coredump.intra.peff.net> <alpine.LNX.1.00.0808191448530.19665@iabervon.org> <20080819190159.GB17943@coredump.intra.peff.net> <alpine.LNX.1.00.0808191523050.19665@iabervon.org>
 <20080819203353.GG10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 19 23:50:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVZ5m-00086X-F5
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 23:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161AbYHSVtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 17:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754392AbYHSVtH
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 17:49:07 -0400
Received: from iabervon.org ([66.92.72.58]:57934 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755161AbYHSVtG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 17:49:06 -0400
Received: (qmail 13626 invoked by uid 1000); 19 Aug 2008 21:49:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Aug 2008 21:49:04 -0000
In-Reply-To: <20080819203353.GG10544@machine.or.cz>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92926>

On Tue, 19 Aug 2008, Petr Baudis wrote:

> On Tue, Aug 19, 2008 at 03:42:01PM -0400, Daniel Barkalow wrote:
> > On Tue, 19 Aug 2008, Jeff King wrote:
> > Ah, okay. I feel like the main application for this is "I typed some git 
> > diff command, started looking at it, my phone rang, I took the call, and 
> > now I don't know what I'm looking at, and the pager hides the command 
> > line, but quitting the pager loses my place." At least, that's the 
> > situation I'm often in.
> 
> Press ctrl-z. ;-)
> 
> > > > Yeah, that's why I think that format-patch should work on content that you 
> > > > haven't committed, generating something you can dump right into an email 
> > > > (with the --- and diffstat that you'd get if you actually did commit and 
> > > > use format-patch now).
> 
> Hmm, and why don't you actually do the commit after all? You can compose
> all the details within the commit and you can do the commit on a
> separate branch or git reset HEAD^ afterwards if you don't want to keep
> it around.

I personally almost always do something like:

$ git checkout -b informational-diff-prefixes
$ git commit -a
$ git show HEAD > temp.patch
$ git checkout master

But then I tend to use "checkout -b; commit -a; checkout" instead of 
"reset --hard" to get rid of unwanted local changes anyway these days.

	-Daniel
*This .sig left intentionally blank*
