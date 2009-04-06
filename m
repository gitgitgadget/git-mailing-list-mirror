From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 01/14] doc/merge-config: list ecmerge as a built-in merge tool
Date: Mon,  6 Apr 2009 01:31:16 -0700
Message-ID: <1239006689-14695-2-git-send-email-davvid@gmail.com>
References: <1239006689-14695-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 06 10:34:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqkID-0002l9-6i
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbZDFIbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 04:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753884AbZDFIbu
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:31:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:11551 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbZDFIbt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 04:31:49 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2100137rvb.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 01:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4B3vl5h3uq7kajluqkjaMlDnvfP+tghHtLVipfq7+bg=;
        b=rdypZ+avAEOlwlWfS63NEkeAh0qKzG9Sij0ynUjYk6Bxz5kcl81AF4GUztT6aOXImT
         vSGoEA7rw6eyckdfsOxBVHsc6n5F/EWOOQo/yI0bI3BXOR1pQSDQpA0CQh//V3YZxXAr
         FJhwcP7FMGOaPUl7cScOo6fjAJrO6XyGDd20A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tunNyNgjXOJzMq68JUIFRP0Ehw3DRqtNK91E6aZR4/lIZja8WtbawvGTq6G+0O1eCM
         ZY1+ljD/H+wP6bsqzUIT4Cvn+5vRFRMjylrzu82hO5H5ePBkv37cMHWtbkuRhyYXEAdk
         C5FjtdUhofz1ZZrNh63Amx4z7w2PCsVHI09Ck=
Received: by 10.114.88.1 with SMTP id l1mr2155632wab.62.1239006706653;
        Mon, 06 Apr 2009 01:31:46 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id k37sm5225253waf.7.2009.04.06.01.31.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 01:31:46 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.414.g81aa9
In-Reply-To: <1239006689-14695-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115782>

From: Markus Heidelberg <markus.heidelberg@web.de>

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 Documentation/merge-config.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 1ff08ff..9c44af8 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -22,7 +22,8 @@ merge.stat::
 merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
-	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff", and
+	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff",
+	"ecmerge" and
 	"opendiff".  Any other value is treated is custom merge tool
 	and there must be a corresponding mergetool.<tool>.cmd option.
 
-- 
1.6.2.2.414.g81aa9
