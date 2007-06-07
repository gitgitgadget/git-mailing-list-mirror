From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: error: char103: premature end of data
Date: Thu, 7 Jun 2007 23:50:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706072348110.4046@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 00:53:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwQqj-0000sT-A5
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 00:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965644AbXFGWwy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 18:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965380AbXFGWwy
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 18:52:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:58310 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965644AbXFGWwx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 18:52:53 -0400
Received: (qmail invoked by alias); 07 Jun 2007 22:52:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 08 Jun 2007 00:52:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18lm4Bd80MlswSUgOSzUMa76NPESYNC+DaDiIfEUn
	hFQPyllyIz8ZIB
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49401>

Hi,

I just tried to fetch from one of my repos which was perfectly usable (and 
fetchable) before, and got this error message:

	error: char103: premature end of data

WTF? Since when did we stop using non-cryptic error messages?

Needless to say, I am very unhappy with such a message, especially in a 
repo which worked perfectly, thank you.

I somehow suspect that this has something to do with the recent work on 
the tag objects. If so, NACK on that patch series from me.

Ciao,
Dscho
