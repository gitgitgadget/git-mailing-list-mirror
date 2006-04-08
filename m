From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] Fix test for command line syntax.
Date: Sat, 8 Apr 2006 22:24:50 +0200
Message-ID: <20060408202450.GA5548@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 08 22:25:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSJzU-0008HC-Vb
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 22:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWDHUY4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 16:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWDHUYz
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 16:24:55 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:48806 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1751379AbWDHUYz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Apr 2006 16:24:55 -0400
Received: (qmail 5595 invoked by uid 5842); 8 Apr 2006 22:24:50 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18525>


Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

 test-delta.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

3e2552fff69fb01249fed53380e24e11754afcdf
diff --git a/test-delta.c b/test-delta.c
index 1be8ee0..94b47f0 100644
--- a/test-delta.c
+++ b/test-delta.c
@@ -27,7 +27,7 @@ int main(int argc, char *argv[])
 	void *from_buf, *data_buf, *out_buf;
 	unsigned long from_size, data_size, out_size;
 
-	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
+	if (argc != 5 || (strcmp(argv[1], "-d") || strcmp(argv[1], "-p"))) {
 		fprintf(stderr, "Usage: %s\n", usage);
 		return 1;
 	}
-- 
1.3.0.rc1.g40e9
