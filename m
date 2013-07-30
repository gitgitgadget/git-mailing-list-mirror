From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] Specify UK English for the documentation source files.
Date: Tue, 30 Jul 2013 11:11:54 -0400
Message-ID: <1375197114-10742-1-git-send-email-marcnarc@xiplink.com>
References: <51F7D2FA.7020208@xiplink.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 30 17:21:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4BkG-0005kw-0Z
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 17:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559Ab3G3PVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 11:21:44 -0400
Received: from 175-249-254-64.static.cogecodata.net ([64.254.249.175]:58738
	"EHLO cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755897Ab3G3PVc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jul 2013 11:21:32 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jul 2013 11:21:32 EDT
Received: from xiplink.com (unknown [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id 5D47260015;
	Tue, 30 Jul 2013 11:11:50 -0400 (EDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <51F7D2FA.7020208@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231366>

This will hopefully avoid questions over which spelling and grammar should
be used.  Translators are of course free to create localizations for other
English dialects.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

Although I'm Canadian I figured en_CA would be a little too parochial.  I
don't have a strong preference for en_UK over en_US though.

On 13-07-30 11:05 AM, Junio C Hamano wrote:> 
> I'd rather not to see any change that turns one accepted form into
> another accepted form at all (like "parseable" vs "parsable" in this
> patch).  For that purpose, asking "What is parseable" to Google and
> seeing if there is a hit is good enough ;-)

I think choosing a dialect for git will help mitigate such changes.  But
perhaps it's a bit too draconian.

		M.


 Documentation/CodingGuidelines | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 559d5f9..43af82e 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -242,6 +242,9 @@ Writing Documentation:
  processed into HTML and manpages (e.g. git.html and git.1 in the
  same directory).
 
+ The human lanuage of the documentation source files is UK English (en_UK).
+ Please follow UK English norms for spelling and grammar.
+
  Every user-visible change should be reflected in the documentation.
  The same general rule as for code applies -- imitate the existing
  conventions.  A few commented examples follow to provide reference
-- 
1.8.3.1
