From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Add gitattributes file making whitespace checking
	pickier
Date: Sat, 9 Feb 2008 15:04:35 -0500
Message-ID: <20080209200435.GA8919@fieldses.org>
References: <20080209162234.GA25533@fieldses.org> <alpine.LNX.1.00.0802091251430.13593@iabervon.org> <20080209185038.GB25533@fieldses.org> <20080209190533.GD25533@fieldses.org> <m3abm9hqix.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 21:05:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNvws-000270-WE
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 21:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417AbYBIUEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 15:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755121AbYBIUEl
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 15:04:41 -0500
Received: from mail.fieldses.org ([66.93.2.214]:39492 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754716AbYBIUEl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 15:04:41 -0500
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1JNvwC-0002Lp-0I; Sat, 09 Feb 2008 15:04:36 -0500
Content-Disposition: inline
In-Reply-To: <m3abm9hqix.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73257>

On Sat, Feb 09, 2008 at 11:36:31AM -0800, Jakub Narebski wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> >  gitweb/gitweb.perl                                  |  566 ++--
> >  index-pack.c                                        |   30 
> 
> gitweb (at my insistence) uses tabs for indent, but spaces for align,
> so that the layout is [roughly] preserved independently of the tab
> size. IMHO it is superior style, but much harder to check
> algorithmically (although I send some sketch of idea how to check that
> at least for aligned commands). That is why there is such a big change.
> 
> I'd rather have real bugfixes, real documentation improvements, new
> features instead of such bikeshedding.  If someone is making a change
> somewhere, he/she can fix the whitespace in the neighbourhood.

I agree completely.  Did I suggest otherwise?

--b.
