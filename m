From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 00/10] use the $( ... ) construct for command substitution
Date: Tue, 22 Dec 2015 15:10:22 +0100
Message-ID: <1450793432-9345-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 15:10:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBNeM-0002Wb-9V
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 15:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbbLVOKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 09:10:41 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36529 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbbLVOKk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 09:10:40 -0500
Received: by mail-pa0-f46.google.com with SMTP id q3so97268187pav.3
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 06:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tUR5oWWr1LM1qLBee2YO7Z/zOvXowETIMnDz052dqmU=;
        b=VZrkRL8HjGQy8WLd8An7jMATIttuKZHRWHp4ILL9pNGKjUo1qe6K608cE43Ef0XsaE
         WiK8XXp1NF372XCWQrMROy3dj/6oUJiE0x2LPmxG5iaLO1OTzMCv8aK+HsZ5bPltO6MP
         L0IfZC2q/q1eiAWxOl8fVksZyiLdbKh2HCzQOOw9NdWmXiTZ539yl6U0pwsgpTXZW2XE
         FTYfv9V3/dwm6H5ad0lbldgPfmnxwK0MpsIi0HrP8/MkGIYbjgs/HQwqDnEcmFgh9McA
         OJS/a5kJRlYMCxz6FCTkMpExzyaCuJuD5wo+bphuC1dYQGsePI8tJh0KiUbUXZ7XbdlV
         cJDw==
X-Received: by 10.66.158.169 with SMTP id wv9mr35640616pab.138.1450793439983;
        Tue, 22 Dec 2015 06:10:39 -0800 (PST)
Received: from ubuntu14.nephoscale.com (static-67.207.195.141.nephosdns.com. [67.207.195.141])
        by smtp.gmail.com with ESMTPSA id fe6sm46421455pab.40.2015.12.22.06.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Dec 2015 06:10:39 -0800 (PST)
X-Mailer: git-send-email 2.3.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282849>

This patch series continues the changes introduced with the merge 
6753d8a85d543253d95184ec2faad6dc197f248:

    Merge branch 'ep/shell-command-substitution'

    Adjust shell scripts to use $(cmd) instead of `cmd`.


This is the first series, the other will be sent separately.


Elia Pinto (10):
  contrib/examples/git-commit.sh: use the $( ... ) construct for command
    substitution
  contrib/examples/git-fetch.sh: use the $( ... ) construct for command
    substitution
  contrib/examples/git-merge.sh: use the $( ... ) construct for command
    substitution
  contrib/examples/git-repack.sh: use the $( ... ) construct for command
    substitution
  contrib/examples/git-revert.sh: use the $( ... ) construct for command
    substitution
  contrib/thunderbird-patch-inline/appp.sh: use the $( ... ) construct
    for command substitution
  git-gui/po/glossary/txt-to-pot.sh: use the $( ... ) construct for
    command substitution
  t/lib-httpd.sh: use the $( ... ) construct for command substitution
  test-sha1.sh: use the $( ... ) construct for command substitution
  unimplemented.sh: use the $( ... ) construct for command substitution

 contrib/examples/git-commit.sh           | 8 ++++----
 contrib/examples/git-fetch.sh            | 4 ++--
 contrib/examples/git-merge.sh            | 4 ++--
 contrib/examples/git-repack.sh           | 4 ++--
 contrib/examples/git-revert.sh           | 8 ++++----
 contrib/thunderbird-patch-inline/appp.sh | 4 ++--
 git-gui/po/glossary/txt-to-pot.sh        | 4 ++--
 t/lib-httpd.sh                           | 4 ++--
 test-sha1.sh                             | 8 ++++----
 unimplemented.sh                         | 2 +-
 10 files changed, 25 insertions(+), 25 deletions(-)

-- 
2.3.3.GIT
