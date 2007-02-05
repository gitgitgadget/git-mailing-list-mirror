From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] git-for-each-ref doesn't return "the bit after $GIT_DIR/refs"
Date: Mon, 5 Feb 2007 19:58:47 +0000
Message-ID: <200702051958.47237.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 21:01:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEA29-0004pu-7z
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 21:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933150AbXBEUBl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 15:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933063AbXBEUBl
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 15:01:41 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:48934 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933141AbXBEUBj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 15:01:39 -0500
Received: by an-out-0708.google.com with SMTP id b33so1116172ana
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 12:01:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=OdOAdwcUkzw552zQnzqNKQ2HYWQ6jyWtUT642FfyW9fNhPVtZQ6DDmCQye/fWsLC5NUKE8Fq5Et58eRVJKe9BBuVnfAd2Fk+XePUCErdqrqoSPaoKRo5O4qrZZN6SVpRNfhUtCPvWjuB4te8oAq7yfXndRDNwUcwD338DFq83Qk=
Received: by 10.100.174.16 with SMTP id w16mr5330149ane.1170705698776;
        Mon, 05 Feb 2007 12:01:38 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 24sm10831015ugf.2007.02.05.12.01.36;
        Mon, 05 Feb 2007 12:01:36 -0800 (PST)
X-TUID: 115ad51fc804308f
X-UID: 219
X-Length: 1015
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38776>

The documentation for git-for-each-ref said that the refname variable
would return "the part after $GIT_DIR/refs/", which isn't true.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 Documentation/git-for-each-ref.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index da52eba..f49b0d9 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -66,7 +66,7 @@ keys.
 For all objects, the following names can be used:
 
 refname::
-	The name of the ref (the part after $GIT_DIR/refs/).
+	The name of the ref (the part after $GIT_DIR/).
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
-- 
1.5.0.rc1.gf4b6c
