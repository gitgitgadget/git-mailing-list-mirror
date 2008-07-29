From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: git-svn and svn:externals, was Re: Hackontest ideas?
Date: Tue, 29 Jul 2008 13:56:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807291354130.4631@eeepc-johanness>
References: <20080729000103.GH32184@machine.or.cz> <m3myk1t54c.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 13:56:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNnoc-0005Ud-DM
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 13:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755686AbYG2Lza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 07:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755796AbYG2Lza
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 07:55:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:45356 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755635AbYG2Lz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 07:55:29 -0400
Received: (qmail invoked by alias); 29 Jul 2008 11:55:27 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp060) with SMTP; 29 Jul 2008 13:55:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/khzUdGlbkA0Z4B7FpDl7XNDcunvxvtKspDy1MhT
	7TTqorFCmNkfT/
X-X-Sender: user@eeepc-johanness
In-Reply-To: <m3myk1t54c.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90619>

Hi,

On Tue, 29 Jul 2008, Jakub Narebski wrote:

>  * handling of svn:externals using submodules

I doubt that this is easy.  Otherwise, Eric would have done it a long time 
ago.

The main concern I have is to get the semantics right: AFAICT 
svn:externals has _no notion_ of "what is current".  It just _always_ 
fetches the HEAD.  Even if you check out an ancient revision in the 
"superproject".

Ciao,
Dscho
