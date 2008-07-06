From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow cherry-picking root commits
Date: Sun, 6 Jul 2008 03:37:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807060331250.3557@eeepc-johanness>
References: <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807031142540.9925@racer> <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net>
 <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <20080703210950.GC6677@leksak.fem-net> <alpine.DEB.1.00.0807040138090.2849@eeepc-johanness> <20080704003857.GG6677@leksak.fem-net> <alpine.DEB.1.00.0807040252490.2849@eeepc-johanness> <20080704015326.GI6677@leksak.fem-net>
 <alpine.DEB.1.00.0807041617320.9925@racer> <7vzlovq0t6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 03:38:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFJCc-0003AV-FW
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 03:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbYGFBhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 21:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbYGFBhF
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 21:37:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:51949 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753195AbYGFBhE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 21:37:04 -0400
Received: (qmail invoked by alias); 06 Jul 2008 01:37:01 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp001) with SMTP; 06 Jul 2008 03:37:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19b/EZzgM5bMLeJkn13NpB3X4kZ2SxMPINGWwFAb9
	MGp5oJnlBib1c5
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vzlovq0t6.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87482>

Hi,

On Sat, 5 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > There is no good reason why cherry-picking root commits should not be 
> > allowed.
> 
> Hmm, does "cherry-pick a root commit" even have a well defined 
> semantics, other than "if there is no overlap in files just add the 
> files in"?

Yes.  You can easily add the files identically, or some similar files, in 
which case you get an easily-resolved conflict.

> I have a feeling that it is more likely to be a user error, a sign that 
> the user mistyped the name of the commit to pick.

Now, now, that is too harsh a statement!

Often I start my work from a tarball, just because the git import takes so 
long that I can fiddle with the thing already while the import runs.

And guess what, it would be easier to rebase that series onto an imported 
tag for me.  The first commit would not result in changes, since it would 
import the identical tree.  Or it would barf, in which case I would know 
that I got the wrong branch point to rebase onto.

At the moment, I play games that need a deep knowledge of Git, which _I_ 
have, but not necessarily occasional Git users.

Ciao,
Dscho
