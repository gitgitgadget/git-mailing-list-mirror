From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2] git-fast-import(1): remove duplicate '--done' option
Date: Mon, 7 Jan 2013 11:57:09 +0000
Message-ID: <20130107115709.GJ6440@serenity.lan>
References: <20130105160652.GE6440@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 12:57:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsBKo-0006za-6e
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 12:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332Ab3AGL5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 06:57:21 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:36920 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744Ab3AGL5T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 06:57:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 3D10660654A;
	Mon,  7 Jan 2013 11:57:19 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M0rIAt+lLgFm; Mon,  7 Jan 2013 11:57:18 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by coyote.aluminati.org (Postfix) with ESMTP id A760E6064E0;
	Mon,  7 Jan 2013 11:57:18 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id 19F163766AC;
	Mon,  7 Jan 2013 11:57:18 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9OatC9SSEs+v; Mon,  7 Jan 2013 11:57:17 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id B87163766A7;
	Mon,  7 Jan 2013 11:57:11 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130105160652.GE6440@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212891>

On Sat, Jan 05, 2013 at 04:06:52PM +0000, John Keeping wrote:
The '--done' option to git-fast-import is documented twice in its manual
page.  Combine the best bits of each description, keeping the location
of the instance that was added first.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
Changed since v1:
    'done' => `done`

I'll wait a bit longer for comments on [1] before I have another go at
the full re-organisation of this page.

[1] http://article.gmane.org/gmane.comp.version-control.git/212805

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
