From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Non-http dumb protocols
Date: Sun, 1 Jul 2007 15:32:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707011527590.4438@racer.site>
References: <Pine.LNX.4.64.0706301613410.14638@iabervon.org>
 <7vbqewakz8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 16:32:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I50Ta-0004KC-0y
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 16:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615AbXGAOcZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 10:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbXGAOcZ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 10:32:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:58483 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754342AbXGAOcY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 10:32:24 -0400
Received: (qmail invoked by alias); 01 Jul 2007 14:32:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 01 Jul 2007 16:32:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/jOMlMgrzj/GKznLZMiRGhQGuU29jJTcNNJnwxSn
	H5p+TIkNYu6x42
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbqewakz8.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51298>

Hi,

On Sat, 30 Jun 2007, Junio C Hamano wrote:

> Having said that, I have a feeling that many people do not build
> any of the commit walkers, and especially the http walker,
> because they have no need for dumb protocols, and libcurl-dev is
> just another piece of dependency they do not have to have.

Interestingly, I just was involved in a discussion on IRC, where somebody 
(out of quotat concerns) wants to use sftp to push to a bare repository, 
which is served via HTTP.

Unfortunately, it seems that all persons wanting to have some support for 
that, expect others to do the work for them.

However, there is a miniscule non-zero chance that eventually somebody 
might want to realise an sftp push protocol (where you basically need the 
ls-remote part of the fetcher, too, to determine what to pack and send). 
And to complete a dumb sftp fetch protocol, you'd need a commit walker,
so I'd like to have at least a minimal interface for commit walkers 
waiting for that saviour.

Ciao,
Dscho
