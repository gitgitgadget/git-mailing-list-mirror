From: mduft@gentoo.org
Subject: [PATCH] Interix catch-ups for recent changes/releases.
Date: Wed, 25 May 2011 16:15:22 +0200
Message-ID: <1306332924-28587-1-git-send-email-mduft@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 16:25:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPF20-0005IJ-Sc
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 16:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932994Ab1EYOZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 10:25:35 -0400
Received: from smtp.salomon.at ([193.186.16.13]:57813 "EHLO sauxb.salomon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932151Ab1EYOZc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 10:25:32 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 May 2011 10:25:31 EDT
Received: from servex01.wamas.com (servex01.salomon.at [172.28.2.2])
	by sauxb.salomon.at (8.12.10/8.12.10) with ESMTP id p4PEFMJV022198
	for <git@vger.kernel.org>; Wed, 25 May 2011 16:15:49 +0200 (METDST)
Received: from s01en22 ([172.28.8.166]) by servex01.wamas.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 25 May 2011 16:15:33 +0200
Received: by s01en22 (sSMTP sendmail emulation); Wed, 25 May 2011 16:15:29 +0200
X-Mailer: git-send-email 1.7.3.4
X-OriginalArrivalTime: 25 May 2011 14:15:33.0612 (UTC) FILETIME=[35E852C0:01CC1AE6]
X-Scanned-By: MIMEDefang 2.54 on 172.28.2.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174407>


Hey!

Since it has been a while since i last built git on interix, it didn't work out of the box for older interixen.
There are a few small changes required, which i hope should be not a big thing to get included in the git repo.

The removal of two previously required options from the Makefile is because of a special library (libsuacomp: [1]).
This library is required all over the place on interix, and provides those previously missing things. There are
others depending on this (gnulib, findutils, coreutils, ...) for interix support, and thus i think it should not 
be a problem to depend on it, right?

May i ask for a review?

Thanks,
markus
