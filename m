From: Robert Zeh <robert.a.zeh@gmail.com>
Subject: [PATCH] Add git svn gc to bash completion
Date: Wed, 29 Jul 2009 20:53:50 -0500
Message-ID: <57d579150907291853ue7058b0sfb31733798e9b6e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 03:54:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWKqQ-0007yz-7e
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 03:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbZG3Bxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 21:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbZG3Bxv
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 21:53:51 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:55515 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbZG3Bxv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 21:53:51 -0400
Received: by gxk9 with SMTP id 9so2183148gxk.13
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 18:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=xZJ0z9tlgDmHjGWc2taDVrZqOZqyB7meb68jnxLR5Vo=;
        b=GnxIDdy4Y0To8x41MqYLL7BlSBd1WXP0t5mJVC30FMp9j3TAY7feqMRJYK2nSvZNS4
         TVuhfyBiZlRx9bY358KVOOUw0beBHF/fMOGd59R1z3XV+Gw/H6uCBzYjdU+7TDkcFddR
         vHdOO+eAb4Ob+aufBG6S4KxCMMje0p5giHhWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=nViP7c/714V+ZFnMGRaSh6WQP7Vp8PLSKdc0dhNYHac0E0kjHt5YCZdVw1rAIr+COV
         eF+gyqqZT8IMQ15uFxr/B96UX62oxRYqaxlwRlL+fJL+I1zHa6Ij3SxLJ5kRxSYrzWOO
         3yt8g7KGqwrRUeEuM5KYwHMOSq419nlk2UZiA=
Received: by 10.151.10.1 with SMTP id n1mr960252ybi.277.1248918830911; Wed, 29 
	Jul 2009 18:53:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124436>

Signed-off-by: Robert Allan Zeh <robert.a.zeh@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 887731e..96ba9f3 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1922,7 +1922,7 @@ _git_submodule ()
 _git_svn ()
 {
 	local subcommands="
-		init fetch clone rebase dcommit log find-rev
+		init fetch clone rebase dcommit log find-rev gc
 		set-tree commit-diff info create-ignore propget
 		proplist show-ignore show-externals branch tag blame
 		migrate
-- 
1.6.4.rc1.10.g2a67.dirty
