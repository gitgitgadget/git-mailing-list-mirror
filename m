From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach 'git pull' the '--rebase' option
Date: Fri, 26 Oct 2007 00:10:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710260007450.4362@racer.site>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site>
 <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 01:11:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlBr7-00008n-IS
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 01:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761702AbXJYXKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 19:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761683AbXJYXKl
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 19:10:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:42284 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761661AbXJYXKk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 19:10:40 -0400
Received: (qmail invoked by alias); 25 Oct 2007 23:10:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 26 Oct 2007 01:10:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wFtMKpUdwFhE1tXYcYedC7PnAFhB0NCpeitBa5n
	JtTIHMOP+XUxcd
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62384>

Hi,

On Thu, 25 Oct 2007, Linus Torvalds wrote:

> On Thu, 25 Oct 2007, Johannes Schindelin wrote:
> > 
> > This behavior is more desirable than fetch + pull when a topic branch
> > is ready to be submitted.
> 
> I'd like there to be some *big*warning* about how this destroys history 
> and how you must not do this if you expose your history anywhere else.
> 
> I think it's a perfectly fine history, but if you have already pushed out 
> your history somewhere else, you're now really screwed. In ways that a 
> *real* merge will never screw you.
> 
> So the "--rebase" option really is only good for the lowest-level 
> developers. And that should be documented.

Fair enough.

How about this in the man page:

\--rebase::
	Instead of a merge, perform a rebase after fetching.
	*NOTE:* Never do this on branches you plan to publish!  This
	command will _destroy_ history, and is thus only suitable for
	topic branches to be submitted to another committer.

Ciao,
Dscho
