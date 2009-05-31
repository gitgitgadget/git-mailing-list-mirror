From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] config.txt: document add.ignore-errors
Date: Sat, 30 May 2009 22:08:02 -0700
Message-ID: <1243746482-11700-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 31 07:10:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAdJT-0005p1-JW
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 07:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbZEaFIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 01:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbZEaFIF
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 01:08:05 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:55753 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbZEaFIE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 01:08:04 -0400
Received: by pzk7 with SMTP id 7so5432978pzk.33
        for <git@vger.kernel.org>; Sat, 30 May 2009 22:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=MYWd54mwz9OxozcyT/O4J++S07ZKQ9hdVyJSyFL8shg=;
        b=PNfazkxhzv1y+RRImcptBit2bSZsiQ+lj4MROBHZKJ7Gkmyv2gQBpVRtP5hh0QKWPi
         UE+qrijUwWZZcK3+SPsy7kDVftpXcSxZiiNVvho98mjDXbLoAFgXlFgO0Y6UoUpny7Mq
         0AdgbwIRT/g6V4h6Tk98tKKGnehzsjHB9yesM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=cwB5HTKQmkBAANOE7HVunD6e5rydbMLbDsq8M/0sJitNo31Cx86v4PIZSH7kYPlYCM
         Yw45ojbwfoh6SBBXRbyIAVOa378TLBRsYrECosHUvuT+RoRgPJ+NLmHpbaNHMwkKxW3j
         gJUsOgQpTeVNGooKJ16a6BqjyeLoDoDtYijd4=
Received: by 10.141.132.1 with SMTP id j1mr4075742rvn.124.1243746485860;
        Sat, 30 May 2009 22:08:05 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id c26sm4242620waa.15.2009.05.30.22.08.03
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 May 2009 22:08:05 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 30 May 2009 22:08:02 -0700
X-Mailer: git-send-email 1.6.3.1.175.g3be7e0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120381>

Use the description of "--ignore-errors" from git-add.txt as
inspiration.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/config.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2c03162..3a86d1f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -438,6 +438,11 @@ On some file system/operating system combinations, this is unreliable.
 Set this config setting to 'rename' there; However, This will remove the
 check that makes sure that existing object files will not get overwritten.
 
+add.ignore-errors::
+	Tells 'git-add' to continue adding files when some files cannot be
+	added due to indexing errors. Equivalent to the '--ignore-errors'
+	option of linkgit:git-add[1].
+
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
-- 
1.6.3.1.175.g3be7e0
