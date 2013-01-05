From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] git-fast-import(1): remove duplicate "--done" option
Date: Sat, 5 Jan 2013 16:06:52 +0000
Message-ID: <20130105160652.GE6440@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 17:07:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrWHV-0007yw-K6
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 17:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798Ab3AEQHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 11:07:04 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:32793 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755811Ab3AEQHB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 11:07:01 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Jan 2013 11:07:01 EST
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id F30AD6064D3;
	Sat,  5 Jan 2013 16:07:00 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tt2AvkDmM2Ic; Sat,  5 Jan 2013 16:07:00 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 684466064CE;
	Sat,  5 Jan 2013 16:07:00 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 5F96E161E541;
	Sat,  5 Jan 2013 16:07:00 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I-CnNrOfGPmL; Sat,  5 Jan 2013 16:07:00 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 7C8A7161E509;
	Sat,  5 Jan 2013 16:06:54 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212701>

The "--done" option to git-fast-import is documented twice in its manual
page.  Combine the best bits of each description, keeping the location
of the instance that was added first.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
I'm guessing that the reason the option was documented again (in commit
3266de10) is because the options are not in an obvious order.  There
does seem to be some grouping of the options by type, but without
subheadings I wonder if it would make more sense to just put them all in
alphabetical order?

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
+	Terminate with error if there is no 'done' command at the
+	end of the stream.
 	This option might be useful for detecting errors that
 	cause the frontend to terminate before it has started to
 	write a stream.
-- 
1.8.0.2
