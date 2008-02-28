From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 22/40] Windows: Implement asynchronous functions as
 threads.
Date: Thu, 28 Feb 2008 15:28:34 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802281525510.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-23-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 28 16:29:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUkhc-0000Xn-9v
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 16:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757612AbYB1P3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 10:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757590AbYB1P3H
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 10:29:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:57437 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757261AbYB1P3G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 10:29:06 -0500
Received: (qmail invoked by alias); 28 Feb 2008 15:29:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp014) with SMTP; 28 Feb 2008 16:29:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/691d4H4T6j/EHjcA9npYJ+bgozdoumxE2ZA7z7m
	5r3JaLRWgGXHCP
X-X-Sender: gene099@racer.site
In-Reply-To: <1204138503-6126-23-git-send-email-johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75409>

Hi,

On Wed, 27 Feb 2008, Johannes Sixt wrote:

> In upload-pack we must explicitly close the output channel of rev-list. 
> (On Unix, the channel is closed automatically because process that runs 
> rev-list terminates.)

When I read this patch, my impression was that it litters the source code 
with #ifdef's.  IMO this makes the code less readable, and as a 
consequence easer to fsck up.

Unfortunately, I have no idea how to help that, other than implementing 
compat/thread.[ch], abstracting the thread functions, and introducing a 
NO_FORK Makefile variable and preprocessor constant.

Hmpf.

Ciao,
Dscho

