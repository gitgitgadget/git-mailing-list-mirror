From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH v3 0/2] Add git-for-each-repo
Date: Wed, 23 Jan 2013 20:59:38 +0100
Message-ID: <1358971180-10652-1-git-send-email-hjemli@gmail.com>
Cc: Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 21:00:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty6UT-0005ZQ-7l
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 21:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789Ab3AWT7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 14:59:49 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:38363 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab3AWT7s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 14:59:48 -0500
Received: by mail-lb0-f169.google.com with SMTP id m4so5264853lbo.0
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 11:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=xCHQGvtV0/PKiLHZutDGRJ//dtoTzHxzAgL0O9hkuAU=;
        b=yD3iWpdb4wOdOzlQOzvUS0ZZlx/0FyXoZdmgtUPGX1dOTJvsIxjE8256r9X8iYcHRh
         890cEMQptiO7UzYGXAuhRi69ZOXLM24vo4I/sqcMVDdyg7WhOV3v2NWX5GQh/KGKaMH0
         YEdxpengvEMaaT4EAJ3yOCpTUFCf96LU+g97sC4Evnh0PGqSK3uYGtBlvP2AXYnYZwk/
         x/lrt8UJYVe1AIGgG9UditB57pdLVkdIGw6/JeCMt8KFfudLH6NotnBMiwLvZPM0IJVn
         +e0Ah/1WjH5kSEBvwKC1/pLcQQQX2fvJeBKjP8aKXdZsbPodp2oE/UFveY1v7CPZ5dPX
         aydA==
X-Received: by 10.152.122.133 with SMTP id ls5mr2558363lab.9.1358971186526;
        Wed, 23 Jan 2013 11:59:46 -0800 (PST)
Received: from slacko.getinternet.no (cm-84.212.47.55.getinternet.no. [84.212.47.55])
        by mx.google.com with ESMTPS id hc20sm8804885lab.11.2013.01.23.11.59.45
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 11:59:45 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.350.g3346805
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214351>

Lars Hjemli (2):
  for-each-repo: new command used for multi-repo operations
  git: rewrite `git -a` to become a git-for-each-repo command

 .gitignore                          |   1 +
 Documentation/git-for-each-repo.txt |  62 +++++++++++++++++++
 Makefile                            |   1 +
 builtin.h                           |   1 +
 builtin/for-each-repo.c             | 119 ++++++++++++++++++++++++++++++++++++
 git.c                               |  37 +++++++++++
 t/t6400-for-each-repo.sh            |  54 ++++++++++++++++
 7 files changed, 275 insertions(+)
 create mode 100644 Documentation/git-for-each-repo.txt
 create mode 100644 builtin/for-each-repo.c
 create mode 100755 t/t6400-for-each-repo.sh

-- 
1.8.1.1.350.g3346805
