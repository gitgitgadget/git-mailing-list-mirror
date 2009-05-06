From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/2] user-manual: use 'fast-forward' instead of 'fast forward'
Date: Thu,  7 May 2009 01:53:36 +0300
Message-ID: <1241650416-12224-3-git-send-email-felipe.contreras@gmail.com>
References: <1241650416-12224-1-git-send-email-felipe.contreras@gmail.com>
 <1241650416-12224-2-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 00:54:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1q0N-0005VM-K9
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 00:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbZEFWxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 18:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbZEFWxx
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 18:53:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:52828 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbZEFWxr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 18:53:47 -0400
Received: by fg-out-1718.google.com with SMTP id 16so153405fgg.17
        for <git@vger.kernel.org>; Wed, 06 May 2009 15:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tunaOmOd7lWyHJk8ca6JROpgm4hEKAI9P6bmlecSkSw=;
        b=rlUiVVSML1tGHJ8f4P3owU/4fbcgtBQP0/UhyBpDt1BDKEC/pXBxClDR+W75CSgdSf
         cOrBuhTYYqLULvmXLCKB9O0iVUYSIFbySfCzpCW384psJ/RrqLe8agfAjhm8u4T5LKKP
         52rgq2mN1FA56uErKlzaFP8O13J9c/EGGN+mQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WmxGJOEEjjI/fRlhTZjq4BXX7AEH1e6PbWdn2hYKt4XVNHM46KUJ+Tv8jQS1hOwdGj
         OPo4LwwgQKah1REKpcFD2l8/my6yudltY60F6Olco17nCu1B2phg1L9nNTG13/Xm+J3E
         WGcFMCKu/LLC3uwCuyI9a1JI84O50MIaUsKII=
Received: by 10.86.65.9 with SMTP id n9mr1838826fga.47.1241650426294;
        Wed, 06 May 2009 15:53:46 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 12sm15953911fgg.10.2009.05.06.15.53.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 May 2009 15:53:45 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc4.14.g96da.dirty
In-Reply-To: <1241650416-12224-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118398>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index a8558a1..9978027 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1384,7 +1384,7 @@ were merged.
 
 However, if the current branch is a descendant of the other--so every
 commit present in the one is already contained in the other--then git
-just performs a '``fast forward'''; the head of the current branch is moved
+just performs a 'fast-forward'; the head of the current branch is moved
 forward to point at the head of the merged-in branch, without any new
 commits being created.
 
@@ -1719,7 +1719,7 @@ producing a default commit message documenting the branch and
 repository that you pulled from.
 
 (But note that no such commit will be created in the case of a
-<<fast-forwards,fast forward>>; instead, your branch will just be
+<<fast-forwards,fast-forward>>; instead, your branch will just be
 updated to point to the latest commit from the upstream branch.)
 
 The `git pull` command can also be given '"."' as the 'remote' repository,
@@ -1943,7 +1943,7 @@ $ git push ssh://yourserver.com/~you/proj.git master
 -------------------------------------------------
 
 As with `git fetch`, `git push` will complain if this does not result in a
-<<fast-forwards,fast forward>>; see the following section for details on
+<<fast-forwards,fast-forward>>; see the following section for details on
 handling this case.
 
 Note that the target of a 'push' is normally a
@@ -1976,7 +1976,7 @@ details.
 What to do when a push fails
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-If a push would not result in a <<fast-forwards,fast forward>> of the
+If a push would not result in a <<fast-forwards,fast-forward>> of the
 remote branch, then it will fail with an error like:
 
 -------------------------------------------------
@@ -2115,7 +2115,7 @@ $ git checkout release && git pull
 
 *Important note!*  If you have any local changes in these branches, then
 this merge will create a commit object in the history (with no local
-changes git will simply do a 'fast forward' merge).  Many people dislike
+changes git will simply do a 'fast-forward' merge).  Many people dislike
 the ``noise'' that this creates in the Linux history, so you should avoid
 doing this capriciously in the 'release' branch, as these noisy commits
 will become part of the permanent history when you ask Linus to pull
@@ -2729,9 +2729,9 @@ In the previous example, when updating an existing branch, "git fetch"
 checks to make sure that the most recent commit on the remote
 branch is a descendant of the most recent commit on your copy of the
 branch before updating your copy of the branch to point at the new
-commit.  Git calls this process a <<fast-forwards,fast forward>>.
+commit.  Git calls this process a <<fast-forwards,fast-forward>>.
 
-A 'fast forward' looks something like this:
+A 'fast-forward' looks something like this:
 
 ................................................
  o--o--o--o <-- old head of the branch
-- 
1.6.3.rc4.14.g96da.dirty
