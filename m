From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 2/2] completion: Add --signature and format.signature
Date: Tue, 15 Jun 2010 22:59:26 -0700
Message-ID: <1276667966-18422-2-git-send-email-bebarino@gmail.com>
References: <1276578039-25023-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 16 07:59:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOlf1-000813-ET
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 07:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092Ab0FPF7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 01:59:36 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64853 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755500Ab0FPF7c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 01:59:32 -0400
Received: by mail-vw0-f46.google.com with SMTP id 13so2242668vws.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 22:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nvs+dVscVzmliOXkoKP3+tAxggPMMFH5sVQ0cjUGz94=;
        b=b8dc3fD22HjVCLDIs7EZmUNBdGtLE55zOSPuI2macgXOMTPUPrviNcIYy3ayc9OkHt
         4gg2EknUf70D22sTNQq7vKuKP/fVLAjIVzx6+4Y18rDdeXx6HAlFFbZ3vzDvFErcEqhV
         8A5pydk3AkdFneNjW9GuwQIVRdJhcZ8F7hW5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Utr3bNMQuWsnbi+kG5s9xNNk9gkDBoJoed6Lnw7UJdbrEMcAh1TWYT2fc+VS8tNHnX
         Fyd1HKFRk07TytvxjO7tPO+/+xjK+d3K9L6P5ICCLiKshjUdbSdhNqb286cpxE2zj6Zy
         VZ90m83GdWX3bEfLwuyURu5CZWGfBq6Db8w0Q=
Received: by 10.220.63.208 with SMTP id c16mr4567751vci.153.1276667972469;
        Tue, 15 Jun 2010 22:59:32 -0700 (PDT)
Received: from localhost ([24.152.169.138])
        by mx.google.com with ESMTPS id s20sm6984249vcr.4.2010.06.15.22.59.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Jun 2010 22:59:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.257.g678728
In-Reply-To: <1276578039-25023-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149249>

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

 Changes since v1:
  - Fixed subject (hah --signoff was totally wrong)

 contrib/completion/git-completion.bash |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 57245a8..d950776 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1052,7 +1052,7 @@ _git_format_patch ()
 			--numbered --start-number
 			--numbered-files
 			--keep-subject
-			--signoff
+			--signoff --signature --no-signature
 			--in-reply-to= --cc=
 			--full-index --binary
 			--not --all
@@ -1726,6 +1726,7 @@ _git_config ()
 		format.headers
 		format.numbered
 		format.pretty
+		format.signature
 		format.signoff
 		format.subjectprefix
 		format.suffix
-- 
1.7.1.257.g678728
