From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: [PATCH 5/6] templates: Fix ASCII art in pre-rebase hook
Date: Sun, 14 Jul 2013 18:21:18 +0200
Message-ID: <1373818879-1698-6-git-send-email-richih.mailinglist@gmail.com>
References: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
 <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
Cc: Richard Hartmann <richih.mailinglist@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 18:21:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyP3F-0006sj-L8
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 18:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744Ab3GNQVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 12:21:30 -0400
Received: from mail-bk0-f52.google.com ([209.85.214.52]:40852 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679Ab3GNQV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 12:21:29 -0400
Received: by mail-bk0-f52.google.com with SMTP id d7so4313902bkh.11
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wH5Tq3CWtcDxpIDeTyTdl5HfBtLBYzhpV5PqDoFFhq8=;
        b=J2ZpvP3KDKe4qj1iDp5dg8RRAiMfmf/NEPRy00ga4IdnGZ4HZoQtp02wXCTe3SKv3x
         3jtr9TA7AXpF1QcrDXlkyWGDWclg2qFS0jyIvBVHWsI85Sci/9yIhnOscBLr8gvBkUGj
         VUDh4bNC0EO9yQRkrFwgSHa70pfjKbyQF6eusRw6nBbtNUh7HsxsuhNB6fJOUuqivfc3
         0j7nNJnmSV4B4KuDa03+pBSTKu8OS4q35O05AkmE6t9dupw/Mb4MAcLZYy9npj1jER0n
         jm2xkn9Asu83BMByI8O/024z9cgxK2jNOpt8FvvIGRxwCEMAHgMDGOsp7QTaOW2Hii1k
         QH5g==
X-Received: by 10.204.165.134 with SMTP id i6mr7513856bky.179.1373818887751;
        Sun, 14 Jul 2013 09:21:27 -0700 (PDT)
Received: from rockhopper.fritz.box (p5499AB9B.dip0.t-ipconnect.de. [84.153.171.155])
        by mx.google.com with ESMTPSA id ct12sm496595bkb.12.2013.07.14.09.21.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 09:21:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230372>

The example assumes 8-char wide tabs and breaks for people with
4-char wide tabs. Convert all of those tabs to whitespace, instead.

Verbatim copy of 11edd8a05778700382e6a21cfc0a6b5b72eff852 in original
patch series from 2013-06-10.

Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
---
 templates/hooks--pre-rebase.sample |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/templates/hooks--pre-rebase.sample b/templates/hooks--pre-rebase.sample
index 053f111..b74cd1d 100755
--- a/templates/hooks--pre-rebase.sample
+++ b/templates/hooks--pre-rebase.sample
@@ -132,14 +132,14 @@ With this workflow, you would want to know:
 
 Let's look at this example:
 
-		   o---o---o---o---o---o---o---o---o---o "next"
-		  /       /           /           /
-		 /   a---a---b A     /           /
-		/   /               /           /
-	       /   /   c---c---c---c B         /
-	      /   /   /             \         /
-	     /   /   /   b---b C     \       /
-	    /   /   /   /             \     /
+                   o---o---o---o---o---o---o---o---o---o "next"
+                  /       /           /           /
+                 /   a---a---b A     /           /
+                /   /               /           /
+               /   /   c---c---c---c B         /
+              /   /   /             \         /
+             /   /   /   b---b C     \       /
+            /   /   /   /             \     /
     ---o---o---o---o---o---o---o---o---o---o---o "master"
 
 
-- 
1.7.10.4
