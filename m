From: Alexei Sholik <alcosholik@gmail.com>
Subject: [PATCH 2/2] Add Author and Documentation sections to git-for-each-ref.txt
Date: Tue,  8 Mar 2011 15:16:10 +0200
Message-ID: <1299590170-30799-3-git-send-email-alcosholik@gmail.com>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
Cc: Alexei Sholik <alcosholik@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 14:14:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwwje-0006ud-5c
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 14:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890Ab1CHNNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 08:13:50 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34391 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589Ab1CHNNt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 08:13:49 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so4543793bwz.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 05:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=o3JAT2rmNSB9DDFuDrJ/b9bzkKExawMcHkLkZJ9vxwE=;
        b=RLXk2KMKJYfLBLoa9S1XjzEaSWN/BQtv5rOTQdpxnjBpuqJiCis3PyM+fyRDrgOHVt
         K4b2e1DfVJ/JBxdbcEtTHHGG4zq37xVNVxkXpeBhhQUPvMrd9gkmFGdE91ZVDSN0z/5d
         4dMcI6xGt4ZQ96j5PzatePSBdbzjoOfHKC+nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ih6cR1kpgotBsTltI5Bl1HZaxIZTaszDKXXQRzOFlYLZuISVZDbqNO8ZAAftddYsBQ
         6P7TlKxurMna7SYXNYwGT4A456q/6EuFPkOv9cihf2i0JVMGkgX0O24DHJieFM4jz/qO
         MYKw0Qmd8xzVS1/OQdzcD8mKvkRzJWpVNLOEM=
Received: by 10.204.74.93 with SMTP id t29mr4450871bkj.150.1299590027967;
        Tue, 08 Mar 2011 05:13:47 -0800 (PST)
Received: from localhost.localdomain ([193.254.233.10])
        by mx.google.com with ESMTPS id u23sm495968bkw.9.2011.03.08.05.13.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Mar 2011 05:13:47 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168662>

Signed-off-by: Alexei Sholik <alcosholik@gmail.com>
---
 Documentation/git-for-each-ref.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index bffb5d2..ceef54b 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -204,3 +204,15 @@ eval=`git for-each-ref --shell --format="$fmt" \
 	refs/tags`
 eval "$eval"
 ------------
+
+Author
+------
+Written by Junio C Hamano <gitster@pobox.com>.
+
+Documentation
+--------------
+Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
1.7.2.3
