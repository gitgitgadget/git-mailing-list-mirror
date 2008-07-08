From: "Theodore Ts'o" <tytso@MIT.EDU>
Subject: [PATCH 2/2] Make guilt work even after git-sh-setup is moved out of the user's path
Date: Mon,  7 Jul 2008 20:03:12 -0400
Message-ID: <1215475392-26221-3-git-send-email-tytso@mit.edu>
References: <1215475392-26221-1-git-send-email-tytso@mit.edu>
 <1215475392-26221-2-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Tue Jul 08 02:04:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG0hK-0007SQ-6m
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 02:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709AbYGHADd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 20:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754351AbYGHADd
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 20:03:33 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:53464 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756709AbYGHADb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jul 2008 20:03:31 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m6803Jeo023855;
	Mon, 7 Jul 2008 20:03:19 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m6803CSF018880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 7 Jul 2008 20:03:16 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KG0fo-0007fN-86; Mon, 07 Jul 2008 20:03:12 -0400
X-Mailer: git-send-email 1.5.6.1.205.ge2c7.dirty
In-Reply-To: <1215475392-26221-2-git-send-email-tytso@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87668>

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 guilt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/guilt b/guilt
index cdf4e9b..d30d35a 100755
--- a/guilt
+++ b/guilt
@@ -23,7 +23,7 @@ esac
 # we change directories ourselves
 SUBDIRECTORY_OK=1
 
-. git-sh-setup
+. $(git --exec-path)/git-sh-setup
 
 #
 # Git version check
-- 
1.5.6.1.205.ge2c7.dirty
