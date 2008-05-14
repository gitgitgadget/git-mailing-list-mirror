From: Ian Hilt <ian.hilt@gmail.com>
Subject: [PATCH] Rephrased git-describe description
Date: Wed, 14 May 2008 14:30:55 -0400
Message-ID: <1210789855-29413-1-git-send-email-ian.hilt@gmail.com>
Cc: Ian Hilt <ian.hilt@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 20:31:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwLlN-0007Ys-Vi
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 20:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763081AbYENSas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 14:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762988AbYENSas
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 14:30:48 -0400
Received: from ag-out-0708.google.com ([72.14.246.241]:34855 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762830AbYENSar (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 14:30:47 -0400
Received: by ag-out-0708.google.com with SMTP id 31so128698agc.10
        for <git@vger.kernel.org>; Wed, 14 May 2008 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=GHHkWJeOv17Ld+Ns5SnFtjWAHQYqwG9ZAD7ceILUw4Q=;
        b=XZkS+S2vw5UVAC2e+myKWT9KUSPEFElqXSjbVhycN7BOLmxJRB5vd1oVIZoGsygCg5Rqf4K+2rHc0mVe0VJ9zZaZZtYRzGCC1x5q2RF6AngtDLeSQsxnFi3rpoTO9PEp804tJ9WnX88jidpjiOuk0K/scv8opXIzspV0AINR5+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=tXsCPMk/Q2+02jSBc+KvDxAJR3ukdBaotjLbNdT8ir4EjYUCh1rNxJ0UmnCMMBci2y7VrtXbaSyEbMs6GCbwUFZMqhsuJ1Bq9NmH82xa53IsMrHkKI6ofhHjRkI/L4be14KQ5mYTHmdomlX4Qac5KMtVQDr18rz4gj9XaH2CSc0=
Received: by 10.100.141.5 with SMTP id o5mr1726249and.64.1210789845064;
        Wed, 14 May 2008 11:30:45 -0700 (PDT)
Received: from sys-0 ( [75.185.208.72])
        by mx.google.com with ESMTPS id c39sm3307759anc.29.2008.05.14.11.30.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 May 2008 11:30:44 -0700 (PDT)
Received: by sys-0 (sSMTP sendmail emulation); Wed, 14 May 2008 14:30:55 -0400
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82128>

git-describe: Make description more readable.

Signed-off-by: Ian Hilt <ian.hilt@gmail.com>
---
 Documentation/git-describe.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index d9aa2f2..69e1ab7 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -13,9 +13,10 @@ SYNOPSIS
 DESCRIPTION
 -----------
 The command finds the most recent tag that is reachable from a
-commit, and if the commit itself is pointed at by the tag, shows
-the tag.  Otherwise, it suffixes the tag name with the number of
-additional commits and the abbreviated object name of the commit.
+commit.  If the tag points to the commit, then only the tag is
+shown.  Otherwise, it suffixes the tag name with the number of
+additional commits on top of the tagged object and the
+abbreviated object name of the most recent commit.
 
 
 OPTIONS
-- 
1.5.3.7
