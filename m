From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Second parent for reverts
Date: Wed, 9 May 2007 22:07:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705092206540.4167@racer.site>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 09 22:08:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlsSE-0002kV-Fe
	for gcvg-git@gmane.org; Wed, 09 May 2007 22:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbXEIUIB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 16:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754958AbXEIUIB
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 16:08:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:36082 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754339AbXEIUIA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 16:08:00 -0400
Received: (qmail invoked by alias); 09 May 2007 20:07:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 09 May 2007 22:07:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fR1VDFfdfe7FtgylEP7PAMpk2SWXKN5fW8I/62U
	rCoFnXo67uZEqT
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46776>

Hi,

On Wed, 9 May 2007, Daniel Barkalow wrote:

> The discussion about having a header to specify, for a revert commit, 
> what it reverts made me realize that this header *would* be useful, but 
> that we don't need a *new* header for it. I think that the right method 
> is to add the parent of the reverted commit as a second parent for the 
> revert.

I am not so sure. In a sense, you are correct. But everybody who does "git 
log --no-merges" would no longer see reverts. Which is somewhat incorrect.

Ciao,
Dscho
