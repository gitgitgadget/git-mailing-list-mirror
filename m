From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/3] Make user formatted commit listing less expensive
Date: Sun, 4 Nov 2007 19:14:02 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711041912190.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 04 20:15:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IokwS-0005p3-V8
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 20:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbXKDTPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 14:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752744AbXKDTPO
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 14:15:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:43057 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751133AbXKDTPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 14:15:13 -0500
Received: (qmail invoked by alias); 04 Nov 2007 19:15:11 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp017) with SMTP; 04 Nov 2007 20:15:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lsq1lavqlJj6gC0fYO7xS3WYt2SNUGgNHljY8et
	mBSfta5d4bczSY
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63431>

Hi,

this series of three splits off the formatting code from commit.c, adds 
the function interp_find_active() to interpolate.[ch], and then uses it in 
the obvious way.

Ciao,
Dscho
