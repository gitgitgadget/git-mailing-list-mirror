From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in
  git, help users out.
Date: Tue, 6 Nov 2007 22:21:18 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711062220050.4362@racer.site>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org>
 <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>
 <7vlk9cmiyq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711052325090.4362@racer.site>
 <7vsl3kjdct.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711060317220.4362@racer.site>
 <7vode8j7o5.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711061230540.4362@racer.site>
 <7v8x5bi703.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711061827030.4362@racer.site>
 <20071106193959.GB4382@artemis.corp> <7vir4fgnz1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 23:22:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpWoa-0003RS-1D
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 23:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbXKFWWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 17:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754586AbXKFWWS
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 17:22:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:38410 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753330AbXKFWWR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 17:22:17 -0500
Received: (qmail invoked by alias); 06 Nov 2007 22:22:15 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp034) with SMTP; 06 Nov 2007 23:22:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18AxCZaItkAOBwTTCc3nlA9S6GRuvabCD1I4+H/hm
	4XiSIvRxpD3cdV
X-X-Sender: gene099@racer.site
In-Reply-To: <7vir4fgnz1.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63738>

Hi,

On Tue, 6 Nov 2007, Junio C Hamano wrote:

> Pierre Habouzit <madcoder@debian.org> writes:
> 
> > On Tue, Nov 06, 2007 at 06:27:54PM +0000, Johannes Schindelin wrote:
> > 
> >> On Tue, 6 Nov 2007, Junio C Hamano wrote:
> >> 
> >> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> > 
> >> > > Well, I think that _if_ we allow "git revert <path>" to mean 
> >> > > "revert the changes to <path>, relative to the index" (which 
> >> > > would be the same as "git checkout <path>"), then committing that 
> >> > > change just does not make sense.
> >> > >
> >> > > And it is this behaviour that people are seeking, not "git revert 
> >> > > <commit> <path>".
> >> > 
> >> > Heh, I found this in the recent log somewhere.
> >> > 
> >> > <gitte> Really, I wonder how difficult git is for people who are not
> >> > 	brainwashed by cvs/svn, and unfortunately enough, partly by bzr 
> >> >  and hg.
> >> > <gitte> From a user perspective, you might be correct.  But then we 
> >> >  have to add 1000 commands to reflect the English language.
> >> > <gitte> Not what I want.						[06:46]
> >> > 
> >> > I am wondering who said it ;-).
> >> 
> >> Now, that is not fair, using my own words against me ;-)
> >
> >   That's very funny actually :]
> 
> Yeah, it was doubly funny after I saw you posted a list of "$scm revert" 
> and Dscho still sided with you in that thread.

Hey, I had my nice 5 minutes for the day, so give me a break!

;-)

Ciao,
Dscho
