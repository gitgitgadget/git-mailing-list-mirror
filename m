From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] git-submodule summary: documentation
Date: Sat, 08 Mar 2008 01:37:58 -0800
Message-ID: <7vpru5v9mx.fsf@gitster.siamese.dyndns.org>
References: <1204914439-23145-1-git-send-email-pkufranky@gmail.com>
 <1204914439-23145-2-git-send-email-pkufranky@gmail.com>
 <1204914439-23145-3-git-send-email-pkufranky@gmail.com>
 <1204914439-23145-4-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 10:39:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXvWI-0001TO-5N
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 10:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbYCHJic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 04:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbYCHJib
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 04:38:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65491 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbYCHJiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 04:38:09 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B2022223;
	Sat,  8 Mar 2008 04:38:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2BF8F2222; Sat,  8 Mar 2008 04:38:05 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76554>

I've replaced the previous series in 'pu' with this series and queued in
'pu', but with a few wording fixes.

I didn't closely look at the script itself yet.  I thinkthe series is
getting closer to a mergeable shape, but it needs tests.

 Documentation/git-submodule.txt |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 4fbc182..e96bf36 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -48,11 +48,10 @@ update::
 	This will make the submodules HEAD be detached.
 
 summary::
-	Show commit summary between given commit (default to HEAD) and
+	Show commit summary between the given commit (defaults to HEAD) and
 	working tree/index. For a submodule in question, a series of commits
-	between src sha1 and dst sha1 will be shown where src sha1 is from the
-	given super project commit and dst sha1 is from the index or working
-	tree (switched by --cached).
+	in the submodule between the given super project commit and the
+	index or working tree (switched by --cached) are shown.
 
 OPTIONS
 -------
@@ -63,16 +62,14 @@ OPTIONS
 	Branch of repository to add as submodule.
 
 --cached::
-	This option is only valid for commands status and summary.
-	When combined with status, display the SHA-1 stored in the index,
-	not the SHA-1 of the currently checked out submodule commit. When
-	combined with summary, switch dst comparison side from working
-	tree to index.
+	This option is only valid for status and summary commands.  These
+	commands typically use the commit found in the submodule HEAD, but
+	with this option, the commit stored in the index is used instead.
 
 -n, --summary-limit::
 	This option is only valid for the summary command.
 	Limit the summary size (number of commits shown in total).
-	Number 0 will disable summary and minus number means unlimted
+	Giving 0 will disable the summary; a negative number means unlimted
 	(the default). This limit only applies to modified submodules. The
 	size is always limited to 1 for added/deleted/typechanged submodules.
 



