Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A46FA207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755198AbdEDNzn (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:55:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:52628 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755005AbdEDNzb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:55:31 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQhyf-1dVLfJ1TfJ-00U4NH; Thu, 04
 May 2017 15:55:12 +0200
Date:   Thu, 4 May 2017 15:54:56 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 00/25] Address a couple of issues identified by Coverity
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1493906084.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1064292636-1493906112=:4905"
X-Provags-ID: V03:K0:zhpOu2K78m2XDsksLrYSE9JCBMsNXD4KGsv7MMArhzySq7BzQHP
 4ZIcaxCBEirpET2h3GnII5EomjN7OmZty/5+SIBYUg+Ex7YVV1DgZcbgMNAXB32oEIc+AfT
 K9jB7SDpazWUYNtAdFiosOSlnzcMHo0qBJl6hN82xDY2Qj3F+r8SGv7+9cjJ4CxUq18ruSk
 1POOPffKa0IBLiW7QBa4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VYhlGYDsd0I=:0AArCP13mVWh9RhfmvdKEt
 oRcYsbsV0b5PtgAX5N6lwSYsbsNKBbyDfRLOzPrv5+tJNbYnKrrFWqqlehWCHYogcIsEGys+N
 VD4O4znNxRDW8fNLrGaVOAJqoIeOJ8jWpQsVmI5BllDjwD/mNIwp7R5llxy59OVxobcHBhfyr
 8tK5KxbitZzxBR9h57tZIquPW6rVLGF+P1Gx8qvtL0aLDQaQK16qoOWM+bW2mcBCf4MuoryzC
 mnoa87SD8yAcd07IlkTcH+Fp5S9pU9Hf8SrKqszy3/Mjl//zFkQH0UuH0co33w9JGmZ9Gc1Ti
 y+uWC77ZdcgS4eEnmt9ow2fSob5hBukKGbffMI2SPxoyMRNzlU6QT8dlWbm8iD33MdnlOennl
 8a4qN1D4g1loteLTDvpMh3YhuOtmNj8dRMCNxtk0hhNanKd4oRgjHRwwbCAF6GmLUM9ieQV/f
 ChNsOm/tsf7I6YiS4u6Ffp/UIXa2jRwQgslDcUd3d3doZ4v53IWGRapwdmfFiMyF0gVv733z6
 xp8XhbaS+JRSLO84cEBoQY/GW6r8/dlWqUNxJXcVBEyhe3GCVENO6okXAxy6+YrSbBg9MK4rc
 H2z/pjnOzh+Rf99LGFUKqGgVQgx3LdUtGDHAdwweWyQRw5hdrRbPcq26beLk6OiCJFitPEswc
 pccNJ1ZTYdznfBJlDDaLm54lcsWYzfR3a4mhBQIlKh42lsZXVs4soHtoPtoWz33Tfh7zapigh
 Fw/WzFdLZFziMJSOvyCgEHQK2kliEhO8gD1QiEG5dd5TQZHa9KjRnpn+KhZ06Mfz2TAsaxVgS
 pKFCXLt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1064292636-1493906112=:4905
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

I recently registered the git-for-windows fork with Coverity to ensure
that even the Windows-specific patches get some static analysis love.

While at it, I squashed a couple of obvious issues in the part that is
not Windows-specific.

Note: while this patch series squashes some of those issues, the
remaining issues are not necessarily all false positives (e.g. Coverity
getting fooled by our FLEX_ARRAY trick into believing that the last
member of the struct is indeed a 0 or 1 size array) or intentional (e.g.
builtins not releasing memory because exit() is called right after
returning from the function that leaks memory).

Notable examples of the remaining issues are:

- a couple of callers of shorten_unambiguous_ref() assume that they do
  not have to release the memory returned from that function, often
  assigning the pointer to a `const` variable that typically does not
  hold a pointer that needs to be free()d. My hunch is that we will want
  to convert that function to have a fixed number of static buffers and
  use those in a round robin fashion =C3=A0 la sha1_to_hex().

- pack-redundant.c seems to have hard-to-reason-about code paths that
  may eventually leak memory. Essentially, the custody of the allocated
  memory is not clear at all.

- fast-import.c calls strbuf_detach() on the command_buf without any
  obvious rationale. Turns out that *some* code paths assign
  command_buf.buf to a `recent_command` which releases the buffer later.
  However, from a cursory look it appears to me as if there are some
  other code paths that skip that assignment, effectively causing a memory
  leak once strbuf_detach() is called.

Sadly, I lack the time to pursue those remaining issues further.

Changes since v3:

- used 0 (black) for the foreground color attributes in winansi when we
  have no console to print to, anyway.

- clarified in the commit message when we hit the path, and why, where
  we set the foreground color attributes to "all black".

- reworded the commit message talking about splitting the PATH (on
  Windows, it is delimited by semicolons, not colons, but it is even
  better to just talk about the path delimiters because it does not
  really happen which character is used, but it is important which role
  it plays).

- rewrote the split_commit_in_progress() function to have a more natural
  flow while still fixing the memory leak.


Johannes Schindelin (25):
  mingw: avoid memory leak when splitting PATH
  winansi: avoid use of uninitialized value
  winansi: avoid buffer overrun
  add_commit_patch_id(): avoid allocating memory unnecessarily
  git_config_rename_section_in_file(): avoid resource leak
  get_mail_commit_oid(): avoid resource leak
  difftool: address a couple of resource/memory leaks
  status: close file descriptor after reading git-rebase-todo
  mailinfo & mailsplit: check for EOF while parsing
  cat-file: fix memory leak
  checkout: fix memory leak
  split_commit_in_progress(): simplify & fix memory leak
  setup_bare_git_dir(): help static analysis
  setup_discovered_git_dir(): plug memory leak
  pack-redundant: plug memory leak
  mktree: plug memory leaks reported by Coverity
  fast-export: avoid leaking memory in handle_tag()
  receive-pack: plug memory leak in update()
  line-log: avoid memory leak
  shallow: avoid memory leak
  add_reflog_for_walk: avoid memory leak
  remote: plug memory leak in match_explicit()
  name-rev: avoid leaking memory in the `deref` case
  show_worktree(): plug memory leak
  submodule_uses_worktrees(): plug memory leak

 builtin/am.c             | 15 ++++++---------
 builtin/cat-file.c       |  1 +
 builtin/checkout.c       | 17 +++++++++--------
 builtin/difftool.c       | 33 +++++++++++++++++++++++----------
 builtin/fast-export.c    |  2 ++
 builtin/mailsplit.c      | 10 ++++++++++
 builtin/mktree.c         |  5 +++--
 builtin/name-rev.c       |  7 +++++--
 builtin/pack-redundant.c |  1 +
 builtin/receive-pack.c   |  4 +++-
 builtin/worktree.c       |  8 +++++---
 compat/mingw.c           |  4 +++-
 compat/winansi.c         | 12 ++++++++++++
 config.c                 |  5 ++++-
 line-log.c               |  1 +
 mailinfo.c               |  9 ++++++++-
 patch-ids.c              |  3 ++-
 reflog-walk.c            | 20 +++++++++++++++++---
 remote.c                 |  5 +++--
 setup.c                  | 11 ++++++++---
 shallow.c                |  8 ++++++--
 worktree.c               |  2 +-
 wt-status.c              | 29 +++++++++++++++--------------
 23 files changed, 148 insertions(+), 64 deletions(-)


base-commit: d2bbb7c2bcf6e77ebfcabf4e12110fe6d5c91de6
Published-As: https://github.com/dscho/git/releases/tag/coverity-v4
Fetch-It-Via: git fetch https://github.com/dscho/git coverity-v4

Interdiff vs v3:

 diff --git a/compat/winansi.c b/compat/winansi.c
 index 861b79d8c31..a11a0f16d27 100644
 --- a/compat/winansi.c
 +++ b/compat/winansi.c
 @@ -105,8 +105,13 @@ static int is_console(int fd)
  =09if (!fd) {
  =09=09if (!GetConsoleMode(hcon, &mode))
  =09=09=09return 0;
 -=09=09sbi.wAttributes =3D FOREGROUND_BLUE | FOREGROUND_GREEN |
 -=09=09=09FOREGROUND_RED;
 +=09=09/*
 +=09=09 * This code path is only reached if there is no console
 +=09=09 * attached to stdout/stderr, i.e. we will not need to output
 +=09=09 * any text to any console, therefore we might just as well
 +=09=09 * use black as foreground color.
 +=09=09 */
 +=09=09sbi.wAttributes =3D 0;
  =09} else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
  =09=09return 0;
 =20
 diff --git a/wt-status.c b/wt-status.c
 index 1f3f6bcb980..117ac8cfb01 100644
 --- a/wt-status.c
 +++ b/wt-status.c
 @@ -1082,34 +1082,29 @@ static char *read_line_from_git_path(const char *f=
ilename)
  static int split_commit_in_progress(struct wt_status *s)
  {
  =09int split_in_progress =3D 0;
 -=09char *head =3D read_line_from_git_path("HEAD");
 -=09char *orig_head =3D read_line_from_git_path("ORIG_HEAD");
 -=09char *rebase_amend =3D read_line_from_git_path("rebase-merge/amend");
 -=09char *rebase_orig_head =3D read_line_from_git_path("rebase-merge/orig-=
head");
 -
 -=09if (!head || !orig_head || !rebase_amend || !rebase_orig_head ||
 -=09    !s->branch || strcmp(s->branch, "HEAD")) {
 -=09=09free(head);
 -=09=09free(orig_head);
 -=09=09free(rebase_amend);
 -=09=09free(rebase_orig_head);
 -=09=09return split_in_progress;
 -=09}
 -
 -=09if (!strcmp(rebase_amend, rebase_orig_head)) {
 -=09=09if (strcmp(head, rebase_amend))
 -=09=09=09split_in_progress =3D 1;
 -=09} else if (strcmp(orig_head, rebase_orig_head)) {
 -=09=09split_in_progress =3D 1;
 -=09}
 +=09char *head, *orig_head, *rebase_amend, *rebase_orig_head;
 +
 +=09if ((!s->amend && !s->nowarn && !s->workdir_dirty) ||
 +=09    !s->branch || strcmp(s->branch, "HEAD"))
 +=09=09return 0;
 =20
 -=09if (!s->amend && !s->nowarn && !s->workdir_dirty)
 -=09=09split_in_progress =3D 0;
 +=09head =3D read_line_from_git_path("HEAD");
 +=09orig_head =3D read_line_from_git_path("ORIG_HEAD");
 +=09rebase_amend =3D read_line_from_git_path("rebase-merge/amend");
 +=09rebase_orig_head =3D read_line_from_git_path("rebase-merge/orig-head")=
;
 +
 +=09if (!head || !orig_head || !rebase_amend || !rebase_orig_head)
 +=09=09; /* fall through, no split in progress */
 +=09else if (!strcmp(rebase_amend, rebase_orig_head))
 +=09=09split_in_progress =3D !!strcmp(head, rebase_amend);
 +=09else if (strcmp(orig_head, rebase_orig_head))
 +=09=09split_in_progress =3D 1;
 =20
  =09free(head);
  =09free(orig_head);
  =09free(rebase_amend);
  =09free(rebase_orig_head);
 +
  =09return split_in_progress;
  }
 =20

--=20
2.12.2.windows.2.800.gede8f145e06

--8323329-1064292636-1493906112=:4905--
