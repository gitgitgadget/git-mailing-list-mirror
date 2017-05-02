Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D183B1F790
	for <e@80x24.org>; Tue,  2 May 2017 16:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750762AbdEBQAm (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:00:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:65179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750717AbdEBQAl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:00:41 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaaVn-1dn7eS3zWJ-00mKBE; Tue, 02
 May 2017 18:00:32 +0200
Date:   Tue, 2 May 2017 18:00:30 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 00/25] Address a couple of issues identified by Coverity
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-947424109-1493740831=:3480"
X-Provags-ID: V03:K0:l+wEmrxDe/uIFZPis2z1RfLe+VoseNbWWypQTloAgGIpv2N9tq+
 ZxQqB3BHKZkKxdcyXAUe02sNVN93oAJNK1AlS9dlqA0ZRjffqDReCL5hTUgQ1tZlU5Y6HT7
 3tkfwPI9rWVuTGxdCYhWsrz3b+3ulplS77vyyE8Tt3BTItVpNnyuAbJXFceW5INmSKG7D23
 fP+PreyQQvYrRSQBISa+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wnOqpBqRo14=:zt7wOMxOi1OW2861JbSnoq
 +PDHXFO0LjQGYG8kfERN2LX4uyPNFUxTTm7VbMGFneDZJDJ+e6fwUxsTcoPBdDpnED2JzBLf8
 otGSJadR82HGNdnanM1DRr8yNLFjY5L4C24vM8I+YcYVEr1wIxyMvJGjBN9acwF8NSpYHssE/
 +b3e1d2t8TQXBlezw4ocurJwKaxyQ71xQ+gg8AzdYn3d+XKCpnp+NuoRl2FV4UOlHd7yKcaZQ
 PNVmWvp7uCIA6e+TLhlUSVGPU33Dk+gmpXZDQkYrdkVCMkRf/1mO5L1BOBRFJhyb8SH3035X/
 paXAwsA9tgr22xnXsHepcxbgrjV3Q1sMGFFYKPTKgXJYg5UCxGURxLQ6WstLqDy7CUQkAr6Uf
 Li3vSzO9yQnrbZahVgZaBBJK+vev9dq8CAJ243bf4gqIJyXwwPdCZPJ1JX7Lsxqkb7OASmLRa
 lFUTCTVk5RGNXK9FTaRvxUdNQaS8CB2aCY8BjG8kuUXf1p60/gawcEZ2JSOPOSeJsgMgmz9/F
 QvbGVXKUOej+mhl4B82JdF1BVMMTJPAYv7ai8fUzqiY6gOoqXQyWcTYsmcZBVosqcbCfg1s5A
 osKe9i9UFssRah/m74nPpZpqqU763uPuv9QOXD/T/Zb9aFtMw/04a8eoEyXFfYmUgKuwrkTwP
 g2KKfxPsW3slNZ5RPA5VG4/WBCrvOw7wIb0Hz5uIWHbTLrfjXnL5sWHKgDNuUXNML7tgcOHgn
 Ux6HZ7vmMkpJwC4owgcEu/eotxUD+2T/+m0Ku4tDnua8PIM8SZL5YP62MLaj+0raWYaeMyDok
 5eK7G9c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-947424109-1493740831=:3480
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

Changes since v2:

- renamed the `p` variables introduced by the patch series to the more
  explanatory `to_free`.

- reworded incorrect commit message claiming that
  setup_discovered_git_dir() was using a static variable that is
  actually a singleton

- reverted a code move that would have resulted in accessing
  uninitialized data of callers of mailinfo() that do not die() right
  away but clean up faithfully


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
  split_commit_in_progress(): fix memory leak
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
 compat/winansi.c         |  7 +++++++
 config.c                 |  5 ++++-
 line-log.c               |  1 +
 mailinfo.c               |  9 ++++++++-
 patch-ids.c              |  3 ++-
 reflog-walk.c            | 20 +++++++++++++++++---
 remote.c                 |  5 +++--
 setup.c                  | 11 ++++++++---
 shallow.c                |  8 ++++++--
 worktree.c               |  2 +-
 wt-status.c              |  8 +++++++-
 23 files changed, 135 insertions(+), 51 deletions(-)


base-commit: d2bbb7c2bcf6e77ebfcabf4e12110fe6d5c91de6
Published-As: https://github.com/dscho/git/releases/tag/coverity-v3
Fetch-It-Via: git fetch https://github.com/dscho/git coverity-v3

Interdiff vs v2:

 diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
 index 9b3efc8e987..664400b8169 100644
 --- a/builtin/mailsplit.c
 +++ b/builtin/mailsplit.c
 @@ -232,9 +232,18 @@ static int split_mbox(const char *file, const char *d=
ir, int allow_bare,
 =20
  =09do {
  =09=09peek =3D fgetc(f);
 +=09=09if (peek =3D=3D EOF) {
 +=09=09=09if (f =3D=3D stdin)
 +=09=09=09=09/* empty stdin is OK */
 +=09=09=09=09ret =3D skip;
 +=09=09=09else {
 +=09=09=09=09fclose(f);
 +=09=09=09=09error(_("empty mbox: '%s'"), file);
 +=09=09=09}
 +=09=09=09goto out;
 +=09=09}
  =09} while (isspace(peek));
 -=09if (peek !=3D EOF)
 -=09=09ungetc(peek, f);
 +=09ungetc(peek, f);
 =20
  =09if (strbuf_getwholeline(&buf, f, '\n')) {
  =09=09/* empty stdin is OK */
 diff --git a/builtin/mktree.c b/builtin/mktree.c
 index f0354bc9718..da0fd8cd706 100644
 --- a/builtin/mktree.c
 +++ b/builtin/mktree.c
 @@ -72,7 +72,7 @@ static void mktree_line(char *buf, size_t len, int nul_t=
erm_line, int allow_miss
  =09unsigned mode;
  =09enum object_type mode_type; /* object type derived from mode */
  =09enum object_type obj_type; /* object type derived from sha */
 -=09char *path, *p =3D NULL;
 +=09char *path, *to_free =3D NULL;
  =09unsigned char sha1[20];
 =20
  =09ptr =3D buf;
 @@ -102,7 +102,7 @@ static void mktree_line(char *buf, size_t len, int nul=
_term_line, int allow_miss
  =09=09struct strbuf p_uq =3D STRBUF_INIT;
  =09=09if (unquote_c_style(&p_uq, path, NULL))
  =09=09=09die("invalid quoting");
 -=09=09path =3D p =3D strbuf_detach(&p_uq, NULL);
 +=09=09path =3D to_free =3D strbuf_detach(&p_uq, NULL);
  =09}
 =20
  =09/*
 @@ -136,7 +136,7 @@ static void mktree_line(char *buf, size_t len, int nul=
_term_line, int allow_miss
  =09}
 =20
  =09append_to_tree(mode, sha1, path);
 -=09free(p);
 +=09free(to_free);
  }
 =20
  int cmd_mktree(int ac, const char **av, const char *prefix)
 diff --git a/builtin/name-rev.c b/builtin/name-rev.c
 index a4ce73fb1e9..e7a3fe7ee70 100644
 --- a/builtin/name-rev.c
 +++ b/builtin/name-rev.c
 @@ -28,7 +28,7 @@ static void name_rev(struct commit *commit,
  =09struct rev_name *name =3D (struct rev_name *)commit->util;
  =09struct commit_list *parents;
  =09int parent_number =3D 1;
 -=09char *p =3D NULL;
 +=09char *to_free =3D NULL;
 =20
  =09parse_commit(commit);
 =20
 @@ -36,7 +36,7 @@ static void name_rev(struct commit *commit,
  =09=09return;
 =20
  =09if (deref) {
 -=09=09tip_name =3D p =3D xstrfmt("%s^0", tip_name);
 +=09=09tip_name =3D to_free =3D xstrfmt("%s^0", tip_name);
 =20
  =09=09if (generation)
  =09=09=09die("generation: %d, but deref?", generation);
 @@ -55,7 +55,7 @@ static void name_rev(struct commit *commit,
  =09=09name->generation =3D generation;
  =09=09name->distance =3D distance;
  =09} else {
 -=09=09free(p);
 +=09=09free(to_free);
  =09=09return;
  =09}
 =20
 diff --git a/mailinfo.c b/mailinfo.c
 index a319911b510..f92cb9f729c 100644
 --- a/mailinfo.c
 +++ b/mailinfo.c
 @@ -1097,6 +1097,9 @@ int mailinfo(struct mailinfo *mi, const char *msg, c=
onst char *patch)
  =09=09return -1;
  =09}
 =20
 +=09mi->p_hdr_data =3D xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
 +=09mi->s_hdr_data =3D xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
 +
  =09do {
  =09=09peek =3D fgetc(mi->input);
  =09=09if (peek =3D=3D EOF) {
 @@ -1106,9 +1109,6 @@ int mailinfo(struct mailinfo *mi, const char *msg, c=
onst char *patch)
  =09} while (isspace(peek));
  =09ungetc(peek, mi->input);
 =20
 -=09mi->p_hdr_data =3D xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
 -=09mi->s_hdr_data =3D xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
 -
  =09/* process the email header */
  =09while (read_one_header_line(&line, mi->input))
  =09=09check_header(mi, &line, mi->p_hdr_data, 1);
 diff --git a/setup.c b/setup.c
 index 12efca85a41..e3f7699a902 100644
 --- a/setup.c
 +++ b/setup.c
 @@ -703,15 +703,15 @@ static const char *setup_discovered_git_dir(const ch=
ar *gitdir,
 =20
  =09/* --work-tree is set without --git-dir; use discovered one */
  =09if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
 -=09=09char *p =3D NULL;
 +=09=09char *to_free =3D NULL;
  =09=09const char *ret;
 =20
  =09=09if (offset !=3D cwd->len && !is_absolute_path(gitdir))
 -=09=09=09gitdir =3D p =3D real_pathdup(gitdir, 1);
 +=09=09=09gitdir =3D to_free =3D real_pathdup(gitdir, 1);
  =09=09if (chdir(cwd->buf))
  =09=09=09die_errno("Could not come back to cwd");
  =09=09ret =3D setup_explicit_git_dir(gitdir, cwd, nongit_ok);
 -=09=09free(p);
 +=09=09free(to_free);
  =09=09return ret;
  =09}
 =20

--=20
2.12.2.windows.2.800.gede8f145e06

--8323329-947424109-1493740831=:3480--
