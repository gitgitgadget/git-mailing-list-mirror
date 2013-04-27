From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/9] completion; remove unuseful comments
Date: Sat, 27 Apr 2013 15:10:01 -0500
Message-ID: <1367093407-8898-4-git-send-email-felipe.contreras@gmail.com>
References: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 22:11:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWBTH-0000Il-6k
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 22:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295Ab3D0ULf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 16:11:35 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:40440 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756117Ab3D0ULe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 16:11:34 -0400
Received: by mail-ob0-f180.google.com with SMTP id uk5so4528581obc.11
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 13:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=wSEDXNZx5Jqk35aF3dw6Ssz546PVj5N8JNGQBwjoglk=;
        b=zQzZVlekdNlqyHcxXHos2F9ITK6hJSr5V+BNxCuv2Owpckm/JWh/aB3V3cIRFeXybR
         B2aOysbJ1l47jTZmtCVz68ECt+4LGtnmbS8mueMgHkmRAbbmAkpKIft34n79i3CA368C
         qGlOAc1m4enHGzsN+A4OHTdQcY+nMrBWfIqn8BjqCBRR3aRnPBhMtA8CVj2E6arpxBEf
         wDVVNDEKjVKup67t2lu35ohMcA+XpdAMps8wFvRCfbmkcq6dOD1OU4eBRUVp07L0xmM8
         To0xdHARVw3/F3QK+B2O9toQrT/YewuCbwnbomnkkwUe/rCy+9E9NrBWa5XYWxc/hfiT
         kjlA==
X-Received: by 10.182.233.227 with SMTP id tz3mr20466402obc.23.1367093494184;
        Sat, 27 Apr 2013 13:11:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h8sm9752763obk.10.2013.04.27.13.11.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 13:11:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222689>

The only caller, __git_complete_index_file() doesn't specify any limits
to the options for 'git ls-files', neither should this function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 --
 1 file changed, 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bc3fc9e..f7b0f3c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -323,8 +323,6 @@ __git_diff_index_helper ()
 
 # __git_index_files accepts 1 or 2 arguments:
 # 1: Options to pass to ls-files (required).
-#    Supported options are --cached, --modified, --deleted, --others,
-#    and --directory.
 # 2: A directory path (optional).
 #    If provided, only files within the specified directory are listed.
 #    Sub directories are never recursed.  Path must have a trailing
-- 
1.8.2.1.1031.g2ee5873
