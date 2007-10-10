From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [FEATURE REQUEST] git clone, just clone selected branches?
Date: Thu, 11 Oct 2007 00:01:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710110000420.4174@racer.site>
References: <011d01c80b8e$b0c0dc30$04ac10ac@Jocke>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Thu Oct 11 01:02:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfkZ9-0001VM-10
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 01:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756687AbXJJXCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 19:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756692AbXJJXCB
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 19:02:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:38778 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756271AbXJJXCA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 19:02:00 -0400
Received: (qmail invoked by alias); 10 Oct 2007 23:01:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 11 Oct 2007 01:01:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/H2n9/fZ/HlnF1eUa1aeQW4oX0Ep4Mh8oDTB2VkP
	ap9Pk9K5upsCAy
X-X-Sender: gene099@racer.site
In-Reply-To: <011d01c80b8e$b0c0dc30$04ac10ac@Jocke>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60564>

Hi,

On Thu, 11 Oct 2007, Joakim Tjernlund wrote:

> > -----Original Message-----
> > From: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de] 
> > 
> > thought it might be pretty easy for you to rewrite git-clone.sh to 
> > take advantage of git-fetch and git-remote, and that your desired 
> > feature would be easier to add then.  So easy that the whole thing 
> > would have taken you all of an hour or so.
> 
> Well, now I had to take a look and I think you are overestimating my 
> capabilities :) It is a 12KB script full of git-plumbing I have never 
> used, nor do I do sh scripts well. It might be an hour for you, but I 
> would probably have to spend the whole day :)

Heh.  git-clone is pretty crowded.  But it predates git-remote.  And I 
have a hunch that git-clone will be a trivial script when it calls 
git-remote and the git-fetch.

Ciao,
Dscho
