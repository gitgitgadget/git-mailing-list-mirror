From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 17/21] Misc. documentation fixes to Base64 utility
Date: Sun, 29 Jun 2008 03:59:27 -0400
Message-ID: <1214726371-93520-18-git-send-email-spearce@spearce.org>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org>
 <1214726371-93520-2-git-send-email-spearce@spearce.org>
 <1214726371-93520-3-git-send-email-spearce@spearce.org>
 <1214726371-93520-4-git-send-email-spearce@spearce.org>
 <1214726371-93520-5-git-send-email-spearce@spearce.org>
 <1214726371-93520-6-git-send-email-spearce@spearce.org>
 <1214726371-93520-7-git-send-email-spearce@spearce.org>
 <1214726371-93520-8-git-send-email-spearce@spearce.org>
 <1214726371-93520-9-git-send-email-spearce@spearce.org>
 <1214726371-93520-10-git-send-email-spearce@spearce.org>
 <1214726371-93520-11-git-send-email-spearce@spearce.org>
 <1214726371-93520-12-git-send-email-spearce@spearce.org>
 <1214726371-93520-13-git-send-email-spearce@spearce.org>
 <1214726371-93520-14-git-send-email-spearce@spearce.org>
 <1214726371-93520-15-git-send-email-spearce@spearce.org>
 <1214726371-93520-16-git-send-email-spearce@spearce.org>
 <1214726371-93520-17-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:02:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrrs-0000I1-OS
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbYF2IBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbYF2IBO
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:01:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36848 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbYF2IAd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:00:33 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrpj-0004PK-OI; Sun, 29 Jun 2008 04:00:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 4734920FBC9; Sun, 29 Jun 2008 04:00:28 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 9C4BC20FBDB;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-17-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86772>

These fixes silence warnings in the utility which are triggered
by our (rather pedantic) Eclipse compiler settings.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/util/Base64.java          |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/Base64.java b/org.spearce.jgit/src/org/spearce/jgit/util/Base64.java
index b0c19b6..9254bd0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/Base64.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/Base64.java
@@ -378,6 +378,7 @@ public class Base64
      * Does not GZip-compress data.
      *
      * @param source The data to convert
+     * @return encoded base64 representation of source.
      * @since 1.4
      */
     public static String encodeBytes( byte[] source )
@@ -403,6 +404,7 @@ public class Base64
      *
      * @param source The data to convert
      * @param options Specified options
+     * @return encoded base64 representation of source.
      * @see Base64#GZIP
      * @see Base64#DONT_BREAK_LINES
      * @since 2.0
@@ -420,6 +422,7 @@ public class Base64
      * @param source The data to convert
      * @param off Offset in array where conversion should begin
      * @param len Length of data to convert
+     * @return encoded base64 representation of source.
      * @since 1.4
      */
     public static String encodeBytes( byte[] source, int off, int len )
@@ -447,6 +450,7 @@ public class Base64
      * @param off Offset in array where conversion should begin
      * @param len Length of data to convert
      * @param options Specified options
+     * @return encoded base64 representation of source.
      * @see Base64#GZIP
      * @see Base64#DONT_BREAK_LINES
      * @since 2.0
@@ -729,7 +733,7 @@ public class Base64
         if( bytes != null && bytes.length >= 4 )
         {
             
-            int head = ((int)bytes[0] & 0xff) | ((bytes[1] << 8) & 0xff00);       
+            int head = (bytes[0] & 0xff) | ((bytes[1] << 8) & 0xff00);       
             if( java.util.zip.GZIPInputStream.GZIP_MAGIC == head ) 
             {
                 java.io.ByteArrayInputStream  bais = null;
@@ -1386,6 +1390,7 @@ public class Base64
         /**
          * Method added by PHIL. [Thanks, PHIL. -Rob]
          * This pads the buffer without closing the stream.
+         * @throws java.io.IOException input was not properly padded.
          */
         public void flushBase64() throws java.io.IOException 
         {
@@ -1430,6 +1435,7 @@ public class Base64
          * May be helpful if you need to embed a piece of
          * base640-encoded data in a stream.
          *
+         * @throws java.io.IOException input was not properly padded.
          * @since 1.5.1
          */
         public void suspendEncoding() throws java.io.IOException 
-- 
1.5.6.74.g8a5e
