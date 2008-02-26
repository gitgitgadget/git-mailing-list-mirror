From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix premature call to git_config() causing t1020-subdirectory
 to fail
Date: Tue, 26 Feb 2008 15:47:42 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802261547060.22527@racer.site>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net> <200802261640.48770.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 16:50:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU23X-0003CI-0a
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 16:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762000AbYBZPsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 10:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758790AbYBZPsM
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 10:48:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:53599 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757418AbYBZPsK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 10:48:10 -0500
Received: (qmail invoked by alias); 26 Feb 2008 15:48:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp013) with SMTP; 26 Feb 2008 16:48:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19M8a1O941MOcYehABrvuMiWFd1ZPArQcXaqk3nY2
	nN30YDgyWmCLqg
X-X-Sender: gene099@racer.site
In-Reply-To: <200802261640.48770.johan@herland.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75148>

Hi,

On Tue, 26 Feb 2008, Johan Herland wrote:

> On Tuesday 26 February 2008, Johan Herland wrote:
> > - Call git_config(git_default_config) in order to properly set up
> >   user.name and user.email for reflogs (This BREAKS test #9 in
> >   t1020-subdirectory.sh. Have yet to figure out why)
> 
> Here is a fix for this breakage, although I think it's ugly as hell.

I think it is not ugly, but correct.

Ciao,
Dscho
