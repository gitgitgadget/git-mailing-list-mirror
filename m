From: Jeff King <peff@peff.net>
Subject: [PATCH] tests: rename duplicate t1009
Date: Wed, 25 Nov 2009 17:46:16 -0500
Message-ID: <20091125224616.GA8586@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 23:46:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDQd5-00074q-Pa
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 23:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934891AbZKYWqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 17:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759871AbZKYWqJ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 17:46:09 -0500
Received: from peff.net ([208.65.91.99]:45531 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759781AbZKYWqI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 17:46:08 -0500
Received: (qmail 17064 invoked by uid 107); 25 Nov 2009 22:50:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Nov 2009 17:50:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Nov 2009 17:46:16 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133692>

We should avoid duplicate test numbers, since things like
GIT_SKIP_TESTS consider something like t1009.5 to be
unambiguous.

Signed-off-by: Jeff King <peff@peff.net>
---
This is on top of the nd/sparse topic.

As an aside, that diffstat is really unreadable. I'm not sure how to do
better without dropping the rename information, though.

 ...ckout.sh => t1011-read-tree-sparse-checkout.sh} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t1009-read-tree-sparse-checkout.sh => t1011-read-tree-sparse-checkout.sh} (100%)

diff --git a/t/t1009-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
similarity index 100%
rename from t/t1009-read-tree-sparse-checkout.sh
rename to t/t1011-read-tree-sparse-checkout.sh
-- 
1.6.6.rc0.249.g9b4cf.dirty
