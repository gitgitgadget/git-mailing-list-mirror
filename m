From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/20] Trivial paches
Date: Sat, 12 Oct 2013 02:06:57 -0500
Message-ID: <1381561636-20717-2-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtOH-0005bT-0U
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab3JLHNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:22 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:52084 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab3JLHNU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:20 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so3407969obc.7
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ff41aJuqeoo9YZmp48s932R1GBuBoInVxHNK+pWGbCc=;
        b=UjgcaGRj1+IcCblAtn5iNmLgs+o6fsXSqSmzf8tOp1R3NwZjy6eX8Mzt2Q3GGOdlsT
         tWi9rjXj8/sFMGsuCHFWCKlozwfgimbHi9rIscPJk35x/7pFqRxy4A+Pr8Q+VGABP+ex
         GdsHs3E7SiOULdxaaQYhfi2iTt2URPEhIGzy/PT8edQGFyawx5k/3akGRDAlS/2B+dKx
         VDaHOFwVHwhlWmDUkJFb5EFRTaGABkZ+HkR9FxkiBnUmheL3+hp+BTtePj1qjvEe94rD
         pG9O1AsSVuRs5onmK9AKMSBukIbIJDlTfRHz/dKXb6hW8lWI3/gtBMV/O7mDbVkQUZwO
         0CNw==
X-Received: by 10.60.60.5 with SMTP id d5mr17967046oer.0.1381561999790;
        Sat, 12 Oct 2013 00:13:19 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm28636703obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236011>



Felipe Contreras (20):
  merge: simplify ff-only option
  t: replace pulls with merges
  pull: cleanup documentation
  fetch: add missing documentation
  remote: fix trivial memory leak
  revision: add missing include
  shortlog: add missing declaration
  branch: trivial style fix
  sha1-name: trivial style cleanup
  doc: git-foo was obsoleted several years ago
  symbolic-ref: trivial style fix
  alias: trivial style fix
  transport-helper: trivial style fix
  describe: trivial style fixes
  pretty: trivial style fix
  revision: trivial style fixes
  diff: trivial style fix
  run-command: trivial style fixes
  setup: trivial style fixes
  add: avoid yoda conditions

 Documentation/git-checkout.txt         |  4 ++--
 Documentation/git-commit.txt           |  4 ++--
 Documentation/git-fetch.txt            |  3 +++
 Documentation/git-pull.txt             |  4 ++--
 Documentation/git-rebase.txt           |  4 ++--
 Documentation/git-status.txt           |  4 ++--
 alias.c                                | 13 +++++++------
 builtin/add.c                          |  2 +-
 builtin/branch.c                       |  3 +--
 builtin/describe.c                     |  7 +++----
 builtin/diff.c                         |  2 +-
 builtin/merge.c                        | 11 ++---------
 builtin/symbolic-ref.c                 |  2 +-
 pretty.c                               |  2 +-
 remote.c                               |  3 ++-
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
 26 files changed, 53 insertions(+), 59 deletions(-)

-- 
1.8.4-fc
