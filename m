Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26461FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 17:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932520AbdJ3RKt (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:10:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:60705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932482AbdJ3RKs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:10:48 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWk7n-1dfjiA1V4F-00Xtc3; Mon, 30
 Oct 2017 18:10:45 +0100
Date:   Mon, 30 Oct 2017 18:10:30 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] mingw: document the experimental standard handle
 redirection
In-Reply-To: <cover.1509382976.git.johannes.schindelin@gmx.de>
Message-ID: <436f0fb010709fe0d90460dc7bc1b3482237b192.1509382976.git.johannes.schindelin@gmx.de>
References: <cover.1509382976.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8xVav52g9P0HEdRehwrtubzW2e2D5hywF/HdVytWnvc0IEfnk+B
 1F1aRkh879NJhsv4iaSnM1kofdNWGCszKVggTm/mlILHvAw4F3bfCQRDNFDvexJlTTiNku9
 PQKLf/B7ujzCBVbw3Nny0dVLzZmM9c8z0Yto4rx4NVDrxbvs5nvSm6EUveoZDH831ZH6kaE
 IBY+4v/kp5GOeqa4HIQgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DUvvbwMjPNQ=:RiYivCEu2FdhEF8DZPL9Fl
 BMIbEpdNOrIzIUPG3ehJuXftZHQTbwRwiqqWQr7GvCLjfjwgqzjhcKeqJzpjjv4OAQKNVU53L
 gxRy0ea1CaOdsvjjH63Ts70aY+0LU2MSEOZbtgzz4Dn0VJke5FCeHVquJPVHT42mLIt004kjS
 3XgVIA5ptJXJrCVLZKNg3aFiagb5I4vtXw1m9r4KaHjNJ3pgD0V+25EaYLthxhYPggvuGiDkh
 dlUEi3Vr/pj4yOfrYAaZQEQlnYuKiI1HBZLy8wzK//WnJMUILzLYKp9q+sm+K1Osr0OvA+eG9
 6jPgAfChn3jopmfNA9Jcb+fi6FH02fecENwbeptBVAOxfDxfJbhivd37l4Yb0fGWjTbAPBUob
 d5wwSahQhm5l9+tQ2ZL5Dl0U8+izzTxGMrmUdMKuK57Q2vM/p52GuEr1EOcZINniW+1NM9Pa2
 vyEn2jyrl9R5qseOqOvpT2Z1MgA/gx6463jh4cxoSxiBIOylNjFHs3eRBWIViTMY2msUKwACq
 dGd2y0dddBx3eLiQWrYNwX2kiv5Ra5XDTrqHy+qv/zHK8icjU3esCOaBhUGbwmeHW1MeL7sTC
 aThBoc+ygNKQWQAG3Vj4xmMuhL0Il+2/mwGn7KbDgsA/wl9mNV6DzQ8BIB+n9gnC0woVWUBGy
 6ARxnXo+aeyGMCJ8514QdfqlboCJDW2LCWldGxAFXtncP+rYJTiBKVsCkowm7Y1wL6kqxSfZr
 L6FY99cR12gfAjWYbS+8KibSK9OCp5m1Wg56OfHud+Pi9A33Q2DA+hG2H8Ntb4wfyXad/uw7O
 rcCEn+BLYv86ybm3rXpyBf08A7u2stj3L/rI7DyenUHAs4hSFyl8NEMj9Jp7wctBPY1U5OJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This feature is still highly experimental and has not even been
contributed to the Git mailing list yet: the feature still needs to be
battle-tested more.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7a1d629ca06..10a98603b39 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -709,6 +709,23 @@ of clones and fetches.
 	the background which do not want to cause lock contention with
 	other operations on the repository.  Defaults to `1`.
 
+`GIT_REDIRECT_STDIN`::
+`GIT_REDIRECT_STDOUT`::
+`GIT_REDIRECT_STDERR`::
+	(EXPERIMENTAL) Windows-only: allow redirecting the standard
+	input/output/error handles. This is particularly useful in
+	multi-threaded applications where the canonical way to pass
+	standard handles via `CreateProcess()` is not an option because
+	it would require the handles to be marked inheritable (and
+	consequently *every* spawned process would inherit them, possibly
+	blocking regular Git operations). The primary intended use case
+	is to use named pipes for communication.
++
+Two special values are supported: `off` will simply close the
+corresponding standard handle, and if `GIT_REDIRECT_STDERR` is
+`2>&1`, standard error will be redirected to the same handle as
+standard output.
+
 Discussion[[Discussion]]
 ------------------------
 
-- 
2.15.0.windows.1
