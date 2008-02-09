From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Add gitattributes file making whitespace checking
	pickier
Date: Sat, 9 Feb 2008 18:39:48 -0500
Message-ID: <20080209233948.GC20501@fieldses.org>
References: <20080209162234.GA25533@fieldses.org> <m3abm9hqix.fsf@localhost.localdomain> <20080209200435.GA8919@fieldses.org> <200802092122.01656.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 00:40:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNzJ4-0005Ah-Dg
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 00:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954AbYBIXjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 18:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755953AbYBIXjv
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 18:39:51 -0500
Received: from mail.fieldses.org ([66.93.2.214]:39333 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755950AbYBIXjt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 18:39:49 -0500
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1JNzIS-0005xW-Js; Sat, 09 Feb 2008 18:39:48 -0500
Content-Disposition: inline
In-Reply-To: <200802092122.01656.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73276>

On Sat, Feb 09, 2008 at 09:22:00PM +0100, Jakub Narebski wrote:
> J. Bruce Fields wrote:
> > On Sat, Feb 09, 2008 at 11:36:31AM -0800, Jakub Narebski wrote:
> > > "J. Bruce Fields" <bfields@fieldses.org> writes:
> > > 
> > > >  gitweb/gitweb.perl                                  |  566 ++--
> > > >  index-pack.c                                        |   30 
> > > 
> > > gitweb (at my insistence) uses tabs for indent, but spaces for align,
> > > so that the layout is [roughly] preserved independently of the tab
> > > size. IMHO it is superior style, but much harder to check
> > > algorithmically (although I send some sketch of idea how to check that
> > > at least for aligned commands). That is why there is such a big change.
> > > 
> > > I'd rather have real bugfixes, real documentation improvements, new
> > > features instead of such bikeshedding.  If someone is making a change
> > > somewhere, he/she can fix the whitespace in the neighbourhood.
> > 
> > I agree completely.  Did I suggest otherwise?
> 
> Ah, sorry, I have misunderstood.
> 
> This is an informational piece, then, isn't it?

Yeah, I was generating the diff just as a way to get an idea which paths
which policies should apply to.

That still doesn't rise much above bikeshedding, but it's not quite as
bad as actually trying to apply such a diff...

--b.
