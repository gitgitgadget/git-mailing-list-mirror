From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/38] rename_ref_available(): add docstring
Date: Fri,  3 Jun 2016 23:03:37 +0200
Message-ID: <5eb96cc20c0f76aff39d1556803ebd4f9f422cea.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:07:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wJE-0002Gf-7H
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbcFCVHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:07:05 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58635 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932907AbcFCVE3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:04:29 -0400
X-AuditID: 1207440e-ef3ff700000008c5-2e-5751f0db6822
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id DE.58.02245.BD0F1575; Fri,  3 Jun 2016 17:04:27 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4KcS003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:26 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqHv7Q2C4wf8JBhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLMm0ZGBw6Pv+8/MHnsnHWX3eNZ7x5Gj4uXlD32
	L93G5rH4gZfHguf32T0+b5IL4IjitklKLCkLzkzP07dL4M7YevoJc8Fs9oo9e9+yNTB+Y+1i
	5OSQEDCR+Pi1ha2LkYtDSGAro8TSja8ZIZzjTBLrF2xmBqliE9CVWNTTzARiiwhESDS8agEr
	YhaYwyRx+2EnUBEHh7CAjcTjThaQGhYBVYn/O0+yg9i8AlESW7qfMENsk5O4PP0BG4jNKWAh
	0fJ5FdgVQgLmEo2nDrNMYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXWC83s0QvNaV0
	EyMk6Ph2MLavlznEKMDBqMTDW/AsMFyINbGsuDL3EKMkB5OSKO/eO0AhvqT8lMqMxOKM+KLS
	nNTiQ4wSHMxKIrwpr4FyvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ
	3kXvgRoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQTEQXwyMApAUD9Be7g8ge4sL
	EnOBohCtpxh1ORb8uL2WSYglLz8vVUqcNxRkhwBIUUZpHtwKWIp5xSgO9LEwbzJIFQ8wPcFN
	egW0hAloScEjf5AlJYkIKakGRrXv5t21/pNvzP3dfvaIi1dicNfitpXWcituy7EcWBzUf+bO
	ijtrFzAZ+usv6KvmWLs/5laU48mX97+umMlgdGTH1Fern/HN107l5lrfV8aw5qzg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296410>

From: David Turner <dturner@twopensource.com>

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/refs-internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index efe5847..d8a2606 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -240,6 +240,11 @@ const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip);
 
+/*
+ * Check if the new name does not conflict with any existing refs
+ * (other than possibly the old ref).  Return 0 if the ref can be
+ * renamed to the new name.
+ */
 int rename_ref_available(const char *oldname, const char *newname);
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
-- 
2.8.1
