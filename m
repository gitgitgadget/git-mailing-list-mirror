From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 01/15] git-format-patch(1): fix stray \ in output
Date: Wed, 2 Jul 2008 23:47:05 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807022332540.16085@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <7viqvqov01.fsf@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jon Loeliger <jdl@jdl.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK7l-0002yW-A4
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546AbYGCG7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754731AbYGCG5v
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:51 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:48442 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbYGCErb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 00:47:31 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m634l6BF006907;
	Wed, 2 Jul 2008 23:47:06 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m634l5ec017536;
	Wed, 2 Jul 2008 23:47:06 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87240>

In listing blocks (set off by rows of dashes), the usual
formatting characters of asciidoc are instead rendered verbatim.
When the escaped double-hyphen of olden days is moved into such a
block along with other formatting improvements, it becomes
backslash-dash-dash.

So we remove the backslash.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/git-format-patch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 894b82d..3c9192a 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -206,7 +206,7 @@ For each commit a separate file is created in the current directory.
 project:
 +
 ------------
-$ git format-patch \--root origin
+$ git format-patch --root origin
 ------------
 
 * The same as the previous one:
-- 
1.5.5.GIT
