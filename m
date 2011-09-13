From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] Documentation: basic configuration of notes.rewriteRef
Date: Tue, 13 Sep 2011 09:32:42 +0200
Message-ID: <95a35723c2ac7e3accfceec2cdededcd213fb59b.1315899036.git.trast@student.ethz.ch>
References: <7vzki92wdc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 09:32:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3NUC-0000Ds-8Z
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 09:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613Ab1IMHcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 03:32:45 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:51960 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539Ab1IMHcp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 03:32:45 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Tue, 13 Sep
 2011 09:32:40 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.289.1; Tue, 13 Sep
 2011 09:32:42 +0200
X-Mailer: git-send-email 1.7.7.rc0.487.g1b75
In-Reply-To: <7vzki92wdc.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181269>

Users had problems finding a working setting for notes.rewriteRef.
Document how to enable rewriting for notes/commits, which should be a
safe setting.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Junio C Hamano wrote:
> Should we drop this post 1.7.7, or (preferrably) replace it with better
> instructions?

I'd replace it with this bit.  Users who have trouble setting the
variable to something useful will likely not know how to edit
non-default notes trees, either.


 Documentation/config.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0ecef9d..0813812 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1464,7 +1464,8 @@ notes.rewriteRef::
 	You may also specify this configuration several times.
 +
 Does not have a default value; you must configure this variable to
-enable note rewriting.
+enable note rewriting.  Set it to `refs/notes/commits` to enable
+rewriting for the default commit notes.
 +
 This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
 environment variable, which must be a colon separated list of refs or
-- 
1.7.7.rc0.487.g1b75
