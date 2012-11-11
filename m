From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/3] Introduce diff.submodule
Date: Sun, 11 Nov 2012 22:29:03 +0530
Message-ID: <1352653146-3932-1-git-send-email-artagnon@gmail.com>
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:59:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXasa-00053S-5D
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 17:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab2KKQ7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 11:59:15 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:59164 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab2KKQ7O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 11:59:14 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so2391580dak.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 08:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=qxJjzmuLlE8voKxHKGr1kbUTmf9msYZKV/MgjCT60QQ=;
        b=rodpskiowlg3q0tXGpIMitINar/lemknvaIBCpRn1+FGr7ozNS0TDQqtx7tlunlS79
         QJIGn8FpgWZiKVn3/1wls+SbgaYVWCoinJZ0F6I7TNPR/UpWXlqKeNlhbBDudP3zgZMP
         s0dNN44RvaTpJuH55KZYWgYIhRHmXaQKf3hvdEksuopywCKvrlsNPQXZxG7ThAt5dURO
         XxL4BWM4uA+AtpdAuxQxKjIKRQ4vYaOx1Z6+mdLeGK5Ci8Oea676byG97hpj3bwj0j/6
         CnEiWOgKceMERM56zIkbz+MwSqgxF44daiaGCahMu0o56miCJ5dDdzQpOA7Ce2Dhw6kM
         Ddhg==
Received: by 10.68.233.136 with SMTP id tw8mr44418824pbc.133.1352653154094;
        Sun, 11 Nov 2012 08:59:14 -0800 (PST)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id s1sm2824079paz.0.2012.11.11.08.59.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 08:59:13 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209409>

v1 is here: http://mid.gmane.org/1349196670-2844-1-git-send-email-artagnon@gmail.com
v2 is here: http://mid.gmane.org/1351766630-4837-1-git-send-email-artagnon@gmail.com

This version was prepared in response to Peff's review of v2.  As
suggested, I've created a separate function which both '--submodule'
and 'diff.submodule' use to set/ unset SUBMODULE_OPT.

Ram

Ramkumar Ramachandra (3):
  Documentation: move diff.wordRegex from config.txt to diff-config.txt
  diff: introduce diff.submodule configuration variable
  submodule: display summary header in bold

 Documentation/config.txt         |    6 -----
 Documentation/diff-config.txt    |   13 +++++++++++
 Documentation/diff-options.txt   |    3 +-
 cache.h                          |    1 +
 diff.c                           |   42 +++++++++++++++++++++++++++++++++----
 submodule.c                      |    8 +++---
 submodule.h                      |    2 +-
 t/t4041-diff-submodule-option.sh |   30 ++++++++++++++++++++++++++-
 8 files changed, 87 insertions(+), 18 deletions(-)

-- 
1.7.8.1.362.g5d6df.dirty
