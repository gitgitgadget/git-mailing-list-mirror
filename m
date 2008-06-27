From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 22/23] Add new handy constructors to TransportException, PackProtocolException
Date: Sat, 28 Jun 2008 00:06:46 +0200
Message-ID: <1214604407-30572-23-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-4-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-5-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-6-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-7-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-8-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-9-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-10-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-11-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-12-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-13-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-14-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-15-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-16-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-17-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-18-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-19-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-20-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-21-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-22-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:10:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM9A-0001Lw-Ap
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762717AbYF0WIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761172AbYF0WIk
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:08:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:36995 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763192AbYF0WIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:08:36 -0400
Received: by nf-out-0910.google.com with SMTP id d3so182348nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qOuied1yNCt7T/1bNb/m3z64uhAdIpp/O/lw3ZvV54s=;
        b=tGpP1OczGmtp/jVN3T37ADoN8zmVqQ8MeqrusFGOtHrsBN5ZL3I8sLLP1uQqEF5/3e
         jPSCQIugJ825OJok+y5vYgsmoqtVM45prEeFmgpkeycUi2KbyA8HBlLkNhbwOI3u56eh
         KWREUWSJIs4KQcMUglYxrX3RESLeavJ2l5w+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rHGG9sat0FILcJEL7Kxwmr2RLv2lQnGWVPT0DwmQc/qbBoL24feJPs9CjYiX5lbHP7
         iunMcmdpgzPLLxY8COY1zNyug05Ac5I3U8BNaWSiXRudpIBgTsc81Zg8R219CxnRlV1J
         sZDKrB6GYn/Pd+x/f0hy/70BlOKcICVSb1OVw=
Received: by 10.210.87.14 with SMTP id k14mr1611763ebb.60.1214604514977;
        Fri, 27 Jun 2008 15:08:34 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id z40sm2449519ikz.7.2008.06.27.15.08.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:08:33 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-22-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86660>

Constructor takes additionally URI argument, to add prefix: uri + ": "
before real message. Now we don't have to remember about ugly (uri + ":
") prefix in each thrown message;

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../spearce/jgit/errors/PackProtocolException.java |   30 +++++++++++++++++++
 .../spearce/jgit/errors/TransportException.java    |   31 ++++++++++++++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/PackProtocolException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/PackProtocolException.java
index 525496a..7b5b4f6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/errors/PackProtocolException.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/PackProtocolException.java
@@ -38,6 +38,7 @@
 
 package org.spearce.jgit.errors;
 
+import org.spearce.jgit.transport.URIish;
 
 /**
  * Indicates a protocol error has occurred while fetching/pushing objects.
@@ -46,6 +47,35 @@ public class PackProtocolException extends TransportException {
 	private static final long serialVersionUID = 1L;
 
 	/**
+	 * Constructs an PackProtocolException with the specified detail message
+	 * prefixed with provided URI.
+	 * 
+	 * @param uri
+	 *            URI used for transport
+	 * @param s
+	 *            message
+	 */
+	public PackProtocolException(final URIish uri, final String s) {
+		super(uri + ": " + s);
+	}
+
+	/**
+	 * Constructs an PackProtocolException with the specified detail message
+	 * prefixed with provided URI.
+	 * 
+	 * @param uri
+	 *            URI used for transport
+	 * @param s
+	 *            message
+	 * @param cause
+	 *            root cause exception
+	 */
+	public PackProtocolException(final URIish uri, final String s,
+			final Throwable cause) {
+		this(uri + ": " + s, cause);
+	}
+
+	/**
 	 * Constructs an PackProtocolException with the specified detail message.
 	 * 
 	 * @param s
diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/TransportException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/TransportException.java
index 7b378db..13c7a28 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/errors/TransportException.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/TransportException.java
@@ -40,6 +40,8 @@ package org.spearce.jgit.errors;
 
 import java.io.IOException;
 
+import org.spearce.jgit.transport.URIish;
+
 /**
  * Indicates a protocol error has occurred while fetching/pushing objects.
  */
@@ -47,6 +49,35 @@ public class TransportException extends IOException {
 	private static final long serialVersionUID = 1L;
 
 	/**
+	 * Constructs an TransportException with the specified detail message
+	 * prefixed with provided URI.
+	 * 
+	 * @param uri
+	 *            URI used for transport
+	 * @param s
+	 *            message
+	 */
+	public TransportException(final URIish uri, final String s) {
+		super(uri + ": " + s);
+	}
+
+	/**
+	 * Constructs an TransportException with the specified detail message
+	 * prefixed with provided URI.
+	 * 
+	 * @param uri
+	 *            URI used for transport
+	 * @param s
+	 *            message
+	 * @param cause
+	 *            root cause exception
+	 */
+	public TransportException(final URIish uri, final String s,
+			final Throwable cause) {
+		this(uri + ": " + s, cause);
+	}
+
+	/**
 	 * Constructs an TransportException with the specified detail message.
 	 * 
 	 * @param s
-- 
1.5.5.3
