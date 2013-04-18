From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/2] api-parse-options.txt: document "no-" for non-boolean options
Date: Thu, 18 Apr 2013 09:46:35 +0200
Message-ID: <1366271195-4276-3-git-send-email-mhagger@alum.mit.edu>
References: <7vbo9ceqb3.fsf@alter.siamese.dyndns.org>
 <1366271195-4276-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 09:54:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USjff-0001r5-UB
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 09:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892Ab3DRHyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 03:54:15 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:50388 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754051Ab3DRHyP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Apr 2013 03:54:15 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Apr 2013 03:54:14 EDT
X-AuditID: 1207440d-b7fd06d000000905-e0-516fa50024c3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 5D.60.02309.005AF615; Thu, 18 Apr 2013 03:47:13 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3I7kuVA006934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 Apr 2013 03:47:11 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366271195-4276-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqMu4ND/Q4PMhJouuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M54uWMdY8Fj9ooJS66zNjAeZOti5OSQEDCR2LBmLyuELSZx4d56oDgXh5DAZUaJtl+9
	LCAJIYEzTBLvdoSD2GwCuhKLepqZQGwRATWJiW2HWEAamAX6GCX6180DSwgLBEnMu/wezGYR
	UJU4cH4XM4jNK+AssefgFXaIbQoSx7dvYwSxOQVcJB4fvs4KsSxf4tupk2wTGHkXMDKsYpRL
	zCnN1c1NzMwpTk3WLU5OzMtLLdI10svNLNFLTSndxAgJKt4djP/XyRxiFOBgVOLh7VyRFyjE
	mlhWXJl7iFGSg0lJlNdySX6gEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeR7JAOd6UxMqq1KJ8
	mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBG8wyFDBotT01Iq0zJwShDQTByeI4ALZ
	wAO0wR+kkLe4IDG3ODMdougUo6KUOG8KSEIAJJFRmgc3ABb/rxjFgf4R5o0FqeIBpg647ldA
	g5mABh9YlQ0yuCQRISXVwOizXzn8xFwDmdVPp5zeOffrwcDmlXwfHKu0PZOMk+r3azhe/W6+
	JsHt9syHM098vXBMfn5Vwxvb5qwEu+Pdk+SW2ofNeRtnXuikIv1ahttkX3pQ8lauJzIpQhnc
	z5dvM1jJ4ie3mPfipy31b0/6S/vFbZhTZbrl4IcVs1dY7ctdeXXLTN9J4oJKLMUZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221623>

Document that the "no-" prefix can also be used for non-boolean
options.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-parse-options.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 32ddc1c..2ff368e 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -41,6 +41,8 @@ The parse-options API allows:
 * Boolean long options can be 'negated' (or 'unset') by prepending
   `no-`, e.g. `--no-abbrev` instead of `--abbrev`. Conversely,
   options that begin with `no-` can be 'negated' by removing it.
+  Other long options can be unset (e.g., set string to NULL, set
+  integer to 0) by prepending `no-`.
 
 * Options and non-option arguments can clearly be separated using the `--`
   option, e.g. `-a -b --option -- --this-is-a-file` indicates that
-- 
1.8.2.1
