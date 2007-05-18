From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: merge summaries
Date: Fri, 18 May 2007 17:56:03 -0400
Message-ID: <20070518215603.GS15393@fieldses.org>
References: <25A3C618-8D12-42A8-9478-D3A4E7633CE7@zib.de> <alpine.LFD.0.98.0705181130580.3890@woody.linux-foundation.org> <7vodki55px.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0705181206051.3890@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 18 23:56:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpAQn-0006rZ-FX
	for gcvg-git@gmane.org; Fri, 18 May 2007 23:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559AbXERV4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 17:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754693AbXERV4J
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 17:56:09 -0400
Received: from mail.fieldses.org ([66.93.2.214]:42131 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754559AbXERV4I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 17:56:08 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HpAQd-0004vM-82; Fri, 18 May 2007 17:56:03 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0705181206051.3890@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47660>

On Fri, May 18, 2007 at 12:13:02PM -0700, Linus Torvalds wrote:
> 
> On Fri, 18 May 2007, Junio C Hamano wrote:
> > 
> > This does not necessarily mean that your lieutenants should not
> > use merge.summary when they pull from other trees (or inside
> > their own repository to merge in the topics).  They need to
> > however disable it with --no-summary when they pull from you
> > when they choose to merge instead of rebase to adjust to the
> > updated infrastructure in your tree.
> 
> Yes, the problem is that people *will* get it wrong, so right now I'd 
> discourage people from even trying to enable merge summaries unless they 
> are the top-level maintainer.

I never quite understood what they're for--do they add any information
not already available in the history?  If not, and if people still find
them helpful anyway, then I dunno, it looks like a sign of some sort of
failure of our history display tools.

--b.
