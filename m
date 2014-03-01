From: Gilles Filippini <gilles.filippini@free.fr>
Subject: [PATCH] contrib/subtree - unset prefix before proceeding
Date: Sat, 01 Mar 2014 17:33:32 +0100
Message-ID: <53120BDC.9000406@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090503090504090006040405"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 17:34:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJmrb-0000Ip-6i
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 17:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbaCAQeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 11:34:06 -0500
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:58624 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbaCAQeF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 11:34:05 -0500
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id C8D3F77CDF8
	for <git@vger.kernel.org>; Sat,  1 Mar 2014 17:33:59 +0100 (CET)
Received: from [129.200.100.4] (unknown [88.189.102.17])
	by smtp5-g21.free.fr (Postfix) with ESMTP id BA66DD4809A
	for <git@vger.kernel.org>; Sat,  1 Mar 2014 17:33:34 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243103>

This is a multi-part message in MIME format.
--------------090503090504090006040405
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is to prevent unwanted prefix when such an environment variable
exists. The case occurs for example during the Debian package build
where the git-subtree test suite is called with 'prefix=/usr', which
makes test 21 fail:
not ok 21 - Check that prefix argument is required for split

Signed-off-by: Gilles Filippini <gilles.filippini@free.fr>
---
 contrib/subtree/git-subtree.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index dc59a91..db925ca 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -46,6 +46,7 @@ ignore_joins=
 annotate=
 squash=
 message=
+prefix=
 
 debug()
 {
-- 
1.9.0


--------------090503090504090006040405
Content-Type: text/plain; charset=UTF-8;
 name="Portion de message joint"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Portion de message joint"


--------------090503090504090006040405--
