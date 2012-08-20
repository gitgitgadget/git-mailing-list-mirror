From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/66] parseopt i18n marking (again)
Date: Mon, 20 Aug 2012 19:31:49 +0700
Message-ID: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 14:39:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RG6-0004yo-Uw
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297Ab2HTMjA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:39:00 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab2HTMi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:38:58 -0400
Received: by pbbrr13 with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=wVgwkaKeA0T5B1nlxhObAlONJTZ1pykYjZkE5yEkxgA=;
        b=gJJMOETPY5b0P8tDUIc070RDqfrzy1DUqemeKEb7JDC9Xtg6VyibP9csjAsI34JX1B
         eSGlGdZ9eroS3R3EhC65FDUc92F8rUTMcOC/uLlTRbzZJhsUtp/NtawGzYozGLNxCaYL
         Lvo0t/qTSHCC5Mao3X/zNnrK7ED6EQZLna3uw4r6bsrFo1CaJv19yqhOGwk9spSlb1eW
         ML2bGHZafYW35iaEpdpUlnwuAXFe53caoTMt2Dfn26xoilCOzOco7QONTRLhgwhCtqRe
         WuTvy4KG6Z0/bNYxZiieUeCYYMWChjCSKdMrmKHUX4k/Bb2CvYPs1Nt/zrgJZPFhLzq3
         ocLg==
Received: by 10.66.83.202 with SMTP id s10mr19984133pay.31.1345466338318;
        Mon, 20 Aug 2012 05:38:58 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id wf7sm11037362pbc.34.2012.08.20.05.38.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:38:57 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:32:57 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203772>

There are not many changes since last time I sent this. A few new
strings are introduced by new options, which are also marked. 'next'
has some more, which causes conflicts but they should be easy to
resolve.

The last two patches are not really related to i18n. I looked at the
marked strings and thought they were good changes to make. I suspect
we'll find more string fixups as translators do their work because
some of these texts are not clear.

Happy translating!

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (66):
  i18n: mark "style" in OPT_COLUMN() for translation
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
  Reduce translations by using same terminologies
  Use imperative form in help usage to describe an action

 archive.c                    |  38 +++++++-------
 builtin/add.c                |  26 +++++-----
 builtin/apply.c              |   2 +-
 builtin/archive.c            |  12 ++---
 builtin/bisect--helper.c     |   6 +--
 builtin/blame.c              |  46 ++++++++---------
 builtin/branch.c             |  56 ++++++++++----------
 builtin/cat-file.c           |  20 ++++----
 builtin/check-attr.c         |  12 ++---
 builtin/checkout-index.c     |  24 ++++-----
 builtin/checkout.c           |  40 +++++++--------
 builtin/clean.c              |  18 +++----
 builtin/clone.c              |  56 ++++++++++----------
 builtin/column.c             |  16 +++---
 builtin/commit.c             | 100 ++++++++++++++++++-----------------=
-
 builtin/config.c             |  56 ++++++++++----------
 builtin/count-objects.c      |   4 +-
 builtin/describe.c           |  28 +++++-----
 builtin/fast-export.c        |  28 +++++-----
 builtin/fetch.c              |  48 ++++++++---------
 builtin/fmt-merge-msg.c      |  16 +++---
 builtin/for-each-ref.c       |  18 +++----
 builtin/fsck.c               |  24 ++++-----
 builtin/gc.c                 |  12 ++---
 builtin/grep.c               |  90 ++++++++++++++++----------------
 builtin/hash-object.c        |  16 +++---
 builtin/help.c               |  10 ++--
 builtin/init-db.c            |  18 +++----
 builtin/log.c                |  80 ++++++++++++++---------------
 builtin/ls-files.c           |  54 +++++++++----------
 builtin/ls-tree.c            |  22 ++++----
 builtin/merge-base.c         |  12 ++---
 builtin/merge-file.c         |  20 ++++----
 builtin/merge.c              |  48 ++++++++---------
 builtin/mktree.c             |   8 +--
 builtin/mv.c                 |  10 ++--
 builtin/name-rev.c           |  22 ++++----
 builtin/notes.c              | 120 +++++++++++++++++++++--------------=
--------
 builtin/pack-objects.c       |  64 +++++++++++------------
 builtin/pack-refs.c          |   6 +--
 builtin/prune-packed.c       |   6 +--
 builtin/prune.c              |  10 ++--
 builtin/push.c               |  34 ++++++------
 builtin/read-tree.c          |  38 +++++++-------
 builtin/remote.c             |  84 +++++++++++++++---------------
 builtin/replace.c            |  12 ++---
 builtin/rerere.c             |   4 +-
 builtin/reset.c              |  20 ++++----
 builtin/rev-parse.c          |  18 +++----
 builtin/revert.c             |  36 ++++++-------
 builtin/rm.c                 |  14 ++---
 builtin/shortlog.c           |  14 ++---
 builtin/show-branch.c        |  42 +++++++--------
 builtin/show-ref.c           |  28 +++++-----
 builtin/symbolic-ref.c       |   8 +--
 builtin/tag.c                |  56 ++++++++++----------
 builtin/update-index.c       |  56 ++++++++++----------
 builtin/update-ref.c         |  10 ++--
 builtin/update-server-info.c |   4 +-
 builtin/verify-pack.c        |   6 +--
 builtin/verify-tag.c         |   4 +-
 builtin/write-tree.c         |  10 ++--
 parse-options.h              |   2 +-
 63 files changed, 911 insertions(+), 911 deletions(-)

--=20
1.7.12.rc2.18.g61b472e
