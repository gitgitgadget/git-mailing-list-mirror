From: Jeff King <peff@peff.net>
Subject: [PATCH v2 20/25] rev-list: document --reflog option
Date: Wed, 15 Oct 2014 18:43:28 -0400
Message-ID: <20141015224327.GT25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:43:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeXI6-0000tk-Nf
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbaJOWnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:43:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:59015 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751227AbaJOWna (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:43:30 -0400
Received: (qmail 2642 invoked by uid 102); 15 Oct 2014 22:43:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:43:30 -0500
Received: (qmail 28224 invoked by uid 107); 15 Oct 2014 22:43:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:43:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:43:28 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is mostly used internally, but it does not hurt to
explain it.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/rev-list-options.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5d311b8..4cf94c6 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -168,6 +168,10 @@ respectively, and they must begin with `refs/` when applied to `--glob`
 or `--all`. If a trailing '/{asterisk}' is intended, it must be given
 explicitly.
 
+--reflog::
+	Pretend as if all objects mentioned by reflogs are listed on the
+	command line as `<commit>`.
+
 --ignore-missing::
 	Upon seeing an invalid object name in the input, pretend as if
 	the bad input was not given.
-- 
2.1.2.596.g7379948
