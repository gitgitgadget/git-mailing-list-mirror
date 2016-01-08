From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 00/10] use the $( ... ) construct for command substitution
Date: Fri,  8 Jan 2016 12:06:18 +0100
Message-ID: <1452251188-12939-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 12:06:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHUsR-0002qP-8x
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 12:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358AbcAHLGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 06:06:35 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34296 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbcAHLGe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 06:06:34 -0500
Received: by mail-pf0-f194.google.com with SMTP id 65so619462pfd.1
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 03:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ABvjTRYPf4z6laN6cSMS1Xd2wZfvV8e0aYG+N7f+QO0=;
        b=rlVJglwIHM+oDRC23/BdJM93MNN7hdfdWPQcDdyC7arYD+8g7lBQfCL2kOFIfclsGM
         NZ+zWcdxCKP6DAH3TmT+hy/K2vAU1KPoznRtBnYUC12R/7/XXMspgOxD2PErxIDBRyLi
         p13M+FnPoD0WbxcI8mDVlxl53JOdEH5iA1+yxQAIfnkwpI/ug6EjZZHkj3sAiTci/O3a
         It5rZ0fmj4udAZDqLVzD5sUawF+no9UxesJdyTuSGBhQi+CJxdGZawvhPs2n9I8WC9+d
         S9c4P/6jjq6gD1EWFSi22YCUg0Xj4/ZjDnJGS/a00XsJpp9gvFySEOnzpxLntJmLErpu
         w5dQ==
X-Received: by 10.98.1.203 with SMTP id 194mr3443813pfb.10.1452251193506;
        Fri, 08 Jan 2016 03:06:33 -0800 (PST)
Received: from ubuntu14.nephoscale.com (static-67.207.195.141.nephosdns.com. [67.207.195.141])
        by smtp.gmail.com with ESMTPSA id fi16sm93143771pac.12.2016.01.08.03.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jan 2016 03:06:32 -0800 (PST)
X-Mailer: git-send-email 2.3.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283537>

This patch series continues the changes introduced with the merge
6753d8a85d543253d95184ec2faad6dc197f248:

    Merge branch 'ep/shell-command-substitution'

    Adjust shell scripts to use $(cmd) instead of `cmd`.

The last patch eliminates entirely the backquotes without replacing them 
for optimization.


This is the  seventh series, the other will be sent separately.

Elia Pinto (10):
  t/t7103-reset-bare.sh: use the $( ... ) construct for command
    substitution
  t/t7406-submodule-update.sh: use the $( ... ) construct for command
    substitution
  t/t7408-submodule-reference.sh: use the $( ... ) construct for command
    substitution
  t/t7504-commit-msg-hook.sh: use the $( ... ) construct for command
    substitution
  t/t7505-prepare-commit-msg-hook.sh: use the $( ... ) construct for
    command substitution
  t/t7602-merge-octopus-many.sh: use the $( ... ) construct for command
    substitution
  t/t7700-repack.sh: use the $( ... ) construct for command substitution
  t/t8003-blame-corner-cases.sh: use the $( ... ) construct for command
    substitution
  t/t9001-send-email.sh: use the $( ... ) construct for command
    substitution
  t/t9001-send-email.sh: get rid of unnecessary backquotes

 t/t7103-reset-bare.sh              |  2 +-
 t/t7406-submodule-update.sh        |  4 ++--
 t/t7408-submodule-reference.sh     |  2 +-
 t/t7504-commit-msg-hook.sh         |  2 +-
 t/t7505-prepare-commit-msg-hook.sh | 32 ++++++++++++++++----------------
 t/t7602-merge-octopus-many.sh      |  8 ++++----
 t/t7700-repack.sh                  |  4 ++--
 t/t8003-blame-corner-cases.sh      |  4 ++--
 t/t9001-send-email.sh              | 12 ++++++------
 9 files changed, 35 insertions(+), 35 deletions(-)

-- 
2.3.3.GIT
