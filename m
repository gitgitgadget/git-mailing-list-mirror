From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 20/23] Push command line utility
Date: Sat, 28 Jun 2008 00:06:44 +0200
Message-ID: <1214604407-30572-21-git-send-email-marek.zawirski@gmail.com>
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
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:10:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM98-0001Lw-7T
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763300AbYF0WIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762970AbYF0WIe
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:08:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:36995 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762838AbYF0WI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:08:27 -0400
Received: by nf-out-0910.google.com with SMTP id d3so182348nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=mnz3A+0tnKO2C6Zl5m8UF4le21FUUomCH6ebF+XiQpQ=;
        b=iwdAFalpNOFwRP0qZToim8aQ96SZw+PSf/vhdtF2lYL6J394g0m8v116ZUp8gSIIa4
         0SbquZguhGFTMclP90SpRBpRsVODy39cfBbbrOHB6eWF6zlpU2tiz49Z8Ys3YU6lKzqI
         BwVugX0BSOFft9ZodSe5oXDXRniw7H9iHoCuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QSsOWTPXQxwJGCH50Rn6QeXObnwW/qRQQyKdLg2glCbnAzyKC34As59WMhyisha5GM
         z7cFJqDJMb4eLdCPDzbr776mtrTZM8TD+4S7MeOv3KrITKGVHKAFv/BysFSM/waCZMlo
         bWZ8vTxLFJb3BaYT5tTmW1D1/dWEtf7ZAbnWM=
Received: by 10.210.87.19 with SMTP id k19mr1579040ebb.176.1214604506115;
        Fri, 27 Jun 2008 15:08:26 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id z37sm2449618ikz.6.2008.06.27.15.08.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:08:24 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-20-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86659>

pgm.Push class providing command line push utility, similar to C Git
one.

Some shared abbreviating methods for both Fetch and Push are moved to
TextBuiltin.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/pgm/Fetch.java            |   36 +---
 .../src/org/spearce/jgit/pgm/Push.java             |  235 ++++++++++++++++++++
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |   21 ++
 3 files changed, 262 insertions(+), 30 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java
index 3a81575..c9c997e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java
@@ -40,8 +40,6 @@ package org.spearce.jgit.pgm;
 import java.util.ArrayList;
 import java.util.List;
 
-import org.spearce.jgit.lib.Constants;
-import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.lib.TextProgressMonitor;
 import org.spearce.jgit.transport.FetchResult;
@@ -50,12 +48,6 @@ import org.spearce.jgit.transport.TrackingRefUpdate;
 import org.spearce.jgit.transport.Transport;
 
 class Fetch extends TextBuiltin {
-	private static final String REFS_HEADS = Constants.HEADS_PREFIX + "/";
-
-	private static final String REFS_REMOTES = Constants.REMOTES_PREFIX + "/";
-
-	private static final String REFS_TAGS = Constants.TAGS_PREFIX + "/";
-
 	@Override
 	void execute(String[] args) throws Exception {
 		int argi = 0;
@@ -84,20 +76,8 @@ class Fetch extends TextBuiltin {
 		for (final TrackingRefUpdate u : r.getTrackingRefUpdates()) {
 			final char type = shortTypeOf(u.getResult());
 			final String longType = longTypeOf(u);
-
-			String src = u.getRemoteName();
-			if (src.startsWith(REFS_HEADS))
-				src = src.substring(REFS_HEADS.length());
-			else if (src.startsWith(REFS_TAGS))
-				src = src.substring(REFS_TAGS.length());
-
-			String dst = u.getLocalName();
-			if (dst.startsWith(REFS_HEADS))
-				dst = dst.substring(REFS_HEADS.length());
-			else if (dst.startsWith(REFS_TAGS))
-				dst = dst.substring(REFS_TAGS.length());
-			else if (dst.startsWith(REFS_REMOTES))
-				dst = dst.substring(REFS_REMOTES.length());
+			final String src = abbreviateRef(u.getRemoteName(), false);
+			final String dst = abbreviateRef(u.getLocalName(), true);
 
 			out.format(" %c %-17s %-10s -> %s", type, longType, src, dst);
 			out.println();
@@ -121,14 +101,14 @@ class Fetch extends TextBuiltin {
 		}
 
 		if (r == RefUpdate.Result.FORCED) {
-			final String aOld = abbreviate(u.getOldObjectId());
-			final String aNew = abbreviate(u.getNewObjectId());
+			final String aOld = abbreviateObject(u.getOldObjectId());
+			final String aNew = abbreviateObject(u.getNewObjectId());
 			return aOld + "..." + aNew;
 		}
 
 		if (r == RefUpdate.Result.FAST_FORWARD) {
-			final String aOld = abbreviate(u.getOldObjectId());
-			final String aNew = abbreviate(u.getNewObjectId());
+			final String aOld = abbreviateObject(u.getOldObjectId());
+			final String aNew = abbreviateObject(u.getNewObjectId());
 			return aOld + ".." + aNew;
 		}
 
@@ -139,10 +119,6 @@ class Fetch extends TextBuiltin {
 		return "[" + r.name() + "]";
 	}
 
-	private static String abbreviate(final ObjectId id) {
-		return id.toString().substring(0, 7);
-	}
-
 	private static char shortTypeOf(final RefUpdate.Result r) {
 		if (r == RefUpdate.Result.LOCK_FAILURE)
 			return '!';
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java
new file mode 100644
index 0000000..4130bc9
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java
@@ -0,0 +1,235 @@
+/*
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.pgm;
+
+import java.util.Collection;
+import java.util.LinkedList;
+
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.TextProgressMonitor;
+import org.spearce.jgit.transport.PushResult;
+import org.spearce.jgit.transport.RefSpec;
+import org.spearce.jgit.transport.RemoteRefUpdate;
+import org.spearce.jgit.transport.Transport;
+import org.spearce.jgit.transport.RemoteRefUpdate.Status;
+
+class Push extends TextBuiltin {
+
+	private boolean verbose = false;
+
+	private Transport transport;
+
+	private boolean first = true;
+
+	@Override
+	void execute(String[] args) throws Exception {
+		final LinkedList<RefSpec> refSpecs = new LinkedList<RefSpec>();
+		Boolean thin = null;
+		String exec = null;
+		boolean forceAll = false;
+
+		int argi = 0;
+		for (; argi < args.length; argi++) {
+			final String a = args[argi];
+			if ("--thin".equals(a))
+				thin = true;
+			else if ("--no-thin".equals(a))
+				thin = false;
+			else if ("-f".equals(a) || "--force".equals(a))
+				forceAll = true;
+			else if (a.startsWith("--exec="))
+				exec = a.substring("--exec=".length());
+			else if (a.startsWith("--receive-pack="))
+				exec = a.substring("--receive-pack=".length());
+			else if ("--tags".equals(a))
+				refSpecs.add(Transport.REFSPEC_TAGS);
+			else if ("--all".equals(a))
+				refSpecs.add(Transport.REFSPEC_PUSH_ALL);
+			else if ("-v".equals(a))
+				verbose = true;
+			else if ("--".equals(a)) {
+				argi++;
+				break;
+			} else if (a.startsWith("-"))
+				die("usage: push [--all] [--tags] [--force] [--thin]\n"
+						+ "[--receive-pack=<git-receive-pack>] [<repository> [<refspec>]...]");
+			else
+				break;
+		}
+
+		final String repository;
+		if (argi == args.length)
+			repository = "origin";
+		else
+			repository = args[argi++];
+		transport = Transport.open(db, repository);
+		if (thin != null)
+			transport.setPushThin(thin);
+		if (exec != null)
+			transport.setOptionReceivePack(exec);
+
+		for (; argi < args.length; argi++) {
+			final RefSpec spec = new RefSpec(args[argi]);
+			if (forceAll)
+				spec.setForceUpdate(true);
+			refSpecs.add(spec);
+		}
+		final Collection<RemoteRefUpdate> toPush = transport
+				.findRemoteRefUpdatesFor(refSpecs);
+
+		final PushResult result = transport.push(new TextProgressMonitor(),
+				toPush);
+		printPushResult(result);
+	}
+
+	private void printPushResult(final PushResult result) {
+		boolean everythingUpToDate = true;
+		// at first, print up-to-date ones...
+		for (final RemoteRefUpdate rru : result.getRemoteUpdates()) {
+			if (rru.getStatus() == Status.UP_TO_DATE) {
+				if (verbose)
+					printRefUpdateResult(result, rru);
+			} else
+				everythingUpToDate = false;
+		}
+
+		for (final RemoteRefUpdate rru : result.getRemoteUpdates()) {
+			// ...then successful updates...
+			if (rru.getStatus() == Status.OK)
+				printRefUpdateResult(result, rru);
+		}
+
+		for (final RemoteRefUpdate rru : result.getRemoteUpdates()) {
+			// ...finally, others (problematic)
+			if (rru.getStatus() != Status.OK
+					&& rru.getStatus() != Status.UP_TO_DATE)
+				printRefUpdateResult(result, rru);
+		}
+
+		if (everythingUpToDate)
+			out.println("Everything up-to-date");
+	}
+
+	private void printRefUpdateResult(final PushResult result,
+			final RemoteRefUpdate rru) {
+		if (first) {
+			first = false;
+			out.format("To %s\n", transport.getURI());
+		}
+
+		final String remoteName = rru.getRemoteName();
+		final String srcRef = rru.isDelete() ? null : rru.getSrcRef();
+
+		switch (rru.getStatus()) {
+		case OK:
+			if (rru.isDelete())
+				printUpdateLine('-', "[deleted]", null, remoteName, null);
+			else {
+				final Ref oldRef = result.getAdvertisedRef(remoteName);
+				if (oldRef == null) {
+					final String summary;
+					if (remoteName.startsWith(REFS_TAGS))
+						summary = "[new tag]";
+					else
+						summary = "[new branch]";
+					printUpdateLine('*', summary, srcRef, remoteName, null);
+				} else {
+					boolean fastForward = rru.isFastForward();
+					final char flag = fastForward ? ' ' : '+';
+					final String summary = abbreviateObject(oldRef
+							.getObjectId())
+							+ (fastForward ? ".." : "...")
+							+ abbreviateObject(rru.getNewObjectId());
+					final String message = fastForward ? null : "forced update";
+					printUpdateLine(flag, summary, srcRef, remoteName, message);
+				}
+			}
+			break;
+
+		case NON_EXISTING:
+			printUpdateLine('X', "[no match]", null, remoteName, null);
+			break;
+
+		case REJECTED_NODELETE:
+			printUpdateLine('!', "[rejected]", null, remoteName,
+					"remote side does not support deleting refs");
+			break;
+
+		case REJECTED_NONFASTFORWARD:
+			printUpdateLine('!', "[rejected]", srcRef, remoteName,
+					"non-fast forward");
+			break;
+
+		case REJECTED_REMOTE_CHANGED:
+			final String message = "remote ref object changed - is not expected one "
+					+ abbreviateObject(rru.getExpectedOldObjectId());
+			printUpdateLine('!', "[rejected]", srcRef, remoteName, message);
+			break;
+
+		case REJECTED_OTHER_REASON:
+			printUpdateLine('!', "[remote rejected]", srcRef, remoteName, rru
+					.getMessage());
+			break;
+
+		case UP_TO_DATE:
+			if (verbose)
+				printUpdateLine('=', "[up to date]", srcRef, remoteName, null);
+			break;
+
+		case NOT_ATTEMPTED:
+		case AWAITING_REPORT:
+			printUpdateLine('?', "[unexpected push-process behavior]", srcRef,
+					remoteName, rru.getMessage());
+			break;
+		}
+	}
+
+	private void printUpdateLine(final char flag, final String summary,
+			final String srcRef, final String destRef, final String message) {
+		out.format(" %c %-17s", flag, summary);
+
+		if (srcRef != null)
+			out.format(" %s ->", abbreviateRef(srcRef, true));
+		out.format(" %s", abbreviateRef(destRef, true));
+
+		if (message != null)
+			out.format(" (%s)", message);
+
+		out.println();
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/TextBuiltin.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/TextBuiltin.java
index 163f795..b3d8f39 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/TextBuiltin.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/TextBuiltin.java
@@ -43,10 +43,17 @@ import java.io.IOException;
 import java.io.OutputStreamWriter;
 import java.io.PrintWriter;
 
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Repository;
 
 abstract class TextBuiltin {
+	protected static final String REFS_HEADS = Constants.HEADS_PREFIX + "/";
+
+	protected static final String REFS_REMOTES = Constants.REMOTES_PREFIX + "/";
+
+	protected static final String REFS_TAGS = Constants.TAGS_PREFIX + "/";
+
 	protected PrintWriter out;
 
 	protected Repository db;
@@ -72,4 +79,18 @@ abstract class TextBuiltin {
 	protected static Die die(final String why) {
 		return new Die(why);
 	}
+
+	protected static String abbreviateObject(final ObjectId id) {
+		return id.toString().substring(0, 7);
+	}
+
+	protected String abbreviateRef(String dst, boolean abbreviateRemote) {
+		if (dst.startsWith(REFS_HEADS))
+			dst = dst.substring(REFS_HEADS.length());
+		else if (dst.startsWith(REFS_TAGS))
+			dst = dst.substring(REFS_TAGS.length());
+		else if (abbreviateRemote && dst.startsWith(REFS_REMOTES))
+			dst = dst.substring(REFS_REMOTES.length());
+		return dst;
+	}
 }
-- 
1.5.5.3
