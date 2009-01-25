From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH v2] diff-options.txt: Fix asciidoc markup issue
Date: Sun, 25 Jan 2009 14:20:22 +0200
Message-ID: <8763k3ziex.fsf_-_@iki.fi>
References: <1232860721-6174-1-git-send-email-tlikonen@iki.fi>
	<alpine.DEB.1.00.0901251257510.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 25 13:21:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR3zx-00024e-Oy
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 13:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbZAYMUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 07:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbZAYMUd
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 07:20:33 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:55749 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898AbZAYMUd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 07:20:33 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 48FC59C7042BC763; Sun, 25 Jan 2009 14:20:26 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LR3yQ-0002Rw-Hq; Sun, 25 Jan 2009 14:20:22 +0200
In-Reply-To: <alpine.DEB.1.00.0901251257510.14855@racer> (Johannes Schindelin's message of "Sun\, 25 Jan 2009 12\:58\:12 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Must be "--patience::", not "--patience:".

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---

Johannes Schindelin (2009-01-25 12:58 +0100) wrote:

> Thanks.  If you would add your Sign-off, I'd add my Acked-by.

Here's a new version. Though it feels a bit funny to add a S-o-b for a
patch that does nothing but adds a single character. :-)


 Documentation/diff-options.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 3816a83..813a7b1 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -36,7 +36,7 @@ endif::git-format-patch[]
 --patch-with-raw::
 	Synonym for "-p --raw".
 
---patience:
+--patience::
 	Generate a diff using the "patience diff" algorithm.
 
 --stat[=width[,name-width]]::
-- 
1.6.1.295.g75c4eae
