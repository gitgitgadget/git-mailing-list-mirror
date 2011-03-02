From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: In-depth git blame?
Date: Wed, 2 Mar 2011 22:29:51 +0100
Message-ID: <20110302212951.GB24660@m62s10.vlinux.de>
References: <AANLkTi=694NiUMzcHkNZ09sotcoN+=wPMnxnom5_ex+f@mail.gmail.com>
 <20110302211545.GD20400@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jez <jezreel@gmail.com>, Thomas Rast <trast@student.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 22:30:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Putce-0006IK-J7
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 22:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757695Ab1CBV36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 16:29:58 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:42994 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757670Ab1CBV35 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 16:29:57 -0500
Received: (qmail invoked by alias); 02 Mar 2011 21:29:55 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp072) with SMTP; 02 Mar 2011 22:29:55 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+VGa9gDl+VeX+5waP0bR0vyttqImjaqYV9E3HSDF
	5oHTUwb9HGBBbB
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id A01D2D401F; Wed,  2 Mar 2011 22:29:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110302211545.GD20400@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168348>

On Wed, Mar 02, 2011 at 04:15:45PM -0500, Jeff King wrote:
> On Wed, Mar 02, 2011 at 03:43:42PM -0500, Jez wrote:
> 
> > Git-blame is useful, but sometimes I want to know the series of
> > commits that have affected a line -- not just the most recent one. Is
> > there a way to do this?
> 
> If you use "git gui blame" or "tig blame", both have a "blame from
> parent commit" feature. This restarts the blame using the content as it
> was just before the answer you just got, so you can recursively dig.
> It's unfortunately a somewhat manual process.
> 
 
Hm. I guess pressing 'B' will blame the parent commit in tig. 
But I can't figure out how to navigate back to the old commit (before pressing 'B')?
Any hints appreciated!

-Peter
