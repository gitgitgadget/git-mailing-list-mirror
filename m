From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Makefile: enable THREADED_DELTA_SEARCH on SunOS
Date: Tue,  6 Oct 2009 20:02:22 -0500
Message-ID: <mMewRoxOZmBOCPocSz21A5zYKJozFCOnBBMfDefojFl0CJbciZjKAX7fE8hBoRYahowcn4j9VisPKCj9cOHGaw@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, peff@peff.net,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 07 03:03:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvKwX-0000bd-UI
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 03:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933828AbZJGBDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 21:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933806AbZJGBDf
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 21:03:35 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47396 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933802AbZJGBDe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 21:03:34 -0400
Received: by mail.nrlssc.navy.mil id n9712gXg007001; Tue, 6 Oct 2009 20:02:43 -0500
X-OriginalArrivalTime: 07 Oct 2009 01:02:42.0417 (UTC) FILETIME=[DF7AC610:01CA46E9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129636>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Any objections?  I've been compiling with THREADED_DELTA_SEARCH since I've
been compiling on Solaris with no problems.

-brandon


 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 12defd4..dd3d520 100644
--- a/Makefile
+++ b/Makefile
@@ -734,6 +734,7 @@ ifeq ($(uname_S),SunOS)
 	NO_MKSTEMPS = YesPlease
 	NO_REGEX = YesPlease
 	NO_EXTERNAL_GREP = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
 	ifeq ($(uname_R),5.7)
 		NEEDS_RESOLV = YesPlease
 		NO_IPV6 = YesPlease
-- 
1.6.5.rc2.17.gdbc1b
