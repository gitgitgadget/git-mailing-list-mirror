From: Linus Arver <linusarver@gmail.com>
Subject: [PATCH 4/7] Documentation: git-init: --separate-git-dir: clarify
Date: Sat,  2 Aug 2014 11:06:54 -0700
Message-ID: <1407002817-29221-5-git-send-email-linusarver@gmail.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
Cc: Steven Drake <sdrake@xnet.co.nz>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Linus Arver <linusarver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 20:08:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDdiu-0007qV-3I
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 20:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbaHBSH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 14:07:59 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:47261 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbaHBSH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2014 14:07:58 -0400
Received: by mail-yk0-f179.google.com with SMTP id 142so3241033ykq.10
        for <git@vger.kernel.org>; Sat, 02 Aug 2014 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5KLKMRdzs4LKHDSBCKIUTBqQWKF7FLx7jhQ4kASksCE=;
        b=QGHfmThyQxgpSCggSyB2QPFDuN8dyeqkvr/d3c2wkVqYssld3V+Nrpg8TPrZaXO+1l
         xXF/AljTj1KfJOWs2daFGKVBicIvrRGPZOFxPS4mk+OIiT0BPvzZfghyhb87LOhksHCF
         mlnzUWxZdPk6SNjLMnYSszfMcKkYMOiS+YvEag9wIO6c2zaj4jTXlU9EoQ/is0ogbFWM
         SJRv6+6mbpy51Upa0kujogJcKFui+cTzLZMHhuXz+0foAmzLdBn4pSkA//g7uWDofcg8
         5AsoFzn5ZFV0JHZBAYM41mn+Zx8qKUJ/h7b0BJTW4Em6wDYOaNmLEnzqLt0JwwiXTPHC
         uzFg==
X-Received: by 10.236.106.10 with SMTP id l10mr21039875yhg.101.1407002878122;
        Sat, 02 Aug 2014 11:07:58 -0700 (PDT)
Received: from k0.localdomain (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id i24sm20618668yha.12.2014.08.02.11.07.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Aug 2014 11:07:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.3
In-Reply-To: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254709>

Signed-off-by: Linus Arver <linusarver@gmail.com>
---
 Documentation/git-init.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index f21b85b..bf0a7ae 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -57,12 +57,12 @@ DIRECTORY" section below.)
 
 --separate-git-dir=<git dir>::
 
-Instead of initializing the repository where it is supposed to be,
-place a filesytem-agnostic Git symbolic link there, pointing to the
-specified path, and initialize a Git repository at the path. The
-result is Git repository can be separated from working tree. If this
-is reinitialization, the repository will be moved to the specified
-path.
+Separate the Git repository from your working tree.  Instead of initializing the
+repository as a directory to either `$GIT_DIR` or `./.git/`, create a text file
+there containing the path to the actual repository.  This file acts as
+filesystem-agnostic Git symbolic link to the repository.
++
+If this is reinitialization, the repository will be moved to the specified path.
 
 --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
 
-- 
2.0.3
