From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] git-bundle: prevent overwriting existing bundles
Date: Fri, 9 Mar 2007 04:05:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703090403090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0703090348480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070309025902.GE32211@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net,
	Mark Levedahl <mlevedahl@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 09 04:05:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPVQ8-0000y1-Pa
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 04:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992902AbXCIDFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 22:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030859AbXCIDFE
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 22:05:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:43550 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030844AbXCIDFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 22:05:03 -0500
Received: (qmail invoked by alias); 09 Mar 2007 03:05:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 09 Mar 2007 04:05:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZrNcnILYZdLHkgaS5E9RHsh/0+l1/KdXTnEuMwi
	7tshF7gkNEXP+z
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070309025902.GE32211@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41784>

Hi,

On Thu, 8 Mar 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >  	if (bundle_fd < 0)
> > -		return error("Could not write to '%s'", path);
> > +		return error("Could not create '%s'", path);
> 
> I hate to be a nit, but what about?
> 
> > +		return error("Could not create '%s': %s", path, strerror(errno));

ACK
