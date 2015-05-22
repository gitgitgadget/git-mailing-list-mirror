From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] doc: fix inconsistent spelling of "packfile"
Date: Fri, 22 May 2015 08:22:04 +0200
Message-ID: <1432275724-3187-1-git-send-email-ps@pks.im>
References: <1432193225-3502-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 22 08:22:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvgM5-0004TE-Vh
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 08:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516AbbEVGWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 02:22:46 -0400
Received: from sender1.zohomail.com ([74.201.84.153]:25853 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbbEVGWp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 02:22:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=kT1pbNQHp9IjwS327snHrSX336CNWy36dLEvsVjajMTaQyrCJgq5JDzGIOGaa2ayDzw0bU1ReJeG
    fMBFgURJ1Yrffv8XkxtZCatZ6fIYaVDjjW/vefo0w7GR7Kwi43flitqpzWoXJ5v2kwi9WhOUDXyC
    8LPfLEPlqpi2s7tQXZw=  
Received: from localhost (x55b3ace6.dyn.telefonica.de [85.179.172.230]) by mx.zohomail.com
	with SMTPS id 1432275761796785.9758967388382; Thu, 21 May 2015 23:22:41 -0700 (PDT)
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432193225-3502-1-git-send-email-ps@pks.im>
X-ZohoMail: Ss  SS_10 UW1 iCHF_KNW_WHT_EXT  SGR3_0_08055_4
X-ZohoMail-Owner: <1432275724-3187-1-git-send-email-ps@pks.im>+zmo_0_<ps@pks.im>
X-ZohoMail-Sender: 85.179.172.230
X-Zoho-Virus-Status: 2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269691>

Fix remaining instances where "pack-file" is used instead of
"packfile". Some places remain where we still use "pack-file",
This is the case when we explicitly refer to a file with a
".pack" extension as opposed to a data source providing a pack
data stream.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-unpack-objects.txt      | 2 +-
 Documentation/technical/pack-protocol.txt | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index 894d20b..07d4329 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -9,7 +9,7 @@ git-unpack-objects - Unpack objects from a packed archive
 SYNOPSIS
 --------
 [verse]
-'git unpack-objects' [-n] [-q] [-r] [--strict] < <pack-file>
+'git unpack-objects' [-n] [-q] [-r] [--strict] < <packfile>
 
 
 DESCRIPTION
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 812d857..fc09c63 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -465,7 +465,7 @@ contain all the objects that the server will need to complete the new
 references.
 
 ----
-  update-request    =  *shallow ( command-list | push-cert ) [pack-file]
+  update-request    =  *shallow ( command-list | push-cert ) [packfile]
 
   shallow           =  PKT-LINE("shallow" SP obj-id LF)
 
@@ -491,7 +491,7 @@ references.
 		      *PKT-LINE(gpg-signature-lines LF)
 		      PKT-LINE("push-cert-end" LF)
 
-  pack-file         = "PACK" 28*(OCTET)
+  packfile          = "PACK" 28*(OCTET)
 ----
 
 If the receiving end does not support delete-refs, the sending end MUST
-- 
2.4.1
