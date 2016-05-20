From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/11] completion: bash: remove old wrappers
Date: Thu, 19 May 2016 23:58:36 -0500
Message-ID: <1463720325-8853-3-git-send-email-felipe.contreras@gmail.com>
References: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 06:58:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3cWT-0001VM-2E
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 06:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbcETE6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 00:58:50 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35774 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbcETE6s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 00:58:48 -0400
Received: by mail-oi0-f66.google.com with SMTP id w198so21095745oiw.2
        for <git@vger.kernel.org>; Thu, 19 May 2016 21:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hn0JZNyYp1Zrb8xCXv1aj2DvuaKQfhItCCgM8Q3utGQ=;
        b=qtcrr5nFrigm1F6NSC1VvjWwyEt+8AtIpEl7+fVfp2UcGKsFGmTMcknnOJNvtfSfip
         kGYgPxS5P9KqbvNgF0nyCME+OxNUHqTNW8tEZmi+3SY5cLXlpmwbWKh68ZcTb0nR2w/B
         CBASru8ELU7ROqt4ZJ9zdtECXnhc9NGGylOcz6MGD4p+P9A6u8EQJcNTubEIrYBLn1Fq
         xkYP+OFTNujOeQZXHxYFa6/pEs7rEWGQq2XYmJH2fU44kGy6lFIbes/8t5vzLYhrO/y0
         djNY8xWzMjtHAN8Vo268XNvQP/d8murJ37TBa2fV9gz4AveYIeFPok3p8h7IHf8jhmT+
         +vGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hn0JZNyYp1Zrb8xCXv1aj2DvuaKQfhItCCgM8Q3utGQ=;
        b=lze4QkewV6xa6/CSv/4wU3/H2DHGNYDQSP43HDCZdGoJuq4IGg1fUgNOnqAjml/BYF
         3wYhBARMvKhVtI+HuOKce501pqZx4cTMVPIsdZm+jyQK5r9lfOeeQx9R45jZzMg1WpHu
         kfqYbb/VNvWbAySHq8kxFyfb+hASWE5ySsFMHm2ooa+xrbb+ieFrx+rhBt6KdMZX+Lji
         g0uzxN8HwkDhO0E0PoGN1gB3dC/qgVCcsX86VYpqQpdCm3FhEuocyPBbsepxWG5jZvgE
         5rIYESqHZg6Qz/se7cLGIfMJU8n2ueBlTI47Xck96hZhvNxOkc27tS0VIaTkkTzRlytb
         Pl4w==
X-Gm-Message-State: AOPr4FXyJ82akJqLw7gMZTrfPvJ2tSlc9vl7CYwzeHy8SxK7KJA/x0JesyghvxsJlF7LjA==
X-Received: by 10.157.11.179 with SMTP id 48mr544542oth.4.1463720328185;
        Thu, 19 May 2016 21:58:48 -0700 (PDT)
Received: from localhost ([189.208.111.205])
        by smtp.gmail.com with ESMTPSA id t21sm4947512otd.20.2016.05.19.21.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 21:58:47 -0700 (PDT)
X-Mailer: git-send-email 2.8.0+fc1
In-Reply-To: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295137>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ecdf742..5e2e590 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2754,18 +2754,6 @@ __git_complete ()
 		|| complete -o default -o nospace -F $wrapper $1
 }
 
-# wrapper for backwards compatibility
-_git ()
-{
-	__git_wrap__git_main
-}
-
-# wrapper for backwards compatibility
-_gitk ()
-{
-	__git_wrap__gitk_main
-}
-
 __git_complete git __git_main
 __git_complete gitk __gitk_main
 
-- 
2.8.0+fc1
