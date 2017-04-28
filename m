Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9DDE207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 13:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426060AbdD1Ntd (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 09:49:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:64871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755682AbdD1Nta (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 09:49:30 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPm54-1d7y9w1KiY-004zHz; Fri, 28
 Apr 2017 15:49:22 +0200
Date:   Fri, 28 Apr 2017 15:49:21 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 00/25] Address a couple of issues identified by Coverity
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-335488560-1493387362=:3480"
X-Provags-ID: V03:K0:Mf/a6GwOFZSgtdn2D5gLnT7U5ecVdV2rEpo+fGkhklIpdOysKVQ
 SlZ3Z0fFQ/2/vPjbu0/kvN+Gll8V8JDyh0ZsaJXltl5eNRt8qHWbqHmDbIb1iLG2jfHkgQp
 td35zsYGDTKkig9xozjiXe5yPhxpq/tTRIzvB9pZKXoPVU8upLtVtni3sEEldt6UVQ5u6/k
 XKB+rtSu44TgcSauKW9dw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lmaYQKJB7Nc=:1lX1biHp30d6pXYGxx0fL9
 8EgS+aeqUFA79MaJPIoLly5/5fMxc7Z7b45XP9SZ/m7K+LeA7kFg+H4x3mT/ky1YIUiSlypLM
 kXY7YfNyIJQS6W951dvZhdYxHHn557AZiLbkOs7hp9WNfunDhWmgdhl7nPiwhDR+sbwkfoSuf
 i0Pr4XQzsvfjL9KNhSBHSF+/WfuYASV595X87TR3i93J3UNjq74y+DcfKcfbfWnAM+xpQxJjB
 QGKeIxM7q/LfSDwOmG4VJMmPZ4MU6WIhPdvrUrXnme0qfGoQON1ByGNoutyw/pK3ZWK7XwI5y
 hhIemg+6P+eI0dSsKjKrQWuvkytAc00Mh5sMCntTAdNilpQ0qmr0Vq0Lm7l3ZfS7Px19xxej+
 Aqc0pgSkDQ+E9iI6lR11dTH/uL1u2+Nci8JhFvwpCtAjlBo4qRdd7Tsi6VMBE0f35ilXMeg/N
 QPpO+hbfigustYSg87xJfAx569SsQJzaHbuxDtUEwGwR2hHVpQpHyK7ZsspmUue1rd8LiTY4K
 FQBDnhAd9SfM+GJC/395J/P2chqmK388tpcKfZq/63MaM80KOs+ZQNGj1nj5YYGUfA3twGZXn
 5wqehWesefnM8TifUqS2sB5tPEnl8G+p/SgIYJF1MZGw94uwsMWgs1HkVEsSwsJ8XGqV4arA7
 mHwSgbz9qta/xAUlHp1PckpVJnwoKwQawpJwcVvqeZ+NnJCp31tIu/CpQ3mKoDJwbglNcBmU7
 UyedLb5siPZKweA6JYbWoq65NHWcsNljyw0Refkn5EVI64gB50aLvSuQKMfaXHQdr+zCGHsPl
 qimCmpy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-335488560-1493387362=:3480
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

Changes since v1:

- clarified in the commit messages for the setup_*git_dir() functions
  that we are not really plugging a memory leak, but marking singletons
  as `static` to help Coverity not to complain about this again

- dropped the patch to http-backend, as it is supposedly a one-shot
  program using exit() as "garbage collector".

- the difftool patch does a more thorough job of fixing leaks now

- reworded the commit subject of the mailinfo/mailsplit patch to sport
  a prefix indicating the overall area of the fix

- changed the mailinfo/mailsplit patch to *really* handle EOF correctly

- simplified the patch to get_mail_commit_oid(), and now it even returns
  the correct error value!

- adjusted the comment in builtin/checkout.c that talked about leaking
  the cache_entry (which is not leaked anymore)

- add forgotten free(buf) in fast-export.c in an early return

- line-log data is now released properly

- a couple more memory leaks in add_reflog_for_walk() have been found
  and addressed (this one *really* needs a couple more eyeballs, though,
  it is just a much bigger change than I originally anticipated)


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
  setup_discovered_git_dir(): help static analysis
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
 builtin/mailsplit.c      |  3 ++-
 builtin/mktree.c         |  5 +++--
 builtin/name-rev.c       |  7 +++++--
 builtin/pack-redundant.c |  1 +
 builtin/receive-pack.c   |  4 +++-
 builtin/worktree.c       |  8 +++++---
 compat/mingw.c           |  4 +++-
 compat/winansi.c         |  7 +++++++
 config.c                 |  5 ++++-
 line-log.c               |  1 +
 mailinfo.c               | 15 +++++++++++----
 patch-ids.c              |  3 ++-
 reflog-walk.c            | 20 +++++++++++++++++---
 remote.c                 |  5 +++--
 setup.c                  | 11 ++++++++---
 shallow.c                |  8 ++++++--
 worktree.c               |  2 +-
 wt-status.c              |  8 +++++++-
 23 files changed, 130 insertions(+), 55 deletions(-)


base-commit: 027a3b943b444a3e3a76f9a89803fc10245b858f
Published-As: https://github.com/dscho/git/releases/tag/coverity-v2
Fetch-It-Via: git fetch https://github.com/dscho/git coverity-v2

Interdiff vs v1:

 diff --git a/builtin/am.c b/builtin/am.c
 index 067dd4fc20d..9c5c2c778e2 100644
 --- a/builtin/am.c
 +++ b/builtin/am.c
 @@ -1353,18 +1353,14 @@ static int get_mail_commit_oid(struct object_id *c=
ommit_id, const char *mail)
  =09const char *x;
  =09int ret =3D 0;
 =20
 -=09if (strbuf_getline_lf(&sb, fp))
 -=09=09ret =3D -1;
 -
 -=09if (!ret && !skip_prefix(sb.buf, "From ", &x))
 -=09=09ret =3D -1;
 -
 -=09if (!ret && get_oid_hex(x, commit_id) < 0)
 +=09if (strbuf_getline_lf(&sb, fp) ||
 +=09    !skip_prefix(sb.buf, "From ", &x) ||
 +=09    get_oid_hex(x, commit_id) < 0)
  =09=09ret =3D -1;
 =20
  =09strbuf_release(&sb);
  =09fclose(fp);
 -=09return 0;
 +=09return ret;
  }
 =20
  /**
 diff --git a/builtin/checkout.c b/builtin/checkout.c
 index 98f98256608..5faea3a05fa 100644
 --- a/builtin/checkout.c
 +++ b/builtin/checkout.c
 @@ -235,14 +235,14 @@ static int checkout_merged(int pos, const struct che=
ckout *state)
  =09/*
  =09 * NEEDSWORK:
  =09 * There is absolutely no reason to write this as a blob object
 -=09 * and create a phony cache entry just to leak.  This hack is
 -=09 * primarily to get to the write_entry() machinery that massages
 -=09 * the contents to work-tree format and writes out which only
 -=09 * allows it for a cache entry.  The code in write_entry() needs
 -=09 * to be refactored to allow us to feed a <buffer, size, mode>
 -=09 * instead of a cache entry.  Such a refactoring would help
 -=09 * merge_recursive as well (it also writes the merge result to the
 -=09 * object database even when it may contain conflicts).
 +=09 * and create a phony cache entry.  This hack is primarily to get
 +=09 * to the write_entry() machinery that massages the contents to
 +=09 * work-tree format and writes out which only allows it for a
 +=09 * cache entry.  The code in write_entry() needs to be refactored
 +=09 * to allow us to feed a <buffer, size, mode> instead of a cache
 +=09 * entry.  Such a refactoring would help merge_recursive as well
 +=09 * (it also writes the merge result to the object database even
 +=09 * when it may contain conflicts).
  =09 */
  =09if (write_sha1_file(result_buf.ptr, result_buf.size,
  =09=09=09    blob_type, oid.hash))
 diff --git a/builtin/difftool.c b/builtin/difftool.c
 index a4f1d117ef6..b9a892f2693 100644
 --- a/builtin/difftool.c
 +++ b/builtin/difftool.c
 @@ -440,8 +440,10 @@ static int run_dir_diff(const char *extcmd, int symli=
nks, const char *prefix,
  =09=09}
 =20
  =09=09if (lmode && status !=3D 'C') {
 -=09=09=09if (checkout_path(lmode, &loid, src_path, &lstate))
 -=09=09=09=09return error("could not write '%s'", src_path);
 +=09=09=09if (checkout_path(lmode, &loid, src_path, &lstate)) {
 +=09=09=09=09ret =3D error("could not write '%s'", src_path);
 +=09=09=09=09goto finish;
 +=09=09=09}
  =09=09}
 =20
  =09=09if (rmode && !S_ISLNK(rmode)) {
 @@ -457,9 +459,12 @@ static int run_dir_diff(const char *extcmd, int symli=
nks, const char *prefix,
  =09=09=09hashmap_add(&working_tree_dups, entry);
 =20
  =09=09=09if (!use_wt_file(workdir, dst_path, &roid)) {
 -=09=09=09=09if (checkout_path(rmode, &roid, dst_path, &rstate))
 -=09=09=09=09=09return error("could not write '%s'",
 -=09=09=09=09=09=09     dst_path);
 +=09=09=09=09if (checkout_path(rmode, &roid, dst_path,
 +=09=09=09=09=09=09  &rstate)) {
 +=09=09=09=09=09ret =3D error("could not write '%s'",
 +=09=09=09=09=09=09    dst_path);
 +=09=09=09=09=09goto finish;
 +=09=09=09=09}
  =09=09=09} else if (!is_null_oid(&roid)) {
  =09=09=09=09/*
  =09=09=09=09 * Changes in the working tree need special
 @@ -474,10 +479,12 @@ static int run_dir_diff(const char *extcmd, int syml=
inks, const char *prefix,
  =09=09=09=09=09=09ADD_CACHE_JUST_APPEND);
 =20
  =09=09=09=09add_path(&rdir, rdir_len, dst_path);
 -=09=09=09=09if (ensure_leading_directories(rdir.buf))
 -=09=09=09=09=09return error("could not create "
 -=09=09=09=09=09=09     "directory for '%s'",
 -=09=09=09=09=09=09     dst_path);
 +=09=09=09=09if (ensure_leading_directories(rdir.buf)) {
 +=09=09=09=09=09ret =3D error("could not create "
 +=09=09=09=09=09=09    "directory for '%s'",
 +=09=09=09=09=09=09    dst_path);
 +=09=09=09=09=09goto finish;
 +=09=09=09=09}
  =09=09=09=09add_path(&wtdir, wtdir_len, dst_path);
  =09=09=09=09if (symlinks) {
  =09=09=09=09=09if (symlink(wtdir.buf, rdir.buf)) {
 @@ -499,13 +506,14 @@ static int run_dir_diff(const char *extcmd, int syml=
inks, const char *prefix,
  =09}
 =20
  =09fclose(fp);
 +=09fp =3D NULL;
  =09if (finish_command(&child)) {
  =09=09ret =3D error("error occurred running diff --raw");
  =09=09goto finish;
  =09}
 =20
  =09if (!i)
 -=09=09return 0;
 +=09=09goto finish;
 =20
  =09/*
  =09 * Changes to submodules require special treatment.This loop writes a
 @@ -628,6 +636,9 @@ static int run_dir_diff(const char *extcmd, int symlin=
ks, const char *prefix,
  =09=09exit_cleanup(tmpdir, rc);
 =20
  finish:
 +=09if (fp)
 +=09=09fclose(fp);
 +
  =09free(lbase_dir);
  =09free(rbase_dir);
  =09strbuf_release(&ldir);
 diff --git a/builtin/fast-export.c b/builtin/fast-export.c
 index 828d41c0c11..64617ad8e36 100644
 --- a/builtin/fast-export.c
 +++ b/builtin/fast-export.c
 @@ -734,6 +734,7 @@ static void handle_tag(const char *name, struct tag *t=
ag)
  =09=09=09     oid_to_hex(&tag->object.oid));
  =09=09case DROP:
  =09=09=09/* Ignore this tag altogether */
 +=09=09=09free(buf);
  =09=09=09return;
  =09=09case REWRITE:
  =09=09=09if (tagged->type !=3D OBJ_COMMIT) {
 diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
 index c0d88f97512..9b3efc8e987 100644
 --- a/builtin/mailsplit.c
 +++ b/builtin/mailsplit.c
 @@ -232,8 +232,9 @@ static int split_mbox(const char *file, const char *di=
r, int allow_bare,
 =20
  =09do {
  =09=09peek =3D fgetc(f);
 -=09} while (peek >=3D 0 && isspace(peek));
 -=09ungetc(peek, f);
 +=09} while (isspace(peek));
 +=09if (peek !=3D EOF)
 +=09=09ungetc(peek, f);
 =20
  =09if (strbuf_getwholeline(&buf, f, '\n')) {
  =09=09/* empty stdin is OK */
 diff --git a/http-backend.c b/http-backend.c
 index d12572fda10..eef0a361f4f 100644
 --- a/http-backend.c
 +++ b/http-backend.c
 @@ -681,10 +681,8 @@ int cmd_main(int argc, const char **argv)
  =09=09if (!regexec(&re, dir, 1, out, 0)) {
  =09=09=09size_t n;
 =20
 -=09=09=09if (strcmp(method, c->method)) {
 -=09=09=09=09free(dir);
 +=09=09=09if (strcmp(method, c->method))
  =09=09=09=09return bad_request(&hdr, c);
 -=09=09=09}
 =20
  =09=09=09cmd =3D c;
  =09=09=09n =3D out[0].rm_eo - out[0].rm_so;
 @@ -710,7 +708,5 @@ int cmd_main(int argc, const char **argv)
  =09=09=09=09=09   max_request_buffer);
 =20
  =09cmd->imp(&hdr, cmd_arg);
 -=09free(dir);
 -=09free(cmd_arg);
  =09return 0;
  }
 diff --git a/line-log.c b/line-log.c
 index 19d46e9ea2c..b9087814b8c 100644
 --- a/line-log.c
 +++ b/line-log.c
 @@ -1125,7 +1125,7 @@ static int process_ranges_ordinary_commit(struct rev=
_info *rev, struct commit *c
  =09changed =3D process_all_files(&parent_range, rev, &queue, range);
  =09if (parent)
  =09=09add_line_range(rev, parent, parent_range);
 -=09free(parent_range);
 +=09free_line_log_data(parent_range);
  =09return changed;
  }
 =20
 diff --git a/mailinfo.c b/mailinfo.c
 index 60dcad7b714..a319911b510 100644
 --- a/mailinfo.c
 +++ b/mailinfo.c
 @@ -882,7 +882,10 @@ static int read_one_header_line(struct strbuf *line, =
FILE *in)
  =09for (;;) {
  =09=09int peek;
 =20
 -=09=09peek =3D fgetc(in); ungetc(peek, in);
 +=09=09peek =3D fgetc(in);
 +=09=09if (peek =3D=3D EOF)
 +=09=09=09break;
 +=09=09ungetc(peek, in);
  =09=09if (peek !=3D ' ' && peek !=3D '\t')
  =09=09=09break;
  =09=09if (strbuf_getline_lf(&continuation, in))
 @@ -1094,14 +1097,18 @@ int mailinfo(struct mailinfo *mi, const char *msg,=
 const char *patch)
  =09=09return -1;
  =09}
 =20
 -=09mi->p_hdr_data =3D xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
 -=09mi->s_hdr_data =3D xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
 -
  =09do {
  =09=09peek =3D fgetc(mi->input);
 -=09} while (peek >=3D 0 && isspace(peek));
 +=09=09if (peek =3D=3D EOF) {
 +=09=09=09fclose(cmitmsg);
 +=09=09=09return error("empty patch: '%s'", patch);
 +=09=09}
 +=09} while (isspace(peek));
  =09ungetc(peek, mi->input);
 =20
 +=09mi->p_hdr_data =3D xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
 +=09mi->s_hdr_data =3D xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
 +
  =09/* process the email header */
  =09while (read_one_header_line(&line, mi->input))
  =09=09check_header(mi, &line, mi->p_hdr_data, 1);
 diff --git a/reflog-walk.c b/reflog-walk.c
 index ec66f2b16e6..c63eb1a3fd7 100644
 --- a/reflog-walk.c
 +++ b/reflog-walk.c
 @@ -197,17 +197,27 @@ int add_reflog_for_walk(struct reflog_walk_info *inf=
o,
  =09=09=09=09reflogs =3D read_complete_reflog(branch);
  =09=09=09}
  =09=09}
 -=09=09if (!reflogs || reflogs->nr =3D=3D 0)
 +=09=09if (!reflogs || reflogs->nr =3D=3D 0) {
 +=09=09=09if (reflogs) {
 +=09=09=09=09free(reflogs->ref);
 +=09=09=09=09free(reflogs);
 +=09=09=09}
 +=09=09=09free(branch);
  =09=09=09return -1;
 +=09=09}
  =09=09string_list_insert(&info->complete_reflogs, branch)->util
  =09=09=09=3D reflogs;
  =09}
 +=09free(branch);
 =20
  =09commit_reflog =3D xcalloc(1, sizeof(struct commit_reflog));
  =09if (recno < 0) {
  =09=09commit_reflog->recno =3D get_reflog_recno_by_time(reflogs, timestam=
p);
  =09=09if (commit_reflog->recno < 0) {
 -=09=09=09free(branch);
 +=09=09=09if (reflogs) {
 +=09=09=09=09free(reflogs->ref);
 +=09=09=09=09free(reflogs);
 +=09=09=09}
  =09=09=09free(commit_reflog);
  =09=09=09return -1;
  =09=09}

--=20
2.12.2.windows.2.800.gede8f145e06

--8323329-335488560-1493387362=:3480--
