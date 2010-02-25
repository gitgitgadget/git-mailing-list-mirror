From: Nelson Elhage <nelhage@MIT.EDU>
Subject: Re: What's cooking in git.git (Feb 2010, #06; Tue, 23)
Date: Wed, 24 Feb 2010 19:11:23 -0500
Message-ID: <1267056683-6697-1-git-send-email-nelhage@mit.edu>
References: <7v635nsa37.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1002241004010.1946@xanadu.home> <7v635m6w0r.fsf@alter.siamese.dyndns.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org,
	Nelson Elhage <nelhage@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 01:13:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkRMC-000335-Ro
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 01:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758659Ab0BYAN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 19:13:28 -0500
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:62675 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758523Ab0BYAN1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 19:13:27 -0500
X-AuditID: 1209190c-b7cfcae00000096b-dd-4b85c0a67f56
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Brightmail Gateway) with SMTP id 88.8D.02411.6A0C58B4; Wed, 24 Feb 2010 19:13:26 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o1P0DPoJ024125;
	Wed, 24 Feb 2010 19:13:25 -0500
Received: from PHANATIQUE.MIT.EDU (c-71-192-160-118.hsd1.nh.comcast.net [71.192.160.118])
	(authenticated bits=0)
        (User authenticated as nelhage@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o1P0DMvg022112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 24 Feb 2010 19:13:23 -0500 (EST)
X-Mailer: git-send-email 1.6.6.30.g1e6fd
In-Reply-To: <7v635m6w0r.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAhMHvRwTB8eX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141015>

You should probably fix --honor-pack-keep while you're at it.

(I assume this should probably get squashed into your patch, but I'm
sending it as another patch, because I'm unsure of the etiquette on
resending an edited version of someone else's patch)

- Nelson

---- >8 ----
Subject: pack-objects documentation: Fix --honor-pack-keep as well.

Signed-off-by: Nelson Elhage <nelhage@mit.edu>
---
 Documentation/git-pack-objects.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 1deaa65..8ed09c0 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -115,8 +115,8 @@ base-name::
 
 --honor-pack-keep::
 	This flag causes an object already in a local pack that
-	has a .keep file to be ignored, even if it appears in the
-	standard input.
+	has a .keep file to be ignored, even if it it would have
+	otherwise been packed.
 
 --incremental::
 	This flag causes an object already in a pack to be ignored
-- 
1.6.6.30.g1e6fd
