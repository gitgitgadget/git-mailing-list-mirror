From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC 0/8] use "git diff" in the test suite
Date: Sun, 25 Feb 2007 23:50:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702252349390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702252329550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Feb 25 23:50:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLSCc-0001p7-Fa
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 23:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbXBYWui (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 17:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437AbXBYWui
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 17:50:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:35586 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750998AbXBYWui (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 17:50:38 -0500
Received: (qmail invoked by alias); 25 Feb 2007 22:50:37 -0000
X-Provags-ID: V01U2FsdGVkX1/n11ligDPnuxl0EDZsgC4vLV4Fez81UsmwRrl426
	8D9g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0702252329550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40590>

Hi,

somehow, patch 7/8 did not come through, I guess, so here is how to do it 
yourself:

$ perl -pi.bak -e "s/(^\s*|'|&&\s*)cmp -s /\1git diff /" *.sh

We should probably add a "--quiet" flag for the diff family first, and use 
that...

Ciao,
Dscho
