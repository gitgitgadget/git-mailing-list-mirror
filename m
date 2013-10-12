From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 14/14] completion: update 'git reset' new stage options
Date: Sat, 12 Oct 2013 02:04:34 -0500
Message-ID: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:10:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtLm-0003qi-Ab
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680Ab3JLHKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:10:51 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:52219 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111Ab3JLHKt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:10:49 -0400
Received: by mail-ob0-f180.google.com with SMTP id wn1so3435098obc.39
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=V2KH7oer/ihLfsPstCXI2OuuhBMmCAvIzRVCaM3Gbxw=;
        b=ZHUA/6l77zR8tArrfBbvgzz7d5R3L+rFSXJyp2o8fCGU5wqHa2PMdjckeSQZVn77Uk
         cJZjqMB9OdCuvzuwICfjZXmwOqrz+Fr3rlL0pvNptIyRpdC9wv560vBHTJjFNYUBQPHj
         CIP+rAgvU/ym8H9354GeN1uL6O/uIU76bfbnspoozCLQ0/9Tof4JhmDXt4CM2G/Ve691
         WN22dvvGbRvb08yoMlgUhbEtLUfpoWxki8V0KHjkZU3ArccTFCQCb8RZmsNS9sKSbNYk
         Wf7s5kPHJf0TRSTiu8uAuThMtC5InV83A25fxH0I+gKDlAVpNDKmul2Ai6dg87XaOd8u
         o4JA==
X-Received: by 10.182.129.42 with SMTP id nt10mr17507876obb.19.1381561849469;
        Sat, 12 Oct 2013 00:10:49 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm101365996oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:10:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235963>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1dde51f..082f207 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2231,7 +2231,8 @@ _git_reset ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "--merge --mixed --hard --soft --patch"
+		__gitcomp "--merge --mixed --hard --soft --patch --keep --merge
+			--stage --no-stage --work --no-work"
 		return
 		;;
 	esac
-- 
1.8.4-fc
