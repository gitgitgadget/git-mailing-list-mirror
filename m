From: "Geoffrey Irving" <irving@naml.us>
Subject: PATCH] doc: adding gitman.info and *.texi to .gitignore
Date: Thu, 12 Jun 2008 07:33:50 -0700
Message-ID: <7f9d599f0806120733y364f7eadkb6440e5b88aec428@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 16:36:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6nt4-00041G-TB
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 16:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbYFLOd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 10:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbYFLOd4
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 10:33:56 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:15742 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938AbYFLOdz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 10:33:55 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2103915wri.5
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 07:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=VEWax5D0ukghKfve+SMfZqzMHrLIuwzMR+lPr8jCixM=;
        b=tSjlcPgE30FcbeGEwxDCojh75/p4xh7k5NF5FLUc915yskxtcYgYEbIdDF3PjTJU08
         cAHS/YMq9Rmf3srxyXJRHe5xPo9c8XuHRnJSMsy13v0fCRx9nZ59lAlbzuEe5+U95ax4
         cY/MJtJn0p3dK9qDmIZ7GHvh1HxQBSYP0vM5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=FtptyzI1FmGR6g9nmeq+KjVrd0vzqjVpzW84vtLLSXA72lqXxkaBgXbxmTTfS6PQ3D
         gVBhLUsBEzpTnfoOT063ckBOUw5YooEkEkZ/dZ+vs8h33bXNClTxXiws2+NmXFr0OYEj
         Hk1CkUHiU4SL84G+PddvWi2ZGIu3lPY88xp9E=
Received: by 10.90.53.1 with SMTP id b1mr729086aga.48.1213281230445;
        Thu, 12 Jun 2008 07:33:50 -0700 (PDT)
Received: by 10.90.97.4 with HTTP; Thu, 12 Jun 2008 07:33:50 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 882094e833c97237
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84758>

>From 4193b9491cfa9d29b0f18b18d09e0c33326f5ed5 Mon Sep 17 00:00:00 2001
From: Geoffrey Irving <irving@naml.us>
Date: Thu, 12 Jun 2008 07:29:42 -0700
Subject: [PATCH] doc: adding gitman.info and *.texi to .gitignore

---
 Documentation/.gitignore |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index 2f938f4..d8edd90 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -2,7 +2,9 @@
 *.html
 *.[1-8]
 *.made
+*.texi
 git.info
+gitman.info
 howto-index.txt
 doc.dep
 cmds-*.txt
-- 
1.5.5.1.508.ga00f3
