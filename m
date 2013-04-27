From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 8/9] completion: add space after completed filename
Date: Sat, 27 Apr 2013 15:10:06 -0500
Message-ID: <1367093407-8898-9-git-send-email-felipe.contreras@gmail.com>
References: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 22:12:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWBTT-0000Wy-GZ
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 22:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756473Ab3D0ULv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 16:11:51 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:43651 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756392Ab3D0ULt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 16:11:49 -0400
Received: by mail-ob0-f171.google.com with SMTP id er7so4468751obc.16
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 13:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=CkRachw7BQrFqpOMhIJ6+lR9sDw6lDnqZbkVfzoZDMo=;
        b=bv/kH/s6MKQrUPnqa2HRdlBZrFrao9Bl5D4/SFoG33qjsq9TlEPl58KCDVU52JfNv6
         9XGdgIkd6VNMWlPRvG1B5ZEMSQJ7OiVs0+lo1u/TOow5YKT8pwwwLFMQUqXy1auaTKZA
         MNkSvoYypf2xuPbxzMJD3Ku1YceGwnuRg2xVEeOyfDrjUunXTqBhAqX88xI0m0nw2rIJ
         BEtSyI6j8CsFEv9+M2wOR6Zx5jHIz6yXImazll1ZnzPyPQu3qP/2I8FFk6eqqd4pIVjw
         QoBt3SFheAxG/YE8u9RyBbsoBwNeQkYTT3jkrNPYGe8eCBqdWoBCziymQ4ykBFQpRma4
         hRfg==
X-Received: by 10.60.132.36 with SMTP id or4mr20822614oeb.112.1367093509444;
        Sat, 27 Apr 2013 13:11:49 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id zc8sm13338275obc.8.2013.04.27.13.11.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 13:11:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222691>

Just like before fea16b4 (git-completion.bash: add support for path
completion).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f9e8e7d..20c9718 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -255,7 +255,7 @@ __gitcomp_file ()
 	__gitcompadd "$1" "${2-}" "${3-$cur}" ""
 
 	# use a hack to enable file mode in bash < 4
-	compopt -o filenames 2>/dev/null ||
+	compopt -o filenames +o nospace 2>/dev/null ||
 	compgen -f /non-existing-dir/ > /dev/null
 }
 
-- 
1.8.2.1.1031.g2ee5873
