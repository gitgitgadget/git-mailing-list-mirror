From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: HTTP trees trailing GIT trees
Date: Thu, 24 May 2007 14:57:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705241456080.4648@racer.site>
References: <loom.20070523T154909-285@post.gmane.org> <20070523140552.GN4489@pasky.or.cz>
 <loom.20070523T161537-175@post.gmane.org> <loom.20070524T142358-608@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Panagiotis Issaris <takis.issaris@uhasselt.be>
X-From: git-owner@vger.kernel.org Thu May 24 15:57:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrDp4-0006Bv-KG
	for gcvg-git@gmane.org; Thu, 24 May 2007 15:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbXEXN5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 09:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbXEXN5e
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 09:57:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:59785 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750705AbXEXN5d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 09:57:33 -0400
Received: (qmail invoked by alias); 24 May 2007 13:57:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 24 May 2007 15:57:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Zyg9VZviZ1o2eSt2j2VrzT2oZVhc1038LGpTdq8
	b81HaUQkJWN7H7
X-X-Sender: gene099@racer.site
In-Reply-To: <loom.20070524T142358-608@post.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48266>

Hi,

On Thu, 24 May 2007, Panagiotis Issaris wrote:

> So, we're asking for /ffmpeg/info/refs, and the server is returning 
> c30fa8391812..., but, using GitWeb one can see that c30fa839812... is 
> not the last commit, this one is: 
> http://git.mplayerhq.hu/?p=ffmpeg;a=commit; 
> h=47d7dcb5a7d89f413064e7ef1b54d77e59fb8375

So, info/refs is still old. This file should have been updated by 
git-update-server-info. I am not sure how this repo is updated, but I 
suspect that the wrong hook contains the call to update-server-info, or 
that the correct hook is not activated, or it does not have write 
permission.

Ciao,
Dscho
