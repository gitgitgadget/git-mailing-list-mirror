From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 4 Dec 2007 14:40:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712041439590.27959@racer.site>
References: <20071204130922.731c407a@pc09.procura.nl>
 <Pine.LNX.4.64.0712041343040.27959@racer.site> <20071204140326.14d9e7a0@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Dec 04 15:42:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzYyP-0007bD-44
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 15:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbXLDOlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 09:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753069AbXLDOlN
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 09:41:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:48275 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753429AbXLDOlM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 09:41:12 -0500
Received: (qmail invoked by alias); 04 Dec 2007 14:41:10 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 04 Dec 2007 15:41:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8o04WHWf8G185DweJus1vAaVOWX6lrwOwVOQKFd
	mhOs8xE+OFyRFL
X-X-Sender: gene099@racer.site
In-Reply-To: <20071204140326.14d9e7a0@pc09.procura.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67050>

Hi,

On Tue, 4 Dec 2007, H.Merijn Brand wrote:

> On Tue, 4 Dec 2007 13:44:02 +0000 (GMT), Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> > Hi,
> > 
> > On Tue, 4 Dec 2007, H.Merijn Brand wrote:
> > 
> > > make test then fails:
> > 
> > Could you run the failing test manually with -i -v, like so:
> > 
> > 	$ cd t/
> > 	$ sh t0001*.sh -i -v
> 
> /pro/3gl/LINUX/git-1.5.3.7 183 > cd t
> /pro/3gl/LINUX/git-1.5.3.7/t 184 > sh t0001*.sh -i -v
> * error: cannot run git init -- have you built things yet?
> Exit 1
> /pro/3gl/LINUX/git-1.5.3.7/t 185 >

Next step: add the sh option -x:

	$ sh -x t0001*.sh -i -v

to find out what made it fail.

Thanks,
Dscho
