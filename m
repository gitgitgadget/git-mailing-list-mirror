From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Obscure commit message formatting issue
Date: Sun, 11 Nov 2007 22:43:10 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711112240350.4362@racer.site>
References: <Pine.LNX.4.64.0711111559220.29952@iabervon.org>
 <7vprygbfwf.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711111706490.29952@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 23:43:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrLWm-0007NE-A4
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 23:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799AbXKKWnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 17:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755516AbXKKWnY
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 17:43:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:55362 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755460AbXKKWnX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 17:43:23 -0500
Received: (qmail invoked by alias); 11 Nov 2007 22:43:21 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp054) with SMTP; 11 Nov 2007 23:43:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187o5pkvC07ew1VHdx9B0lwdhThRruS+eGYEt8NkU
	0Xj5BHfOdR3HaY
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711111706490.29952@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64531>

Hi,

On Sun, 11 Nov 2007, Daniel Barkalow wrote:

> On Sun, 11 Nov 2007, Junio C Hamano wrote:
> 
> > Daniel Barkalow <barkalow@iabervon.org> writes:
> > 
> > > The current code drops extra blank lines between the first line of a 
> > > commit message (the summary line) and the remainder.
> > 
> > The patch application side does even more.  It not just strips
> > off the leading or trailing blank lines, but duplicate blank
> > lines in the middle and trailing whitespaces at the end of each
> > line.
> > 
> > I am of two minds about the formatting side.
> > 
> > The behaviour you found does not go far enough to correct all of
> > the above whitespace breakage the application side will fix up
> > on the generation side -- it only corrects one of them.  We
> > might want to do more, instead of less that you seem to be
> > implying to favor.
> 
> What I'm actually doing is working on a cover letter implementation.

Funny.

I am in the middle of cleaning out my personal git branch that has a messy 
history, since I never rebased, but always merged.  Now I decided to go 
with rebasing.

And there I found an implementation of a cover letter.  You might want to 
be interested ;-)

	http://repo.or.cz/w/git/dscho.git?a=shortlog;h=cover-letter

Ciao,
Dscho
