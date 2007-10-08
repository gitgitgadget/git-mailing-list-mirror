From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [TIG PATCH] Add missing = for comparison in obsolete actions check.
Date: Mon, 8 Oct 2007 13:30:35 -0400
Message-ID: <20071008173034.GA27292@crux.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: fonseca@diku.dk
X-From: git-owner@vger.kernel.org Mon Oct 08 19:30:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IewRR-0001qt-Se
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 19:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbXJHRan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 13:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbXJHRan
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 13:30:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59104 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753370AbXJHRam (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 13:30:42 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id l98HUaKN020226;
	Mon, 8 Oct 2007 13:30:36 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l98HUach001242;
	Mon, 8 Oct 2007 13:30:36 -0400
Received: from crux (crux.toronto.redhat.com [172.16.14.85])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l98HUZuq014508;
	Mon, 8 Oct 2007 13:30:35 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60329>

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---
 tig.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tig.c b/tig.c
index 933d083..30c505b 100644
--- a/tig.c
+++ b/tig.c
@@ -1184,7 +1184,7 @@ option_bind_command(int argc, char *argv[])
 	}
 
 	request = get_request(argv[2]);
-	if (request = REQ_NONE) {
+	if (request == REQ_NONE) {
 		const char *obsolete[] = { "cherry-pick" };
 		size_t namelen = strlen(argv[2]);
 		int i;
-- 
1.5.3.4.1155.gfe96ee
