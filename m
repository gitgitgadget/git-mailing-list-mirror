From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/16] Trivial patches
Date: Thu, 31 Oct 2013 03:25:31 -0600
Message-ID: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:32:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbocE-00083I-Az
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427Ab3JaJca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:32:30 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:40632 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab3JaJc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:32:29 -0400
Received: by mail-oa0-f54.google.com with SMTP id o20so2804296oag.13
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5/ou5gl4K66eCubJ8x4cMhY4M3omWpqUP7/Qrn7grV0=;
        b=os3SUSWPOKPNB57CLg1sDhyGr5PutODmRcVxRj9WFtUktZtVATbrrH2pSygU7z3TY6
         0ekStpdoXuSPbjrl4nUNvB585Ehy1S4+dK1X3VURi4TUhHKnUXEjX+XoBZuMyNqpeGFL
         SSM8YrCtI6blK716MqZ6vWMURUI/RNn47KWznXGp8DX/a/wCYfZggKcPeXYUJ+6QvFXk
         AGuoEKCxz3KVfmMu64P53wFOZJOWPcjC6AWSqKfu9lRbnbOemTNF8OQXSxVk+/Q1xWig
         j8ia69x9y/QbJsmrqOKxl626Pa2LajGLGGIjYoQxynClErmSCdXOc0SLq7pMryoiOH/8
         AtAw==
X-Received: by 10.60.94.164 with SMTP id dd4mr1047100oeb.68.1383211949042;
        Thu, 31 Oct 2013 02:32:29 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id eg8sm4486571obd.6.2013.10.31.02.32.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:32:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237084>

Most of these have been sent before, but were not applied for one reason or
another.

Felipe Contreras (16):
  merge: simplify ff-only option
  t: replace pulls with merges
  pull: cleanup documentation
  fetch: add missing documentation
  revision: add missing include
  shortlog: add missing declaration
  branch: trivial style fix
  sha1-name: trivial style cleanup
  transport-helper: trivial style fix
  describe: trivial style fixes
  pretty: trivial style fix
  revision: trivial style fixes
  diff: trivial style fix
  run-command: trivial style fixes
  setup: trivial style fixes
  add: avoid yoda conditions

 Documentation/git-fetch.txt            |  3 +++
 Documentation/git-pull.txt             |  4 ++--
 builtin/add.c                          |  2 +-
 builtin/branch.c                       |  3 +--
 builtin/describe.c                     |  7 +++----
 builtin/diff.c                         |  2 +-
 builtin/merge.c                        | 11 ++---------
 pretty.c                               |  2 +-
 revision.c                             | 14 ++++++--------
 revision.h                             |  1 +
 run-command.c                          | 13 +++++--------
 setup.c                                |  4 ++--
 sha1_name.c                            |  1 -
 shortlog.h                             |  2 ++
 t/annotate-tests.sh                    |  2 +-
 t/t4200-rerere.sh                      |  2 +-
 t/t9114-git-svn-dcommit-merge.sh       |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh |  2 +-
 transport-helper.c                     |  1 +
 19 files changed, 35 insertions(+), 43 deletions(-)

-- 
1.8.4.2+fc1
