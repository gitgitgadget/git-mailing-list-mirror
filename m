From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH 1/2] bash completion: Add '--intent-to-add' long option for 'git add'
Date: Wed, 10 Dec 2008 12:39:17 -0700
Message-ID: <1228937958-5091-1-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 10 20:41:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAUvZ-0003kf-Ll
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 20:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209AbYLJTjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 14:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754513AbYLJTji
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 14:39:38 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:5760 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbYLJTjh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 14:39:37 -0500
Received: by ey-out-2122.google.com with SMTP id 6so123597eyi.37
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 11:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=svf1OucflabAw/s4mEu0KcBJ8XuBrGnd+0Fcc0wdgr8=;
        b=Iin33ll/KObnZJvW8ICgU8IA51ulvOSRtuRpqFvpSdWO8klVEzN1oFPgTn+6hT4Jze
         HecRh9IEcGsFGxdmTuXZfvZovkKDerW3YipxfecF8u6aU9hG25niIneVfPv5LkC0ifWp
         2P/pPYTp3R8NqzoHIZug1tGWBMQ0V82LQXO8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=FGmE7XSd8mYZMHbLLIbD5/4E08gUG8GjZMfYbR0GoC0jz13dpQBb/BeXOL+4sKi3nj
         7zQ3sZ3ZDFIYuzfG6DccwBFjgYOiLjKVHbbZ2VDoUSmHwkdLP3boCFkFW1GoC2B87Vlu
         inmneBuKYi5L5w3UT8uHUl2/IDJydr4IKaDRY=
Received: by 10.103.131.18 with SMTP id i18mr657328mun.74.1228937975790;
        Wed, 10 Dec 2008 11:39:35 -0800 (PST)
Received: from localhost.localdomain ([12.25.108.178])
        by mx.google.com with ESMTPS id g1sm2581164muf.47.2008.12.10.11.39.31
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Dec 2008 11:39:34 -0800 (PST)
X-Mailer: git-send-email 1.6.1.rc2.14.g5363d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102704>

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c79c98f..5356e5b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -563,7 +563,7 @@ _git_add ()
 	--*)
 		__gitcomp "
 			--interactive --refresh --patch --update --dry-run
-			--ignore-errors
+			--ignore-errors --intent-to-add
 			"
 		return
 	esac
-- 
1.6.1.rc2.14.g5363d
