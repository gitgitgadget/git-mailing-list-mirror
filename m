From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Obscure commit message formatting issue
Date: Sun, 11 Nov 2007 17:50:54 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711111744090.29952@iabervon.org>
References: <Pine.LNX.4.64.0711111559220.29952@iabervon.org>
 <7vprygbfwf.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711111706490.29952@iabervon.org>
 <Pine.LNX.4.64.0711112240350.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 23:51:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrLe3-0000wS-Pu
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 23:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097AbXKKWu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 17:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756092AbXKKWu4
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 17:50:56 -0500
Received: from iabervon.org ([66.92.72.58]:44861 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756068AbXKKWuz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 17:50:55 -0500
Received: (qmail 29966 invoked by uid 1000); 11 Nov 2007 22:50:54 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Nov 2007 22:50:54 -0000
In-Reply-To: <Pine.LNX.4.64.0711112240350.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64534>

On Sun, 11 Nov 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Sun, 11 Nov 2007, Daniel Barkalow wrote:
> 
> > On Sun, 11 Nov 2007, Junio C Hamano wrote:
> > 
> > > Daniel Barkalow <barkalow@iabervon.org> writes:
> > > 
> > > > The current code drops extra blank lines between the first line of a 
> > > > commit message (the summary line) and the remainder.
> > > 
> > > The patch application side does even more.  It not just strips
> > > off the leading or trailing blank lines, but duplicate blank
> > > lines in the middle and trailing whitespaces at the end of each
> > > line.
> > > 
> > > I am of two minds about the formatting side.
> > > 
> > > The behaviour you found does not go far enough to correct all of
> > > the above whitespace breakage the application side will fix up
> > > on the generation side -- it only corrects one of them.  We
> > > might want to do more, instead of less that you seem to be
> > > implying to favor.
> > 
> > What I'm actually doing is working on a cover letter implementation.
> 
> Funny.
> 
> I am in the middle of cleaning out my personal git branch that has a messy 
> history, since I never rebased, but always merged.  Now I decided to go 
> with rebasing.
> 
> And there I found an implementation of a cover letter.  You might want to 
> be interested ;-)
> 
> 	http://repo.or.cz/w/git/dscho.git?a=shortlog;h=cover-letter

I actually started from the patch you sent me a while back, but using code 
from pretty.c instead of generating the message directly. I'll have to 
check whether you added anything since the patch I got.

	-Daniel
*This .sig left intentionally blank*
