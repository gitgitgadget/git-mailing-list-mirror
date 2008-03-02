From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-filter-branch may leave tree in a nasty state
Date: Sun, 2 Mar 2008 20:40:16 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803022039360.22527@racer.site>
References: <Pine.LNX.4.64.0803022029540.27717@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Sun Mar 02 21:42:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVv0W-0002lm-Ue
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 21:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbYCBUlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 15:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755890AbYCBUlD
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 15:41:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:40407 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752362AbYCBUlB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 15:41:01 -0500
Received: (qmail invoked by alias); 02 Mar 2008 20:40:59 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp013) with SMTP; 02 Mar 2008 21:40:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mfLtPtubmRFVj2cE0uUzRvhqHCs+4CmXG9F6Mwf
	pqoaPNAl9UnGq4
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0803022029540.27717@fbirervta.pbzchgretzou.qr>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75837>

Hi,

On Sun, 2 Mar 2008, Jan Engelhardt wrote:

> $ git-filter-branch --env-filter 'export GIT_AUTHOR_NAME="";' b4caa441..HEAD
> Rewrite cf1d02ac074041f7e570ff206d87fb47ef2b2c34 (1/1)fatal: empty ident  
> <user@corp.com> not allowed

Well, I kinda expected people savvy enough to run filter-branch to have 
set up the proper ident ;-)

Ciao,
Dscho
