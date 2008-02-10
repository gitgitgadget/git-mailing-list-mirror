From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix "git clone" for git:// protocol
Date: Sun, 10 Feb 2008 12:12:15 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802101210340.11591@racer.site>
References: <alpine.LSU.1.00.0802091657000.11591@racer.site> <alpine.LNX.1.00.0802091205530.13593@iabervon.org> <alpine.LSU.1.00.0802100302050.11591@racer.site> <alpine.LNX.1.00.0802092208280.13593@iabervon.org> <7vhcgh4fb9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 13:12:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOB3B-0005rC-Iu
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 13:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbYBJMMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 07:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbYBJMMO
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 07:12:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:36131 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751660AbYBJMMO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 07:12:14 -0500
Received: (qmail invoked by alias); 10 Feb 2008 12:12:12 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp010) with SMTP; 10 Feb 2008 13:12:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ImWRnqz1IGR9iwtd8TL5067qQj6sveYJPrkLeR6
	8Ej7GsnKI7qhd9
X-X-Sender: gene099@racer.site
In-Reply-To: <7vhcgh4fb9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73341>

Hi,

On Sat, 9 Feb 2008, Junio C Hamano wrote:

> Thanks.  The patch makes sense.
> 
> I wonder this deserves a new test case to protect the fix from future 
> regressions.

It would probably make sense; this would also exercise git-daemon for the 
first time in our test suite.

Will work on it right away.

Ciao,
Dscho
