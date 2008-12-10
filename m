From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH 2/2] bash completion: Use 'git add' completions for 'git stage'
Date: Wed, 10 Dec 2008 12:39:18 -0700
Message-ID: <1228937958-5091-2-git-send-email-lee.marlow@gmail.com>
References: <1228937958-5091-1-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 10 20:41:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAUvo-0003ry-I7
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 20:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbYLJTjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 14:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755100AbYLJTjo
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 14:39:44 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:61060 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbYLJTjn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 14:39:43 -0500
Received: by fg-out-1718.google.com with SMTP id 19so301445fgg.17
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 11:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=U9zqd3RMwJl13T79WoiRdJ3PaW6qe9tMSDvVkE3z2ic=;
        b=cW5wKmmaIvWM5FL9c1M/LEl8gd5rhAgR/lXYidMwHjNbmg72c7HRAfJYD9Vg10el8o
         Bmmr0PxqL8DAo90jjst73Mz7gP6uc7fmv2a0zCorkDkz4wFki/RleojVgfsaW8GFGyPP
         AZWXZcHcj7X68UkMo4yU/Vhw8xHzcxw9InY9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=H/GyhK1RdUA4dNyHwIUvK02pWCB9wm4DGQgOlxoX/1bUpiQ8fHc2lCZ8AR0XUZDevc
         lYxvQPW2iKf71DnphgLGniSDBDcyum5jBLrccUTJnazw0VoqpjXlayUGdZPrKxzv4Hea
         IWLz65MSWwQ1um4aSXjnSAlx86NCz6pICvT6k=
Received: by 10.103.160.3 with SMTP id m3mr667217muo.25.1228937982226;
        Wed, 10 Dec 2008 11:39:42 -0800 (PST)
Received: from localhost.localdomain ([12.25.108.178])
        by mx.google.com with ESMTPS id g1sm2581164muf.47.2008.12.10.11.39.37
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Dec 2008 11:39:40 -0800 (PST)
X-Mailer: git-send-email 1.6.1.rc2.14.g5363d
In-Reply-To: <1228937958-5091-1-git-send-email-lee.marlow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102705>

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5356e5b..7e2b482 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1660,6 +1660,7 @@ _git ()
 	show)        _git_show ;;
 	show-branch) _git_show_branch ;;
 	stash)       _git_stash ;;
+	stage)       _git_add ;;
 	submodule)   _git_submodule ;;
 	svn)         _git_svn ;;
 	tag)         _git_tag ;;
-- 
1.6.1.rc2.14.g5363d
