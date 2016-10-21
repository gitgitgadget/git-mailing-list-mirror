Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 150E520987
	for <e@80x24.org>; Fri, 21 Oct 2016 12:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932792AbcJUM0a (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:26:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:56023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754368AbcJUM03 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:26:29 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M1nbu-1cloCl3FVa-00tkIO; Fri, 21 Oct 2016 14:26:21
 +0200
Date:   Fri, 21 Oct 2016 14:26:21 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 25/27] sequencer: quote filenames in error messages
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <8490f9cf3c6ff6b453064175e5fe8cfecadb9600.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1208570025-1477052781=:3264"
X-Provags-ID: V03:K0:6uhxQvtDHa16XojGK7S0FgQ5S31ghSi0Wbo8tfMkJushdeLiML1
 xtqGX1OEPac7BzK8VavGe7otRn/wdCfhkrO5SuRmTCdruRdEnRTzDDeqApyJtL/bxCxn/lw
 RaoqZQqNydytcXlFORTqFi9G36OTYEhznkfb91s86XvI2CzDTEKA0hs8NZUmBAoEu0fDEIc
 adGCrdEChpp3sDTXqqrpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rMVMQzVcF1c=:Ab7K7Q4lmNlVswulfCQIAK
 xqUiBZZz+tSZvzKNY+6w4meJ5JJYgD9yh539iwiqzxsjhPBApcWHSzdZshxb2RqGrKAa5ehfZ
 XODR6zHgbghpgkOymgCk4YSeWaSx6R/2vLBpDG/2xMIv1ntC5MxSKP6gtCdGpxpG34ylq1YhQ
 04tauqTHxQYD4z+TNoL+0tPfivaMdu3xHHniaLH2QTvk1W4ODPQ1/W+E/di0flc1j6nQtsH9E
 MHWczotfKdW331sjM/7WCymoyBS9W7aHbmScU8fQ6LFDRA9rsRUQopnUOV47R9rV1YqHpDzYR
 tBJOhGwTykS6pcYhUfDK//T3s7+6VIQXxJvUhyqT7md+cEPqInF9bkePfRexal7vuc3NERK21
 QNho09nyB0w90rrJPazLCdZIagOwVYzE48rgQUbcSSx8MnWpM7ppJ23mrPWmr4rq/asaYE+Ob
 y9GAOhhmI22ZUWo9+xnPbU8eQvGSUP86IFsfQR7j4GukRmEP9DVuJBw3qDxLbvDA9yV4Ay2KL
 rF3AgtOu5uHd5307PGWyYGEzLokByF4u2I4Tu8wrn3iaywcc5PrZhiZIKSI3EKG6ivrt7ULOX
 q2vTzJ7F+NJLPEddsCkx9NlwoiadMO9fjWOjDnSLBRcdJQklB0Fi1qfdwhcGP9iH/rTQpCfga
 wxkW/FB8Wiy1E9UF384vLVRd9IOftFqywAtxfWORbQV9PEWjpYw36j2Jqea7/e3qK+/fhECT+
 UcyRyS68ne270xlHMRqTn+aBxd/J3a8bhytvrnvOnormbkJXrVvBCFk0r6wm/jXhSdkcy9/6W
 UuByrg0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1208570025-1477052781=:3264
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

This makes the code consistent by fixing quite a couple of error messages.

Suggested by Jakub Nar=C4=99bski.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ff76b6f..340d0ed 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -252,7 +252,7 @@ static int write_message(const void *buf, size_t len, c=
onst char *filename,
 =09}
 =09if (commit_lock_file(&msg_file) < 0) {
 =09=09rollback_lock_file(&msg_file);
-=09=09return error(_("Error wrapping up %s."), filename);
+=09=09return error(_("Error wrapping up '%s'."), filename);
 =09}
=20
 =09return 0;
@@ -954,16 +954,16 @@ static int read_populate_todo(struct todo_list *todo_=
list,
 =09strbuf_reset(&todo_list->buf);
 =09fd =3D open(todo_file, O_RDONLY);
 =09if (fd < 0)
-=09=09return error_errno(_("Could not open %s"), todo_file);
+=09=09return error_errno(_("Could not open '%s'"), todo_file);
 =09if (strbuf_read(&todo_list->buf, fd, 0) < 0) {
 =09=09close(fd);
-=09=09return error(_("Could not read %s."), todo_file);
+=09=09return error(_("Could not read '%s'."), todo_file);
 =09}
 =09close(fd);
=20
 =09res =3D parse_insn_buffer(todo_list->buf.buf, todo_list);
 =09if (res)
-=09=09return error(_("Unusable instruction sheet: %s"), todo_file);
+=09=09return error(_("Unusable instruction sheet: '%s'"), todo_file);
=20
 =09if (!is_rebase_i(opts)) {
 =09=09enum todo_command valid =3D
@@ -1054,7 +1054,7 @@ static int read_populate_opts(struct replay_opts *opt=
s)
 =09 * are pretty certain that it is syntactically correct.
 =09 */
 =09if (git_config_from_file(populate_opts_cb, git_path_opts_file(), opts) =
< 0)
-=09=09return error(_("Malformed options sheet: %s"),
+=09=09return error(_("Malformed options sheet: '%s'"),
 =09=09=09git_path_opts_file());
 =09return 0;
 }
@@ -1097,7 +1097,7 @@ static int create_seq_dir(void)
 =09=09return -1;
 =09}
 =09else if (mkdir(git_path_seq_dir(), 0777) < 0)
-=09=09return error_errno(_("Could not create sequencer directory %s"),
+=09=09return error_errno(_("Could not create sequencer directory '%s'"),
 =09=09=09=09   git_path_seq_dir());
 =09return 0;
 }
@@ -1116,12 +1116,12 @@ static int save_head(const char *head)
 =09strbuf_addf(&buf, "%s\n", head);
 =09if (write_in_full(fd, buf.buf, buf.len) < 0) {
 =09=09rollback_lock_file(&head_lock);
-=09=09return error_errno(_("Could not write to %s"),
+=09=09return error_errno(_("Could not write to '%s'"),
 =09=09=09=09   git_path_head_file());
 =09}
 =09if (commit_lock_file(&head_lock) < 0) {
 =09=09rollback_lock_file(&head_lock);
-=09=09return error(_("Error wrapping up %s."), git_path_head_file());
+=09=09return error(_("Error wrapping up '%s'."), git_path_head_file());
 =09}
 =09return 0;
 }
@@ -1166,9 +1166,9 @@ int sequencer_rollback(struct replay_opts *opts)
 =09=09return rollback_single_pick();
 =09}
 =09if (!f)
-=09=09return error_errno(_("cannot open %s"), git_path_head_file());
+=09=09return error_errno(_("cannot open '%s'"), git_path_head_file());
 =09if (strbuf_getline_lf(&buf, f)) {
-=09=09error(_("cannot read %s: %s"), git_path_head_file(),
+=09=09error(_("cannot read '%s': %s"), git_path_head_file(),
 =09=09      ferror(f) ?  strerror(errno) : _("unexpected end of file"));
 =09=09fclose(f);
 =09=09goto fail;
@@ -1207,7 +1207,7 @@ static int save_todo(struct todo_list *todo_list, str=
uct replay_opts *opts)
 =09=09=09todo_list->buf.len - offset) < 0)
 =09=09return error_errno(_("Could not write to '%s'"), todo_path);
 =09if (commit_lock_file(&todo_lock) < 0)
-=09=09return error(_("Error wrapping up %s."), todo_path);
+=09=09return error(_("Error wrapping up '%s'."), todo_path);
 =09return 0;
 }
=20
--=20
2.10.1.583.g721a9e0


--8323329-1208570025-1477052781=:3264--
