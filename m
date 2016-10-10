Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA2E720989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753273AbcJJRdJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:33:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:56644 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753155AbcJJRdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:33:09 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MJByE-1bqtBs2uHS-002seR; Mon, 10 Oct 2016 19:26:30
 +0200
Date:   Mon, 10 Oct 2016 19:26:29 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 23/25] sequencer: quote filenames in error messages
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <5f2a1aacfba5e661d8a3782358a1c651b21d57e8.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-475627690-1476120390=:35196"
X-Provags-ID: V03:K0:yiPHgj98psKbjvdGMEkvjxxhqyJzZujW/2w2xShUEwGLV/UvfXZ
 NbaTsOmVtDSl4YruJiD/9+o9Tg5dKY4A+6msLgIaDyRBqqjTHZhTQqV0Pzmxr1qmJI799Ox
 fMiQ+x2np/G0o1trphEVCMbHx/7d3QkCr9TjreAVt9wwRE/QRyr0OP/BjAr2BsGLKioY8uv
 T05SjLbnFCTXj9UlWvF2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8mikAyEyD2U=:y9t5Hk5ie9Wcl5dEssxvxQ
 pQzsBkXcOLTcMSQ3oKjn1bkWFrIr6dtw2QvFPLjQBxLRrz9SNb1aQ92KltEDjsSOA/f3E/MoL
 T7pqaA5JXFnj7N2d/89r7mUB4rpIfuhNUIYCmFxQeRFlYLWmabPPpHFPvGWhGfNdO7sk7yDGg
 1i1tIN37SxrpjtqBPG8s2JSgEQmbKATe/2qszegYfx/XzgTYICp+dYUQO23Y0HTxiNcoTf+NE
 6Vapx39tzaKclZPIJ03C8fHvLFrfE7Q5anL7ggwRc1016Q8Sq0U9CcIwALmBerJcEFc3mjCUD
 gqg9RwDWzTExyYXyLQJgSFrftYIrnr9blQzMmNgQlVGp2UIDHoeqRwLHo53H8oY+1AVJCMhiN
 PKcxVNG6CtbjjLqP+maiDf8qsxeXW3ixvMfDqo9jx44RoIWRc6z7cYX9kl3g0jclFi7VuK8bI
 F+lp+XpLdeoAoVKPYrJQ1pW2Hjv4qrkYKKQzmAmiFt6DlKgQn5221HLM2neB1/QNS8JVnsCLG
 ZliLTIAO15LI6EWSaBqBwQAhgaazShLn1FOe0eIyzsWMClPJU74HidLBv3J2D4j68+h3nDy/l
 AKtzj2Xw/TV82LPNozvbIIt1RLQYbQ0AaDPTPg6kvW/rHNDqjuYSWSlkykjiZnaBJ6ZzJWTml
 eht6sL9LsUZ2Cbda0PJJ0K0U/EpdKcKak0fJiebFWerCEa/Wfj0KgPLQQMkz+5E1QnTOEAcp7
 IDOoIo9jrkdRrnKXwtlMO28TTVej3GUCVEvQXpOdydb/4fZ/aCiVCGAQMU0JZW+XOguZQMhK7
 CYgKxH2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-475627690-1476120390=:35196
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

This makes the code consistent by fixing quite a couple of error messages.

Suggested by Jakub Nar=C4=99bski.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 40ef33c..4596540 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -252,7 +252,7 @@ static int write_with_lock_file(const char *filename,
 =09}
 =09if (commit_lock_file(&msg_file) < 0) {
 =09=09rollback_lock_file(&msg_file);
-=09=09return error(_("Error wrapping up %s."), filename);
+=09=09return error(_("Error wrapping up '%s'."), filename);
 =09}
=20
 =09return 0;
@@ -963,16 +963,16 @@ static int read_populate_todo(struct todo_list *todo_=
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
@@ -1065,7 +1065,7 @@ static int read_populate_opts(struct replay_opts *opt=
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
@@ -1108,7 +1108,7 @@ static int create_seq_dir(void)
 =09=09return -1;
 =09}
 =09else if (mkdir(git_path_seq_dir(), 0777) < 0)
-=09=09return error_errno(_("Could not create sequencer directory %s"),
+=09=09return error_errno(_("Could not create sequencer directory '%s'"),
 =09=09=09=09   git_path_seq_dir());
 =09return 0;
 }
@@ -1127,12 +1127,12 @@ static int save_head(const char *head)
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
@@ -1177,9 +1177,9 @@ int sequencer_rollback(struct replay_opts *opts)
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
@@ -1218,7 +1218,7 @@ static int save_todo(struct todo_list *todo_list, str=
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
2.10.0.windows.1.325.ge6089c1


--8323329-475627690-1476120390=:35196--
