From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: HTTP trees trailing GIT trees
Date: Fri, 25 May 2007 13:36:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705251332360.4648@racer.site>
References: <loom.20070523T154909-285@post.gmane.org> <20070523140552.GN4489@pasky.or.cz>
 <loom.20070523T161537-175@post.gmane.org> <loom.20070524T142358-608@post.gmane.org>
 <Pine.LNX.4.64.0705241456080.4648@racer.site> <f36g7l$2oe$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 14:36:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrZ1v-0000Dl-I4
	for gcvg-git@gmane.org; Fri, 25 May 2007 14:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbXEYMgX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 08:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbXEYMgX
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 08:36:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:40988 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761102AbXEYMgV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 08:36:21 -0400
Received: (qmail invoked by alias); 25 May 2007 12:36:19 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 25 May 2007 14:36:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/z5Q97PkPzQXiaCsQoD+sHJrpyei46+ZX+p710s1
	P1JuTS5i+L1dW3
X-X-Sender: gene099@racer.site
In-Reply-To: <f36g7l$2oe$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48367>

Hi,

On Fri, 25 May 2007, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > Hi,
> > 
> > On Thu, 24 May 2007, Panagiotis Issaris wrote:
> > 
> >> So, we're asking for /ffmpeg/info/refs, and the server is returning 
> >> c30fa8391812..., but, using GitWeb one can see that c30fa839812... is 
> >> not the last commit, this one is: 
> >> http://git.mplayerhq.hu/?p=ffmpeg;a=commit; 
> >> h=47d7dcb5a7d89f413064e7ef1b54d77e59fb8375
> > 
> > So, info/refs is still old. This file should have been updated by 
> > git-update-server-info. I am not sure how this repo is updated, but I 
> > suspect that the wrong hook contains the call to update-server-info, or 
> > that the correct hook is not activated, or it does not have write 
> > permission.
> 
> If you push to repository (it is the usual setup for public
> repositories), it would be enough to simply enable default 
> 'post-update' hook (make it executable).
> 
> If you however for example commit to this public repository directly,
> you would need to put call to git-update-server-info in the 'post-commit'
> hook.

I have the slight suspicion that this repo is only updated via git-svn. 
And I am still new enough to git-svn to not know which hook it executes, 
if any.

Ciao,
Dscho
