From: David Soria Parra <sn_@gmx.net>
Subject: [PATCH 0/2] Improve portability for OpenSolaris
Date: Wed, 27 Aug 2008 19:39:01 +0200
Message-ID: <1219858743-4476-1-git-send-email-sn_@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 19:40:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYP0B-0007ze-Tx
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 19:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbYH0RjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 13:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbYH0RjH
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 13:39:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:49190 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751214AbYH0RjF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 13:39:05 -0400
Received: (qmail invoked by alias); 27 Aug 2008 17:39:03 -0000
Received: from p57AEDFED.dip.t-dialin.net (EHLO localhost.localdomain) [87.174.223.237]
  by mail.gmx.net (mp038) with SMTP; 27 Aug 2008 19:39:03 +0200
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX1/j9XlxwjfjzepWMJhiEbPOHK+OHQAg4RttvpX4me
	G+AZI7slYEMi38
X-Mailer: git-send-email 1.6.0.174.gd789c
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93905>

This small patch series fixes some compile warnings on OpenSolaris/Solaris.
As pid_t is a long on Solaris, I changed the output of fprintf&co to longs
and cast pids to long, so that we are safe on the solaris
