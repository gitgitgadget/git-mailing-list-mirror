From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: error: char103: premature end of data
Date: Fri, 8 Jun 2007 00:55:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706080054330.4046@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706080105.28102.johan@herland.net> <Pine.LNX.4.64.0706080023450.4046@racer.site>
 <200706080147.50207.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Jun 08 01:58:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwRrv-0003UC-9y
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 01:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937147AbXFGX6B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 19:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937133AbXFGX6A
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 19:58:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:53894 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S936378AbXFGX57 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 19:57:59 -0400
Received: (qmail invoked by alias); 07 Jun 2007 23:57:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 08 Jun 2007 01:57:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+eeRQZnYWeMRMdXR9Cu3o85Vueq1d2SQXTod2fNh
	En5ojmz4KhN3EG
X-X-Sender: gene099@racer.site
In-Reply-To: <200706080147.50207.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49415>

Hi,

On Fri, 8 Jun 2007, Johan Herland wrote:

> If I'm pulling from a corrupt repo, I'd sure as hell want git to tell me 
> when I first fetched, and not a couple of weeks later when I'd try to 
> use the corrupt data, or call fsck, or whatever.

We don't check that the object names match the object contents on pull. 
With your argument, we should do that, too. And of course, get rid of 
git-fsck, because it is of no more use, then.

Ciao,
Dscho
