From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH V2] user-manual: add addition gitweb information
Date: Wed, 30 Dec 2015 16:25:20 -0700
Message-ID: <1451517920-30703-1-git-send-email-ischis2@cox.net>
References: <xmqqoad7d1g0.fsf@gitster.mtv.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Stephen P. Smith" <ischis2@cox.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 31 00:25:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEQ7P-00069d-LC
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 00:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbbL3XZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 18:25:20 -0500
Received: from fed1rmfepo201.cox.net ([68.230.241.146]:40143 "EHLO
	fed1rmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbL3XZT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 18:25:19 -0500
Received: from fed1rmimpo305 ([68.230.241.173]) by fed1rmfepo201.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151230232518.OTAA5597.fed1rmfepo201.cox.net@fed1rmimpo305>
          for <git@vger.kernel.org>; Wed, 30 Dec 2015 18:25:18 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo305 with cox
	id zzRH1r00K2tqoqC01zRHhV; Wed, 30 Dec 2015 18:25:17 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020203.568467DD.01B9,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=f8aW8pOM c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=wUQvQvOEmiQA:10
 a=f_JlSur-vpJdsRJimCAA:9 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 2296A13F6B9;
	Wed, 30 Dec 2015 16:25:24 -0700 (MST)
X-Mailer: git-send-email 2.7.0-rc2
In-Reply-To: <xmqqoad7d1g0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283215>

Rework the section on gitweb to add information about the cgi script
and the instaweb command.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---

Notes:
    Removed wording duplication in the first paragraph.
    
    Added explicit gitweb reference with regard to instaweb.
    
    Fixed two spelling errors.

 Documentation/user-manual.txt | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1c790ac..226b972 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2125,8 +2125,17 @@ Allowing web browsing of a repository
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The gitweb cgi script provides users an easy way to browse your
-project's files and history without having to install Git; see the file
-gitweb/INSTALL in the Git source tree for instructions on setting it up.
+project's revisions, file contents and logs without having to install
+Git. Features like RSS/Atom feeds and blame/annotation details may
+optionally be enabled.
+
+The linkgit:git-instaweb[1] command provides a simple way to start
+browsing the repository using gitweb. The default server when using
+instaweb is lighttpd.
+
+See the file gitweb/INSTALL in the Git source tree and
+linkgit:gitweb[1] for instructions on details setting up a permament
+installation with a CGI or Perl capable server.
 
 [[sharing-development-examples]]
 Examples
@@ -4651,8 +4660,6 @@ documentation.
 Add a section on working with other version control systems, including
 CVS, Subversion, and just imports of series of release tarballs.
 
-More details on gitweb?
-
 Write a chapter on using plumbing and writing scripts.
 
 Alternates, clone -reference, etc.
-- 
2.7.0-rc2
