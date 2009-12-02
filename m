From: Alex Vandiver <alex@chmrr.net>
Subject: [PATCH 0/5] git-svn: svk log message cleanup
Date: Wed,  2 Dec 2009 14:07:49 -0500
Message-ID: <1259780874-14706-1-git-send-email-alex@chmrr.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 20:38:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFv1w-0007t6-Gd
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578AbZLBThj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755577AbZLBThh
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:37:37 -0500
Received: from chmrr.net ([209.67.253.66]:56889 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754948AbZLBThf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:37:35 -0500
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=localhost.localdomain)
	by utwig.chmrr.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alex@chmrr.net>)
	id 1NFuYc-0004Rd-8q
	for git@vger.kernel.org; Wed, 02 Dec 2009 14:08:13 -0500
X-Mailer: git-send-email 1.6.6.rc0.327.g032bc
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.69 (build at 07-Feb-2009 20:08:51)
X-Date: 2009-12-02 14:08:13
X-Connected-IP: 75.147.59.54:47077
X-Message-Linecount: 12
X-Body-Linecount: 5
X-Message-Size: 476
X-Body-Size: 213
X-Received-Count: 1
X-Recipient-Count: 1
X-Local-Recipient-Count: 1
X-Local-Recipient-Defer-Count: 0
X-Local-Recipient-Fail-Count: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134385>

This patch series tries to clean up the cruft that svk leaves in log
messages, while optionally (using the existing --use-log-author
option) using the information therein to set author username and time.
 - Alex
