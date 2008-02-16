From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Validate nicknames of remote branches to prohibit
 confusing ones
Date: Fri, 15 Feb 2008 22:11:38 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802152209560.13593@iabervon.org>
References: <alpine.LNX.1.00.0802151412390.13593@iabervon.org> <7vskztg8rr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 04:12:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQDTK-0002Ih-KN
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 04:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbYBPDLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 22:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbYBPDLk
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 22:11:40 -0500
Received: from iabervon.org ([66.92.72.58]:48371 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852AbYBPDLj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 22:11:39 -0500
Received: (qmail 28700 invoked by uid 1000); 16 Feb 2008 03:11:38 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Feb 2008 03:11:38 -0000
In-Reply-To: <7vskztg8rr.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74002>

On Fri, 15 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > The original problem was that the parsers for configuration files were
> > getting confused by seeing as nicknames remotes that involved
> > directory-changing characters. In particular, the branches config file
> > for ".." was particularly mystifying on platforms that can open
> > directories and read odd data from them.
> >
> > The validation function was written by Junio Hamano (with a typo
> > corrected).
> >
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> > I was sort of expecting you to just put this in yourself, but since you 
> > haven't, I wrote it up as an actual patch and fixed the polarity of the 
> > test for slashes.
> 
> Thanks.  I am bogged down in day-job these days and have been
> down-sick for the past 36 hours.

No problem. It's an easy enough patch, and the test suite found the bug in 
the original version. I just wanted to make sure it didn't get forgotten 
on account of never getting a patch emailled to the list.

	-Daniel
*This .sig left intentionally blank*
