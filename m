From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 8/8] t5100: use ancient encoding syntax for backwards compatibility
Date: Mon, 18 May 2009 18:44:45 -0500
Message-ID: <KfeKNR3Jm6YKvPIcYGBMpDtcOdL_JQMWwSHWkmiNf_gpkqZ0z2Gj3DhR4xNob0vpb5MbKv1cOns@cipher.nrlssc.navy.mil>
References: <KfeKNR3Jm6YKvPIcYGBMpCbbOxxIaBRphS4qzgN2W9mXIvp7Hl8SgBQzbAhZRV4A4Q6X14JTLR4@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpKjNOsMcmMNMJ1vr-EBr-eE371H-Rg69NOM1rMB2Oa5nCGVe2SMGKdc@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpLkRr97IFN82BZR2bJNHFQYwhjGgwGRoIAkKO5m1EZb7M9epcX8P-fk@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpEj60b9ww0Dv2XSyNy2qLE-KEaaF8D8q9OHVC3tPAPSzNe1CJUXJDfA@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpGlk83sgTnCuuc7WdvYgBn_Ja9b0yZjdlJxTSSCaDWC05irzAQVk1uM@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpPhpa6XnDlrUaNKPjrH6NYGZK9NzwH2STGreDnkCUEwiMxu0BD6uSgk@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpKMgDQvtEffFhDQ5lsZU861rwPvLMbXRKufUbP1Cj7yuYKrGcvxDsnU@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpD_AmxNUeXbQUOa7RCzy3RyTmaiqpcJHJcp9eR8w363qcg0oZzieLd0@ciph
 er.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 01:45:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6CWm-0003iT-SE
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 01:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbZERXpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 19:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbZERXpP
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 19:45:15 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50122 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbZERXpB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 19:45:01 -0400
Received: by mail.nrlssc.navy.mil id n4INitKY024906; Mon, 18 May 2009 18:45:00 -0500
In-Reply-To: <KfeKNR3Jm6YKvPIcYGBMpD_AmxNUeXbQUOa7RCzy3RyTmaiqpcJHJcp9eR8w363qcg0oZzieLd0@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 May 2009 23:44:56.0183 (UTC) FILETIME=[A5F13870:01C9D812]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119479>

Some ancient platforms do not have an extensive list of alternate names for
character encodings.  For example, Solaris 7 does not know that ISO-8859-1
is the same as ISO8859-1.  Modern platforms do know this, so use the older
names.

The following conversions were performed:

    ISO-8859-1 --> ISO8859-1
    ISO-8859-2 --> ISO8859-2
    ISO-8859-8 --> ISO8859-8
    iso-2022-jp --> ISO-2022-JP

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t5100/rfc2047-samples.mbox |   32 ++++++++++++++++----------------
 t/t5100/sample.mbox          |    8 ++++----
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/t/t5100/rfc2047-samples.mbox b/t/t5100/rfc2047-samples.mbox
index 3ca2470..1fc2248 100644
--- a/t/t5100/rfc2047-samples.mbox
+++ b/t/t5100/rfc2047-samples.mbox
@@ -1,48 +1,48 @@
 From nobody Mon Sep 17 00:00:00 2001
 From: =?US-ASCII?Q?Keith_Moore?= <moore@cs.utk.edu>
-To: =?ISO-8859-1?Q?Keld_J=F8rn_Simonsen?= <keld@dkuug.dk>
-CC: =?ISO-8859-1?Q?Andr=E9?= Pirard <PIRARD@vm1.ulg.ac.be>
-Subject: =?ISO-8859-1?B?SWYgeW91IGNhbiByZWFkIHRoaXMgeW8=?=
- =?ISO-8859-2?B?dSB1bmRlcnN0YW5kIHRoZSBleGFtcGxlLg==?=
+To: =?ISO8859-1?Q?Keld_J=F8rn_Simonsen?= <keld@dkuug.dk>
+CC: =?ISO8859-1?Q?Andr=E9?= Pirard <PIRARD@vm1.ulg.ac.be>
+Subject: =?ISO8859-1?B?SWYgeW91IGNhbiByZWFkIHRoaXMgeW8=?=
+ =?ISO8859-2?B?dSB1bmRlcnN0YW5kIHRoZSBleGFtcGxlLg==?=
 
 From nobody Mon Sep 17 00:00:00 2001
-From: =?ISO-8859-1?Q?Olle_J=E4rnefors?= <ojarnef@admin.kth.se>
+From: =?ISO8859-1?Q?Olle_J=E4rnefors?= <ojarnef@admin.kth.se>
 To: ietf-822@dimacs.rutgers.edu, ojarnef@admin.kth.se
 Subject: Time for ISO 10646?
 
 From nobody Mon Sep 17 00:00:00 2001
 To: Dave Crocker <dcrocker@mordor.stanford.edu>
 Cc: ietf-822@dimacs.rutgers.edu, paf@comsol.se
-From: =?ISO-8859-1?Q?Patrik_F=E4ltstr=F6m?= <paf@nada.kth.se>
+From: =?ISO8859-1?Q?Patrik_F=E4ltstr=F6m?= <paf@nada.kth.se>
 Subject: Re: RFC-HDR care and feeding
 
 From nobody Mon Sep 17 00:00:00 2001
 From: Nathaniel Borenstein <nsb@thumper.bellcore.com>
-      (=?iso-8859-8?b?7eXs+SDv4SDp7Oj08A==?=)
+      (=?ISO8859-8?b?7eXs+SDv4SDp7Oj08A==?=)
 To: Greg Vaudreuil <gvaudre@NRI.Reston.VA.US>, Ned Freed
    <ned@innosoft.com>, Keith Moore <moore@cs.utk.edu>
 Subject: Test of new header generator
 MIME-Version: 1.0
-Content-type: text/plain; charset=ISO-8859-1
+Content-type: text/plain; charset=ISO8859-1
 
 From nobody Mon Sep 17 00:00:00 2001
-Subject: (=?ISO-8859-1?Q?a?=)
+Subject: (=?ISO8859-1?Q?a?=)
 
 From nobody Mon Sep 17 00:00:00 2001
-Subject: (=?ISO-8859-1?Q?a?= b)
+Subject: (=?ISO8859-1?Q?a?= b)
 
 From nobody Mon Sep 17 00:00:00 2001
-Subject: (=?ISO-8859-1?Q?a?= =?ISO-8859-1?Q?b?=)
+Subject: (=?ISO8859-1?Q?a?= =?ISO8859-1?Q?b?=)
 
 From nobody Mon Sep 17 00:00:00 2001
-Subject: (=?ISO-8859-1?Q?a?=  =?ISO-8859-1?Q?b?=)
+Subject: (=?ISO8859-1?Q?a?=  =?ISO8859-1?Q?b?=)
 
 From nobody Mon Sep 17 00:00:00 2001
-Subject: (=?ISO-8859-1?Q?a?=
-    =?ISO-8859-1?Q?b?=)
+Subject: (=?ISO8859-1?Q?a?=
+    =?ISO8859-1?Q?b?=)
 
 From nobody Mon Sep 17 00:00:00 2001
-Subject: (=?ISO-8859-1?Q?a_b?=)
+Subject: (=?ISO8859-1?Q?a_b?=)
 
 From nobody Mon Sep 17 00:00:00 2001
-Subject: (=?ISO-8859-1?Q?a?= =?ISO-8859-2?Q?_b?=)
+Subject: (=?ISO8859-1?Q?a?= =?ISO8859-2?Q?_b?=)
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index c5ad206..c3074ac 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -99,7 +99,7 @@ index 9123cdc..918dcf8 100644
 From nobody Sat Aug 27 23:07:49 2005
 Path: news.gmane.org!not-for-mail
 Message-ID: <20050721.091036.01119516.yoshfuji@linux-ipv6.org>
-From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
+From: YOSHIFUJI Hideaki / =?ISO-2022-JP?B?GyRCNUhGIzFRTEAbKEI=?= 
 	<yoshfuji@linux-ipv6.org>
 Newsgroups: gmane.comp.version-control.git
 Subject: [PATCH 1/2] GIT: Try all addresses for given remote name
@@ -218,7 +218,7 @@ GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
 From nobody Sat Aug 27 23:07:49 2005
 Path: news.gmane.org!not-for-mail
 Message-ID: <u5tacjjdpxq.fsf@lysator.liu.se>
-From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
+From: =?ISO8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
 Newsgroups: gmane.comp.version-control.git
 Subject: [PATCH] Fixed two bugs in git-cvsimport-script.
 Date: Mon, 15 Aug 2005 20:18:25 +0200
@@ -226,7 +226,7 @@ Lines: 83
 Approved: news@gmane.org
 NNTP-Posting-Host: main.gmane.org
 Mime-Version: 1.0
-Content-Type: text/plain; charset=iso-8859-1
+Content-Type: text/plain; charset=ISO8859-1
 Content-Transfer-Encoding: QUOTED-PRINTABLE
 X-Trace: sea.gmane.org 1124130247 31839 80.91.229.2 (15 Aug 2005 18:24:07 GMT)
 X-Complaints-To: usenet@sea.gmane.org
@@ -476,7 +476,7 @@ MIME-Version: 1.0
 Content-Type: multipart/mixed; boundary="=-=-="
 
 --=-=-=
-Content-Type: text/plain; charset=iso-8859-15
+Content-Type: text/plain; charset=ISO8859-15
 Content-Transfer-Encoding: quoted-printable
 
 Here comes a commit log message, and
-- 
1.6.3.1.24.g152f4
