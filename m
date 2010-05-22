From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH 5/5] bash completion: add --orphan to 'git checkout'
Date: Fri, 21 May 2010 21:43:52 -0300
Message-ID: <1274488119-6989-6-git-send-email-erick.mattos@gmail.com>
References: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com>
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 02:44:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFcp7-0005Qx-LV
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 02:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787Ab0EVAoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 20:44:11 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:35904 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932767Ab0EVAoK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 20:44:10 -0400
Received: by gxk27 with SMTP id 27so954430gxk.1
        for <git@vger.kernel.org>; Fri, 21 May 2010 17:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cvzmmiu7XYA+FXtN6BxjBJDvFGrC9VUXBLAvmRsmBRA=;
        b=jGdNCx3P6IlgCNe7qambK0ywDCfqS5w+gVyF8eLZUWKPPvK4lBTTjE8eCTTI7tTkuB
         VruhMgICJZqse+lJIF/09TNvdH4sN59kiFPxk26nxpRJBk3DYcK7jGd4VRQgMLRSFheF
         Gg9a0j9uwkVilFO2vrgiHh+6flIyc9cfFnv/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mTMJRI6G6MMUxA/F0kNJrDoq50+qD3O07IiPoYE20C9vB3wse9tDNHZhx4sBOAja0i
         snDqtYHrO6Mu3dFEFiqyzDSwj0iuW5TpXUqzbL3MQ3CKsIgH1/ig5HRHtoKSxQw9aILu
         kIHM6I+BevEBGYFaCYh/UqA82RxShzO9HLCaw=
Received: by 10.150.131.12 with SMTP id e12mr3584467ybd.237.1274489049669;
        Fri, 21 May 2010 17:44:09 -0700 (PDT)
Received: from localhost.localdomain ([187.15.117.192])
        by mx.google.com with ESMTPS id z32sm23602049ybc.23.2010.05.21.17.44.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 May 2010 17:44:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.231.g0687c.dirty
In-Reply-To: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147502>

Updating git-completion.bash with new --orphan option to 'git checkout'.
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 545bd4b..b70cca1 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -841,7 +841,7 @@ _git_checkout ()
 	--*)
 		__gitcomp "
 			--quiet --ours --theirs --track --no-track --merge
-			--conflict= --patch
+			--conflict= --orphan --patch
 			"
 		;;
 	*)
-- 
1.7.1.231.g0687c.dirty
