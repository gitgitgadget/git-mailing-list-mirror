From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 22/40] Windows: Implement asynchronous functions as
 threads.
Date: Fri, 29 Feb 2008 01:27:25 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802290122110.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-23-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281525510.22527@racer.site> <47C6F40A.4010703@comcast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Paul Franz <thefranz@comcast.net>
X-From: git-owner@vger.kernel.org Fri Feb 29 02:28:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUu3L-00059g-84
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 02:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbYB2B2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 20:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbYB2B2I
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 20:28:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:54145 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751254AbYB2B2F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 20:28:05 -0500
Received: (qmail invoked by alias); 29 Feb 2008 01:28:03 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp038) with SMTP; 29 Feb 2008 02:28:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/NQ50hHnrNAyI5cJkWC8HYgzBbbgAEL3m8AH80sN
	vanNLX5N0vLBTT
X-X-Sender: gene099@racer.site
In-Reply-To: <47C6F40A.4010703@comcast.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75485>

Hi,

On Thu, 28 Feb 2008, Paul Franz wrote:

> Do you think it would be possible to change git to use Apache's apr 
> library?

Possible?  Yes.

Sensible?  That's another issue.  For one, we already rely on a pretty 
good POSIX shell support.  That is not something helped by APR.

So if we already need a POSIX shell, we might just as well rely on a 
(kind of) POSIX environment.

Besides, I cannot say that I found compiling APR in msysGit _easy_.

So if there are as many disadvantages as I suspect, and as few advantages, 
as I suspect, too, I think it would be a waste of time to bother to port 
Git to APR.

Besides, I think there are -- again, as always when things seem to be only 
fun -- legal issues.  I do not know the details, but there are people who 
say that APL is incompatible with GPL (v2).

Not that I care too much about those bastards who devised licenses just to 
make my life miserable.  But them lawyer types have ways to _make_ my 
life miserable.  So I avoid those kind of problems.  I guess you could 
call this "collateral legal damage".

Ciao,
Dscho

