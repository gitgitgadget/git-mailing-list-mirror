From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v9] Detection of directory renames
Date: Thu,  9 Dec 2010 22:38:01 +0100
Message-ID: <1291930687-8990-1-git-send-email-ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:38:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoCM-0005wX-Qo
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757326Ab0LIViV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:38:21 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:39500 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757211Ab0LIViV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:38:21 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 988F3D48150
	for <git@vger.kernel.org>; Thu,  9 Dec 2010 22:38:15 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PQoBq-0002SZ-D8
	for git@vger.kernel.org; Thu, 09 Dec 2010 22:38:14 +0100
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163328>

This series requires:
- v6 of "generalizing sorted-array handling" series
- Jonathan Nieder's "compat: add memrchr()" patch,
  aka. mid:<20101015051750.GA21830@burratino>

Changes since v8:

* use of the new sorted-array.h, which gives the main patch a diet
* split of debug func into its own patch

Next iteration will be merging the bulk-rm detection into this series.
Interested eyes can get a preview at t/* branches on
http://repo.or.cz/w/git/ydirson.git
