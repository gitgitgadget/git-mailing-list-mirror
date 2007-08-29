From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cloning/pulling hooks
Date: Wed, 29 Aug 2007 15:31:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708291529010.28586@racer.site>
References: <1188319608.6106.63.camel@beauty> <20070828172709.GB1219@pasky.or.cz>
 <200708291005.08795.andyparkins@gmail.com> <20070829095202.GE1219@pasky.or.cz>
 <b3889dff0708290618s79cffdb5nb6cc69d14efa8b9@mail.gmail.com>
 <Pine.LNX.4.64.0708291446011.28586@racer.site> <20070829135441.GI10749@pasky.or.cz>
 <Pine.LNX.4.64.0708291502340.28586@racer.site> <20070829141948.GJ10749@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Benjamin Collins <aggieben@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 29 16:31:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQOa4-0002T3-QV
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 16:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893AbXH2Obe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 10:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755871AbXH2Obe
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 10:31:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:47640 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755132AbXH2Obd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 10:31:33 -0400
Received: (qmail invoked by alias); 29 Aug 2007 14:31:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 29 Aug 2007 16:31:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WLJN7PioWIDRi6TeGDAqYpXfEzOR58GacoXFJ0n
	5tH10KB840rGd4
X-X-Sender: gene099@racer.site
In-Reply-To: <20070829141948.GJ10749@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56957>

Hi,

On Wed, 29 Aug 2007, Petr Baudis wrote:

> On Wed, Aug 29, 2007 at 04:06:17PM CEST, Johannes Schindelin wrote:
> > I think that they are way more than just technical issues: the 
> > chicken-and-egg problem is certainly _not_ a technical issue.
> 
> What do you mean by the chicken-and-egg problem? I think I missed that.

What if hooks/update is in your set?  It _does not_ run before it is 
checked out, but of course, some ref is updated before it is checked out.

> > _All_ of the arguments I read are along the lines "we want to enforce 
> > some coding styles" or similar.  These issues are _orthogonal_ to the 
> > question which SCM is used.
> 
> Your company has certain rules on how all the source on the public 
> branches should look like, etc. It's not quite clear to me how can build 
> system enforce these rules.

The same as a hook.  You just put the check into the Makefile.

Ciao,
Dscho
