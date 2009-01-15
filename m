From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 2/2] api-run-command.txt: talk about run_hook()
Date: Thu, 15 Jan 2009 16:00:18 +0100
Message-ID: <1232031618-5243-2-git-send-email-s-beyer@gmx.net>
References: <1232031618-5243-1-git-send-email-s-beyer@gmx.net>
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>, gitster@pobox.com,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 16:02:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNTjN-0000qM-Bp
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 16:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758563AbZAOPAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 10:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758348AbZAOPAb
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 10:00:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:58277 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757369AbZAOPA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 10:00:26 -0500
Received: (qmail invoked by alias); 15 Jan 2009 15:00:20 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp016) with SMTP; 15 Jan 2009 16:00:20 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+QhHcrM1CQJIgEQcW0VTG86b4Liskfi0fcQS6dUT
	oiQvCVZl25TVIS
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNThi-0001NV-D5; Thu, 15 Jan 2009 16:00:18 +0100
X-Mailer: git-send-email 1.6.1.160.gecdb
In-Reply-To: <1232031618-5243-1-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105827>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

	I noticed that the last patch is lacking some documentation.
	Here it is. Should perhaps be squashed.

 Documentation/technical/api-run-command.txt |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index 82e9e83..1241f48 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -52,6 +52,22 @@ Functions
 	Wait for the completion of an asynchronous function that was
 	started with start_async().
 
+`run_hook`::
+
+	Run a hook.
+	The first argument is a string to an index file or NULL
+	if the default index file or no index is used at all.
+	The second argument is the name of the hook.
+	The further variable number (up to 9) of arguments correspond
+	to the hook arguments.
+	The last argument has to be NULL to terminate the variable
+	arguments list.
+	If the hook is not executable, the return value is zero.
+	If it is executable, the hook will be executed and the exit
+	status of the hook is returned.
+	On execution, .stdout_to_stderr and .no_stdin will be set.
+	(See below.)
+
 
 Data structures
 ---------------
-- 
1.6.1.160.gecdb
