From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: In-depth git blame?
Date: Wed, 2 Mar 2011 22:44:45 +0100
Message-ID: <20110302214445.GC24660@m62s10.vlinux.de>
References: <AANLkTi=694NiUMzcHkNZ09sotcoN+=wPMnxnom5_ex+f@mail.gmail.com>
 <20110302211545.GD20400@sigill.intra.peff.net>
 <20110302212951.GB24660@m62s10.vlinux.de>
 <20110302213437.GG20400@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jez <jezreel@gmail.com>, Thomas Rast <trast@student.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 22:44:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Putqp-0005i0-P5
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 22:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757497Ab1CBVou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 16:44:50 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:37269 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755527Ab1CBVou (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 16:44:50 -0500
Received: (qmail invoked by alias); 02 Mar 2011 21:44:48 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp022) with SMTP; 02 Mar 2011 22:44:48 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18w6JNsb6IwsEkE2qZPgbLS/0j3zRXjHVSucphEWH
	kUp4U30+7EEyvN
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 06EE1D401F; Wed,  2 Mar 2011 22:44:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110302213437.GG20400@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168352>

[ Cc Jonas, because he might know more about that ]

On Wed, Mar 02, 2011 at 04:34:37PM -0500, Jeff King wrote:
> On Wed, Mar 02, 2011 at 10:29:51PM +0100, Peter Baumann wrote:
> 
> > > If you use "git gui blame" or "tig blame", both have a "blame from
> > > parent commit" feature. This restarts the blame using the content as
> > > it was just before the answer you just got, so you can recursively
> > > dig.  It's unfortunately a somewhat manual process.
> > > 
> >  
> > Hm. I guess pressing 'B' will blame the parent commit in tig.  But I
> > can't figure out how to navigate back to the old commit (before
> > pressing 'B')?  Any hints appreciated!
> 
> No, it is "," (comma) from the blame viewer in tig to blame starting
> from the parent of the blamed commit of the highlighted line.
> 
Thx, I didn't know that. Your help is really appreciated!

> Doing "B" will just re-blame starting at that commit, which will of
> course give you the same answer (I think it is a global "go to blame
> view", so it is more useful when you are _not_ in the blame viewer
> already).
> 
> And if you are confused at any point, "h" should give you a
> context-sensitive list of keystrokes.
> 
Hm. I did look at the 'h'elp, but it wasn't mentioned there, at least
not in my version (tig version 0.16-9-g7630a8f) here.

> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
