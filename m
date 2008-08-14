From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH 2/2] bash completion: Add '--merge' long option for 'git log'
Date: Thu, 14 Aug 2008 16:41:11 -0600
Message-ID: <1218753671-58099-3-git-send-email-lee.marlow@gmail.com>
References: <1218753671-58099-1-git-send-email-lee.marlow@gmail.com>
 <1218753671-58099-2-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:42:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTlWa-000872-On
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbYHNWlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 18:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbYHNWlV
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:41:21 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:36028 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbYHNWlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:41:19 -0400
Received: by rv-out-0506.google.com with SMTP id k40so635822rvb.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 15:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ko4b+quRsYQ23nNr2WFG9CD3LEdJiTpWKzUYmIJqChA=;
        b=I9o3PHVaSKjdkODl1djMzCAcVvWDy0QB5zhqXn8uqMSFyjSATZGmdJxpbiJgVgOm/2
         3wXoXrT5qNX7AKwCB16W1Q07L8LCNrtBjSd7gjBroMpVdW3yLKAGbkKLNlY5VnSdSfWH
         +1NA8TCI3aivNu0Rll1whynhWFJ7+d6iyPnjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LHtaXxjwR9LEjFKW4sFt5EzzJ9jBUUC+MevRSxkspbLUWnLoayw0E4Jf6NpbQQo40p
         xFviLT8nZ33LhyVIzndytpBik52MO1ehWUziyqjXajua0BCYxatADIgEsg1HhOaCRCTO
         zum2kEXY3nEpb8x3GRZH2enFQMq2r0HQ4Nawg=
Received: by 10.140.185.1 with SMTP id i1mr1073258rvf.102.1218753678854;
        Thu, 14 Aug 2008 15:41:18 -0700 (PDT)
Received: from localhost.localdomain ( [75.71.41.234])
        by mx.google.com with ESMTPS id f21sm2511657rvb.5.2008.08.14.15.41.17
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 15:41:18 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc3.6.ga0653
In-Reply-To: <1218753671-58099-2-git-send-email-lee.marlow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92429>

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4089670..bdf4f4a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -972,6 +972,7 @@ _git_log ()
 			--decorate --diff-filter=
 			--color-words --walk-reflogs
 			--parents --children --full-history
+			--merge
 			"
 		return
 		;;
-- 
1.6.0.rc3.6.ga0653
