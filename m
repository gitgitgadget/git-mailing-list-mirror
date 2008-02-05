From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-rebase.sh: Use POSIX/Susv command substitution
 instead of backticks
Date: Tue, 5 Feb 2008 22:27:45 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802052226340.8543@racer.site>
References: <lk5zxdix.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 23:29:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMWHy-0003FQ-Ty
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 23:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760471AbYBEW21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 17:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760346AbYBEW21
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 17:28:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:53992 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756469AbYBEW20 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 17:28:26 -0500
Received: (qmail invoked by alias); 05 Feb 2008 22:28:24 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp024) with SMTP; 05 Feb 2008 23:28:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18OE18Eh4wOMyxXtvLoEo7ekia21HsQiMU/Oz1mY2
	nPCGlTICS4y2uq
X-X-Sender: gene099@racer.site
In-Reply-To: <lk5zxdix.fsf@blue.sea.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72710>

Hi,

On Wed, 6 Feb 2008, Jari Aalto wrote:

> Use redable $(<command>) syntax instead of backtics in code.  See The 
> Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition

Sorry, I am not quite sure if this patch is worth it: either you want to 
clean this up in _all_ of our shell scripts, or you leave it.  Or you fix 
it in those parts that you touch anyway, but again leave the rest as-are.

Ciao,
Dscho
