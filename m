From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 08/11] Allow for having for_each_ref() list some refs
 that aren't local
Date: Sat, 8 Mar 2008 18:25:23 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081823230.19665@iabervon.org>
References: <alpine.LNX.1.00.0803081804170.19665@iabervon.org> <alpine.LSU.1.00.0803090020430.3975@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:26:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY8QX-0005yz-24
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbYCHXZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbYCHXZZ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:25:25 -0500
Received: from iabervon.org ([66.92.72.58]:34167 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812AbYCHXZY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:25:24 -0500
Received: (qmail 19749 invoked by uid 1000); 8 Mar 2008 23:25:23 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 23:25:23 -0000
In-Reply-To: <alpine.LSU.1.00.0803090020430.3975@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76620>

On Sun, 9 Mar 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Sat, 8 Mar 2008, Daniel Barkalow wrote:
> 
> > This is useful, for example, for listing the refs in a reference 
> > repository during clone, when you don't have your own refs that cover 
> > the objects that are in your alternate repository.
> 
> How about this commit oneline instead:
> 
> 	for_each_ref(): Allow adding extra refs to be traversed
> 
> Hmm?
> 
> You can explain in the body that the SHA-1s are not verified locally, so 
> that you can add extra refs that do not reference local objects.

The non-local aspect is actually that the repository's refs doesn't 
actually include them. We actually do have these objects, in an alternate 
repo. Clearly I need a better commit message, with this info not trying to 
fit in the first line.

	-Daniel
*This .sig left intentionally blank*
