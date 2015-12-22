From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 00/10] use the $( ... ) construct for command substitution
Date: Tue, 22 Dec 2015 16:27:43 +0100
Message-ID: <1450798073-22811-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 16:28:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBOr9-0001p6-7X
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 16:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbbLVP2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 10:28:00 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34323 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498AbbLVP17 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 10:27:59 -0500
Received: by mail-pf0-f169.google.com with SMTP id u7so61508336pfb.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 07:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Q0tXh+gl4Dp5PQWmlD+Vx8ktW0iDOT0xIuXWQySLURI=;
        b=mcNGe0pZTWRM1X5x1DAbB0S4hSgQ7pg4XEMZhZ1gUAtyBaP5GJ9ZF9FwkbDmBB7BWu
         7Bi0bJU4CktjAvk6PgZMPP2UOjLzRcst1WXVIPE4ptn/AeZD2kezvFy+N8RvcvhxpW/R
         NsNpmt8VMjbqtPtMLydt6VR+DJBgMdFkMeW++sQt3Kzx6oY1kgS5o+TBknt9mIKV29Bd
         Mi1fN9xTRyOtWOkE+NiODXBhnSmSWV9Zr/xTNKUuN0NxerH0hHLODxV/5dTaO4bD5Ih2
         KPyXZhIDn+3z+jx9Jfo8syk1Y7/Nc+YNyPtV+2wSofaBKPK7ht7mecyRgKm8EvCr5Dfi
         1BDA==
X-Received: by 10.98.14.143 with SMTP id 15mr36690918pfo.154.1450798078810;
        Tue, 22 Dec 2015 07:27:58 -0800 (PST)
Received: from ubuntu14.nephoscale.com (static-67.207.195.141.nephosdns.com. [67.207.195.141])
        by smtp.gmail.com with ESMTPSA id q190sm42030149pfq.59.2015.12.22.07.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Dec 2015 07:27:58 -0800 (PST)
X-Mailer: git-send-email 2.3.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282869>

This patch series continues the changes introduced with the merge
6753d8a85d543253d95184ec2faad6dc197f248:

    Merge branch 'ep/shell-command-substitution'

    Adjust shell scripts to use $(cmd) instead of `cmd`.


This is the third serie, the other will be sent separately.


Elia Pinto (10):
  t3101-ls-tree-dirname.sh: use the $( ... ) construct for command
    substitution
  t3210-pack-refs.sh: use the $( ... ) construct for command
    substitution
  t3403-rebase-skip.sh: use the $( ... ) construct for command
    substitution
  t3511-cherry-pick-x.sh: use the $( ... ) construct for command
    substitution
  t3600-rm.sh: use the $( ... ) construct for command substitution
  t3700-add.sh: use the $( ... ) construct for command substitution
  t5100-mailinfo.sh: use the $( ... ) construct for command substitution
  t5300-pack-object.sh: use the $( ... ) construct for command
    substitution
  t5301-sliding-window.sh: use the $( ... ) construct for command
    substitution
  t5302-pack-index.sh: use the $( ... ) construct for command
    substitution

 t/t3101-ls-tree-dirname.sh |  2 +-
 t/t3210-pack-refs.sh       |  2 +-
 t/t3403-rebase-skip.sh     |  2 +-
 t/t3511-cherry-pick-x.sh   | 14 +++++++-------
 t/t3600-rm.sh              |  4 ++--
 t/t3700-add.sh             | 16 ++++++++--------
 t/t5100-mailinfo.sh        | 12 ++++++------
 t/t5300-pack-object.sh     | 18 +++++++++---------
 t/t5301-sliding-window.sh  | 14 +++++++-------
 t/t5302-pack-index.sh      | 34 +++++++++++++++++-----------------
 10 files changed, 59 insertions(+), 59 deletions(-)

-- 
2.3.3.GIT
