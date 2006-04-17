From: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: [PATCH 5/7] cleanups: Remove unused variable from sha1_file.c
Date: Mon, 17 Apr 2006 10:14:48 -0500 (CDT)
Message-ID: <20060417151448.1D99C19B912@sergelap.hallyn.com>
References: <20060417145148.2F3CB19C90D@sergelap.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 17 17:15:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVVRN-0006b0-7R
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 17:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWDQPO7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 11:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWDQPO6
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 11:14:58 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:17037 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751092AbWDQPO5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Apr 2006 11:14:57 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3HFEsVW006257
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:54 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3HFEnkk232032
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:49 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3HFEmlA017262
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:48 -0400
Received: from sergelap.hallyn.com ([9.49.218.134])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id k3HFEmjK017239
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:48 -0400
Received: by sergelap.hallyn.com (Postfix, from userid 1000)
	id 1D99C19B912; Mon, 17 Apr 2006 10:14:48 -0500 (CDT)
To: git@vger.kernel.org
Content-Disposition: inline
X-Mutt-Fcc: =SENT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18824>

Left is assigned to, but never used in sha1_file.c

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 sha1_file.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

0c6ecfcb112a0fb3f1ea51d8e3c220aae235a007
diff --git a/sha1_file.c b/sha1_file.c
index e3d0113..4301c80 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -874,13 +874,12 @@ void packed_object_info_detail(struct pa
 			       unsigned char *base_sha1)
 {
 	struct packed_git *p = e->p;
-	unsigned long offset, left;
+	unsigned long offset;
 	unsigned char *pack;
 	enum object_type kind;
 
 	offset = unpack_object_header(p, e->offset, &kind, size);
 	pack = p->pack_base + offset;
-	left = p->pack_size - offset;
 	if (kind != OBJ_DELTA)
 		*delta_chain_length = 0;
 	else {
-- 
1.2.5
