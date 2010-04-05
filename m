From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/43] nd/setup update
Date: Mon,  5 Apr 2010 20:40:45 +0200
Message-ID: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:41:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrF0-0003mJ-Tg
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509Ab0DESlh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:41:37 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864Ab0DESlf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:41:35 -0400
Received: by fxm27 with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Dcf6H5+qQoUVIGDXHaJFgv9u64yJ9wBf6+fafNfzkTY=;
        b=vlB3fNl3QN1iKr1JdJxgxYRh7PbSGKjMtm1LPCEfPzkkEKXocT8g0NaU7hd9fIdOLB
         FlY3VOE+/zAh0vCMMu48WTY9ao5TXpRZ4/lPCWVyzxaAY8q0adTxfJNQOc8iOvZM4PUX
         zwNl4s27IqGn9G8TNIJjKo1RxV9MzLu1fCBiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=MX8SKaESv+d42DUN9dglpOGTQUlE0wSlw8sxgdkz19Rjrl/axVFrH5lJkNnc923Ueo
         SOEZccw9plqITq6vPV011xv1bsAZl6Kd4+fdydTcuybG15Q2+Ei3zENjDGPiMevAOPTq
         WtFL/3moxzqzn3L8CqBk4RPJEMk8oxwiRcsA0=
Received: by 10.223.67.144 with SMTP id r16mr6090461fai.102.1270492893471;
        Mon, 05 Apr 2010 11:41:33 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id f31sm13672966fkf.48.2010.04.05.11.41.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:41:32 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:41:31 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144000>

Cleanup series, rebased on master.

Except 15/43 (which is now a comment only patch), no changes from pu 9f=
72b82.

Jonathan Nieder (2):
  help: take note why this command is not applicable for
    RUN_SETUP_GENTLY
  t0001: Add test cases for "git init" with aliases

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (41):
  builtin: introduce startup_info struct
  builtin: Support RUN_SETUP_GENTLY to set up repository early if found
  config: use RUN_SETUP_GENTLY
  hash-object: use RUN_SETUP_GENTLY
  shortlog: use RUN_SETUP_GENTLY
  grep: use RUN_SETUP_GENTLY
  builtin: USE_PAGER should not be used without RUN_SETUP*
  archive: use RUN_SETUP_GENTLY
  mailinfo: use RUN_SETUP_GENTLY
  check-ref-format: use RUN_SETUP_GENTLY
  verify-pack: use RUN_SETUP_GENTLY
  apply: use RUN_SETUP_GENTLY
  bundle: use RUN_SETUP_GENTLY
  diff: use RUN_SETUP_GENTLY
  ls-remote: use RUN_SETUP_GENTLY
  var: use RUN_SETUP_GENTLY
  merge-file: use RUN_SETUP_GENTLY
  worktree setup: calculate prefix even if no worktree is found
  index-pack: trust the prefix returned by setup_git_directory_gently()
  index-pack: use RUN_SETUP_GENTLY
  Move enter_repo() to setup.c
  enter_repo(): initialize other variables as
    setup_git_directory_gently() does
  rev-parse --git-dir: print relative gitdir correctly
  worktree setup: call set_git_dir explicitly
  Add git_config_early()
  Use git_config_early() instead of git_config() during repo setup
  worktree setup: restore original state when things go wrong
  init/clone: turn on startup->have_repository properly
  git_config(): do not read .git/config if there is no repository
  Do not read .git/info/exclude if there is no repository
  Do not read .git/info/attributes if there is no repository
  apply: do not check sha1 when repository has not been found
  config: do not read .git/config if there is no repository
  run_builtin(): save "-h" detection result for later use
  builtins: utilize startup_info->help where possible
  builtins: check for startup_info->help, print and exit early
  Allow to undo setup_git_directory_gently() gracefully (and fix alias
    code)
  alias: keep repository found while collecting aliases as long as
    possible
  Guard unallowed access to repository when it's not set up
  builtins: setup repository before print unknown command error
  builtins: do not commit pager choice early

 attr.c                     |    5 +-
 builtin/apply.c            |    9 +-
 builtin/archive.c          |    2 +-
 builtin/branch.c           |    3 +
 builtin/bundle.c           |    6 +-
 builtin/check-ref-format.c |    2 +-
 builtin/checkout-index.c   |    3 +
 builtin/clone.c            |    3 +-
 builtin/commit.c           |    6 +
 builtin/config.c           |   15 ++--
 builtin/diff.c             |    6 +-
 builtin/gc.c               |    3 +
 builtin/grep.c             |   11 +--
 builtin/hash-object.c      |    9 +-
 builtin/help.c             |    5 +
 builtin/index-pack.c       |   21 +---
 builtin/init-db.c          |   10 +-
 builtin/log.c              |    6 +-
 builtin/ls-files.c         |    3 +
 builtin/ls-remote.c        |    3 -
 builtin/mailinfo.c         |    3 -
 builtin/merge-file.c       |    4 +-
 builtin/merge-ours.c       |    2 +-
 builtin/merge.c            |    3 +
 builtin/pack-redundant.c   |    2 +-
 builtin/rev-parse.c        |    8 ++
 builtin/shortlog.c         |    4 +-
 builtin/show-ref.c         |    2 +-
 builtin/update-index.c     |    3 +
 builtin/upload-archive.c   |    7 +-
 builtin/var.c              |    2 -
 cache.h                    |   14 +++-
 config.c                   |   22 ++++-
 dir.c                      |    8 +-
 environment.c              |   34 +++++++-
 git.c                      |   99 ++++++++++++-------
 help.c                     |    4 +
 path.c                     |   91 ------------------
 setup.c                    |  223 ++++++++++++++++++++++++++++++++++++=
++++----
 t/t0001-init.sh            |   52 ++++++++++
 t/t1300-repo-config.sh     |   14 +++
 t/t1302-repo-version.sh    |    2 +-
 t/t1500-rev-parse.sh       |    2 +-
 t/t1501-worktree.sh        |    5 +
 t/t7002-grep.sh            |   24 +++++
 45 files changed, 525 insertions(+), 240 deletions(-)
