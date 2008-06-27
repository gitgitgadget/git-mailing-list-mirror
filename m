From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 17/23] Test cases for PushProcess
Date: Sat, 28 Jun 2008 00:06:41 +0200
Message-ID: <1214604407-30572-18-git-send-email-marek.zawirski@gmail.com>
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
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:10:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM96-0001Lw-9O
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762580AbYF0WIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762359AbYF0WIU
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:08:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:38733 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761334AbYF0WIN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:08:13 -0400
Received: by nf-out-0910.google.com with SMTP id d3so182445nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=D9YmmBzGZPQSXJYgZxAEwP52JVt3hPn6EmCtChMl5bM=;
        b=UvOsNW4qPYOb2Nx/fyLzdvtJUD/1/Sb+q1WPgJYGsXGB1tOxPi+R3IsRt/FHTHewHz
         F1q0Mo23C1RmaFDOm5ZS0D/pjYpbCcUyrqtdDg7HuVliRFJKCGzHI5hn9BhcA4R3w5+Y
         gcDAVxJGpg1tACdLlaOe479JfSo0o1lwdV1+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ecNWjD3yEfOHXYzQ7ygZ2Tr/KSz8OpSUMi/rSQTOjsh1xPHcSBP37JypKMxF2aikjF
         r/Wp3ozaDY4EU9P+bH3QBnXdsPQyyBbUC+R+CPX/JIyzIqo3f/IPo7pByiTRV9pAf6VL
         DxBx/evEYR52M/nT1KbAkmM2K7m7e2yAvRmYI=
Received: by 10.210.144.3 with SMTP id r3mr1585819ebd.148.1214604492591;
        Fri, 27 Jun 2008 15:08:12 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id b30sm2456104ika.3.2008.06.27.15.08.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:08:10 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-17-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86656>

Tests for push process with highly differentiated remote update cases,
that are possible in practice.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../spearce/jgit/transport/PushProcessTest.java    |  407 ++++++++++++++++++++
 1 files changed, 407 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java
new file mode 100644
index 0000000..f0cfe98
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java
@@ -0,0 +1,407 @@
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
+package org.spearce.jgit.transport;
+
+import java.io.IOException;
+import java.util.HashMap;
+import java.util.HashSet;
+import java.util.Map;
+
+import org.spearce.jgit.errors.NotSupportedException;
+import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ProgressMonitor;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RepositoryTestCase;
+import org.spearce.jgit.lib.TextProgressMonitor;
+import org.spearce.jgit.lib.RefUpdate.Result;
+import org.spearce.jgit.transport.RemoteRefUpdate.Status;
+
+public class PushProcessTest extends RepositoryTestCase {
+	private PushProcess process;
+
+	private MockTransport transport;
+
+	private HashSet<RemoteRefUpdate> refUpdates;
+
+	private HashSet<Ref> advertisedRefs;
+
+	private Status connectionUpdateStatus;
+
+	@Override
+	public void setUp() throws Exception {
+		super.setUp();
+		transport = new MockTransport(db, new URIish());
+		refUpdates = new HashSet<RemoteRefUpdate>();
+		advertisedRefs = new HashSet<Ref>();
+		connectionUpdateStatus = Status.OK;
+	}
+
+	/**
+	 * Test for fast-forward remote update.
+	 * 
+	 * @throws IOException
+	 */
+	public void testUpdateFastForward() throws IOException {
+		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
+				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
+				"refs/heads/master", false, null, null);
+		final Ref ref = new Ref("refs/heads/master", ObjectId
+				.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
+		testOneUpdateStatus(rru, ref, Status.OK, true);
+	}
+
+	/**
+	 * Test for non fast-forward remote update, when remote object is not known
+	 * to local repository.
+	 * 
+	 * @throws IOException
+	 */
+	public void testUpdateNonFastForwardUnknownObject() throws IOException {
+		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
+				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
+				"refs/heads/master", false, null, null);
+		final Ref ref = new Ref("refs/heads/master", ObjectId
+				.fromString("0000000000000000000000000000000000000001"));
+		testOneUpdateStatus(rru, ref, Status.REJECTED_NONFASTFORWARD, null);
+	}
+
+	/**
+	 * Test for non fast-forward remote update, when remote object is known to
+	 * local repository, but it is not an ancestor of new object.
+	 * 
+	 * @throws IOException
+	 */
+	public void testUpdateNonFastForward() throws IOException {
+		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
+				"ac7e7e44c1885efb472ad54a78327d66bfc4ecef",
+				"refs/heads/master", false, null, null);
+		final Ref ref = new Ref("refs/heads/master", ObjectId
+				.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
+		testOneUpdateStatus(rru, ref, Status.REJECTED_NONFASTFORWARD, null);
+	}
+
+	/**
+	 * Test for non fast-forward remote update, when force update flag is set.
+	 * 
+	 * @throws IOException
+	 */
+	public void testUpdateNonFastForwardForced() throws IOException {
+		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
+				"ac7e7e44c1885efb472ad54a78327d66bfc4ecef",
+				"refs/heads/master", true, null, null);
+		final Ref ref = new Ref("refs/heads/master", ObjectId
+				.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
+		testOneUpdateStatus(rru, ref, Status.OK, false);
+	}
+
+	/**
+	 * Test for remote ref creation.
+	 * 
+	 * @throws IOException
+	 */
+	public void testUpdateCreateRef() throws IOException {
+		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
+				"ac7e7e44c1885efb472ad54a78327d66bfc4ecef",
+				"refs/heads/master", false, null, null);
+		testOneUpdateStatus(rru, null, Status.OK, true);
+	}
+
+	/**
+	 * Test for remote ref deletion.
+	 * 
+	 * @throws IOException
+	 */
+	public void testUpdateDelete() throws IOException {
+		final RemoteRefUpdate rru = new RemoteRefUpdate(db, null,
+				"refs/heads/master", false, null, null);
+		final Ref ref = new Ref("refs/heads/master", ObjectId
+				.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
+		testOneUpdateStatus(rru, ref, Status.OK, true);
+	}
+
+	/**
+	 * Test for remote ref deletion (try), when that ref doesn't exist on remote
+	 * repo.
+	 * 
+	 * @throws IOException
+	 */
+	public void testUpdateDeleteNonExisting() throws IOException {
+		final RemoteRefUpdate rru = new RemoteRefUpdate(db, null,
+				"refs/heads/master", false, null, null);
+		testOneUpdateStatus(rru, null, Status.NON_EXISTING, null);
+	}
+
+	/**
+	 * Test for remote ref update, when it is already up to date.
+	 * 
+	 * @throws IOException
+	 */
+	public void testUpdateUpToDate() throws IOException {
+		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
+				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
+				"refs/heads/master", false, null, null);
+		final Ref ref = new Ref("refs/heads/master", ObjectId
+				.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
+		testOneUpdateStatus(rru, ref, Status.UP_TO_DATE, null);
+	}
+
+	/**
+	 * Test for remote ref update with expected remote object.
+	 * 
+	 * @throws IOException
+	 */
+	public void testUpdateExpectedRemote() throws IOException {
+		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
+				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
+				"refs/heads/master", false, null, ObjectId
+						.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
+		final Ref ref = new Ref("refs/heads/master", ObjectId
+				.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
+		testOneUpdateStatus(rru, ref, Status.OK, true);
+	}
+
+	/**
+	 * Test for remote ref update with expected old object set, when old object
+	 * is not that expected one.
+	 * 
+	 * @throws IOException
+	 */
+	public void testUpdateUnexpectedRemote() throws IOException {
+		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
+				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
+				"refs/heads/master", false, null, ObjectId
+						.fromString("0000000000000000000000000000000000000001"));
+		final Ref ref = new Ref("refs/heads/master", ObjectId
+				.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
+		testOneUpdateStatus(rru, ref, Status.REJECTED_REMOTE_CHANGED, null);
+	}
+
+	/**
+	 * Test for remote ref update with expected old object set, when old object
+	 * is not that expected one and force update flag is set (which should have
+	 * lower priority) - shouldn't change behavior.
+	 * 
+	 * @throws IOException
+	 */
+	public void testUpdateUnexpectedRemoteVsForce() throws IOException {
+		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
+				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
+				"refs/heads/master", true, null, ObjectId
+						.fromString("0000000000000000000000000000000000000001"));
+		final Ref ref = new Ref("refs/heads/master", ObjectId
+				.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
+		testOneUpdateStatus(rru, ref, Status.REJECTED_REMOTE_CHANGED, null);
+	}
+
+	/**
+	 * Test for remote ref udpate, when connection rejects update.
+	 * 
+	 * @throws IOException
+	 */
+	public void testUpdateRejectedByConnection() throws IOException {
+		connectionUpdateStatus = Status.REJECTED_OTHER_REASON;
+		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
+				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
+				"refs/heads/master", false, null, null);
+		final Ref ref = new Ref("refs/heads/master", ObjectId
+				.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
+		testOneUpdateStatus(rru, ref, Status.REJECTED_OTHER_REASON, null);
+	}
+
+	/**
+	 * Test for remote refs updates with mixed cases that shouldn't depend on
+	 * each other.
+	 * 
+	 * @throws IOException
+	 */
+	public void testUpdateMixedCases() throws IOException {
+		final RemoteRefUpdate rruOk = new RemoteRefUpdate(db, null,
+				"refs/heads/master", false, null, null);
+		final Ref refToChange = new Ref("refs/heads/master", ObjectId
+				.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
+		final RemoteRefUpdate rruReject = new RemoteRefUpdate(db, null,
+				"refs/heads/nonexisting", false, null, null);
+		refUpdates.add(rruOk);
+		refUpdates.add(rruReject);
+		advertisedRefs.add(refToChange);
+		executePush();
+		assertEquals(Status.OK, rruOk.getStatus());
+		assertEquals(true, rruOk.isFastForward());
+		assertEquals(Status.NON_EXISTING, rruReject.getStatus());
+	}
+
+	/**
+	 * Test for local tracking ref update.
+	 * 
+	 * @throws IOException
+	 */
+	public void testTrackingRefUpdateEnabled() throws IOException {
+		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
+				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
+				"refs/heads/master", false, "refs/remotes/test/master", null);
+		final Ref ref = new Ref("refs/heads/master", ObjectId
+				.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
+		refUpdates.add(rru);
+		advertisedRefs.add(ref);
+		final PushResult result = executePush();
+		final TrackingRefUpdate tru = result
+				.getTrackingRefUpdate("refs/remotes/test/master");
+		assertNotNull(tru);
+		assertEquals("refs/remotes/test/master", tru.getLocalName());
+		assertEquals(Result.NEW, tru.getResult());
+	}
+
+	/**
+	 * Test for local tracking ref update disabled.
+	 * 
+	 * @throws IOException
+	 */
+	public void testTrackingRefUpdateDisabled() throws IOException {
+		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
+				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
+				"refs/heads/master", false, null, null);
+		final Ref ref = new Ref("refs/heads/master", ObjectId
+				.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
+		refUpdates.add(rru);
+		advertisedRefs.add(ref);
+		final PushResult result = executePush();
+		assertTrue(result.getTrackingRefUpdates().isEmpty());
+	}
+
+	/**
+	 * Test for local tracking ref update when remote update has failed.
+	 * 
+	 * @throws IOException
+	 */
+	public void testTrackingRefUpdateOnReject() throws IOException {
+		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
+				"ac7e7e44c1885efb472ad54a78327d66bfc4ecef",
+				"refs/heads/master", false, null, null);
+		final Ref ref = new Ref("refs/heads/master", ObjectId
+				.fromString("2c349335b7f797072cf729c4f3bb0914ecb6dec9"));
+		final PushResult result = testOneUpdateStatus(rru, ref,
+				Status.REJECTED_NONFASTFORWARD, null);
+		assertTrue(result.getTrackingRefUpdates().isEmpty());
+	}
+
+	/**
+	 * Test for push operation result - that contains expected elements.
+	 * 
+	 * @throws IOException
+	 */
+	public void testPushResult() throws IOException {
+		final RemoteRefUpdate rru = new RemoteRefUpdate(db,
+				"2c349335b7f797072cf729c4f3bb0914ecb6dec9",
+				"refs/heads/master", false, "refs/remotes/test/master", null);
+		final Ref ref = new Ref("refs/heads/master", ObjectId
+				.fromString("ac7e7e44c1885efb472ad54a78327d66bfc4ecef"));
+		refUpdates.add(rru);
+		advertisedRefs.add(ref);
+		final PushResult result = executePush();
+		assertEquals(1, result.getTrackingRefUpdates().size());
+		assertEquals(1, result.getAdvertisedRefs().size());
+		assertEquals(1, result.getRemoteUpdates().size());
+		assertNotNull(result.getTrackingRefUpdate("refs/remotes/test/master"));
+		assertNotNull(result.getAdvertisedRef("refs/heads/master"));
+		assertNotNull(result.getRemoteUpdate("refs/heads/master"));
+	}
+
+	private PushResult testOneUpdateStatus(final RemoteRefUpdate rru,
+			final Ref advertisedRef, final Status expectedStatus,
+			Boolean fastForward) throws NotSupportedException,
+			TransportException {
+		refUpdates.add(rru);
+		if (advertisedRef != null)
+			advertisedRefs.add(advertisedRef);
+		final PushResult result = executePush();
+		assertEquals(expectedStatus, rru.getStatus());
+		if (fastForward != null)
+			assertEquals(fastForward.booleanValue(), rru.isFastForward());
+		return result;
+	}
+
+	private PushResult executePush() throws NotSupportedException,
+			TransportException {
+		process = new PushProcess(transport, refUpdates);
+		return process.execute(new TextProgressMonitor());
+	}
+
+	private class MockTransport extends Transport {
+		MockTransport(Repository local, URIish uri) {
+			super(local, uri);
+		}
+
+		@Override
+		public FetchConnection openFetch() throws NotSupportedException,
+				TransportException {
+			throw new NotSupportedException("mock");
+		}
+
+		@Override
+		public PushConnection openPush() throws NotSupportedException,
+				TransportException {
+			return new MockPushConnection();
+		}
+	}
+
+	private class MockPushConnection extends BaseConnection implements
+			PushConnection {
+		MockPushConnection() {
+			final Map<String, Ref> refsMap = new HashMap<String, Ref>();
+			for (final Ref r : advertisedRefs)
+				refsMap.put(r.getName(), r);
+			available(refsMap);
+		}
+
+		@Override
+		public void close() {
+			// nothing here
+		}
+
+		public void push(ProgressMonitor monitor,
+				Map<String, RemoteRefUpdate> refUpdates)
+				throws TransportException {
+			for (final RemoteRefUpdate rru : refUpdates.values()) {
+				assertEquals(Status.NOT_ATTEMPTED, rru.getStatus());
+				rru.setStatus(connectionUpdateStatus);
+			}
+		}
+	}
+}
-- 
1.5.5.3
