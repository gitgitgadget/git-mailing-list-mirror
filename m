From: newren@gmail.com
Subject: [PATCHv3 7/7] fast-export: Document the fact that git-rev-list arguments are accepted
Date: Thu, 25 Jun 2009 22:48:33 -0600
Message-ID: <1245991713-12782-8-git-send-email-newren@gmail.com>
References: <1245991713-12782-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusmabite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 26 06:51:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK3PH-0003HF-TV
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 06:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbZFZEu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 00:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbZFZEuz
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 00:50:55 -0400
Received: from mail-pz0-f202.google.com ([209.85.222.202]:64756 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbZFZEux (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 00:50:53 -0400
Received: by pzk40 with SMTP id 40so3878pzk.33
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 21:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=thWsQ/mvO7olRuxQBHOjgYQACcJIrGcJC1Rb/4CQbMQ=;
        b=ZopWkC5yeWbC1aftxkcPKjClEELGdbSEsBilGjuC2Ye+UtaCnF0POMw+APc+nfbZ1F
         BR7W98Nt9s3A3O/OWZAnVD8CMxRgJLWL7BnQT8qSTRJnyoZ1uW2p98Bf+RfoR9SK+X/q
         KUrFPrDY08vBtw6jfggHRalIlN7JanNZjJIIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=G1GEOE8oLr9PBPPRSEjApHVhR5UekWp+rE5/84MiLN1nZLoLurg68IQtKJPmbUXq9V
         H/zddR6TE2SWnnA3zcMd3JwYZm1Xudv6kcIDP5/EkR5GyZG8hWOXY9pnkXrcjaXWYNWQ
         oWbOUs6JhrtNl6VJdaKvhTDZSwncCXkqeH5co=
Received: by 10.142.163.13 with SMTP id l13mr1212570wfe.4.1245991856089;
        Thu, 25 Jun 2009 21:50:56 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 27sm160173wff.6.2009.06.25.21.50.54
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 21:50:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.341.g1a0a
In-Reply-To: <1245991713-12782-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122271>

From: Elijah Newren <newren@gmail.com>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
No change since the last series.

 Documentation/git-fast-export.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 194abde..af2328d 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -82,6 +82,12 @@ marks the same across runs.
 	allow that.  So fake a tagger to be able to fast-import the
 	output.
 
+[git-rev-list-args...]::
+       A list of arguments, acceptable to 'git-rev-parse' and
+       'git-rev-list', that specifies the specific objects and references
+       to export.  For example, `master\~10..master` causes the
+       current master reference to be exported along with all objects
+       added since its 10th ancestor commit.
 
 EXAMPLES
 --------
-- 
1.6.3.2.323.geb889
