From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/11] Revert "Update documentation occurrences of filename .sh"
Date: Thu, 19 May 2016 23:58:45 -0500
Message-ID: <1463720325-8853-12-git-send-email-felipe.contreras@gmail.com>
References: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 06:59:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3cWn-0001iW-Ve
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 06:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbcETE7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 00:59:06 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32955 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232AbcETE7D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 00:59:03 -0400
Received: by mail-oi0-f65.google.com with SMTP id m198so2987904oig.0
        for <git@vger.kernel.org>; Thu, 19 May 2016 21:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B6zCLZtqa8AflPIJNInVDctj4xTZQx28P9jn1Ab0QQs=;
        b=KoOVbJAR571+e+pLuuoAl538KHCvn2PlyLbkuEphNDG+ndEa8xUVnsnovFZYa5fwDx
         7QeDh5N2uRmClLuoEUetuAifaVXKLQp+okJZUcbIVBU1o0/9/6pgAub8BwXu19bvjz57
         kt6zYghidPhsfQhc4P9AzznkVlTjDCz4qpjuriC0tLT13235hU6ZAXeBb8bT8XhcqY6O
         aHoD/uisKeiyX1x5xdAzYbHIPHkxRFZVb+4NHbBHBqO5n8dc8JRZCibVlbd+apEuplLf
         6GQlAamH1z8bJmznyUlkHuoLdaGzPMHppLeT0CO0j3CV02BeACdXuRVVhpkozpbRIZs3
         YUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B6zCLZtqa8AflPIJNInVDctj4xTZQx28P9jn1Ab0QQs=;
        b=mzq44ywxLC0EGsNdMOmWppoDchIXHBUvKhqGiAPTxFTWa6BmZzx35CoRUKcz/0HAWZ
         mvcAMDua+eNoca6xCEq+Hf0u76qp/M1dveSYWCNVt8phUayLAXHoVHUZPBbFTVB3G5gY
         Mc2UU3D9sS3THm66Xzl3TCwBoFDCrZfZwRz1NGCtAUonqrqsEhJU+uDVLh245l+13gTh
         xzTFV4DU1+JzdZyEORSYhDuwA5bnjjmV/3pokTZ0H9nEVhaXI61bWJsWaq/mD1q+Lzii
         op+3kI06KY+pBnyPm8uVMqYOfPuD8khOQEdMpgZhJinbcGECcba96uwmtOuUytPk56SM
         tYTA==
X-Gm-Message-State: AOPr4FWba5AUxlxZseVgPhongWHWKqiFLqC/h4kS9bklyFcnh3sZdQlU0k/zIAh8KOcRGQ==
X-Received: by 10.157.8.17 with SMTP id 17mr540486oty.22.1463720337324;
        Thu, 19 May 2016 21:58:57 -0700 (PDT)
Received: from localhost ([189.208.111.205])
        by smtp.gmail.com with ESMTPSA id u41sm4908593otd.37.2016.05.19.21.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 21:58:56 -0700 (PDT)
X-Mailer: git-send-email 2.8.0+fc1
In-Reply-To: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295146>

The original code was correct: the example location ~/.git-completion.sh
is correct, because it's not only used by Bash. And zstyle command in
Zsh should use that same location; the Bash script.

This reverts commit 0e5ed7cca3c51c821c2bb0465617e75d994f432f.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 contrib/completion/git-completion.zsh  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 398f3a7..3224ae1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -17,9 +17,9 @@
 #
 # To use these routines:
 #
-#    1) Copy this file to somewhere (e.g. ~/.git-completion.bash).
+#    1) Copy this file to somewhere (e.g. ~/.git-completion.sh).
 #    2) Add the following line to your .bashrc/.zshrc:
-#        source ~/.git-completion.bash
+#        source ~/.git-completion.sh
 #    3) Consider changing your PS1 to also show the current branch,
 #       see git-prompt.sh for details.
 #
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 28eaaed..6075111 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -9,7 +9,7 @@
 #
 # If your script is somewhere else, you can configure it on your ~/.zshrc:
 #
-#  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
+#  zstyle ':completion:*:*:git:*' script ~/.git-completion.sh
 #
 # The recommended way to install this script is to copy to '~/.zsh/_git', and
 # then add the following to your ~/.zshrc file:
-- 
2.8.0+fc1
