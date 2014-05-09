From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 00/17] contrib: cleanup
Date: Fri,  9 May 2014 14:11:26 -0500
Message-ID: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 21:11:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiqD4-0000Qt-Dk
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 21:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbaEITLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 15:11:50 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:55461 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbaEITLu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 15:11:50 -0400
Received: by mail-yh0-f42.google.com with SMTP id t59so4211475yho.1
        for <git@vger.kernel.org>; Fri, 09 May 2014 12:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Iqf8hHvyV/Kd+GFLVfj3v35JlaMcxno3uBDi8baJpJ4=;
        b=d8gafocjYqKUaJA+7QV5QTUuTehMvR1n/qbqM6jN7ROJhFS0biRmMf2Rzmi5t+BV+0
         E35Z2Tx5+TThqKdCsBIR8APUT3MXv2lsai54HCQe3cy8mLwdmCX/pOIGSbXPnHfAah66
         A9BphC4hT8eXPH0hi1SUXNVH1vfkSMHWei3xaZ2gKgJQNub0LZ7r/0R9fBQgxqqK9RS4
         aAl3NqzU+K7oJqpYMd5W3LvxeakXi2ZsQ/+QZikumJTW9YBzPKC4hKGmNt7mVkdkujOI
         EMvG80AUWa2YB5I0c5t4HQlzM36i9WR5ee68RShKEvPDLW0KdTnlGe//RvqRcVMjBj1G
         Amyg==
X-Received: by 10.236.61.45 with SMTP id v33mr17704733yhc.20.1399662709548;
        Fri, 09 May 2014 12:11:49 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id r23sm7400132yhb.46.2014.05.09.12.11.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 12:11:48 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.28.g12374c0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248613>

The contrib area is full of accumulatted cruft. Let's remove what is not used
and what is already maintained externay.


Felipe Contreras (17):
  contrib: remove outdated README
  contrib: remove 'vim'
  contrib: remove 'emacs'
  contrib: remove 'diffall'
  contrib: remove 'hg-to-git'
  contrib: remove 'hooks/multimail'
  contrib: remove 'stats'
  contrib: remove 'convert-objects'
  contrib: remove 'git-shell-commands'
  contrib: reomve 'thunderbird-patch-inline'
  contrib: remove 'workdir'
  contrib: remove 'svn-fe'
  contrib: remove 'rerere-train'
  contrib: remove 'remotes2config'
  contrib: remove 'persistent-https'
  contrib: remove 'git-resurrect'
  contrib: remove 'contacts'

 contrib/README                                     |   43 -
 contrib/contacts/git-contacts                      |  203 --
 contrib/contacts/git-contacts.txt                  |   94 -
 contrib/convert-objects/convert-objects.c          |  329 ---
 contrib/convert-objects/git-convert-objects.txt    |   29 -
 contrib/diffall/README                             |   31 -
 contrib/diffall/git-diffall                        |  257 --
 contrib/emacs/.gitignore                           |    1 -
 contrib/emacs/Makefile                             |   21 -
 contrib/emacs/README                               |   39 -
 contrib/emacs/git-blame.el                         |  484 ----
 contrib/emacs/git.el                               | 1705 -------------
 contrib/git-resurrect.sh                           |  182 --
 contrib/git-shell-commands/README                  |   18 -
 contrib/git-shell-commands/help                    |   18 -
 contrib/git-shell-commands/list                    |   10 -
 contrib/hg-to-git/hg-to-git.py                     |  255 --
 contrib/hg-to-git/hg-to-git.txt                    |   21 -
 contrib/hooks/multimail/CHANGES                    |   33 -
 contrib/hooks/multimail/README                     |  500 ----
 contrib/hooks/multimail/README.Git                 |   15 -
 .../README.migrate-from-post-receive-email         |  145 --
 contrib/hooks/multimail/git_multimail.py           | 2539 --------------------
 contrib/hooks/multimail/migrate-mailhook-config    |  269 ---
 contrib/hooks/multimail/post-receive               |   90 -
 contrib/persistent-https/LICENSE                   |  202 --
 contrib/persistent-https/Makefile                  |   38 -
 contrib/persistent-https/README                    |   62 -
 contrib/persistent-https/client.go                 |  189 --
 contrib/persistent-https/main.go                   |   82 -
 contrib/persistent-https/proxy.go                  |  190 --
 contrib/persistent-https/socket.go                 |   97 -
 contrib/remotes2config.sh                          |   33 -
 contrib/rerere-train.sh                            |   52 -
 contrib/stats/git-common-hash                      |   26 -
 contrib/stats/mailmap.pl                           |   70 -
 contrib/stats/packinfo.pl                          |  212 --
 contrib/svn-fe/.gitignore                          |    4 -
 contrib/svn-fe/Makefile                            |   63 -
 contrib/svn-fe/svn-fe.c                            |   18 -
 contrib/svn-fe/svn-fe.txt                          |   71 -
 contrib/svn-fe/svnrdump_sim.py                     |   57 -
 contrib/thunderbird-patch-inline/README            |   20 -
 contrib/thunderbird-patch-inline/appp.sh           |   55 -
 contrib/vim/README                                 |   22 -
 contrib/workdir/git-new-workdir                    |   82 -
 46 files changed, 8976 deletions(-)
 delete mode 100644 contrib/README
 delete mode 100755 contrib/contacts/git-contacts
 delete mode 100644 contrib/contacts/git-contacts.txt
 delete mode 100644 contrib/convert-objects/convert-objects.c
 delete mode 100644 contrib/convert-objects/git-convert-objects.txt
 delete mode 100644 contrib/diffall/README
 delete mode 100755 contrib/diffall/git-diffall
 delete mode 100644 contrib/emacs/.gitignore
 delete mode 100644 contrib/emacs/Makefile
 delete mode 100644 contrib/emacs/README
 delete mode 100644 contrib/emacs/git-blame.el
 delete mode 100644 contrib/emacs/git.el
 delete mode 100755 contrib/git-resurrect.sh
 delete mode 100644 contrib/git-shell-commands/README
 delete mode 100755 contrib/git-shell-commands/help
 delete mode 100755 contrib/git-shell-commands/list
 delete mode 100755 contrib/hg-to-git/hg-to-git.py
 delete mode 100644 contrib/hg-to-git/hg-to-git.txt
 delete mode 100644 contrib/hooks/multimail/CHANGES
 delete mode 100644 contrib/hooks/multimail/README
 delete mode 100644 contrib/hooks/multimail/README.Git
 delete mode 100644 contrib/hooks/multimail/README.migrate-from-post-receive-email
 delete mode 100755 contrib/hooks/multimail/git_multimail.py
 delete mode 100755 contrib/hooks/multimail/migrate-mailhook-config
 delete mode 100755 contrib/hooks/multimail/post-receive
 delete mode 100644 contrib/persistent-https/LICENSE
 delete mode 100644 contrib/persistent-https/Makefile
 delete mode 100644 contrib/persistent-https/README
 delete mode 100644 contrib/persistent-https/client.go
 delete mode 100644 contrib/persistent-https/main.go
 delete mode 100644 contrib/persistent-https/proxy.go
 delete mode 100644 contrib/persistent-https/socket.go
 delete mode 100755 contrib/remotes2config.sh
 delete mode 100755 contrib/rerere-train.sh
 delete mode 100755 contrib/stats/git-common-hash
 delete mode 100755 contrib/stats/mailmap.pl
 delete mode 100755 contrib/stats/packinfo.pl
 delete mode 100644 contrib/svn-fe/.gitignore
 delete mode 100644 contrib/svn-fe/Makefile
 delete mode 100644 contrib/svn-fe/svn-fe.c
 delete mode 100644 contrib/svn-fe/svn-fe.txt
 delete mode 100755 contrib/svn-fe/svnrdump_sim.py
 delete mode 100644 contrib/thunderbird-patch-inline/README
 delete mode 100755 contrib/thunderbird-patch-inline/appp.sh
 delete mode 100644 contrib/vim/README
 delete mode 100755 contrib/workdir/git-new-workdir

-- 
1.9.2+fc1.28.g12374c0
