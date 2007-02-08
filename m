From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Correct some language in fast-import documentation.
Date: Thu, 8 Feb 2007 02:58:51 -0500
Message-ID: <20070208075851.GB3950@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 08 08:59:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF4BI-0006GP-CR
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 08:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161527AbXBHH64 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 8 Feb 2007 02:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161534AbXBHH64
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 02:58:56 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60206 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161527AbXBHH6z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Feb 2007 02:58:55 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HF4BA-0008FU-9J; Thu, 08 Feb 2007 02:58:52 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AE38620FBAE; Thu,  8 Feb 2007 02:58:51 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39040>

Minor documentation improvements, as suggested on the Git mailing
list by Horst H. von Brand and Karl Hasselstr=C3=B6m.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-fast-import.txt |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast=
-import.txt
index 0c44761..01f4c8a 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -181,7 +181,7 @@ If the local offset is not available in the source =
material, use
 ``+0000'', or the most common local offset.  For example many
 organizations have a CVS repository which has only ever been accessed
 by users who are located in the same location and timezone.  In this
-case the offset from UTC can be easily assumed.
+case a reasonable offset from UTC could be assumed.
 +
 Unlike the `rfc2822` format, this format is very strict.  Any
 variation in formatting will cause gfi to reject the value.
@@ -190,7 +190,7 @@ variation in formatting will cause gfi to reject th=
e value.
 	This is the standard email format as described by RFC 2822.
 +
 An example value is ``Tue Feb 6 11:22:18 2007 -0500''.  The Git
-parser is accurate, but a little on the lenient side.  Its the
+parser is accurate, but a little on the lenient side.  It is the
 same parser used by gitlink:git-am[1] when applying patches
 received from email.
 +
@@ -205,14 +205,15 @@ contained in an RFC 2822 date string is used to a=
djust the date
 value to UTC prior to storage.  Therefore it is important that
 this information be as accurate as possible.
 +
-If the source material is formatted in RFC 2822 style dates,
+If the source material uses RFC 2822 style dates,
 the frontend should let gfi handle the parsing and conversion
 (rather than attempting to do it itself) as the Git parser has
 been well tested in the wild.
 +
 Frontends should prefer the `raw` format if the source material
-is already in UNIX-epoch format, or is easily convertible to
-that format, as there is no ambiguity in parsing.
+already uses UNIX-epoch format, can be coaxed to give dates in that
+format, or its format is easiliy convertible to it, as there is no
+ambiguity in parsing.
=20
 `now`::
 	Always use the current time and timezone.  The literal
--=20
1.5.0.rc3.175.g6506
