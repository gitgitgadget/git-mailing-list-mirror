From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 00/10] use the $( ... ) construct for command substitution
Date: Tue, 22 Dec 2015 16:05:45 +0100
Message-ID: <1450796755-15848-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 16:06:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBOVu-00049p-Hh
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 16:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783AbbLVPGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 10:06:00 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34021 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbbLVPF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 10:05:59 -0500
Received: by mail-pa0-f43.google.com with SMTP id uo6so13613096pac.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 07:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=GAnItoz9R5Ae/UYQetJ4033rtfEGEyRyZSMZXst6UO0=;
        b=JVqrPo1CfJYLV/SDnytPQVi6hyqvSEKCnx1KL6/0KusiNlAWdiZQuFvSmSTreZ2CHR
         SJSqgDzVu8evEwwOoJ7K/PFkU6GQeld214cZ+SJ5lyBc0wfoKjwnE09r9Mi31y6Y/Q5b
         FuUVJN7qNmUT//FXDt9ImKj+GGrLAeVrFNTssJ8PO+dyC/ggTZW4BaWOMRU9Cvy8qEcM
         2XVGm+2cNed3i5rgTAObGmbtBGitgnoJMHYW37rtTIoam/VnDv5cDapSBTECPIVpoXno
         rUc/1GoWwpQaFCRGE3ytR4ItVvQNPMTUst66l7UerjeXTWf5uOu9bp4P3fl6V5eOYbib
         QpKw==
X-Received: by 10.66.180.99 with SMTP id dn3mr36753963pac.85.1450796758978;
        Tue, 22 Dec 2015 07:05:58 -0800 (PST)
Received: from ubuntu14.nephoscale.com (static-67.207.195.141.nephosdns.com. [67.207.195.141])
        by smtp.gmail.com with ESMTPSA id hz8sm46766591pac.10.2015.12.22.07.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Dec 2015 07:05:58 -0800 (PST)
X-Mailer: git-send-email 2.3.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282858>

This patch series continues the changes introduced with the merge
6753d8a85d543253d95184ec2faad6dc197f248:

    Merge branch 'ep/shell-command-substitution'

    Adjust shell scripts to use $(cmd) instead of `cmd`.


This is the second series, the other will be sent separately.


Elia Pinto (10):
  t/t1100-commit-tree-options.sh: use the $( ... ) construct for command
    substitution
  t/t1401-symbolic-ref.sh: use the $( ... ) construct for command
    substitution
  t/t1410-reflog.sh: use the $( ... ) construct for command substitution
  t/t1511-rev-parse-caret.sh: use the $( ... ) construct for command
    substitution
  t/t1512-rev-parse-disambiguation.sh: use the $( ... ) construct for
    command substitution
  t/t1700-split-index.sh: use the $( ... ) construct for command
    substitution
  t/t2025-worktree-add.sh: use the $( ... ) construct for command
    substitution
  t/t2102-update-index-symlinks.sh: use the $( ... ) construct for
    command substitution
  t/t3030-merge-recursive.sh: use the $( ... ) construct for command
    substitution
  t/t3100-ls-tree-restrict.sh: use the $( ... ) construct for command
    substitution

 t/t1100-commit-tree-options.sh      |  4 ++--
 t/t1401-symbolic-ref.sh             |  2 +-
 t/t1410-reflog.sh                   | 24 ++++++++++++------------
 t/t1511-rev-parse-caret.sh          |  4 ++--
 t/t1512-rev-parse-disambiguation.sh |  8 ++++----
 t/t1700-split-index.sh              |  2 +-
 t/t2025-worktree-add.sh             |  4 ++--
 t/t2102-update-index-symlinks.sh    |  2 +-
 t/t3030-merge-recursive.sh          |  2 +-
 t/t3100-ls-tree-restrict.sh         |  2 +-
 10 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.3.3.GIT
