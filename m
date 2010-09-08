From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/3] fast-import: typofix
Date: Tue, 7 Sep 2010 22:13:00 -0500
Message-ID: <20100908031300.GA23409@capella.cs.uchicago.edu>
References: <20100701031819.GA12524@burratino> <20100701054849.GA14972@burratino> <20100817170216.GA14491@kytes> <20100905031528.GA2344@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 05:13:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtB5w-0001PI-Av
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 05:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756320Ab0IHDND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 23:13:03 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:58612 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591Ab0IHDNC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 23:13:02 -0400
Received: from capella.cs.uchicago.edu (capella.cs.uchicago.edu [128.135.24.228])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id B68D7A241;
	Tue,  7 Sep 2010 22:13:00 -0500 (CDT)
Received: by capella.cs.uchicago.edu (Postfix, from userid 10442)
	id 3FEAA761AF; Tue,  7 Sep 2010 22:13:00 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20100905031528.GA2344@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155759>

Noticed-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
To be squashed with patch 3 in the next round.  Thanks,
Sverre.

 fast-import.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index b7fa9ae..099f63e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2761,7 +2761,7 @@ static void parse_cat_request(void)
 	/* cat SP <object> */
 	p = command_buf.buf + strlen("cat ");
 	if (report_fd < 0)
-		die("The cat command features the report-fd feature.");
+		die("The cat command requires the report-fd feature.");
 	if (*p == ':') {
 		char *x;
 		oe = find_mark(strtoumax(p + 1, &x, 10));
-- 
1.7.3.rc0.6.g7505a.dirty
