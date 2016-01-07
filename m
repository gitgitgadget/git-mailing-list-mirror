From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 00/10] use the $( ... ) construct for command substitution
Date: Thu,  7 Jan 2016 14:51:40 +0100
Message-ID: <1452174710-28188-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 14:52:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHAz0-0001sB-Dx
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 14:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbcAGNv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 08:51:56 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36549 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbcAGNv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 08:51:56 -0500
Received: by mail-pa0-f43.google.com with SMTP id yy13so166900058pab.3
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 05:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yL1WtB4MEzBRi+T5f2t6Ze0f2DZ37OrNtD4+DAN2Itw=;
        b=IRR6Fv2D051WR0TRc9HvIVTBz7JI4k4TlZMYGAaKrPRDVXuigyrGn0AzDFBeTcrZG2
         MfHRzMv61+eq4NxJr9tZ+nlejUqt9a4BVFBpcmMXqY4kvxEMCu1uu98u9kMKqCjwwG7G
         tt723c18zJ/AuDw6ShCPvMbpLrWoJ3VN1O5GwNuqtwpFPbpGI1jTL6SqTl6eKvS6Jxa4
         7aCf7/5G9O5z++J/WSkDZhOVcuNoO3XTVkB53sUdWaapodIwoV0Ye5RevoD9gk/GzP3c
         nXrdqy04DGU1tRECSlCiljpewnCdj3F5JtaLgqghWRwxUDC2oC8QHEfHyatQ01/y7OGF
         AubA==
X-Received: by 10.66.163.231 with SMTP id yl7mr147073169pab.141.1452174715756;
        Thu, 07 Jan 2016 05:51:55 -0800 (PST)
Received: from ubuntu14.nephoscale.com (static-67.207.195.141.nephosdns.com. [67.207.195.141])
        by smtp.gmail.com with ESMTPSA id kk5sm140627824pab.16.2016.01.07.05.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jan 2016 05:51:54 -0800 (PST)
X-Mailer: git-send-email 2.3.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283483>

This patch series continues the changes introduced with the merge
6753d8a85d543253d95184ec2faad6dc197f248:

    Merge branch 'ep/shell-command-substitution'

    Adjust shell scripts to use $(cmd) instead of `cmd`.


This is the  sixth  series, the other will be sent separately.

Elia Pinto (10):
  t/t5900-repo-selection.sh: use the $( ... ) construct for command
    substitution
  t/t6001-rev-list-graft.sh: use the $( ... ) construct for command
    substitution
  t/t6002-rev-list-bisect.sh: use the $( ... ) construct for command
    substitution
  t/t6015-rev-list-show-all-parents.sh: use the $( ... ) construct for
    command substitution
  t/t6032-merge-large-rename.sh: use the $( ... ) construct for command
    substitution
  t/t6132-pathspec-exclude.sh: use the $( ... ) construct for command
    substitution
  t/t7001-mv.sh: use the $( ... ) construct for command substitution
  t/t7003-filter-branch.sh: use the $( ... ) construct for command
    substitution
  t/t7004-tag.sh: use the $( ... ) construct for command substitution
  t/t7006-pager.sh: use the $( ... ) construct for command substitution

 t/t5900-repo-selection.sh            |  2 +-
 t/t6001-rev-list-graft.sh            | 12 ++++++------
 t/t6002-rev-list-bisect.sh           |  6 +++---
 t/t6015-rev-list-show-all-parents.sh |  6 +++---
 t/t6032-merge-large-rename.sh        |  2 +-
 t/t6132-pathspec-exclude.sh          |  2 +-
 t/t7001-mv.sh                        |  4 ++--
 t/t7003-filter-branch.sh             |  6 +++---
 t/t7004-tag.sh                       | 16 ++++++++--------
 t/t7006-pager.sh                     |  2 +-
 10 files changed, 29 insertions(+), 29 deletions(-)

-- 
2.3.3.GIT
