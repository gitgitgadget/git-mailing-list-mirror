From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] doc: 'git status' quote the zero (NUL) character
Date: Tue, 21 Oct 2014 23:09:50 +0100
Message-ID: <1413929390-1624-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 22 00:09:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xghca-00025O-Dv
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 00:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933454AbaJUWJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 18:09:37 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:33598 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933014AbaJUWJg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Oct 2014 18:09:36 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlEeAGjYRlRZ8YBmPGdsb2JhbABcgw0BAYEqgjaFB4F3s2mPVIdWBAKBFBcBAQUBAQEBODuEMC8jGIECChoTiEPHGpBXhFIFmQucO4IyPC+CSwEBAQ
X-IPAS-Result: AlEeAGjYRlRZ8YBmPGdsb2JhbABcgw0BAYEqgjaFB4F3s2mPVIdWBAKBFBcBAQUBAQEBODuEMC8jGIECChoTiEPHGpBXhFIFmQucO4IyPC+CSwEBAQ
X-IronPort-AV: E=Sophos;i="5.04,764,1406588400"; 
   d="scan'208";a="474596071"
Received: from host-89-241-128-102.as13285.net (HELO localhost) ([89.241.128.102])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 21 Oct 2014 23:09:31 +0100
X-Mailer: git-send-email 1.9.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Newer web rendering of 'git status --help --web' shows the zero in
"NUL (ASCII 0)" as if it is a small 'o' character. Back-tick quote the
zero to ensure it is displayed as a full size mono-spaced font. Also
display the "double quote (ASCII 34)" in the same manner.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/git-status.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 4d8d530..24390d6 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -122,7 +122,7 @@ status code.
 The fields (including the `->`) are separated from each other by a
 single space. If a filename contains whitespace or other nonprintable
 characters, that field will be quoted in the manner of a C string
-literal: surrounded by ASCII double quote (34) characters, and with
+literal: surrounded by double quote (ASCII `34`) characters, and with
 interior special characters backslash-escaped.
 
 For paths with merge conflicts, `X` and `Y` show the modification
@@ -189,7 +189,7 @@ There is also an alternate -z format recommended for machine parsing. In
 that format, the status field is the same, but some other things
 change.  First, the '\->' is omitted from rename entries and the field
 order is reversed (e.g 'from \-> to' becomes 'to from'). Second, a NUL
-(ASCII 0) follows each filename, replacing space as a field separator
+(ASCII `0`) follows each filename, replacing space as a field separator
 and the terminating newline (but a space still separates the status
 field from the first filename).  Third, filenames containing special
 characters are not specially formatted; no quoting or
-- 
1.9.4.msysgit.0
