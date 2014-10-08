From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] Documentation: fix misrender of pretty-formats in Asciidoctor
Date: Wed,  8 Oct 2014 20:46:10 +0000
Message-ID: <1412801170-60741-1-git-send-email-sandals@crustytoothpaste.net>
References: <CAMsgyKadiE-HOH_oLK=Fc0UQXnEuUTMHmz3=9zRiMvU0fr4KvA@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Derek Moore <derek.p.moore@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 22:46:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xby7v-0003Ia-Dh
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 22:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbaJHUqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 16:46:23 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49143 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753035AbaJHUqX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Oct 2014 16:46:23 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 782AB2808F;
	Wed,  8 Oct 2014 20:46:19 +0000 (UTC)
X-Mailer: git-send-email 2.1.1
In-Reply-To: <CAMsgyKadiE-HOH_oLK=Fc0UQXnEuUTMHmz3=9zRiMvU0fr4KvA@mail.gmail.com>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neither the AsciiDoc nor the Asciidoctor documentation specify whether
the same number of delimiter characters must be used to end a block as
to begin it, although both sets of documentation show exactly matching
pairs.  AsciiDoc allows mismatches, but AsciiDoctor apparently does not.
Adjust the pretty formats documentation to use matching pairs to prevent
a misrendering where the remainder of the document was rendered as a
listing block.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/pretty-formats.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index eecc39d..dcf7429 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -95,7 +95,7 @@ would show something like this:
 The author of fe6e0ee was Junio C Hamano, 23 hours ago
 The title was >>t4119: test autocomputing -p<n> for traditional diff input.<<
 
---------
+-------
 +
 The placeholders are:
 
-- 
2.1.1
