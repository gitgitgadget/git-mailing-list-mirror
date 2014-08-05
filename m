From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3] imap-send doc: omit confusing "to use imap-send" modifier
Date: Tue,  5 Aug 2014 02:56:50 +0000
Message-ID: <1407207410-26443-1-git-send-email-sandals@crustytoothpaste.net>
References: <20140805025108.GW12427@google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 05 04:57:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEUvq-0001A5-O2
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 04:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbaHEC4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 22:56:55 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49317 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753169AbaHEC4y (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2014 22:56:54 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DA5EE2808F;
	Tue,  5 Aug 2014 02:56:53 +0000 (UTC)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <20140805025108.GW12427@google.com>
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254800>

It wouldn't make sense for these configuration variables to be
required for Git in general to function.  'Required' in this context
means required for git imap-send to work.

Noticed while trying to figure out what the sentence describing
imap.tunnel meant.

[jn: expanded to also simplify explanation of imap.folder and
 imap.host in the same way]

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-imap-send.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 875d283..d3b465d 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -38,17 +38,17 @@ Variables
 imap.folder::
 	The folder to drop the mails into, which is typically the Drafts
 	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
-	"[Gmail]/Drafts". Required to use imap-send.
+	"[Gmail]/Drafts". Required.
 
 imap.tunnel::
 	Command used to setup a tunnel to the IMAP server through which
 	commands will be piped instead of using a direct network connection
-	to the server. Required when imap.host is not set to use imap-send.
+	to the server. Required when imap.host is not set.
 
 imap.host::
 	A URL identifying the server. Use a `imap://` prefix for non-secure
 	connections and a `imaps://` prefix for secure connections.
-	Ignored when imap.tunnel is set, but required to use imap-send
+	Ignored when imap.tunnel is set, but required.
 	otherwise.
 
 imap.user::
-- 
2.0.1
