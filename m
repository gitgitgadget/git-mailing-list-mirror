From: Denis Cheng <crquan@gmail.com>
Subject: [PATCH 1/3] whatchanged documentation: share description of --pretty with others
Date: Sun,  2 Mar 2008 17:05:51 +0800
Message-ID: <1204448753-4471-1-git-send-email-crquan@gmail.com>
References: <7vr6etvlgm.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 02 10:06:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVk9i-0000HG-7G
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 10:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbYCBJGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 04:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752738AbYCBJGJ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 04:06:09 -0500
Received: from el-out-1112.google.com ([209.85.162.176]:16954 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbYCBJGG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 04:06:06 -0500
Received: by el-out-1112.google.com with SMTP id v27so982375ele.17
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 01:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0P/WBKdlAuZpy19lDLqi0MLZI9ADsfnWEw1JoWM0nlU=;
        b=cMTuacMXhCzVk9G5wc6GlXXcK5Vp24wmTW6k/r9dhXkr1qTSHKIKFmQAZN3cOsCAfMo/AMxfSlAXlh0ATElDLSCMr5EaVrGL0oCg5ksaBdT2HFNvySCUph8u4pcGHOWONlIJDDyXHCRbbHUT7fsEI9Wdo33WkALmJUi+2Q3TwrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aM3qfqKEcEsGDT4og6cL1Z0yMUpbpv8UMIfqrxRDzRUgbbIAkXk9KLL92JPZxzK9lA7IPmhqzAhqsgIgw8yug/DUkYreyqlz1M3p2kLdF6CDU7wNwMXT9SMt/dNGPQXqAYnHgQ+tWRP7a/IG4+OvFFbqFV+OD5OQ6Cjjw+5dIDY=
Received: by 10.114.160.1 with SMTP id i1mr2907905wae.49.1204448764169;
        Sun, 02 Mar 2008 01:06:04 -0800 (PST)
Received: from tux ( [121.34.60.168])
        by mx.google.com with ESMTPS id n6sm18369690wag.17.2008.03.02.01.05.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 01:06:02 -0800 (PST)
Received: by tux (sSMTP sendmail emulation); Sun,  2 Mar 2008 17:05:53 +0800
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <7vr6etvlgm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75750>

The documentation had its own description for --pretty and did not
include pretty-options/formats as documentation for other commands in
the "log" family did.

Signed-off-by: Denis Cheng <crquan@gmail.com>
---
 Documentation/git-whatchanged.txt |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index 54947b6..a6e7bd4 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -38,11 +38,6 @@ OPTIONS
 	Show git internal diff output, but for the whole tree,
 	not just the top level.
 
---pretty=<format>::
-	Controls the output format for the commit logs.
-	<format> can be one of 'raw', 'medium', 'short', 'full',
-	and 'oneline'.
