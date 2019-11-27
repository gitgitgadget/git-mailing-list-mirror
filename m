Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3315EC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AE42070B
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK0MyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:54:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:33856 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726282AbfK0MyG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 07:54:06 -0500
Received: (qmail 11072 invoked by uid 109); 27 Nov 2019 12:54:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Nov 2019 12:54:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9853 invoked by uid 111); 27 Nov 2019 12:58:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2019 07:58:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Nov 2019 07:54:04 -0500
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: [PATCH 2/2] doc: replace public-inbox links with lore.kernel.org
Message-ID: <20191127125404.GB27983@sigill.intra.peff.net>
References: <20191127125231.GH22221@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191127125231.GH22221@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we're now recommending lore.kernel.org (and because the
public-inbox.org domain might eventually go away), let's update our
internal references to use it, too. That future-proofs our references,
and sets the example we want people to follow.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-bisect-lk2009.txt                |  2 +-
 Documentation/technical/commit-graph.txt           | 10 +++++-----
 .../technical/hash-function-transition.txt         | 14 +++++++-------
 Documentation/technical/multi-pack-index.txt       |  4 ++--
 Documentation/technical/partial-clone.txt          | 12 ++++++------
 apply.c                                            |  2 +-
 sha1dc/sha1.c                                      |  2 +-
 t/t0021-conversion.sh                              |  4 ++--
 t/t4038-diff-combined.sh                           |  2 +-
 tree-walk.c                                        |  2 +-
 10 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index e99925184d..5bcf4d9b94 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -1350,7 +1350,7 @@ References
 - [[[1]]] https://www.nist.gov/sites/default/files/documents/director/planning/report02-3.pdf['The Economic Impacts of Inadequate Infratructure for Software Testing'.  Nist Planning Report 02-3], see Executive Summary and Chapter 8.
 - [[[2]]] http://www.oracle.com/technetwork/java/codeconvtoc-136057.html['Code Conventions for the Java Programming Language'. Sun Microsystems.]
 - [[[3]]] https://en.wikipedia.org/wiki/Software_maintenance['Software maintenance'. Wikipedia.]
-- [[[4]]] https://public-inbox.org/git/7vps5xsbwp.fsf_-_@assigned-by-dhcp.cox.net/[Junio C Hamano. 'Automated bisect success story'.]
+- [[[4]]] https://lore.kernel.org/git/7vps5xsbwp.fsf_-_@assigned-by-dhcp.cox.net/[Junio C Hamano. 'Automated bisect success story'.]
 - [[[5]]] https://lwn.net/Articles/317154/[Christian Couder. 'Fully automated bisecting with "git bisect run"'. LWN.net.]
 - [[[6]]] https://lwn.net/Articles/277872/[Jonathan Corbet. 'Bisection divides users and developers'. LWN.net.]
 - [[[7]]] http://marc.info/?l=linux-kernel&m=119702753411680&w=2[Ingo Molnar. 'Re: BUG 2.6.23-rc3 can't see sd partitions on Alpha'. Linux-kernel mailing list.]
diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index 729fbcb32f..25eabe36cf 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -323,14 +323,14 @@ Related Links
 [0] https://bugs.chromium.org/p/git/issues/detail?id=8
     Chromium work item for: Serialized Commit Graph
 
-[1] https://public-inbox.org/git/20110713070517.GC18566@sigill.intra.peff.net/
+[1] https://lore.kernel.org/git/20110713070517.GC18566@sigill.intra.peff.net/
     An abandoned patch that introduced generation numbers.
 
-[2] https://public-inbox.org/git/20170908033403.q7e6dj7benasrjes@sigill.intra.peff.net/
+[2] https://lore.kernel.org/git/20170908033403.q7e6dj7benasrjes@sigill.intra.peff.net/
     Discussion about generation numbers on commits and how they interact
     with fsck.
 
-[3] https://public-inbox.org/git/20170908034739.4op3w4f2ma5s65ku@sigill.intra.peff.net/
+[3] https://lore.kernel.org/git/20170908034739.4op3w4f2ma5s65ku@sigill.intra.peff.net/
     More discussion about generation numbers and not storing them inside
     commit objects. A valuable quote:
 
@@ -342,9 +342,9 @@ Related Links
      commit objects (i.e., packv4 or something like the "metapacks" I
      proposed a few years ago)."
 
-[4] https://public-inbox.org/git/20180108154822.54829-1-git@jeffhostetler.com/T/#u
+[4] https://lore.kernel.org/git/20180108154822.54829-1-git@jeffhostetler.com/T/#u
     A patch to remove the ahead-behind calculation from 'status'.
 
-[5] https://public-inbox.org/git/f27db281-abad-5043-6d71-cbb083b1c877@gmail.com/
+[5] https://lore.kernel.org/git/f27db281-abad-5043-6d71-cbb083b1c877@gmail.com/
     A discussion of a "two-dimensional graph position" that can allow reading
     multiple commit-graph chains at the same time.
diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 2ae8fa470a..4744a3f6c6 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -730,7 +730,7 @@ adoption.
 
 Using hash functions in parallel
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-(e.g. https://public-inbox.org/git/22708.8913.864049.452252@chiark.greenend.org.uk/ )
+(e.g. https://lore.kernel.org/git/22708.8913.864049.452252@chiark.greenend.org.uk/ )
 Objects newly created would be addressed by the new hash, but inside
 such an object (e.g. commit) it is still possible to address objects
 using the old hash function.
@@ -783,7 +783,7 @@ bmwill@google.com, jonathantanmy@google.com, jrnieder@gmail.com,
 sbeller@google.com
 
 Initial version sent to
-http://public-inbox.org/git/20170304011251.GA26789@aiede.mtv.corp.google.com
+http://lore.kernel.org/git/20170304011251.GA26789@aiede.mtv.corp.google.com
 
 2017-03-03 jrnieder@gmail.com
 Incorporated suggestions from jonathantanmy and sbeller:
@@ -820,8 +820,8 @@ Later history:
  edits. This document history is no longer being maintained as it
  would now be superfluous to the commit log
 
-[1] http://public-inbox.org/git/CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com/
-[2] http://public-inbox.org/git/CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com/
-[3] http://public-inbox.org/git/20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net/
-[4] http://public-inbox.org/git/20170304224936.rqqtkdvfjgyezsht@genre.crustytoothpaste.net
-[5] https://public-inbox.org/git/CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com/
+[1] http://lore.kernel.org/git/CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com/
+[2] http://lore.kernel.org/git/CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com/
+[3] http://lore.kernel.org/git/20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net/
+[4] http://lore.kernel.org/git/20170304224936.rqqtkdvfjgyezsht@genre.crustytoothpaste.net
+[5] https://lore.kernel.org/git/CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com/
diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
index d7e57639f7..1e31239696 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/technical/multi-pack-index.txt
@@ -102,8 +102,8 @@ Related Links
 [0] https://bugs.chromium.org/p/git/issues/detail?id=6
     Chromium work item for: Multi-Pack Index (MIDX)
 
-[1] https://public-inbox.org/git/20180107181459.222909-1-dstolee@microsoft.com/
+[1] https://lore.kernel.org/git/20180107181459.222909-1-dstolee@microsoft.com/
     An earlier RFC for the multi-pack-index feature
 
-[2] https://public-inbox.org/git/alpine.DEB.2.20.1803091557510.23109@alexmv-linux/
+[2] https://lore.kernel.org/git/alpine.DEB.2.20.1803091557510.23109@alexmv-linux/
     Git Merge 2018 Contributor's summit notes (includes discussion of MIDX)
diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index 210373e258..3bd3a4d45d 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -350,26 +350,26 @@ Related Links
 [0] https://crbug.com/git/2
     Bug#2: Partial Clone
 
-[1] https://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com/ +
+[1] https://lore.kernel.org/git/20170113155253.1644-1-benpeart@microsoft.com/ +
     Subject: [RFC] Add support for downloading blobs on demand +
     Date: Fri, 13 Jan 2017 10:52:53 -0500
 
-[2] https://public-inbox.org/git/cover.1506714999.git.jonathantanmy@google.com/ +
+[2] https://lore.kernel.org/git/cover.1506714999.git.jonathantanmy@google.com/ +
     Subject: [PATCH 00/18] Partial clone (from clone to lazy fetch in 18 patches) +
     Date: Fri, 29 Sep 2017 13:11:36 -0700
 
-[3] https://public-inbox.org/git/20170426221346.25337-1-jonathantanmy@google.com/ +
+[3] https://lore.kernel.org/git/20170426221346.25337-1-jonathantanmy@google.com/ +
     Subject: Proposal for missing blob support in Git repos +
     Date: Wed, 26 Apr 2017 15:13:46 -0700
 
-[4] https://public-inbox.org/git/1488999039-37631-1-git-send-email-git@jeffhostetler.com/ +
+[4] https://lore.kernel.org/git/1488999039-37631-1-git-send-email-git@jeffhostetler.com/ +
     Subject: [PATCH 00/10] RFC Partial Clone and Fetch +
     Date: Wed,  8 Mar 2017 18:50:29 +0000
 
-[5] https://public-inbox.org/git/20170505152802.6724-1-benpeart@microsoft.com/ +
+[5] https://lore.kernel.org/git/20170505152802.6724-1-benpeart@microsoft.com/ +
     Subject: [PATCH v7 00/10] refactor the filter process code into a reusable module +
     Date: Fri,  5 May 2017 11:27:52 -0400
 
-[6] https://public-inbox.org/git/20170714132651.170708-1-benpeart@microsoft.com/ +
+[6] https://lore.kernel.org/git/20170714132651.170708-1-benpeart@microsoft.com/ +
     Subject: [RFC/PATCH v2 0/1] Add support for downloading blobs on demand +
     Date: Fri, 14 Jul 2017 09:26:50 -0400
diff --git a/apply.c b/apply.c
index b9291f5f7b..a2f0f804fe 100644
--- a/apply.c
+++ b/apply.c
@@ -450,7 +450,7 @@ static char *find_name_gnu(struct strbuf *root,
 
 	/*
 	 * Proposed "new-style" GNU patch/diff format; see
-	 * https://public-inbox.org/git/7vll0wvb2a.fsf@assigned-by-dhcp.cox.net/
+	 * https://lore.kernel.org/git/7vll0wvb2a.fsf@assigned-by-dhcp.cox.net/
 	 */
 	if (unquote_c_style(&name, line, NULL)) {
 		strbuf_release(&name);
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 9d3cf81d4d..4afc989a9e 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -98,7 +98,7 @@
 /*
  * Defines Big Endian on a whitelist of OSs that are known to be Big
  * Endian-only. See
- * https://public-inbox.org/git/93056823-2740-d072-1ebd-46b440b33d7e@felt.demon.nl/
+ * https://lore.kernel.org/git/93056823-2740-d072-1ebd-46b440b33d7e@felt.demon.nl/
  */
 #define SHA1DC_BIGENDIAN
 
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index c954c709ad..6c6d77b51a 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -35,7 +35,7 @@ filter_git () {
 # Compare two files and ensure that `clean` and `smudge` respectively are
 # called at least once if specified in the `expect` file. The actual
 # invocation count is not relevant because their number can vary.
-# c.f. http://public-inbox.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
+# c.f. http://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
 test_cmp_count () {
 	expect=$1
 	actual=$2
@@ -50,7 +50,7 @@ test_cmp_count () {
 
 # Compare two files but exclude all `clean` invocations because Git can
 # call `clean` zero or more times.
-# c.f. http://public-inbox.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
+# c.f. http://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
 test_cmp_exclude_clean () {
 	expect=$1
 	actual=$2
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index b5a56895e8..94680836ce 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -354,7 +354,7 @@ test_expect_failure 'combine diff coalesce three parents' '
 '
 
 # Test for a bug reported at
-# https://public-inbox.org/git/20130515143508.GO25742@login.drsnuggles.stderr.nl/
+# https://lore.kernel.org/git/20130515143508.GO25742@login.drsnuggles.stderr.nl/
 # where a delete lines were missing from combined diff output when they
 # occurred exactly before the context lines of a later change.
 test_expect_success 'combine diff missing delete bug' '
diff --git a/tree-walk.c b/tree-walk.c
index bea819d826..d5a8e096a6 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1124,7 +1124,7 @@ static enum interesting do_match(struct index_state *istate,
 		 * later on.
 		 * max_depth is ignored but we may consider support it
 		 * in future, see
-		 * https://public-inbox.org/git/7vmxo5l2g4.fsf@alter.siamese.dyndns.org/
+		 * https://lore.kernel.org/git/7vmxo5l2g4.fsf@alter.siamese.dyndns.org/
 		 */
 		if (ps->recursive && S_ISDIR(entry->mode))
 			return entry_interesting;
-- 
2.24.0.778.ge5f6c7a838
