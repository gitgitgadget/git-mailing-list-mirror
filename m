From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/5] Some git-instaweb enhancements
Date: Wed, 26 Jul 2006 16:32:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607261628020.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jul 26 16:33:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5kRL-000693-1q
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 16:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbWGZOco (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 10:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbWGZOco
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 10:32:44 -0400
Received: from mail.gmx.net ([213.165.64.21]:47019 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751639AbWGZOcn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 10:32:43 -0400
Received: (qmail invoked by alias); 26 Jul 2006 14:32:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 26 Jul 2006 16:32:41 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net,
	Eric Wong <normalperson@yhbt.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24214>

Hi,

these are assorted fixes/features for git-instaweb:

1) do not mind git being installed somewhere else than /usr/bin
2) do not mind some Apache having mod_cgi builtin
3) store defaults in config
4) fall back to apache if lighttp cannot be found
5) fall back to echo if firefox cannot be found

IMHO 1 & 2 should go in, since they fix bugs. 3 to 5 are nice-to-haves.

Ciao,
Dscho
