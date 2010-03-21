From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 4/4] Documentation/git-clone: Transform description list into item list
Date: Sun, 21 Mar 2010 18:30:19 +0100
Message-ID: <e42082555a7956ada34713d2972d05bc3950d757.1269192495.git.git@drmicha.warpmail.net>
References: <cover.1269192495.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 18:31:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtOzQ-0003VF-7h
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 18:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259Ab0CURaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 13:30:24 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60773 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753180Ab0CURaP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 13:30:15 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9A042E9C76;
	Sun, 21 Mar 2010 13:30:15 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 21 Mar 2010 13:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=xPVDzdYnxA5nSWogo4X5ssGSzhY=; b=Ue6ZGUYvyPFG9INIXG2pFJjMxSnxLSfK7DY9yc9F6C0aCwcTMEj5zNlyEgYefBGvI62kFrUMGvJJPxxnpENDpHH8kgFiHBa+bGS7s8v5z3gq5f8GTMn8t39agnVWbu3orci/+hepCT0+VRSuGKNHtoamzvsWNM46DHhJvqhLBe4=
X-Sasl-enc: 7rj3H8turTFssbZdXFZurm2XyEa65acooUF57sQ0zZzA 1269192614
Received: from localhost (p3EE280DF.dip0.t-ipconnect.de [62.226.128.223])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BF5A7B75C;
	Sun, 21 Mar 2010 13:30:14 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.2.358.g30511
In-Reply-To: <cover.1269192495.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142844>

so that the list of examples is formatted in the same way as for
git-fetch, and, more importantly, the different identation for the
code blocks in the examples (compared to the immediately preceding code
blocks from url.txt) doesn't look like misformatted, but is clarified by
the items' bullets.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-clone.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 43cfba0..dc7d3d1 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -187,7 +187,7 @@ include::urls.txt[]
 Examples
 --------
 
-Clone from upstream::
+* Clone from upstream:
 +
 ------------
 $ git clone git://git.kernel.org/pub/scm/.../linux-2.6 my2.6
@@ -196,7 +196,7 @@ $ make
 ------------
 
 
-Make a local clone that borrows from the current directory, without checking things out::
+* Make a local clone that borrows from the current directory, without checking things out:
 +
 ------------
 $ git clone -l -s -n . ../copy
@@ -205,7 +205,7 @@ $ git show-branch
 ------------
 
 
-Clone from upstream while borrowing from an existing local directory::
+* Clone from upstream while borrowing from an existing local directory:
 +
 ------------
 $ git clone --reference my2.6 \
@@ -215,14 +215,14 @@ $ cd my2.7
 ------------
 
 
-Create a bare repository to publish your changes to the public::
+* Create a bare repository to publish your changes to the public:
 +
 ------------
 $ git clone --bare -l /home/proj/.git /pub/scm/proj.git
 ------------
 
 
-Create a repository on the kernel.org machine that borrows from Linus::
+* Create a repository on the kernel.org machine that borrows from Linus:
 +
 ------------
 $ git clone --bare -l -s /pub/scm/.../torvalds/linux-2.6.git \
-- 
1.7.0.2.358.g30511
