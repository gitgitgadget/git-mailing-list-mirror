From: Jim Hill <gjthill@gmail.com>
Subject: [PATCH] pre-push.sample: Remove unwanted `IFS=' '`.
Date: Sun, 21 Dec 2014 10:14:25 -0800
Message-ID: <1419185665-19988-1-git-send-email-gjthill@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 19:14:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2l1c-0006KJ-6K
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 19:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbaLUSOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 13:14:32 -0500
Received: from mail-yh0-f44.google.com ([209.85.213.44]:40842 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbaLUSOb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 13:14:31 -0500
Received: by mail-yh0-f44.google.com with SMTP id c41so1734936yho.17
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 10:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7vZZ0qR+nBVUjQllPn0xBOlA++ak6i8NlCcpyHmt3/4=;
        b=sWz4DnjVRyKp11ynPaH8rgwIIK5t8ki3sV5KKPCmA88n7xQfZo6XzIR2cPtobPaYXJ
         BLTqrR1iuXFFru4GzdDmlmU7TnDyXGsUSuFm/ODCl3WrRaJ7AqdNT3TckAOv9qic0zc9
         6wD7OMj4NwGzJcKbxS8iSRfnwWeQKMKwzcTlHXOmrunpadTgGSCPBmL2jfeNELJp1hhL
         P088w7U4SM0vhiIXcQ53005M+RWYJwGPP2LzQFhv8UMNMZh90wQQQYLylPu3xs1BYBTL
         EOqSAr4JXrOpOjUzJK03APwI5HfRX35DZguWY53acYgwCUr8VoJ+cJatjaTdqm/Pa1rw
         SNpA==
X-Received: by 10.236.32.129 with SMTP id o1mr15016627yha.196.1419185670860;
        Sun, 21 Dec 2014 10:14:30 -0800 (PST)
Received: from gadabout.domain.actdsltmp (pool-71-189-147-248.lsanca.fios.verizon.net. [71.189.147.248])
        by mx.google.com with ESMTPSA id 21sm10148324yhj.18.2014.12.21.10.14.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Dec 2014 10:14:30 -0800 (PST)
X-Mailer: git-send-email 2.2.1.212.g51be871
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261615>

---
 templates/hooks--pre-push.sample | 1 -
 1 file changed, 1 deletion(-)

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
index 69e3c67..6187dbf 100755
--- a/templates/hooks--pre-push.sample
+++ b/templates/hooks--pre-push.sample
@@ -24,7 +24,6 @@ url="$2"
 
 z40=0000000000000000000000000000000000000000
 
-IFS=' '
 while read local_ref local_sha remote_ref remote_sha
 do
 	if [ "$local_sha" = $z40 ]
-- 
2.2.1.212.g51be871
