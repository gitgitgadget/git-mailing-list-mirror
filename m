From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 1/1] diff: support making output friendlier for fine, grand users
Date: Tue, 28 Oct 2008 22:23:52 -0700
Message-ID: <1225257832-29086-1-git-send-email-pasky@suse.cz>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>, Jeff King <peff@peff.net>,
	"J.H." <warthog19@eaglescrag.net>, Sam Vilain <sam@vilain.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 07:19:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kv4Oj-00007A-SI
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 07:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbYJ2GOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 02:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbYJ2GOW
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 02:14:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46594 "EHLO pixie.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751357AbYJ2GOV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 02:14:21 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 1F1002ACFF0; Tue, 28 Oct 2008 22:23:52 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99348>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Scott Chacon <schacon@gmail.com>
Signed-off-by: Tom Preston-Werner <tom@github.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: J.H. <warthog19@eaglescrag.net>
Signed-off-by: Sam Vilain <sam@vilain.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Kai Blin <kai@samba.org>
Acked-by: Petr Baudis <pasky@suse.cz>
Enabled-by: Cascade "Smooth" Amber <clarity@tiedhouse.com>
---
 diff.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index e368fef..0e2c14a 100644
--- a/diff.c
+++ b/diff.c
@@ -2489,6 +2489,9 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!prefixcmp(arg, "--output=")) {
 		options->file = fopen(arg + strlen("--output="), "w");
 		options->close_file = 1;
+	}
+	else if (!strcmp(arg, "--pirate")) {
+		printf("Arrrr!  These be yer fine changes, me 'earty!!\n");
 	} else
 		return 0;
 	return 1;
-- 
1.5.4.5
