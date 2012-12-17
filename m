From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] t6006: clean up whitespace
Date: Mon, 17 Dec 2012 17:56:23 -0500
Message-ID: <20121217225623.GB1653@sigill.intra.peff.net>
References: <20121217225516.GA1408@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Srb, Michal" <michal.srb11@imperial.ac.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 23:56:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkjc4-0005hI-7z
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 23:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834Ab2LQW40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 17:56:26 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57097 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077Ab2LQW4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 17:56:25 -0500
Received: (qmail 10851 invoked by uid 107); 17 Dec 2012 22:57:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Dec 2012 17:57:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2012 17:56:23 -0500
Content-Disposition: inline
In-Reply-To: <20121217225516.GA1408@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211714>

From: Junio C Hamano <gitster@pobox.com>

The test_format function did not indent its in-line test
script in an attempt to make the output of the test look
better. But it does not make a big difference to the output,
and the source looks quite ugly. Let's use our normal
indenting instead.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6006-rev-list-format.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index f94f0c4..c0c62c9 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -11,12 +11,12 @@ test_format() {
 '
 
 # usage: test_format name format_string <expected_output
-test_format() {
+test_format () {
 	cat >expect.$1
 	test_expect_success "format $1" "
-git rev-list --pretty=format:'$2' master >output.$1 &&
-test_cmp expect.$1 output.$1
-"
+		git rev-list --pretty=format:'$2' master >output.$1 &&
+		test_cmp expect.$1 output.$1
+	"
 }
 
 test_format percent %%h <<'EOF'
-- 
1.8.1.rc2.28.gce0611a
