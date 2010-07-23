From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] request-pull.txt: Document -p option
Date: Fri, 23 Jul 2010 09:31:27 -0700
Message-ID: <1279902687-5949-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 18:31:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcLA2-0005sF-W9
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 18:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758338Ab0GWQbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 12:31:41 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45667 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672Ab0GWQbk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 12:31:40 -0400
Received: by pvc7 with SMTP id 7so3572558pvc.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=JPhDAY5FIk3TkRRo9KMkaRxQUiNpHGEektiRxcU1pf8=;
        b=oGTTb3d4hqiLgkWIEqk0+h7btBhLQje3uwWMao7oTCaqa4B1oq+JZhHeHgC0bX0EZo
         jDBNMI0/6vgrz/e0nPtJ/8FotpdlzBBx/m5qMA6u0JVe1nyZn/62YTIAphzgaIoLFlB2
         QgAX7NeRDcund+Pf9fTyotf7s714IYhVfq5U0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wOO2uI2Ie45y+dnIP+fgjd/UAFod1DHg2vfIlpNcvXKlGWzR1+skN3HcvHBngPdn3p
         w4sZugPuYvoyEJ3+dO8pMPeYdAyXmTou2dCILsDzyeVzRxqEtb+GD859pL/bhynFjJdH
         9ub2chrPSXjszK1cSDLAc2OgkoByg1zgedMNI=
Received: by 10.114.210.6 with SMTP id i6mr5819056wag.139.1279902699701;
        Fri, 23 Jul 2010 09:31:39 -0700 (PDT)
Received: from earth ([75.85.182.25])
        by mx.google.com with ESMTPS id n32sm668312wag.11.2010.07.23.09.31.36
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 09:31:38 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Fri, 23 Jul 2010 09:31:27 -0700
X-Mailer: git-send-email 1.7.2.1.g3c91be
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151546>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-request-pull.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index 19335fd..400f61f 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -7,7 +7,7 @@ git-request-pull - Generates a summary of pending changes
 
 SYNOPSIS
 --------
-'git request-pull' <start> <url> [<end>]
+'git request-pull' [-p] <start> <url> [<end>]
 
 DESCRIPTION
 -----------
@@ -17,6 +17,9 @@ the given URL in the generated summary.
 
 OPTIONS
 -------
+-p::
+	Show patch text
+
 <start>::
 	Commit to start at.
 
-- 
1.7.2.1.g3c91be
