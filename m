From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/65] Mark parseopt strings for translation
Date: Sun,  6 May 2012 21:23:50 +0700
Message-ID: <1336314232-21002-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 16:27:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR2Qz-0005u0-86
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 16:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185Ab2EFO1c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 10:27:32 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34157 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654Ab2EFO1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 10:27:31 -0400
Received: by pbbrp8 with SMTP id rp8so5683668pbb.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=UxhUGEZkw0G/Uxk0BlCWDznA5gejw2ZS45KDfoyu8vk=;
        b=JoapeKdj1r3t58xaH7IBdjfPsJAeg45QaUcJIbDlXfzxCByAMoAm0hQ5QhZsfM/OvP
         +dFzl3nLQ6UGd2fPalVc9vcLECCyM+3UMMh8Xws/pwxMDz+4APC8kneRIoJJ/rNM8cGb
         NfCodQ3267g6C7YKJVaqrNMsISC03MTpow8PNeIShPc3mQW15DUeDEQJ7pzAfteltyn+
         ZRwNDSRvbNa8OsyqaA72tr8hj5miwVU8qf/+kPGLre3o23hXohD8x2UEZIR9iF3klYCw
         GzAgKaltW2nmgsyI/XUoaTGaxKHaixV/7vo+Qx/5meEQOewUWjoD25lwrUwaLi5Gabp3
         uU3w==
Received: by 10.68.201.40 with SMTP id jx8mr87850pbc.49.1336314450757;
        Sun, 06 May 2012 07:27:30 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.32.70])
        by mx.google.com with ESMTPS id pn5sm15082690pbb.71.2012.05.06.07.27.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 07:27:29 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 06 May 2012 21:23:53 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197191>

The main code change is in the first patch, which enables parseopt to
use gettext(). The rest is a bunch of N_(). I only post 2 patches
here. The rest can be found at

https://github.com/pclouds/git/commits/parseopt-i18n

About 1000 strings are marked for translation in this series.
Shell-based parseopt is not supported because I don't know how to mark
strings in shell scripts.

I suggest to merge this series (once it passes the review) in a
quiet time in next. Then I'll add additional patches to all topics in
pu that touch parseopt and keep doing so until the series graduates to
master.

Surprisingly, this series (based on master) does not cause any
conflicts with pu. So now may be a good time.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (65):
  i18n: parseopt: lookup help and argument translations when showing
    usage
  i18n: apply: mark parseopt strings for translation
  i18n: archive: mark parseopt strings for translation
  i18n: add: mark parseopt strings for translation
  i18n: bisect--helper: mark parseopt strings for translation
  i18n: blame: mark parseopt strings for translation
  i18n: branch: mark parseopt strings for translation
  i18n: cat-file: mark parseopt strings for translation
  i18n: check-attr: mark parseopt strings for translation
  i18n: checkout-index: mark parseopt strings for translation
  i18n: checkout: mark parseopt strings for translation
  i18n: cherry: mark parseopt strings for translation
  i18n: clean: mark parseopt strings for translation
  i18n: clone: mark parseopt strings for translation
  i18n: column: mark parseopt strings for translation
  i18n: commit: mark parseopt strings for translation
  i18n: config: mark parseopt strings for translation
  i18n: count-objects: mark parseopt strings for translation
  i18n: describe: mark parseopt strings for translation
  i18n: fast-export: mark parseopt strings for translation
  i18n: fetch: mark parseopt strings for translation
  i18n: fmt-merge-msg: mark parseopt strings for translation
  i18n: for-each-ref: mark parseopt strings for translation
  i18n: format-patch: mark parseopt strings for translation
  i18n: fsck: mark parseopt strings for translation
  i18n: gc: mark parseopt strings for translation
  i18n: grep: mark parseopt strings for translation
  i18n: hash-object: mark parseopt strings for translation
  i18n: help: mark parseopt strings for translation
  i18n: init-db: mark parseopt strings for translation
  i18n: log: mark parseopt strings for translation
  i18n: ls-files: mark parseopt strings for translation
  i18n: ls-tree: mark parseopt strings for translation
  i18n: merge-base: mark parseopt strings for translation
  i18n: merge-file: mark parseopt strings for translation
  i18n: merge: mark parseopt strings for translation
  i18n: mktree: mark parseopt strings for translation
  i18n: mv: mark parseopt strings for translation
  i18n: name-rev: mark parseopt strings for translation
  i18n: notes: mark parseopt strings for translation
  i18n: pack-objects: mark parseopt strings for translation
  i18n: pack-refs: mark parseopt strings for translation
  i18n: prune-packed: mark parseopt strings for translation
  i18n: prune: mark parseopt strings for translation
  i18n: push: mark parseopt strings for translation
  i18n: read-tree: mark parseopt strings for translation
  i18n: remote: mark parseopt strings for translation
  i18n: replace: mark parseopt strings for translation
  i18n: status: mark parseopt strings for translation
  i18n: rerere: mark parseopt strings for translation
  i18n: reset: mark parseopt strings for translation
  i18n: rev-parse: mark parseopt strings for translation
  i18n: revert, cherry-pick: mark parseopt strings for translation
  i18n: rm: mark parseopt strings for translation
  i18n: shortlog: mark parseopt strings for translation
  i18n: show-branch: mark parseopt strings for translation
  i18n: show-ref: mark parseopt strings for translation
  i18n: symbolic-ref: mark parseopt strings for translation
  i18n: tag: mark parseopt strings for translation
  i18n: update-index: mark parseopt strings for translation
  i18n: update-ref: mark parseopt strings for translation
  i18n: update-server-info: mark parseopt strings for translation
  i18n: verify-pack: mark parseopt strings for translation
  i18n: verify-tag: mark parseopt strings for translation
  i18n: write-tree: mark parseopt strings for translation

 archive.c                    |   38 +++++++-------
 builtin/add.c                |   26 +++++-----
 builtin/apply.c              |   62 +++++++++++-----------
 builtin/archive.c            |   12 ++--
 builtin/bisect--helper.c     |    6 +-
 builtin/blame.c              |   46 ++++++++--------
 builtin/branch.c             |   54 +++++++++---------
 builtin/cat-file.c           |   20 ++++----
 builtin/check-attr.c         |   12 ++--
 builtin/checkout-index.c     |   24 ++++----
 builtin/checkout.c           |   40 +++++++-------
 builtin/clean.c              |   18 +++---
 builtin/clone.c              |   56 ++++++++++----------
 builtin/column.c             |   16 +++---
 builtin/commit.c             |   98 +++++++++++++++++-----------------
 builtin/config.c             |   56 ++++++++++----------
 builtin/count-objects.c      |    4 +-
 builtin/describe.c           |   28 +++++-----
 builtin/fast-export.c        |   28 +++++-----
 builtin/fetch.c              |   48 ++++++++--------
 builtin/fmt-merge-msg.c      |   16 +++---
 builtin/for-each-ref.c       |   18 +++---
 builtin/fsck.c               |   24 ++++----
 builtin/gc.c                 |   12 ++--
 builtin/grep.c               |   90 ++++++++++++++++----------------
 builtin/hash-object.c        |   16 +++---
 builtin/help.c               |   10 ++--
 builtin/init-db.c            |   18 +++---
 builtin/log.c                |   80 ++++++++++++++--------------
 builtin/ls-files.c           |   54 +++++++++---------
 builtin/ls-tree.c            |   22 ++++----
 builtin/merge-base.c         |   12 ++--
 builtin/merge-file.c         |   20 ++++----
 builtin/merge.c              |   48 ++++++++--------
 builtin/mktree.c             |    8 ++--
 builtin/mv.c                 |   10 ++--
 builtin/name-rev.c           |   22 ++++----
 builtin/notes.c              |  120 +++++++++++++++++++++-------------=
--------
 builtin/pack-objects.c       |   64 +++++++++++-----------
 builtin/pack-refs.c          |    6 +-
 builtin/prune-packed.c       |    6 +-
 builtin/prune.c              |   10 ++--
 builtin/push.c               |   34 ++++++------
 builtin/read-tree.c          |   38 +++++++-------
 builtin/remote.c             |   84 +++++++++++++++---------------
 builtin/replace.c            |   12 ++--
 builtin/rerere.c             |    4 +-
 builtin/reset.c              |   20 ++++----
 builtin/rev-parse.c          |   18 +++---
 builtin/revert.c             |   36 ++++++------
 builtin/rm.c                 |   14 +++---
 builtin/shortlog.c           |   14 +++---
 builtin/show-branch.c        |   42 +++++++-------
 builtin/show-ref.c           |   28 +++++-----
 builtin/symbolic-ref.c       |    8 ++--
 builtin/tag.c                |   56 ++++++++++----------
 builtin/update-index.c       |   54 +++++++++---------
 builtin/update-ref.c         |   10 ++--
 builtin/update-server-info.c |    4 +-
 builtin/verify-pack.c        |    6 +-
 builtin/verify-tag.c         |    4 +-
 builtin/write-tree.c         |   10 ++--
 parse-options.c              |   19 ++++---
 parse-options.h              |   25 +++++----
 64 files changed, 962 insertions(+), 956 deletions(-)

--=20
1.7.8.36.g69ee2
