From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 1/2] git-branch: allow --track to work w/local
 branches
Date: Sat, 16 Feb 2008 11:45:26 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802161143290.30505@racer.site>
References: <1203133557-50013-1-git-send-email-jaysoffian@gmail.com> <7v7ih5fpve.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 12:46:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQLUv-0000R0-A0
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 12:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbYBPLpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 06:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753494AbYBPLpw
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 06:45:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:37236 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753447AbYBPLpp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 06:45:45 -0500
Received: (qmail invoked by alias); 16 Feb 2008 11:45:42 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp039) with SMTP; 16 Feb 2008 12:45:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Jknoyfe4JpsAZ0UR8lQj3+WV5QvnruEAwiEP9XP
	wbi0DcUxCQGLEH
X-X-Sender: gene099@racer.site
In-Reply-To: <7v7ih5fpve.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74037>

Hi,

On Fri, 15 Feb 2008, Junio C Hamano wrote:

> This area was last cleaned up in 6f084a5 (branch --track: code cleanup 
> and saner handling of local branches).  I do not know if the original 
> intention of the code was to allow a hack like this to work, or it is 
> just an unintended accident that it happens to work.  Dscho, any ideas?

AFAIR the problem was that you were (rightfully) annoyed when you were 
setting up your local branches, and all of a sudden, they were set up with 
loads of tracking information, cluttering your config.

Basically, that is the reason why we disallowed tracking information to be 
set up for local branching.

Ciao,
Dscho
