From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v2 3/8] rev-list-options.txt: correct TREESAME for P
Date: Tue, 30 Apr 2013 20:26:23 +0300
Message-ID: <1367342788-7795-4-git-send-email-kevin@bracey.fi>
References: <1367342788-7795-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 19:35:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXESD-00055O-Ke
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761198Ab3D3Rek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:34:40 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:59572 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761267Ab3D3Ref (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:34:35 -0400
Received: from mail414.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 850CDFFA5CB
	for <git@vger.kernel.org>; Tue, 30 Apr 2013 19:26:51 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 30 Apr 2013 19:26:51 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 30 Apr 2013 19:26:50 +0200
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.1.632.gd2b1879
In-Reply-To: <1367342788-7795-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18363990431596974305
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrheehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.500001/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrheehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222961>

In the example given, P is not TREESAME to E. This doesn't affect the
current result, but it will matter when we change behaviour.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 Documentation/rev-list-options.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 3bdbf5e..50bbff7 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -367,8 +367,7 @@ each merge.  The commits are:
   `N` and `D` to "foobarbaz"; i.e., it is not TREESAME to any parent.
 
 * `E` changes `quux` to "xyzzy", and its merge `P` combines the
-  strings to "quux xyzzy".  Despite appearing interesting, `P` is
-  TREESAME to all parents.
+  strings to "quux xyzzy".  `P` is TREESAME to `O`, but not to `E`.
 
 'rev-list' walks backwards through history, including or excluding
 commits based on whether '\--full-history' and/or parent rewriting
-- 
1.8.2.1.632.gd2b1879
