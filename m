From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v4 2/2] merge-recursive: use "up-to-date" instead of "uptodate" in error message for consistency
Date: Fri,  9 Jul 2010 22:27:49 +0200
Message-ID: <f5c54a4e27321b4ffb0f1f8542530281ef7841eb.1278707023.git.nicolas.s.dev@gmx.fr>
References: <7vd3uystsh.fsf@alter.siamese.dyndns.org>
Cc: <git@vger.kernel.org>, Wincent Colaiuta <win@wincent.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 22:28:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXKBd-00037K-BL
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 22:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728Ab0GIU22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 16:28:28 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55365 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598Ab0GIU21 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 16:28:27 -0400
Received: by wyf23 with SMTP id 23so1892751wyf.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:in-reply-to
         :references;
        bh=vVqgPW1/ARFIGvSdQuJzGIYpOQ9XiGrjgfSMqsqTuPk=;
        b=Rl2cV7mb8VJsqcjdw0jkyYP8VSAjzUmOEGGWHuyTNhWj0M5adHKPdlKjsf0WmoU6+q
         FCjlGWXmRJJTy20QZHioFJvwKwnTMhoBjDMHPAft83g+9AkjSZZR4v3GRbngoOlc2EaT
         A1AkmUJHxhErwdz6BBs4ZD1Z0XmenlXxsMusA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=q85RiA0pgRgFxtA6bFT+6oomBfjZI4+OQnmfuXi095OlhZjlZPCQTR1Qiuxz35NHfv
         iJ9q3MzaDbyGph6kvrwltHLhdDbnnmKnJzcZGytho+mHc6OWN7zjjqIUq7rAVkxoOAOU
         FN1EmPuRYov2FCu0L0pn2ZOH24Flb0mXv10zM=
Received: by 10.227.142.2 with SMTP id o2mr8806187wbu.201.1278707305678;
        Fri, 09 Jul 2010 13:28:25 -0700 (PDT)
Received: from localhost (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id a1sm8969390wbb.14.2010.07.09.13.28.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 13:28:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2.194.g494e9.dirty
In-Reply-To: <7vd3uystsh.fsf@alter.siamese.dyndns.org>
In-Reply-To: <33e9dcc468b1e1ed18a180046f5d4c135921c7ab.1278707023.git.nicolas.s.dev@gmx.fr>
References: <33e9dcc468b1e1ed18a180046f5d4c135921c7ab.1278707023.git.nicolas.s.dev@gmx.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150686>

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---
 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 856e98c..fb6aa4a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1214,7 +1214,7 @@ int merge_trees(struct merge_options *o,
 	}
 
 	if (sha_eq(common->object.sha1, merge->object.sha1)) {
-		output(o, 0, "Already uptodate!");
+		output(o, 0, "Already up-to-date!");
 		*result = head;
 		return 1;
 	}
-- 
1.7.2.rc2.194.g494e9.dirty
