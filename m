From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3] git-fast-import(1): remove duplicate '--done' option
Date: Tue, 8 Jan 2013 19:39:34 +0000
Message-ID: <20130108193934.GP6440@serenity.lan>
References: <20130105160652.GE6440@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 20:40:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsf1r-0008TE-Qj
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 20:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756211Ab3AHTjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 14:39:48 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:53828 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755393Ab3AHTjr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 14:39:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 58CA122CF4;
	Tue,  8 Jan 2013 19:39:46 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kl0JRePSKr9x; Tue,  8 Jan 2013 19:39:45 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 95E0C22F02;
	Tue,  8 Jan 2013 19:39:45 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 446A0161E559;
	Tue,  8 Jan 2013 19:39:45 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6H5FVH1llRyy; Tue,  8 Jan 2013 19:39:45 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 56F25161E509;
	Tue,  8 Jan 2013 19:39:36 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130105160652.GE6440@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213000>

The '--done' option to git-fast-import is documented twice in its manual
page.  Combine the best bits of each description, keeping the location
of the instance that was added first.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
The commit description gained some noise in v2; this version should be
the really correct, final version.

Sorry for the noise.

 Documentation/git-fast-import.txt | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 68bca1a..4ef5721 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -39,10 +39,6 @@ OPTIONS
 	See ``Date Formats'' below for details about which formats
 	are supported, and their syntax.
 
--- done::
-	Terminate with error if there is no 'done' command at the
-	end of the stream.
-
 --force::
 	Force updating modified existing branches, even if doing
 	so would cause commits to be lost (as the new commit does
@@ -108,7 +104,8 @@ OPTIONS
 	output.
 
 --done::
-	Require a `done` command at the end of the stream.
+	Terminate with error if there is no `done` command at the
+	end of the stream.
 	This option might be useful for detecting errors that
 	cause the frontend to terminate before it has started to
 	write a stream.
-- 
1.8.0.2
