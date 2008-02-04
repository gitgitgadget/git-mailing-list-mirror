From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Clean up connection correctly if object fetch wasn't
 done
Date: Mon, 4 Feb 2008 21:21:39 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802042118320.8543@racer.site>
References: <alpine.LNX.1.00.0802041326260.13593@iabervon.org> <alpine.LSU.1.00.0802042023160.8543@racer.site> <alpine.LNX.1.00.0802041602020.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 22:22:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM8mD-000852-82
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 22:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbYBDVWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 16:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbYBDVWS
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 16:22:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:45619 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754032AbYBDVWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 16:22:17 -0500
Received: (qmail invoked by alias); 04 Feb 2008 21:22:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp014) with SMTP; 04 Feb 2008 22:22:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19b2ahF0jpbUff1lNmaKDwqzOouzPwIlfNApA6178
	MmoG+/k4V/DdrQ
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802041602020.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72572>

Hi,

On Mon, 4 Feb 2008, Daniel Barkalow wrote:

> On Mon, 4 Feb 2008, Johannes Schindelin wrote:
> 
> > On Mon, 4 Feb 2008, Daniel Barkalow wrote:
> > 
> > > Further optimization allowed the fetch_objs call to be skipped if it 
> > > isn't necessary. However, this leaves the connection in need of 
> > > cleaning up to avoid getting an error message from the remote end 
> > > when ssh is used. Fix this.
> > 
> > I _think_ something similar is necessary for ls-remote, too (at least 
> > it showed the same symptoms today, but I have not had time to 
> > investigate yet).
> 
> Yup, exactly the same change to builtin-ls-remote that builtin-fetch 
> needed.

Thanks, works here.

Ciao,
Dscho
