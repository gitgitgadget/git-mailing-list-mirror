From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 3/5] api-run-command.txt: talk about run_hook()
Date: Fri, 16 Jan 2009 20:10:00 +0100
Message-ID: <1232133002-21725-3-git-send-email-s-beyer@gmx.net>
References: <20090116172521.GD28177@leksak.fem-net>
 <1232133002-21725-1-git-send-email-s-beyer@gmx.net>
 <1232133002-21725-2-git-send-email-s-beyer@gmx.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>, gitster@pobox.com,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 20:12:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNu75-0005Fh-6b
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 20:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764211AbZAPTKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 14:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936430AbZAPTKS
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 14:10:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:55107 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763992AbZAPTKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 14:10:09 -0500
Received: (qmail invoked by alias); 16 Jan 2009 19:10:06 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp006) with SMTP; 16 Jan 2009 20:10:06 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19hVWxcRathqUmYRDJcaXuP0wKaJyceFAI8DRVr39
	QvrU/A8otNbEpg
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNu4w-0005fL-Ml; Fri, 16 Jan 2009 20:10:02 +0100
X-Mailer: git-send-email 1.6.1.160.gecdb
In-Reply-To: <1232133002-21725-2-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105989>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

	Jakub, thanks for your notes.
	I still rephrased it some more.

 Documentation/technical/api-run-command.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index 82e9e83..13e7b63 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -52,6 +52,21 @@ Functions
 	Wait for the completion of an asynchronous function that was
 	started with start_async().
 
+`run_hook`::
+
+	Run a hook.
+	The first argument is a pathname to an index file, or NULL
+	if the hook uses the default index file or no index is needed.
+	The second argument is the name of the hook.
+	The further arguments (up to 9) correspond to the hook arguments.
+	The last argument has to be NULL to terminate the arguments list.
+	If the hook does not exist or is not executable, the return
+	value will be zero.
+	If it is executable, the hook will be executed and the exit
+	status of the hook is returned.
+	On execution, .stdout_to_stderr and .no_stdin will be set.
+	(See below.)
+
 
 Data structures
 ---------------
-- 
1.6.1.160.gecdb
