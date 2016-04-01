From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] doc: clarify that notes can be attached to any type of stored
 object
Date: Fri, 1 Apr 2016 12:09:10 +0200
Message-ID: <56FE48C6.9050306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 12:09:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alw1C-0004yX-SA
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 12:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbcDAKJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 06:09:27 -0400
Received: from plane.gmane.org ([80.91.229.3]:35621 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbcDAKJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 06:09:26 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1alw10-0004sh-Rk
	for git@vger.kernel.org; Fri, 01 Apr 2016 12:09:18 +0200
Received: from 131.228.216.133 ([131.228.216.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 12:09:18 +0200
Received: from sschuberth by 131.228.216.133 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 12:09:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 131.228.216.133
X-Mozilla-News-Host: news://news.gmane.org:119
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290515>

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-notes.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 8de3499..5375d98 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -234,8 +234,9 @@ which operation triggered the update, and the commit authorship is
 determined according to the usual rules (see linkgit:git-commit[1]).
 These details may change in the future.
 
-It is also permitted for a notes ref to point directly to a tree
-object, in which case the history of the notes can be read with
+It is also permitted for a notes ref to point to any other object in
+the object store besides commit objects, that is annotated tags, blobs
+or trees. For the latter, the history of the notes can be read with
 `git log -p -g <refname>`.
 
 
-- 
2.8.0.windows.1
