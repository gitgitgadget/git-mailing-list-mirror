From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] Add missing test file for UTF-16.
Date: Sat,  3 Aug 2013 17:26:31 +0000
Message-ID: <1375550791-5823-1-git-send-email-sandals@crustytoothpaste.net>
Cc: pclouds@gmail.com, peter@softwolves.pp.se,
	stefano.lattarini@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 19:27:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5fbY-0001Tj-7U
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 19:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563Ab3HCR0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 13:26:38 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:45660 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752482Ab3HCR0h (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Aug 2013 13:26:37 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2C09828078;
	Sat,  3 Aug 2013 17:26:36 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231612>

The test file that the UTF-16 rejection test looks for is missing, but this went
unnoticed because the test is expected to fail anyway; as a consequence, the
test fails because the file containing the commit message is missing, and not
because the test file contains a NUL byte.  Fix this by including a sample text
file containing a commit message encoded in UTF-16.
---
 t/t3900/UTF-16.txt | Bin 0 -> 146 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 t/t3900/UTF-16.txt

diff --git a/t/t3900/UTF-16.txt b/t/t3900/UTF-16.txt
new file mode 100644
index 0000000000000000000000000000000000000000..2257f05a992a4b9500f6ff33752cbdf8fb58c99d
GIT binary patch
literal 146
zcmW-aJqm<C6obFoQ_KYvZ0uz~uwFfY_=AGZf}@2;@>bjKEzFY?FCi}po-doQaNvlX
zuj<&j$Vh~SS#Fd&>8^}o3xQtzWRNy5zCGpzu|P`62Tv_HZgu?B*(r7K7qg7DI9e@K
J`p+qB@d1eo8QA~;

literal 0
HcmV?d00001

-- 
1.8.4.rc1
