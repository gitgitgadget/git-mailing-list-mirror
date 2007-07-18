From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Move bundle specific stuff into bundle.[ch]
Date: Wed, 18 Jul 2007 10:56:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707181053130.14781@racer.site>
References: <Pine.LNX.4.64.0707172346450.14781@racer.site>
 <Pine.LNX.4.64.0707172216420.14596@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 11:57:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB6HH-0004zR-BR
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 11:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762054AbXGRJ4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 05:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759567AbXGRJ4b
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 05:56:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:55321 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757512AbXGRJ43 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 05:56:29 -0400
Received: (qmail invoked by alias); 18 Jul 2007 09:56:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 18 Jul 2007 11:56:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+M/qIGGweMwqrVpV4cCvgxG7JEduCtKyHtj4Xc4C
	OGMdJmAIwu0bPc
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707172216420.14596@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52845>

Hi,

On Tue, 17 Jul 2007, Daniel Barkalow wrote:

> On Tue, 17 Jul 2007, Johannes Schindelin wrote:
> 
> > The transport specific stuff was moved into libgit.a, and the bundle 
> > specific stuff will not be left behind.
> > 
> > This is a big code move, with one exception: the function unbundle() 
> > no longer outputs the list of refs.  You have to call 
> > list_bundle_refs() yourself for that.
> 
> You should use -C on this sort of thing, so that the interesting aspects 
> of the patch are easier to see. (It actually comes out longer in this 
> case, but it's far easier to tell that the code in the new file is the 
> same as the old code.)

Okay, I wanted it to be kept short, since I really get lost easily in 
hundreds of "-" lines, with possibly one in the midst being a "+".

> Can you tell I've been rearranging a lot of code lately and trying to 
> make the patches not look really scary?

Sorry, I did not pay that close attention.

> Aside from presentation, it looks good to me. Shall I stick the bundle 
> changes into my series? I'd like to have them come before the patch to 
> switch to builtin-fetch, so that there aren't any revisions where "git 
> fetch" doesn't have bundle support.

Looks fine to me.  Seems like you should add a SOB line, too.

> And I think it would be best to take part 3 as a review fix to my final 
> patch.

Yes, definitely.  This shows again (to me, at least), that just looking at 
the code is not enough, you have to run it, too, to review patches.

Ciao,
Dscho
