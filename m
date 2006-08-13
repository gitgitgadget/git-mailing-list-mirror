From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: recur status on linux-2.6
Date: Sun, 13 Aug 2006 15:54:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608131550290.10541@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Aug 13 15:54:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCGQA-0001Vh-8g
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 15:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWHMNyV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 09:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWHMNyV
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 09:54:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:201 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751252AbWHMNyU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Aug 2006 09:54:20 -0400
Received: (qmail invoked by alias); 13 Aug 2006 13:54:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp007) with SMTP; 13 Aug 2006 15:54:19 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25283>

Hi,

I tested git-merge-recur vs. git-merge-recursive on the linux-2.6 
repository last night. It contains 2298 two-head merges. _All_ of them 
come out identically with -recur as compared to -recursive (looking at 
the resulting index only).

That was the good news. The bad news is: it _seems_, that -recur is only 
about 6x faster than -recursive, not 10x, and this number becomes smaller, 
the longer the merge takes. So I see a startup effect here, probably.

Ciao,
Dscho
