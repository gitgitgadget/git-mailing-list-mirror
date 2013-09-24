From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] clone.c: Add a period after "done" to end the sentence
Date: Tue, 24 Sep 2013 12:24:46 +0200
Message-ID: <5241686E.3040806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 24 12:25:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOPnj-0001H0-Sv
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 12:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab3IXKY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 06:24:59 -0400
Received: from plane.gmane.org ([80.91.229.3]:58087 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757Ab3IXKY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 06:24:59 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VOPne-0001BS-0r
	for git@vger.kernel.org; Tue, 24 Sep 2013 12:24:58 +0200
Received: from p5ddb25b8.dip0.t-ipconnect.de ([93.219.37.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 12:24:58 +0200
Received: from sschuberth by p5ddb25b8.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 12:24:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb25b8.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235298>

We have a period in other places after "done" (see e.g. clone_local), so
we should have one here, too.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index ca3eb68..0aff974 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -556,7 +556,7 @@ static void update_remote_refs(const struct ref *refs,
 							      0, &rm, transport))
 			die(_("remote did not send all necessary objects"));
 		if (0 <= option_verbosity)
-			printf(_("done\n"));
+			printf(_("done.\n"));
 	}
 
 	if (refs) {
-- 
1.8.3.msysgit.1.3.g5b82b42.dirty
