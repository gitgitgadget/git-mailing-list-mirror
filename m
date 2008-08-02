From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH] bash completion: Add more long options for 'git log'
Date: Fri,  1 Aug 2008 18:56:53 -0600
Message-ID: <1217638613-57366-1-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 02:58:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP5S1-00029j-AT
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 02:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbYHBA45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 20:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbYHBA45
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 20:56:57 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:55433 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbYHBA44 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 20:56:56 -0400
Received: by wa-out-1112.google.com with SMTP id j37so810476waf.23
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 17:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ueVXoODL/t0+uulIUF2zv7WS6fLZT/UE3JWkJiBMcdU=;
        b=IrYdC2HtIH1XskUFsur1p6Vb9ivIa0GqSfLXX9HWyQSYNS/KWHgm/mMZpdvumy79aL
         0eXXxro+TfJnjlk0OA8rLlebsckWIgeES2XY/yfSkS9/2bAh0VG8C2uKEB5DlNreUIrV
         gWGXj1U3/xdqmlP24mxOERK2oDa/vfSEJFwrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=gGkIxeR8EJYsrS3E8jLP38ONm2Lz9za67J+ChrX3wfVhWdj04XXx+7rXnSgDPFCVzl
         A/RuM45x/xI9XukrztKvnvvDwHVkgn0M4V/Jrf4T5xl9ioa4VLsh/a451TiJ+f9Z5DrK
         W7SJdQikR3AzyLhIHBsI5voOGpGdHN6gsomag=
Received: by 10.114.208.20 with SMTP id f20mr12308485wag.147.1217638616087;
        Fri, 01 Aug 2008 17:56:56 -0700 (PDT)
Received: from localhost.localdomain ( [75.71.41.234])
        by mx.google.com with ESMTPS id z15sm4373923pod.2.2008.08.01.17.56.54
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Aug 2008 17:56:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.27.g9b6bf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91127>

Options added: --parents --children --full-history

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 30d8701..7132a68 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -853,6 +853,7 @@ _git_log ()
 			--stat --numstat --shortstat
 			--decorate --diff-filter=
 			--color-words --walk-reflogs
+			--parents --children --full-history
 			"
 		return
 		;;
-- 
1.6.0.rc1.27.g9b6bf
