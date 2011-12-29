From: Jack Nagel <jacknagel@gmail.com>
Subject: [PATCH] Add MYMETA.json to perl/.gitignore
Date: Wed, 28 Dec 2011 22:42:05 -0600
Message-ID: <1325133725-20671-1-git-send-email-jacknagel@gmail.com>
Cc: jacknagel@gmail.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 29 05:42:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rg7ou-0002h7-CQ
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 05:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074Ab1L2EmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 23:42:20 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38989 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab1L2EmT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 23:42:19 -0500
Received: by iaeh11 with SMTP id h11so23050992iae.19
        for <git@vger.kernel.org>; Wed, 28 Dec 2011 20:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ae1QNmaSWn6ASrEfY5EyMND9JawzyOcbgt+LxRJgU2s=;
        b=c7ZiU16BDs79xHCQjX1VRDf67jGphuRDU54zbCIufJMdkD+QsPjGGGF+cdFnm/H5k0
         jzPMj1sehCZH0EzIXbJSR+LXJySIryK+LC+WBmFHc3xcth9UcUGNh+GPNaJZ3G3+5+JW
         lES07it1oWzYGjpbc5Lv8OclkETjNG75OHw7U=
Received: by 10.50.156.130 with SMTP id we2mr38704312igb.10.1325133738759;
        Wed, 28 Dec 2011 20:42:18 -0800 (PST)
Received: from localhost.localdomain ([69.42.228.181])
        by mx.google.com with ESMTPS id py9sm55174090igc.2.2011.12.28.20.42.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Dec 2011 20:42:17 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2.302.g17b4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187771>

ExtUtils::MakeMaker generates MYMETA.json in addition to MYMETA.yml
since version 6.57_07. As it suggests, it is just meta information about
the build and is cleaned up with 'make clean', so it should be ignored.

Signed-off-by: Jack Nagel <jacknagel@gmail.com>
---
 perl/.gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/perl/.gitignore b/perl/.gitignore
index 9235e73..d5c6e22 100644
--- a/perl/.gitignore
+++ b/perl/.gitignore
@@ -1,5 +1,6 @@
 perl.mak
 perl.mak.old
+MYMETA.json
 MYMETA.yml
 blib
 blibdirs
-- 
1.7.8.2.302.g17b4
