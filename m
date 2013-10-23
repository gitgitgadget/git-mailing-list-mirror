From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/15] api-remote.txt: correct section "struct refspect"
Date: Wed, 23 Oct 2013 17:50:37 +0200
Message-ID: <1382543448-2586-5-git-send-email-mhagger@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:59:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0pv-0006py-0r
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab3JWP7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:59:00 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:62806 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752635Ab3JWP67 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 11:58:59 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Oct 2013 11:58:59 EDT
X-AuditID: 1207440e-b7fbc6d000004ad9-37-5267f09cee90
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id D4.86.19161.C90F7625; Wed, 23 Oct 2013 11:51:57 -0400 (EDT)
Received: from localhost.localdomain (p57A247B5.dip0.t-ipconnect.de [87.162.71.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9NFpLsv009100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Oct 2013 11:51:54 -0400
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqDv3Q3qQwcx2JovpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE74/uGM2wFN/gr3r6ZwtrA+J6ni5GTQ0LARGL66m5WCFtM4sK99WxdjFwcQgKXGSWO717F
	CuFcYZJ41dnCBFLFJqArsainGcwWEVCTmNh2iAWkiFlgIrPE8emLWEASwgIeEkdez2UHsVkE
	VCWOLJ8GZvMKOEsc2ncCqJkDaJ2cxMNvsSBhTgEXiQvHp4NdIQRUMmHhVPYJjLwLGBlWMcol
	5pTm6uYmZuYUpybrFicn5uWlFuka6+VmluilppRuYoSELd8Oxvb1MocYBTgYlXh4LdrTgoRY
	E8uKK3MPMUpyMCmJ8s55lx4kxJeUn1KZkVicEV9UmpNafIhRgoNZSYR3x12gHG9KYmVValE+
	TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgrfpPVCjYFFqempFWmZOCUKaiYMTRHCB
	bOAB2jALpJC3uCAxtzgzHaLoFKOilDhvA0hCACSRUZoHNwCWYF4xigP9I8w7G6SKB5ic4Lpf
	AQ1mAho8ZUkayOCSRISUVANj3a78LM5VQX2PZwu8nXnqTFdpr8f1qff/BRmlVKvPeiea37W8
	8FDNzYgNWZpTD978uHPtn48WOS8+v3jNGe2aJ7DZoP/e+e16V2Y8Pld4WoFlKvN8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236524>

* Replace reference to function parse_ref_spec() with references to
  functions parse_fetch_refspec() and parse_push_refspec().

* Correct description of src and dst: they *do* include the '*'
  characters.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-remote.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/api-remote.txt b/Documentation/technical/api-remote.txt
index 4be8776..5d245aa 100644
--- a/Documentation/technical/api-remote.txt
+++ b/Documentation/technical/api-remote.txt
@@ -58,16 +58,16 @@ default remote, given the current branch and configuration.
 struct refspec
 --------------
 
-A struct refspec holds the parsed interpretation of a refspec. If it
-will force updates (starts with a '+'), force is true. If it is a
-pattern (sides end with '*') pattern is true. src and dest are the two
-sides (if a pattern, only the part outside of the wildcards); if there
-is only one side, it is src, and dst is NULL; if sides exist but are
-empty (i.e., the refspec either starts or ends with ':'), the
-corresponding side is "".
-
-This parsing can be done to an array of strings to give an array of
-struct refpsecs with parse_ref_spec().
+A struct refspec holds the parsed interpretation of a refspec.  If it
+will force updates (starts with a '+'), force is true.  If it is a
+pattern (sides end with '*') pattern is true.  src and dest are the
+two sides (including '*' characters if present); if there is only one
+side, it is src, and dst is NULL; if sides exist but are empty (i.e.,
+the refspec either starts or ends with ':'), the corresponding side is
+"".
+
+An array of strings can be parsed into an array of struct refspecs
+using parse_fetch_refspec() or parse_push_refspec().
 
 remote_find_tracking(), given a remote and a struct refspec with
 either src or dst filled out, will fill out the other such that the
-- 
1.8.4
