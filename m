From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: [PATCH] Document the --done option.
Date: Wed, 22 Aug 2012 06:57:05 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20120822105705.GA30472@thyrsus.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 22 13:06:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T48lp-00005N-NM
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 13:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686Ab2HVLGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 07:06:40 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:57351
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab2HVLGj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 07:06:39 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 57268420F5; Wed, 22 Aug 2012 06:57:05 -0400 (EDT)
Content-Disposition: inline
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204010>

---
 Documentation/git-fast-import.txt |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 2620d28..9291ea0 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -39,6 +39,10 @@ OPTIONS
 	See ``Date Formats'' below for details about which formats
 	are supported, and their syntax.
 
+-- done::
+	Terminate with error if there is no 'done' command at the 
+	end of the stream.
+
 --force::
 	Force updating modified existing branches, even if doing
 	so would cause commits to be lost (as the new commit does
@@ -1047,7 +1051,9 @@ done::
 	Error out if the stream ends without a 'done' command.
 	Without this feature, errors causing the frontend to end
 	abruptly at a convenient point in the stream can go
-	undetected.
+	undetected.  This may occur, for example, if an import
+	front end dies in mid-operation without emitting SIGTERM
+	or SIGKILL at its subordinate git fast-import instance.
 
 `option`
 ~~~~~~~~
-- 
1.7.9.5


-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
