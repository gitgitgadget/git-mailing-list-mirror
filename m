From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Possible regression: overwriting untracked files in a fresh repo
Date: Mon, 24 Aug 2009 18:31:21 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908241829510.11375@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 18:31:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfcSC-00075u-L3
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 18:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbZHXQbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 12:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbZHXQbV
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 12:31:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:56266 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751101AbZHXQbV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 12:31:21 -0400
Received: (qmail invoked by alias); 24 Aug 2009 16:31:21 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp057) with SMTP; 24 Aug 2009 18:31:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198UdBOzIJ8kQcRET37fgN171POcMfKn4zNlekrxS
	x1Af8AERJ72S0t
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126942>

Hi,

I _think_ that this used to complain about untracked files being 
overwritten:

	$ git init
	$ git remote add -f origin <url>
	$ git checkout -b blub origin/master

It does not do that here (any longer, IIAC).  Intended?

Ciao,
Dscho
