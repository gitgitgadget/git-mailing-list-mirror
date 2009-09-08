From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] completion: complete --scissors option of git-am
Date: Mon,  7 Sep 2009 23:57:42 -0700
Message-ID: <1252393062-11130-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 08 08:56:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mkud2-0001HG-R0
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 08:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602AbZIHG40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 02:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753485AbZIHG40
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 02:56:26 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:47072 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbZIHG4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 02:56:25 -0400
Received: by yxe5 with SMTP id 5so5570643yxe.33
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 23:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=nkibG2p0MkZ1IootnGqRmKsUXhdqt1zUKv6Mb/W6PVE=;
        b=RNMc+x3vL9703CBytPiUdYU/yOEpgP2EuVxziPDJrFZPD4HmEDE3PbkrjCM/6GdGUg
         m/N+eQalP5a7T+op5HNLzmkq7hQ5n1zlTbqPKnbus0s2s46rCA3irCDoA+aOrGYIDITi
         M524wDvW/fwghov3VZ6l6k6gbHv18sYZ/8lug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=OjGqG5ntKuMmEXNuaAWZbDX8fOLfUIizNp6Q4P5QpZ/xgQgZVkz3x1qTAMU1tm/0Y/
         edOWM3f8V6UDp2xJacAEwHTlyTq8Q67J5uza4qLWU4L1ZWTSGccz4IgRl5ojSE4FIEUT
         m4VP0XuTrJ3yEZfDI6XobQBSSOBqEtA7BadaY=
Received: by 10.90.225.5 with SMTP id x5mr11837172agg.87.1252392988110;
        Mon, 07 Sep 2009 23:56:28 -0700 (PDT)
Received: from earth (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id 36sm6735456agc.60.2009.09.07.23.56.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Sep 2009 23:56:27 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 07 Sep 2009 23:57:42 -0700
X-Mailer: git-send-email 1.6.5.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127978>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bf688e1..226e3ea 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -676,7 +676,7 @@ _git_am ()
 			--3way --committer-date-is-author-date --ignore-date
 			--ignore-whitespace --ignore-space-change
 			--interactive --keep --no-utf8 --signoff --utf8
-			--whitespace=
+			--whitespace= --scissors
 			"
 		return
 	esac
-- 
1.6.5.rc0
