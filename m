From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] enter_repo missing its prototype
Date: Mon, 21 Nov 2005 09:14:36 +0100
Message-ID: <81b0412b0511210014q54a62878ubaf1e975930758ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_12595_25841749.1132560876263"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 09:15:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee6oy-0007NE-HC
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 09:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVKUIOh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 03:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVKUIOh
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 03:14:37 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:13439 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932210AbVKUIOh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 03:14:37 -0500
Received: by nproxy.gmail.com with SMTP id n28so63824nfc
        for <git@vger.kernel.org>; Mon, 21 Nov 2005 00:14:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=UnYbWExlvsBrnirCB3GfbyVKACTHa9uOBOoiCqNMBHkWo8ObM7uWp3WmDKxb2kV5TM2loy9vPolrdAp/ccEsGgWrA48lb+6Wf0GqURCko+lRXRO2nn53WVsxUGYYpqx1+ASLH6jDv6V2sdGqSMnNbOMVCseJ7mxsvFLkoBU3VCw=
Received: by 10.49.41.2 with SMTP id t2mr229653nfj;
        Mon, 21 Nov 2005 00:14:36 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Mon, 21 Nov 2005 00:14:36 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12428>

------=_Part_12595_25841749.1132560876263
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

enter_repo was missing its prototype

Signed-off-by: Alex Riesen <ariesen@gmail.com>

------=_Part_12595_25841749.1132560876263
Content-Type: text/plain; name=0001-enter_repo-missing-its-prototype.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0001-enter_repo-missing-its-prototype.txt"

Subject: [PATCH] enter_repo missing its prototype
(cherry picked from 00de97b561c4114e89a8d2f5c8af08403278d8fa commit)

Signed-off-by: Alex Riesen <ariesen@harmanbecker.com>


---

 cache.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

applies-to: e12ceef6841365e64bb765294235a67e9263d7de
64c38741ba2b5840990b695ec3dbaa51a3427c4b
diff --git a/cache.h b/cache.h
index a7c1bbd..80f69a7 100644
--- a/cache.h
+++ b/cache.h
@@ -204,6 +204,8 @@ int git_mkstemp(char *path, size_t n, co
 int safe_create_leading_directories(char *path);
 char *safe_strncpy(char *, const char *, size_t);
 
+extern char *enter_repo(char *path, int strict);
+
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int unpack_sha1_header(z_stream *stream, void *map, unsigned long mapsize, void *buffer, unsigned long size);
 extern int parse_sha1_header(char *hdr, char *type, unsigned long *sizep);
---
0.99.9.GIT

------=_Part_12595_25841749.1132560876263--
