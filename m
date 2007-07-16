From: "Francis Moreau" <francis.moro@gmail.com>
Subject: [PATCH] Fix git-branch documentation when using remote refs
Date: Mon, 16 Jul 2007 13:38:47 +0200
Message-ID: <38b2ab8a0707160438v4365da74m20eca9334fd1d927@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 13:38:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAOuh-0007Yc-F7
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 13:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbXGPLit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 07:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbXGPLit
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 07:38:49 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:36904 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755540AbXGPLis (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 07:38:48 -0400
Received: by nz-out-0506.google.com with SMTP id s18so807002nze
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 04:38:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=utKBzX6/l9pST9GdmlNVKVXILi6pg3cjjiNifenNQeKgaKoF6kYOasn8iYpKUNFmrpDEBM1xIgGh8wisQHlRWJQBELlgzK1GqZi+2hakIK6YVt0FOZUA+yOz85BbzaH6R/7KojcEDwOe936Em1oEn3f9mnMbQ8vYqfD3utLgyZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YxOpCB11fWjfgfgJncNdEtwor+kiN3aJyZvRdNBXinG2Tc2JOaRI7R+HgvIzPYsfMHTqy3ara0Lbqnsk1sDKWKalUoywEtfaJVCEHsCM/4jYQccHEoyn9/v8/u3WaqMyzw0hcJxS8UvdFn1KlAE85QRszlXZ3V3/sKj2fqXsyvM=
Received: by 10.115.60.1 with SMTP id n1mr4067349wak.1184585927129;
        Mon, 16 Jul 2007 04:38:47 -0700 (PDT)
Received: by 10.115.47.5 with HTTP; Mon, 16 Jul 2007 04:38:47 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52664>

Signed-off-by: Francis Moreau <francis.moro@gmail.com>
---
 Documentation/git-branch.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index bb6b57d..bc6aa88 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -130,8 +130,8 @@ Delete unneeded branch::
 ------------
 $ git clone git://git.kernel.org/.../git.git my.git
 $ cd my.git
-$ git branch -d -r todo html man   <1>
-$ git branch -D test               <2>
+$ git branch -d -r origin/todo origin/html origin/man   <1>
+$ git branch -D test                                    <2>
 ------------
 +
 <1> delete remote-tracking branches "todo", "html", "man"
