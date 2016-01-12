From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 00/10] use the $( ... ) construct for command substitution
Date: Tue, 12 Jan 2016 10:45:08 +0000
Message-ID: <1452595518-38149-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 11:45:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIwSB-0007U4-6O
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 11:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934386AbcALKp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 05:45:27 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34739 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbcALKpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 05:45:25 -0500
Received: by mail-wm0-f65.google.com with SMTP id b14so30678862wmb.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 02:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mvush5BclAFgTyeSJvzODLjX/dYp50x2Be0syjQWzO4=;
        b=Cz0FgJ9kpICI+JRrMj9twD7M9KO4U5IrFAUgApSPNUQDvM2ndSr1v2p0HvMweA2k4W
         ouZWt1Eu15bFXwe4hqsz9eSfxDFQRM9tADwEG2nVIf75TRa215ccw5VDNWQ7xTVD+u71
         MGeEHG7frlxNztA8z8MnA4e8gX/HaTWr7dqlvNcz9B7MOej/AtScpzLwRzAoKF6pzgoo
         /2DqAGdreeR3Y8zWXe24+ykWxJemobTAjmHC7sxrZVUm3tXZVixmyWLrw/4ivUQSm+OX
         y5fYNTcPHUMVuemuRJwWdUerar0cJT3PMAN38f0o8lqXRovs9JfPAeQb9NIujVzzx1RZ
         C8oQ==
X-Received: by 10.28.51.17 with SMTP id z17mr14157083wmz.26.1452595523992;
        Tue, 12 Jan 2016 02:45:23 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gb9sm96320537wjb.26.2016.01.12.02.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jan 2016 02:45:23 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.20.g4b9ab0e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283790>

This patch series continues the changes introduced with the merge
6753d8a85d543253d95184ec2faad6dc197f248:

    Merge branch 'ep/shell-command-substitution'

    Adjust shell scripts to use $(cmd) instead of `cmd`.


This is the eighth series, the other will be sent separately.

Elia Pinto (10):
  t9100-git-svn-basic.sh: use the $( ... ) construct for command
    substitution
  t9101-git-svn-props.sh: use the $( ... ) construct for command
    substitution
  t9104-git-svn-follow-parent.sh: use the $( ... ) construct for command
    substitution
  t9105-git-svn-commit-diff.sh: use the $( ... ) construct for command
    substitution
  t9107-git-svn-migrate.sh: use the $( ... ) construct for command
    substitution
  t9108-git-svn-glob.sh: use the $( ... ) construct for command
    substitution
  t9109-git-svn-multi-glob.sh: use the $( ... ) construct for command
    substitution
  t9110-git-svn-use-svm-props.sh: use the $( ... ) construct for command
    substitution
  t9114-git-svn-dcommit-merge.sh: use the $( ... ) construct for command
    substitution
  t9118-git-svn-funky-branch-names.sh: use the $( ... ) construct for
    command substitution

 t/t9100-git-svn-basic.sh              |  8 ++---
 t/t9101-git-svn-props.sh              | 30 ++++++++--------
 t/t9104-git-svn-follow-parent.sh      | 68 +++++++++++++++++------------------
 t/t9105-git-svn-commit-diff.sh        |  4 +--
 t/t9107-git-svn-migrate.sh            | 28 +++++++--------
 t/t9108-git-svn-glob.sh               | 20 +++++------
 t/t9109-git-svn-multi-glob.sh         | 32 ++++++++---------
 t/t9110-git-svn-use-svm-props.sh      |  2 +-
 t/t9114-git-svn-dcommit-merge.sh      | 12 +++----
 t/t9118-git-svn-funky-branch-names.sh |  2 +-
 10 files changed, 103 insertions(+), 103 deletions(-)

-- 
2.5.0
