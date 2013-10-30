From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/23] api-remote.txt: correct section "struct refspec"
Date: Wed, 30 Oct 2013 06:32:53 +0100
Message-ID: <1383111192-23780-5-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:34:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOQ2-0005oe-Uo
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab3J3FeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:34:04 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60304 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752365Ab3J3FeB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:34:01 -0400
X-AuditID: 1207440f-b7f306d000006d99-b5-52709a48b3f4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 79.FF.28057.84A90725; Wed, 30 Oct 2013 01:34:00 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIF014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:33:58 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqOsxqyDI4PVLCYvpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE7o32FV8Et/oq5+/czNjB+5Oli5OSQEDCRmDHvADOELSZx4d56ti5GLg4hgcuMEu07FjND
	OFeYJFa2LGcCqWIT0JVY1NMMZosIqElMbDvEAlLELDCRWeL49EUsIAlhAS+JpV8fsHcxcnCw
	CKhKzFhvCRLmFXCR6GmZzASxTUHiRvNUVhCbU8BV4tOum+wgthBQTVP7Z/YJjLwLGBlWMcol
	5pTm6uYmZuYUpybrFicn5uWlFuma6OVmluilppRuYoQELf8Oxq71MocYBTgYlXh4DR7kBwmx
	JpYVV+YeYpTkYFIS5U2bUhAkxJeUn1KZkVicEV9UmpNafIhRgoNZSYR3+nGgct6UxMqq1KJ8
	mJQ0B4uSOK/6EnU/IYH0xJLU7NTUgtQimKwMB4eSBK/yTKChgkWp6akVaZk5JQhpJg5OEMEF
	soEHaAMPSCFvcUFibnFmOkTRKUZFKXFeBZCEAEgiozQPbgAsvbxiFAf6RxiinQeYmuC6XwEN
	ZgIavIclD2RwSSJCSqqBsVBhgeOlnvrlz30lX+ZWi+rPFd87+12F5pL5f3R15Hc9jk/Y91Fq
	3mmpyb8DeH25RXZzXk+cqqNYuFH2/rptArvDlJT4jbMk30iUnGudlRL0dvbSguCK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236959>

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
1.8.4.1
