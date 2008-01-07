From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 7 Jan 2008 21:18:00 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801072115120.10101@racer.site>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-369704998-1199740683=:10101"
Cc: Jeff King <peff@peff.net>, Steffen Prohaska <prohaska@zib.de>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	msysgit@googlegroups.com
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 22:18:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBzMo-0004W2-Al
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 22:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbYAGVSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 16:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbYAGVSO
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 16:18:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:54868 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752398AbYAGVSN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 16:18:13 -0500
Received: (qmail invoked by alias); 07 Jan 2008 21:18:11 -0000
Received: from host86-149-202-249.range86-149.btcentralplus.com (EHLO [192.168.1.3]) [86.149.202.249]
  by mail.gmx.net (mp043) with SMTP; 07 Jan 2008 22:18:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+RTU0FTuyRYdOoQQeCWkeJzWTeeeO7g7cPjg+2VJ
	Sq1Gl3hvqt9ybI
X-X-Sender: gene099@racer.site
In-Reply-To: <200801072203.23938.robin.rosenberg.lists@dewire.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69811>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-369704998-1199740683=:10101
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

[msysGit Cc'ed, since it is massively concerned by this thread]

On Mon, 7 Jan 2008, Robin Rosenberg wrote:

> måndagen den 7 januari 2008 skrev du:
> > Problem.  There is not a single "right".  It really depends on the 
> > project.
> 
> Indeed, but the most common SCM's detect binary files automatically, 
> either by suffix or content analysis, so I think that is what user's 
> expect. It will be right for more projects that the current behaviour.

Steffen also fought for turning this on by default, but so far I resisted.  
For a good reason: the primary user of msysGit for the moment is... 
msysGit.  And this project does not need CR for obvious reasons.

But I imagine that it makes sense for the Git installers.  Colour me 
no-longer-resisting.

Ciao,
Dscho

---1463811741-369704998-1199740683=:10101--
