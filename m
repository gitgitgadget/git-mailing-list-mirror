From: Jeff King <peff@peff.net>
Subject: Re: In-depth git blame?
Date: Wed, 2 Mar 2011 16:34:37 -0500
Message-ID: <20110302213437.GG20400@sigill.intra.peff.net>
References: <AANLkTi=694NiUMzcHkNZ09sotcoN+=wPMnxnom5_ex+f@mail.gmail.com>
 <20110302211545.GD20400@sigill.intra.peff.net>
 <20110302212951.GB24660@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jez <jezreel@gmail.com>, Thomas Rast <trast@student.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 02 22:34:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Puth6-0000Wm-0Z
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 22:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756919Ab1CBVek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 16:34:40 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35205 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756074Ab1CBVej (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 16:34:39 -0500
Received: (qmail 20705 invoked by uid 111); 2 Mar 2011 21:34:39 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 02 Mar 2011 21:34:39 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2011 16:34:37 -0500
Content-Disposition: inline
In-Reply-To: <20110302212951.GB24660@m62s10.vlinux.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168349>

On Wed, Mar 02, 2011 at 10:29:51PM +0100, Peter Baumann wrote:

> > If you use "git gui blame" or "tig blame", both have a "blame from
> > parent commit" feature. This restarts the blame using the content as
> > it was just before the answer you just got, so you can recursively
> > dig.  It's unfortunately a somewhat manual process.
> > 
>  
> Hm. I guess pressing 'B' will blame the parent commit in tig.  But I
> can't figure out how to navigate back to the old commit (before
> pressing 'B')?  Any hints appreciated!

No, it is "," (comma) from the blame viewer in tig to blame starting
from the parent of the blamed commit of the highlighted line.

Doing "B" will just re-blame starting at that commit, which will of
course give you the same answer (I think it is a global "go to blame
view", so it is more useful when you are _not_ in the blame viewer
already).

And if you are confused at any point, "h" should give you a
context-sensitive list of keystrokes.

-Peff
