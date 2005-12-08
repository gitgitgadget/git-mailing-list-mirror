From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 14/17] Documentation/git-http-fetch.txt: Document the commit-id argument.
Date: Fri, 9 Dec 2005 00:28:05 +0100
Message-ID: <11340844853429-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <11340844852496-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVCK-0004lM-10
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbVLHX2P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbVLHX2O
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:14 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:2254 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932725AbVLHX2I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:08 -0500
Received: from puritan.petwork ([213.112.43.250] [213.112.43.250])
          by mxfep02.bredband.com with ESMTP
          id <20051208232807.VWYC17186.mxfep02.bredband.com@puritan.petwork>;
          Fri, 9 Dec 2005 00:28:07 +0100
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id D7ECDADFF9;
	Fri,  9 Dec 2005 00:28:05 +0100 (CET)
In-Reply-To: <11340844852496-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13394>

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-http-fetch.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

3bd76463c218402e883fc5c173ba9b9af77640bf
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 088624f..1116e85 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -14,6 +14,12 @@ DESCRIPTION
 -----------
 Downloads a remote git repository via HTTP.
 
+OPTIONS
+-------
+commit-id::
+        Either the hash or the filename under [URL]/refs/ to
+        pull.
+
 -c::
 	Get the commit objects.
 -t::
-- 
0.99.9l
