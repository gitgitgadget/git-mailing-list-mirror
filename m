From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH] command-list.txt: fix whitespace inconsistency
Date: Fri,  8 May 2015 21:29:35 +0200
Message-ID: <1431113375-10410-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 21:30:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqnyO-0000TJ-9p
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 21:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbbEHTaH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2015 15:30:07 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34938 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbbEHTaE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 15:30:04 -0400
Received: by widdi4 with SMTP id di4so41209875wid.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 12:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=QpB3/52cOPwn5xr4j7DP/KecLL8MGzAw6V0fjoGcbQ4=;
        b=HYh7+2SwwZ3+v7/wyVHa0pUxnW4DyCc2y6Ma7HXjINwZkusJGEAkWfnZ/GW119qsu2
         5W6L/pYnpJDpjjSsPVd/9BYAwlDkL3NEusQ7QQCc/KXlfnAXuc/Vd4kUbieAmmonGlDu
         3iloLcA6aryaQnkmlVDVqZJrZvkAtEda+mGwv+qIdZ2X07UEqJcTJnqx3g6FpojMaWVL
         lkNj7G2AZT1egIvjnJsrLMnsmgUUTZLawmw7UNivlqgw0OVlVmhRz5618NFHfefCfHle
         7kDOH9LLqdK7mX07A00IIM08d7X0gRLNRlcXu8EAvfwf7LDBNsDSep+TwNrnWrlT8S7r
         UYIw==
X-Received: by 10.194.222.137 with SMTP id qm9mr10317592wjc.43.1431113401810;
        Fri, 08 May 2015 12:30:01 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id u6sm9734739wjy.13.2015.05.08.12.30.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 May 2015 12:30:01 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268649>

The overwhelming majority of lines were single space aligned,
except a few ones aligned by tabs. Fix inconsistency by using
single space everywhere.

Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 command-list.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index f1eae08..54d8d21 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,5 +1,5 @@
 # List of known git commands.
-# command name				category [deprecated] [common]
+# command name                          category [deprecated] [common]
 git-add                                 mainporcelain common
 git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
@@ -40,21 +40,21 @@ git-diff-files                          plumbingint=
errogators
 git-diff-index                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
 git-difftool                            ancillaryinterrogators
-git-fast-export				ancillarymanipulators
-git-fast-import				ancillarymanipulators
+git-fast-export                         ancillarymanipulators
+git-fast-import                         ancillarymanipulators
 git-fetch                               mainporcelain common
 git-fetch-pack                          synchingrepositories
 git-filter-branch                       ancillarymanipulators
 git-fmt-merge-msg                       purehelpers
 git-for-each-ref                        plumbinginterrogators
 git-format-patch                        mainporcelain
-git-fsck	                        ancillaryinterrogators
+git-fsck                                ancillaryinterrogators
 git-gc                                  mainporcelain
 git-get-tar-commit-id                   ancillaryinterrogators
 git-grep                                mainporcelain common
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
-git-help				ancillaryinterrogators
+git-help                                ancillaryinterrogators
 git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
--=20
2.4.0
