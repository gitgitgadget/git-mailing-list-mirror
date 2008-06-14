From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] enable whitespace checking of test scripts
Date: Sat, 14 Jun 2008 02:56:36 -0400
Message-ID: <20080614065636.GD9006@sigill.intra.peff.net>
References: <20080614064857.GA8930@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 08:57:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Pi1-0000Ym-R3
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 08:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbYFNG4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 02:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbYFNG4j
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 02:56:39 -0400
Received: from peff.net ([208.65.91.99]:1743 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751671AbYFNG4i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 02:56:38 -0400
Received: (qmail 28276 invoked by uid 111); 14 Jun 2008 06:56:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 14 Jun 2008 02:56:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jun 2008 02:56:36 -0400
Content-Disposition: inline
In-Reply-To: <20080614064857.GA8930@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84969>

Now that all of the policy violations have been cleaned up,
we can turn this on and start checking incoming patches.

Signed-off-by: Jeff King <peff@peff.net>
---
Check and mate, whitespace.

 t/.gitattributes |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/t/.gitattributes b/t/.gitattributes
index ab6edbf..1b97c54 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -1,2 +1 @@
-t[0-9][0-9][0-9][0-9]-*.sh -whitespace
 t[0-9][0-9][0-9][0-9]/* -whitespace
-- 
1.5.6.rc2.183.g04614
