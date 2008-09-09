From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 3/6] t9700: use "git config" without dash
Date: Wed, 10 Sep 2008 06:25:26 +0900
Message-ID: <20080910062526.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:28:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdAkh-0007Te-PB
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 23:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbYIIV0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 17:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbYIIV0Z
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 17:26:25 -0400
Received: from karen.lavabit.com ([72.249.41.33]:33445 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753228AbYIIV0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 17:26:24 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 3B48CC89DB;
	Tue,  9 Sep 2008 16:26:15 -0500 (CDT)
Received: from 9677.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id KC4W5YLAUQVH; Tue, 09 Sep 2008 16:26:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=ZwNskXkVXQIV0GPulC5QBkxh9/Snm4vu7gYp74w8pWg21dFyQGBuDjUy8nLCp38zftDTiznRU2iuo3miz/bocNJUkx6SPLijqBOMeJ9m85pw9H508CMo1Sr3det7gA6hznhqWkGwBEQE/jli/Lb+sZo1kI2HJuU+RfMjAvbV1Ks=;
  h=From:To:Cc:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Message-Id:Signed-off-by;
Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95437>

---
 t/t9700-perl-git.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 0f04ba0..b81d5df 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -27,14 +27,14 @@ test_expect_success \
      echo "changed file 1" > file1 &&
      git commit -a -m "second commit" &&
 
-     git-config --add color.test.slot1 green &&
-     git-config --add test.string value &&
-     git-config --add test.dupstring value1 &&
-     git-config --add test.dupstring value2 &&
-     git-config --add test.booltrue true &&
-     git-config --add test.boolfalse no &&
-     git-config --add test.boolother other &&
-     git-config --add test.int 2k
+     git config --add color.test.slot1 green &&
+     git config --add test.string value &&
+     git config --add test.dupstring value1 &&
+     git config --add test.dupstring value2 &&
+     git config --add test.booltrue true &&
+     git config --add test.boolfalse no &&
+     git config --add test.boolother other &&
+     git config --add test.int 2k
      '
 
 test_external_without_stderr \
-- 
1.6.0.1


-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
