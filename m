From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/2] Document the --histogram diff option
Date: Tue, 6 Mar 2012 14:15:02 +0100
Message-ID: <a8d07a8e3860196053da7595f040707d3a3723ef.1331039505.git.trast@student.ethz.ch>
References: <f113867bcf2fec3210cd1a997e1398903b3bdd76.1331039505.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Michal Privoznik <mprivozn@redhat.com>,
	Jeff King <peff@peff.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 14:15:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4uEV-0007Wl-BX
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 14:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758489Ab2CFNPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 08:15:10 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:27277 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758374Ab2CFNPI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 08:15:08 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 14:15:03 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 14:15:03 +0100
X-Mailer: git-send-email 1.7.9.2.467.g7fee4
In-Reply-To: <f113867bcf2fec3210cd1a997e1398903b3bdd76.1331039505.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192344>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This is only the minimal update.  I think in the long run, we should
add a note saying why we support all of them.  BUt off hand I didn't
have any substantial evidence in favour of patience that could be used
as an argument.

 Documentation/diff-options.txt |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 87f0a5f..7d4566f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -52,6 +52,9 @@ endif::git-format-patch[]
 --patience::
 	Generate a diff using the "patience diff" algorithm.
 
+--histogram::
+	Generate a diff using the "histogram diff" algorithm.
+
 --stat[=<width>[,<name-width>[,<count>]]]::
 	Generate a diffstat. By default, as much space as necessary
 	will be used for the filename part, and the rest for the graph
-- 
1.7.9.2.467.g7fee4
