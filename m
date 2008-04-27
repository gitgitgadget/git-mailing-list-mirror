From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use
 whitespace.
Date: Sun, 27 Apr 2008 16:22:29 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness>
References: <20080427151610.GB57955@Hermes.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 17:23:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq8ic-0002vJ-Jt
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 17:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbYD0PWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 11:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753155AbYD0PWX
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 11:22:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:51180 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752530AbYD0PWX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 11:22:23 -0400
Received: (qmail invoked by alias); 27 Apr 2008 15:22:21 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp018) with SMTP; 27 Apr 2008 17:22:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/HIt44sDXHhlT20DOnkuwiwkI5wGMfGqkiBlp2gF
	JF6JqXRNbM8IV2
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080427151610.GB57955@Hermes.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80451>

Hi,

On Sun, 27 Apr 2008, Brian Gernhardt wrote:

>  Should this construct go into CodingStyle?  I seem to have to write 
>  patches like this every month or so.

Yes, probably.  I am very sorry, I really should have reviewed those 
patches better (I know that ":" in expr is better than "match", "tac" is 
something to be avoided, and "wc -l" can output whitespace).  It did not 
help that I hated the fact that that series changed the original design 
without even understanding it.

Ciao,
Dscho
