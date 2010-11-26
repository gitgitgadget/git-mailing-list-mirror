From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/47] nd/setup updates on pu
Date: Fri, 26 Nov 2010 22:31:56 +0700
Message-ID: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:34:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0JP-0000Sm-PA
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627Ab0KZPeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:34:06 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60914 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab0KZPeF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:34:05 -0500
Received: by pwj3 with SMTP id 3so400409pwj.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=JPEFjK+4iwRlbZG6YexPSMoLb8Nvm/F6Ip//mQ/fZGo=;
        b=lKTOsFtKvZg0NZWk6py25HnPQFXfv+026d2x42Wqc+aPTj1BQX0nC1jUViaHXawCw8
         v9D121YwY2/TclG8/bgqADuiRavEVG1CV5YSGYWOsPOdnSDvQKJSKQsWjxdgRzpP+pOS
         71jShODwfjFhgrSyB3cCMKA7Ede/pqgUAIWDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=unDwceAODiexwZfFEFkdLcwHN/7KmfuN5SnFsH3QvJCbmShQOVWh3jbNESongs93FI
         kZNP7984n3OSKXfS7tyMcH2iYc/FZAijk0hON1clPxWHt0QtLfbW5pHZlky7G6jsnYiT
         wtJzzPuUJLsJ+srHSQwmU26Gv9jWEKAz/mjYY=
Received: by 10.142.203.15 with SMTP id a15mr2525550wfg.90.1290785643974;
        Fri, 26 Nov 2010 07:34:03 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id w22sm2671039wfd.19.2010.11.26.07.33.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:34:02 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:32:45 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162216>

Only tests are updated to eliminate bashisms. Tested on busybox ash.

Jonathan Nieder (2):
  git-rev-parse.txt: clarify --git-dir
  t0001: test git init when run via an alias

Michael J Gruber (1):
  t1020-subdirectory: test alias expansion in a subdirectory

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (44):
  builtins: print setup info if repo is found
  Add t1510 and basic rules that run repo setup
  t1510: setup case #0
  t1510: setup case #1
  t1510: setup case #2
  t1510: setup case #3
  t1510: setup case #4
  t1510: setup case #5
  t1510: setup case #6
  t1510: setup case #7
  t1510: setup case #8
  t1510: setup case #9
  t1510: setup case #10
  t1510: setup case #11
  t1510: setup case #12
  t1510: setup case #13
  t1510: setup case #14
  t1510: setup case #15
  t1510: setup case #16
  t1510: setup case #17
  t1510: setup case #18
  t1510: setup case #19
  t1510: setup case #20
  t1510: setup case #21
  t1510: setup case #22
  t1510: setup case #23
  t1510: setup case #24
  t1510: setup case #25
  t1510: setup case #26
  t1510: setup case #27
  t1510: setup case #28
  t1510: setup case #29
  t1510: setup case #30
  t1510: setup case #31
  rev-parse: prints --git-dir relative to user's cwd
  Add git_config_early()
  Use git_config_early() instead of git_config() during repo setup
  setup: limit get_git_work_tree()'s to explicit setup case only
  setup: clean up setup_bare_git_dir()
  setup: clean up setup_discovered_git_dir()
  setup: rework setup_explicit_git_dir()
  Remove all logic from get_git_work_tree()
  Revert "Documentation: always respect core.worktree if set"
  git.txt: correct where --work-tree path is relative to

 Documentation/config.txt        |   23 +-
 Documentation/git-rev-parse.txt |    7 +-
 Documentation/git.txt           |    2 +-
 builtin/init-db.c               |   13 +-
 builtin/rev-parse.c             |    6 +-
 cache.h                         |    2 +
 config.c                        |   19 +-
 environment.c                   |   26 +-
 git.c                           |    4 +
 setup.c                         |  230 ++-
 t/t0001-init.sh                 |   56 +
 t/t1020-subdirectory.sh         |    8 +
 t/t1510-repo-setup.sh           | 4532 +++++++++++++++++++++++++++++++=
++++++++
 trace.c                         |   42 +
 14 files changed, 4835 insertions(+), 135 deletions(-)
 create mode 100755 t/t1510-repo-setup.sh

--=20
1.7.3.2.316.gda8b3
