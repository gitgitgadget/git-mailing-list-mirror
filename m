From: Ben Clifford <benc@hawaga.org.uk>
Subject: [PATCH] include header to define uint32_t, necessary on Mac OS X
Date: Sun, 14 May 2006 20:58:33 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0605142057220.10680@mundungus.clifford.ac>
References: <20060511173632.G60c08b4@leonov.stosberg.net>
 <Pine.LNX.4.64.0605111054290.3866@g5.osdl.org> <7v7j4swg0r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605111218380.3866@g5.osdl.org> <7viroav534.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605142056320.3038@mundungus.clifford.ac>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Dennis Stosberg <dennis@stosberg.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 14 22:59:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfNg7-0002r8-Rc
	for gcvg-git@gmane.org; Sun, 14 May 2006 22:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWENU7B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 16:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWENU7A
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 16:59:00 -0400
Received: from mundungus.clifford.ac ([81.187.211.39]:23303 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S1751387AbWENU7A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 16:59:00 -0400
Received: from mundungus.clifford.ac (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id k4EKwZvm028769
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 14 May 2006 20:58:36 GMT
Received: from localhost (benc@localhost)
	by mundungus.clifford.ac (8.13.3/8.13.3/Submit) with ESMTP id k4EKwXS8028764;
	Sun, 14 May 2006 20:58:33 GMT
X-Authentication-Warning: mundungus.clifford.ac: benc owned process doing -bs
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0605142056320.3038@mundungus.clifford.ac>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19982>


From: Ben Clifford <benc@hawaga.org.uk>
Date: Sun, 14 May 2006 21:34:56 +0100
Subject: [PATCH] include header to define uint32_t, necessary on Mac OS X

---

  pack-objects.c |    1 +
  sha1_file.c    |    1 +
  2 files changed, 2 insertions(+), 0 deletions(-)

2ee926ab9da67ef2a6ca28bb70954a33d65ba466
diff --git a/pack-objects.c b/pack-objects.c
index 1b9e7a1..5466b15 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -10,6 +10,7 @@ #include "csum-file.h"
  #include "tree-walk.h"
  #include <sys/time.h>
  #include <signal.h>
+#include <stdint.h>

  static const char pack_usage[] = "git-pack-objects [-q] [--no-reuse-delta] [--non-empty] [--local] [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list";

diff --git a/sha1_file.c b/sha1_file.c
index 631a605..3372ebc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -13,6 +13,7 @@ #include "blob.h"
  #include "commit.h"
  #include "tag.h"
  #include "tree.h"
+#include <stdint.h>

  #ifndef O_NOATIME
  #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
-- 
1.3.2.g5f7f2-dirty
