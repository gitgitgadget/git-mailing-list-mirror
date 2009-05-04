From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 3/5] completion: complete values for help.format
Date: Sun,  3 May 2009 23:25:33 -0700
Message-ID: <1241418335-18474-3-git-send-email-bebarino@gmail.com>
References: <1241418335-18474-1-git-send-email-bebarino@gmail.com>
 <1241418335-18474-2-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 04 08:26:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0rd9-0004vC-RA
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 08:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbZEDGZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 02:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752585AbZEDGZ7
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 02:25:59 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:60755 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbZEDGZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 02:25:58 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2785056rvb.1
        for <git@vger.kernel.org>; Sun, 03 May 2009 23:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=y/kIqFSbq3gMzMwyWuI8WDzCWLGKo6dJjVRJUzKKNdA=;
        b=kVJbpohsifmk0zTkp3x++5N3+VmTbe/rZrwzNBMEvuRxGo32k3yRbdXrW4ZbULVbH1
         RZQC2go5Qyyaz7iGOSDJ0L6UB3f3wx+E+ZR/mRI6R3fG/fmySoYMzsDtezSW91mvNTJD
         9jjuNn/dD4E7UdmMHcd4tG3JZMI4fDdryLsKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FRNIlmewMnPiBb2nPf1yaxxzzAahqVO/QfMYe5CmCsSCPm+dr7ftcesf9skDGlW4g0
         FKVFU9LQnqmzf8kfY23FXqNB3QCJfk2mPZwH/lV7lZh/zrL7+Y2wx+j+1KK1AKMVSgIj
         VEX5yNDtUSIr9lR8VL41TpLPXTMpIOKz8mirk=
Received: by 10.143.31.11 with SMTP id i11mr2070949wfj.289.1241418359078;
        Sun, 03 May 2009 23:25:59 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 30sm11954790wff.29.2009.05.03.23.25.53
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 May 2009 23:25:58 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 03 May 2009 23:25:52 -0700
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <1241418335-18474-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118207>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ec02b06..023b0c9 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1348,6 +1348,10 @@ _git_config ()
 			"
 		return
 		;;
+	help.format)
+		__gitcomp "man info web html"
+		return
+		;;
 	*.*)
 		COMPREPLY=()
 		return
-- 
1.6.2.3
