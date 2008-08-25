From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: "failed to read delta base object at..."
Date: Mon, 25 Aug 2008 18:13:21 -0400
Message-ID: <20080825221321.GL2213@fieldses.org>
References: <20080825164602.GA2213@fieldses.org> <alpine.LFD.1.10.0808251153210.3363@nehalem.linux-foundation.org> <20080825213104.GI2213@fieldses.org> <alpine.LFD.1.10.0808251435540.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 00:14:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXkKS-0004ih-EV
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 00:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbYHYWNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 18:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753472AbYHYWNX
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 18:13:23 -0400
Received: from mail.fieldses.org ([66.93.2.214]:47530 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753417AbYHYWNW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 18:13:22 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1KXkJN-0002ax-Bu; Mon, 25 Aug 2008 18:13:21 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808251435540.3363@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93691>

On Mon, Aug 25, 2008 at 02:37:39PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 25 Aug 2008, J. Bruce Fields wrote:
> > 
> > OK.  I seem to recall these pack files are created with something like
> > 
> > 	open
> > 	write
> > 	sync
> > 	close
> > 	rename
> > 
> > ? 
> 
> Yes. We're trying to be _extremely_ safe and only do things that should 
> work for everything.
> 
> > This is just ext3 with data=writeback on a local laptop disk,
> > ubuntu's 2.6.24-21-generic.  Would it be any use trying to look more
> > closely at the pack in connection for any hints?
> 
> You still have the packfile that caused problems available somewhere? If 
> so, absolutely yes. If you have the corrupt pack, please make it 
> available.
> 
> > (But with my git repo back I'm happy enough to just forget this for now
> > if there's not anything obvious to try.)
> 
> With the actual corrupt pack, we can make a fairly intelligent guess about 
> exactly what the corruption was. Was it a flipped bit, or what? So if you 
> have it, please do send it over.

OK!  It's in:

	http://www.citi.umich.edu/u/bfields/bad-pack/

I assume the .idx file isn't interesting, but it's there anyway in case.

--b.
