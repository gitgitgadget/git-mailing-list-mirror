From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 1/2] Add for_each_remote() function, and extend
 remote_find_tracking()
Date: Tue, 10 Jul 2007 17:09:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707101503470.6977@iabervon.org>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
 <7vhcof2rur.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707081336020.4248@racer.site>
 <7vzm2620wp.fsf@assigned-by-dhcp.cox.net> <46919692.5020708@gnu.org>
 <7vhcoexqeh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707091228290.5546@racer.site>
 <7v4pkduw2f.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707092203100.5546@racer.site>
 <7vzm25tex6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707100401070.4131@racer.site>
 <7vy7hosv7v.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707101848050.4047@racer.site>
 <7vtzscqf2r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 23:09:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8Mxy-0006L2-CS
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 23:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759493AbXGJVJq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 17:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759705AbXGJVJq
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 17:09:46 -0400
Received: from iabervon.org ([66.92.72.58]:4635 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758422AbXGJVJq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 17:09:46 -0400
Received: (qmail 2641 invoked by uid 1000); 10 Jul 2007 21:09:45 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jul 2007 21:09:45 -0000
In-Reply-To: <7vtzscqf2r.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52112>

On Tue, 10 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The function for_each_remote() does exactly what the name suggests.
> >
> > The function remote_find_tracking() was extended to be able to search
> > remote refs for a given local ref.  You have to set the parameter
> > "reverse" to true for that behavior.
> 
> The updated patch does not use "reverse" but the old description
> is still there.
> 
> Daniel, one thing I fear about your "I want to store the message
> in the object store so that I can reuse even after I re-polish
> the series" desire on the cover letter topic is this kind of
> gotcha, and that is why I suggested "*** BLURB GOES HERE ***".
> Both the summary (diffstat and shortlog) part and the
> description part should be kept fresh in the updated 0/N; while
> we can automate the summary part whenever we re-generate 0/N,
> you cannot automate the description part.

It seems to me that commit messages are much more likely to mention the 
sorts of details that are affected by review than cover letters are. 
Furthermore, if the message is coming out of a tag on the head of the 
series, whatever is used to put the tag onto the new head of the series 
would present the buffer for editting again, just like commit --amend 
does. So the user would be just as likely to think to update a series 
header as a commit message, and less likely to need to.

	-Daniel
*This .sig left intentionally blank*
