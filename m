From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 20/20] PackWriter test suite
Date: Sun, 15 Jun 2008 23:45:49 +0200
Message-ID: <1213566349-25395-21-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-7-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-8-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-9-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-10-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-11-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-12-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-13-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-14-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-15-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-16-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-17-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-18-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-19-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-20-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:49:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8063-00026j-Fr
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbYFOVsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754027AbYFOVsK
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:48:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:50674 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892AbYFOVsF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:48:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3138098fgg.17
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ne4VglNrn8352Y50ulL2c1Xf/x9hEAwb9aT35NQAKBo=;
        b=WzONGNaFvTrRxvDteBQdpm2YydVfjW2zHnOTFJtkJoAYmCxLgdhTfOblBxS1Gi6Seu
         yCFMc/7P06fPqt/7VfsAFQaG+2i6kNTJGe8O44CT4Pkzxw6C4Ce3W4F2WJ81stR00qgd
         +WZI4GsTOJhPxbA8nzPxR/4xgBnxvhsX++Uzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bNe121hmEQEmqU4WOa/qqSy7ZioYyMuOCbNeaLv1K6wY8MVtlO3pQ3cFk2cPDccnEU
         O0f+0Gq90lkI9dxGXhrUyocGmKebruB3qlJGumFpsEcBM6rO3qVt8woMrQTIp2Aoh5kP
         12omAnp/5b//NQxqyy7UZ5Rb3PSv1JQLof5so=
Received: by 10.86.33.10 with SMTP id g10mr7227643fgg.15.1213566484849;
        Sun, 15 Jun 2008 14:48:04 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id 4sm9672088fge.5.2008.06.15.14.48.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:48:03 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-20-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85145>

Test suite is provided relying on IndexPack and PackIndex to verify
PackWriter output for various configurations.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |  454 ++++++++++++++++++++
 1 files changed, 454 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
new file mode 100644
index 0000000..9572342
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -0,0 +1,454 @@
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
+package org.spearce.jgit.lib;
+
+import java.io.ByteArrayInputStream;
+import java.io.ByteArrayOutputStream;
+import java.io.File;
+import java.io.IOException;
+import java.io.InputStream;
+import java.util.ArrayList;
+import java.util.Arrays;
+import java.util.Collection;
+import java.util.Collections;
+import java.util.Comparator;
+import java.util.Iterator;
+import java.util.LinkedList;
+import java.util.List;
+
+import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.lib.PackIndex.MutableEntry;
+import org.spearce.jgit.revwalk.RevObject;
+import org.spearce.jgit.revwalk.RevWalk;
+import org.spearce.jgit.transport.IndexPack;
+import org.spearce.jgit.util.CountingOutputStream;
+
+public class PackWriterTest extends RepositoryTestCase {
+
+	private static final List<ObjectId> EMPTY_LIST_OBJECT = Collections
+			.<ObjectId> emptyList();
+
+	private static final List<RevObject> EMPTY_LIST_REVS = Collections
+			.<RevObject> emptyList();
+
+	private PackWriter writer;
+
+	private ByteArrayOutputStream os;
+
+	private CountingOutputStream cos;
+
+	private File packBase;
+
+	private File packFile;
+
+	private File indexFile;
+
+	private PackFile pack;
+
+	public void setUp() throws Exception {
+		super.setUp();
+		os = new ByteArrayOutputStream();
+		cos = new CountingOutputStream(os);
+		packBase = new File(trash, "tmp_pack");
+		packFile = new File(trash, "tmp_pack.pack");
+		indexFile = new File(trash, "tmp_pack.idx");
+		writer = new PackWriter(db, cos, new TextProgressMonitor());
+	}
+
+	/**
+	 * Test constructor for exceptions, default settings, initialization.
+	 */
+	public void testContructor() {
+		assertEquals(false, writer.isDeltaBaseAsOffset());
+		assertEquals(true, writer.isReuseDeltas());
+		assertEquals(true, writer.isReuseObjects());
+		assertEquals(0, writer.getObjectsNumber());
+	}
+
+	/**
+	 * Change default settings and verify them.
+	 */
+	public void testModifySettings() {
+		writer.setDeltaBaseAsOffset(true);
+		writer.setReuseDeltas(false);
+		writer.setReuseObjects(false);
+
+		assertEquals(true, writer.isDeltaBaseAsOffset());
+		assertEquals(false, writer.isReuseDeltas());
+		assertEquals(false, writer.isReuseObjects());
+	}
+
+	/**
+	 * Write empty pack by providing empty sets of interesting/uninteresting
+	 * objects and check for correct format.
+	 * 
+	 * @throws IOException
+	 */
+	public void testWriteEmptyPack1() throws IOException {
+		createVerifyOpenPack(EMPTY_LIST_OBJECT, EMPTY_LIST_OBJECT, false);
+
+		assertEquals(0, writer.getObjectsNumber());
+		assertEquals(0, pack.getObjectCount());
+		assertEquals("da39a3ee5e6b4b0d3255bfef95601890afd80709", writer
+				.computeName().toString());
+	}
+
+	/**
+	 * Write empty pack by providing empty iterator of objects to write and
+	 * check for correct format.
+	 * 
+	 * @throws IOException
+	 */
+	public void testWriteEmptyPack2() throws IOException {
+		createVerifyOpenPack(EMPTY_LIST_REVS.iterator());
+
+		assertEquals(0, writer.getObjectsNumber());
+		assertEquals(0, pack.getObjectCount());
+	}
+
+	/**
+	 * Create pack basing on only interesting objects, then precisely verify
+	 * content. No delta reuse here.
+	 * 
+	 * @throws IOException
+	 */
+	public void testWritePack1() throws IOException {
+		writer.setReuseDeltas(false);
+		writeVerifyPack1();
+	}
+
+	/**
+	 * Test writing pack without object reuse. Pack content/preparation as in
+	 * {@link #testWritePack1()}.
+	 * 
+	 * @throws IOException
+	 */
+	public void testWritePack1NoObjectReuse() throws IOException {
+		writer.setReuseDeltas(false);
+		writer.setReuseObjects(false);
+		writeVerifyPack1();
+	}
+
+	/**
+	 * Create pack basing on both interesting and uninteresting objects, then
+	 * precisely verify content. No delta reuse here.
+	 * 
+	 * @throws IOException
+	 */
+	public void testWritePack2() throws IOException {
+		writeVerifyPack2(false);
+	}
+
+	/**
+	 * Test pack writing with deltas reuse, delta-base first rule. Pack
+	 * content/preparation as in {@link #testWritePack2()}.
+	 * 
+	 * @throws IOException
+	 */
+	public void testWritePack2DeltasReuseRefs() throws IOException {
+		writeVerifyPack2(true);
+	}
+
+	/**
+	 * Test pack writing with delta reuse. Delta bases referred as offsets. Pack
+	 * configuration as in {@link #testWritePack2DeltasReuseRefs()}.
+	 * 
+	 * @throws IOException
+	 */
+	public void testWritePack2DeltasReuseOffsets() throws IOException {
+		writer.setDeltaBaseAsOffset(true);
+		writeVerifyPack2(true);
+	}
+
+	/**
+	 * Test pack writing with delta reuse. Raw-data copy (reuse) is made on a
+	 * pack with CRC32 index. Pack configuration as in
+	 * {@link #testWritePack2DeltasReuseRefs()}.
+	 * 
+	 * @throws IOException
+	 */
+	public void testWritePack2DeltasCRC32Copy() throws IOException {
+		final File packDir = new File(db.getObjectsDirectory(), "pack");
+		final File crc32Pack = new File(packDir,
+				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack");
+		final File crc32Idx = new File(packDir,
+				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx");
+		copyFile(new File(new File("tst"),
+				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2"),
+				crc32Idx);
+		db.openPack(crc32Pack, crc32Idx);
+
+		writeVerifyPack2(true);
+	}
+
+	/**
+	 * Create pack basing on fixed objects list, then precisely verify content.
+	 * No delta reuse here.
+	 * 
+	 * @throws IOException
+	 * @throws MissingObjectException
+	 * 
+	 */
+	public void testWritePack3() throws MissingObjectException, IOException {
+		writer.setReuseDeltas(false);
+		final ObjectId forcedOrder[] = new ObjectId[] {
+				ObjectId.fromString("82c6b885ff600be425b4ea96dee75dca255b69e7"),
+				ObjectId.fromString("c59759f143fb1fe21c197981df75a7ee00290799"),
+				ObjectId.fromString("aabf2ffaec9b497f0950352b3e582d73035c2035"),
+				ObjectId.fromString("902d5476fa249b7abc9d84c611577a81381f0327"),
+				ObjectId.fromString("5b6e7c66c276e7610d4a73c70ec1a1f7c1003259"),
+				ObjectId.fromString("6ff87c4664981e4397625791c8ea3bbb5f2279a3") };
+		final RevWalk parser = new RevWalk(db);
+		final RevObject forcedOrderRevs[] = new RevObject[forcedOrder.length];
+		for (int i = 0; i < forcedOrder.length; i++)
+			forcedOrderRevs[i] = parser.parseAny(forcedOrder[i]);
+
+		createVerifyOpenPack(Arrays.asList(forcedOrderRevs).iterator());
+
+		assertEquals(forcedOrder.length, writer.getObjectsNumber());
+		verifyObjectsOrder(forcedOrder);
+		assertEquals("ed3f96b8327c7c66b0f8f70056129f0769323d86", writer
+				.computeName().toString());
+	}
+
+	/**
+	 * Another pack creation: basing on both interesting and uninteresting
+	 * objects. No delta reuse possible here, as this is a specific case when we
+	 * write only 1 commit, associated with 1 tree, 1 blob.
+	 * 
+	 * @throws IOException
+	 */
+	public void testWritePack4() throws IOException {
+		writeVerifyPack4(false);
+	}
+
+	/**
+	 * Test thin pack writing: 1 blob delta base is on objects edge. Pack
+	 * configuration as in {@link #testWritePack4()}.
+	 * 
+	 * @throws IOException
+	 */
+	public void testWritePack4ThinPack() throws IOException {
+		writeVerifyPack4(true);
+	}
+
+	/**
+	 * Compare sizes of packs created using {@link #testWritePack2()} and
+	 * {@link #testWritePack2DeltasReuseRefs()}. The pack using deltas should
+	 * be smaller.
+	 * 
+	 * @throws Exception
+	 */
+	public void testWritePack2SizeDeltasVsNoDeltas() throws Exception {
+		testWritePack2();
+		final int sizePack2NoDeltas = cos.getCount();
+		setUp();
+		testWritePack2DeltasReuseRefs();
+		final int sizePack2DeltasRefs = cos.getCount();
+
+		assertTrue(sizePack2NoDeltas > sizePack2DeltasRefs);
+	}
+
+	/**
+	 * Compare sizes of packs created using
+	 * {@link #testWritePack2DeltasReuseRefs()} and
+	 * {@link #testWritePack2DeltasReuseOffsets()}. The pack with delta bases
+	 * written as offsets should be smaller.
+	 * 
+	 * @throws Exception
+	 */
+	public void testWritePack2SizeOffsetsVsRefs() throws Exception {
+		testWritePack2DeltasReuseRefs();
+		final int sizePack2DeltasRefs = cos.getCount();
+		setUp();
+		testWritePack2DeltasReuseOffsets();
+		final int sizePack2DeltasOffsets = cos.getCount();
+
+		assertTrue(sizePack2DeltasRefs > sizePack2DeltasOffsets);
+	}
+
+	/**
+	 * Compare sizes of packs created using {@link #testWritePack4()} and
+	 * {@link #testWritePack4ThinPack()}. Obviously, the thin pack should be
+	 * smaller.
+	 * 
+	 * @throws Exception
+	 */
+	public void testWritePack4SizeThinVsNoThin() throws Exception {
+		testWritePack4();
+		final int sizePack4 = cos.getCount();
+		setUp();
+		testWritePack4ThinPack();
+		final int sizePack4Thin = cos.getCount();
+
+		assertTrue(sizePack4 > sizePack4Thin);
+	}
+
+	// TODO: testWritePackDeltasCycle()
+	// TODO: testWritePackDeltasDepth()
+
+	private void writeVerifyPack1() throws IOException {
+		final LinkedList<ObjectId> interestings = new LinkedList<ObjectId>();
+		interestings.add(ObjectId
+				.fromString("82c6b885ff600be425b4ea96dee75dca255b69e7"));
+		createVerifyOpenPack(interestings, EMPTY_LIST_OBJECT, false);
+
+		final ObjectId expectedOrder[] = new ObjectId[] {
+				ObjectId.fromString("82c6b885ff600be425b4ea96dee75dca255b69e7"),
+				ObjectId.fromString("c59759f143fb1fe21c197981df75a7ee00290799"),
+				ObjectId.fromString("540a36d136cf413e4b064c2b0e0a4db60f77feab"),
+				ObjectId.fromString("aabf2ffaec9b497f0950352b3e582d73035c2035"),
+				ObjectId.fromString("902d5476fa249b7abc9d84c611577a81381f0327"),
+				ObjectId.fromString("4b825dc642cb6eb9a060e54bf8d69288fbee4904"),
+				ObjectId.fromString("5b6e7c66c276e7610d4a73c70ec1a1f7c1003259"),
+				ObjectId.fromString("6ff87c4664981e4397625791c8ea3bbb5f2279a3") };
+
+		assertEquals(expectedOrder.length, writer.getObjectsNumber());
+		verifyObjectsOrder(expectedOrder);
+		assertEquals("34be9032ac282b11fa9babdc2b2a93ca996c9c2f", writer
+				.computeName().toString());
+	}
+
+	private void writeVerifyPack2(boolean deltaReuse) throws IOException {
+		writer.setReuseDeltas(deltaReuse);
+		final LinkedList<ObjectId> interestings = new LinkedList<ObjectId>();
+		interestings.add(ObjectId
+				.fromString("82c6b885ff600be425b4ea96dee75dca255b69e7"));
+		final LinkedList<ObjectId> uninterestings = new LinkedList<ObjectId>();
+		uninterestings.add(ObjectId
+				.fromString("540a36d136cf413e4b064c2b0e0a4db60f77feab"));
+		createVerifyOpenPack(interestings, uninterestings, false);
+
+		final ObjectId expectedOrder[] = new ObjectId[] {
+				ObjectId.fromString("82c6b885ff600be425b4ea96dee75dca255b69e7"),
+				ObjectId.fromString("c59759f143fb1fe21c197981df75a7ee00290799"),
+				ObjectId.fromString("aabf2ffaec9b497f0950352b3e582d73035c2035"),
+				ObjectId.fromString("902d5476fa249b7abc9d84c611577a81381f0327"),
+				ObjectId.fromString("5b6e7c66c276e7610d4a73c70ec1a1f7c1003259"),
+				ObjectId.fromString("6ff87c4664981e4397625791c8ea3bbb5f2279a3") };
+		if (deltaReuse) {
+			// objects order influenced (swapped) by delta-base first rule
+			ObjectId temp = expectedOrder[4];
+			expectedOrder[4] = expectedOrder[5];
+			expectedOrder[5] = temp;
+		}
+		assertEquals(expectedOrder.length, writer.getObjectsNumber());
+		verifyObjectsOrder(expectedOrder);
+		assertEquals("ed3f96b8327c7c66b0f8f70056129f0769323d86", writer
+				.computeName().toString());
+	}
+
+	private void writeVerifyPack4(final boolean thin) throws IOException {
+		final LinkedList<ObjectId> interestings = new LinkedList<ObjectId>();
+		interestings.add(ObjectId
+				.fromString("82c6b885ff600be425b4ea96dee75dca255b69e7"));
+		final LinkedList<ObjectId> uninterestings = new LinkedList<ObjectId>();
+		uninterestings.add(ObjectId
+				.fromString("c59759f143fb1fe21c197981df75a7ee00290799"));
+		createVerifyOpenPack(interestings, uninterestings, thin);
+
+		final ObjectId writtenObjects[] = new ObjectId[] {
+				ObjectId.fromString("82c6b885ff600be425b4ea96dee75dca255b69e7"),
+				ObjectId.fromString("aabf2ffaec9b497f0950352b3e582d73035c2035"),
+				ObjectId.fromString("5b6e7c66c276e7610d4a73c70ec1a1f7c1003259") };
+		assertEquals(writtenObjects.length, writer.getObjectsNumber());
+		ObjectId expectedObjects[];
+		if (thin) {
+			expectedObjects = new ObjectId[4];
+			System.arraycopy(writtenObjects, 0, expectedObjects, 0,
+					writtenObjects.length);
+			expectedObjects[3] = ObjectId
+					.fromString("6ff87c4664981e4397625791c8ea3bbb5f2279a3");
+
+		} else {
+			expectedObjects = writtenObjects;
+		}
+		verifyObjectsOrder(expectedObjects);
+		assertEquals("cded4b74176b4456afa456768b2b5aafb41c44fc", writer
+				.computeName().toString());
+	}
+
+	private void createVerifyOpenPack(final Collection<ObjectId> interestings,
+			final Collection<ObjectId> uninterestings, final boolean thin)
+			throws MissingObjectException, IOException {
+		writer.writePack(interestings, uninterestings, thin);
+		verifyOpenPack(thin);
+	}
+
+	private void createVerifyOpenPack(final Iterator<RevObject> objectSource)
+			throws MissingObjectException, IOException {
+		writer.writePack(objectSource);
+		verifyOpenPack(false);
+	}
+
+	private void verifyOpenPack(final boolean thin) throws IOException {
+		if (thin) {
+			final InputStream is = new ByteArrayInputStream(os.toByteArray());
+			final IndexPack indexer = new IndexPack(db, is, packBase);
+			try {
+				indexer.index(new TextProgressMonitor());
+				fail("indexer should grumble about missing object");
+			} catch (IOException x) {
+				// expected
+			}
+		}
+		final InputStream is = new ByteArrayInputStream(os.toByteArray());
+		final IndexPack indexer = new IndexPack(db, is, packBase);
+		indexer.setFixThin(thin);
+		indexer.index(new TextProgressMonitor());
+		pack = new PackFile(db, indexFile, packFile);
+	}
+
+	private void verifyObjectsOrder(final ObjectId objectsOrder[]) {
+		final List<PackIndex.MutableEntry> entries = new ArrayList<PackIndex.MutableEntry>();
+
+		for (MutableEntry me : pack) {
+			entries.add(me.cloneEntry());
+		}
+		Collections.sort(entries, new Comparator<PackIndex.MutableEntry>() {
+			public int compare(MutableEntry o1, MutableEntry o2) {
+				return Long.signum(o1.getOffset() - o2.getOffset());
+			}
+		});
+
+		int i = 0;
+		for (MutableEntry me : entries) {
+			assertEquals(objectsOrder[i++], me.copy());
+		}
+	}
+}
-- 
1.5.5.1
