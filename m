From: Ray Lehtiniemi <rayl@mail.com>
Subject: Re: Can you do this with GIT?
Date: Fri, 27 Jul 2007 14:08:06 -0600
Message-ID: <200707271408.07108.rayl@mail.com>
References: <11834063.post@talk.nabble.com> <200707271345.03300.rayl@mail.com> <Pine.LNX.4.64.0707272048280.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: CPD <cdavidson@altsoftware.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 27 22:08:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEW7N-000507-Ku
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 22:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933820AbXG0UIw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 16:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934142AbXG0UIw
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 16:08:52 -0400
Received: from static-68-179-52-57.ptr.terago.ca ([68.179.52.57]:41218 "EHLO
	mail.headplay.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933644AbXG0UIv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 16:08:51 -0400
Received: from linux.local ([192.168.1.201])
	by mail.headplay.com with ESMTP; Fri, 27 Jul 2007 14:08:38 -0600
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0707272048280.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53962>

On Friday 27 July 2007 13:49, Johannes Schindelin wrote:
> Hi,
>
> On Fri, 27 Jul 2007, Ray Lehtiniemi wrote:
> > On Friday 27 July 2007 13:05, Johannes Schindelin wrote:
> > > On Fri, 27 Jul 2007, CPD wrote:
> > > > We produce variations based on a (mostly) common codebase. In CVS I
> > > > set up "environment" modules for each platform, then when you are
> > > > working on that platform, you simply check out the correct
> > > > environment and build. Only the needed code and tools are exposed in
> > > > that environment (this is important as clients must NOT see each
> > > > other's code and most customers have some customization). I do this
> > > > by defining and renaming modules in the CVSROOT modules file.
> > >
> > > I would use branches for that.  A base branch with the common code, and
> > > the customisations in all the branches, which merge from the base
> > > branch.
> >
> > this would break down if there were client-specific modules in the base
> > branch, though... how could those be hidden from the other clients?
>
> Umm.  Don't put the client-specific modules in the base branch, then?  The
> base branch is the common code, the code that every client may look at.
> Nothing else.

yes, i don;t think there's any other way to do it with branches (and just be 
careful not to merge the private branches back! :-)


> Maybe I did not get the whole picture...  do you want your _clients_ to
> access your main repo with Git?

not in my case, anyway... although if you define "client" to 
include "subcontractor", then yes, i'd be interested in going down that 
road... sometimes there are pieces which they aren't licensed to see, but if 
we could somehow track their work in a separate repo and then easily merge it 
back into the fully licensed tree, that would have great value.

from the original message, i also keyed on "Only the needed code and tools are 
exposed in that environment".  this is something i'd like to see too... i'm 
working in a software eco-system with hundreds of standalone components, and 
would like the ability to pick and choose a small handful of those for any 
given project, without pulling in reams of history on the stuff i'm not 
using...

thanks
ray


>
> Ciao,
> Dscho
