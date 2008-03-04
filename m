From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit f5bbc322 to git broke pre-commit hooks which read stdin
Date: Tue, 4 Mar 2008 12:03:16 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803041202150.22527@racer.site>
References: <0tableanpe.wl%bremner@pivot.cs.unb.ca> <alpine.LSU.1.00.0803041044120.22527@racer.site> <m3k5kiiu60.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Bremner <bremner@unb.ca>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org, 469250@bugs.debian.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 13:04:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWVsw-0003hg-Fq
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 13:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbYCDMEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 07:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756875AbYCDMEF
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 07:04:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:59284 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756716AbYCDMEE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 07:04:04 -0500
Received: (qmail invoked by alias); 04 Mar 2008 12:04:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 04 Mar 2008 13:04:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lZqkCBKOlSvO0O5xCInzjoTOh80uqPTeiyBKslw
	icckjK0RQblr5S
X-X-Sender: gene099@racer.site
In-Reply-To: <m3k5kiiu60.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76074>

Hi,

On Tue, 4 Mar 2008, Jakub Narebski wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > On Tue, 4 Mar 2008, David Bremner wrote:
> > 
> >> It looks like line 435 of builtin-commit.c disables stdin for hooks 
> >> (with the disclaimer that I first looked at the git source ten minutes 
> >> ago).
> >> 
> >> 	   hook.no_stdin = 1
> 
> Never mind pre-commit. What about pre-receive and post-receive hooks, 
> both of which gets data on stdin?

He was talking about builtin-commit.c.  AFAIR there is no code to call 
pre-receive or post-receive in that file. ;-)

IOW the issue does not apply to the hooks you mentioned.

Ciao,
Dscho

