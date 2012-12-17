From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t6006: clean up whitespace
Date: Mon, 17 Dec 2012 17:55:52 -0500
Message-ID: <20121217225552.GA1653@sigill.intra.peff.net>
References: <20121217225516.GA1408@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Srb, Michal" <michal.srb11@imperial.ac.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:02:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkji1-0000ae-Pd
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 00:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab2LQXCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 18:02:36 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57116 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019Ab2LQXCf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 18:02:35 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Dec 2012 18:02:35 EST
Received: (qmail 10845 invoked by uid 107); 17 Dec 2012 22:56:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Dec 2012 17:56:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2012 17:55:52 -0500
Content-Disposition: inline
In-Reply-To: <20121217225516.GA1408@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211718>

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
