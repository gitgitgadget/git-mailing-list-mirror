Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 136FE209AB
	for <e@80x24.org>; Fri, 14 Oct 2016 13:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932773AbcJNNT4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:19:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:55081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755159AbcJNNTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:19:25 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lk7T8-1cWpzB3Yfi-00c6lV; Fri, 14 Oct 2016 15:19:19
 +0200
Date:   Fri, 14 Oct 2016 15:19:19 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 23/25] sequencer: quote filenames in error messages
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <930ea31d6f10973807276c7a9f35f0d692d1ada6.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1044603594-1476451159=:197091"
X-Provags-ID: V03:K0:Z19eCzZkhaI65WJN+bEEyLKlj2DShD270il/dFL33Y5b6STyuHt
 LOqfeKfkhWKktM5KMlsYRtXXYqFL2LkEHZVFm7SCMkfcZvxUunDtJ1+kamYkyMLAKCtMcOg
 o2OmcUXOG5CnvdSd36f1MEc0vFejgq2xH1zHh5XxYK2ES6BiN2n84HqJDe781EJXSG4VJu0
 3uPaAz0MZeOtZhSwLrINg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/mHX2bskZd8=:6XIA3YqYkF7UI1DRSMisxC
 +AQssNOEgSW8MOVMJuXarDbp1PUb8oW9ELU3RqHw2iV6GGhgvA61bmr3MhlDABlLavZqoeR1n
 rMMHkgU6fHwtqLKp2PKAROavmvEz2TxhRq3QdwEI9sJRxqrmRnPtIaAwAFJ7Io9KlJDUVDEKL
 hWiWGJ8t9wDzi3TQp9TvqCR8DjcCIcX5tGPA42V6uQ+b5CmGnvedjgM9cdQiH51HbSybdwzgT
 qFBDltzVnkSCKaRT4m4M9yCPNHYhggWmm9ZpVlbfPm6QQNtitIfjsRfpH3l08rdhhBHzm0JGP
 IRYoc9+TA52CgOj2LlfNRy3SH27oKZos6OSZk0Y8oXOnJXMbMb2Dc6+PkKO2yo5YENWK+x054
 +N3/ENamS+E3Z+aE0CQRWBlzeapQYccuyxbJaoVPN2hHQfZjf0DIw6OfBpEGadWORru9luU9O
 Q560mRN7YC30zGRvDqGjZ3cc+gRjXU10+QEFZs9GSVnIvXtIKkPQhLA7hk6Lfhwkdm6wRvuZO
 M7WZ8s1Vmo7PQ4XbxGtisOMEKY+2EMjGVqG3ZIk6Ev9huDIDewHg2A+aVpJVC6jURxCBN2WnW
 sgYau08/pFJLZeSfXbxa3KJf353OK4r1ITIE7bVE39Ln1cbqzmaBsqXeJpoWX5LS310fLENpN
 Wb4sR1Il94Tn/eiqSpW58eGjF81fcJFXCU38yqdwQ27yt9PYWJ1tVKK3GSZZR6/6YtR0r0ODF
 3z0fc6enCeNjugiEdkmHFa5KZL1Zg0rHezLwrYAtefQ2KU3eNJXNT/8yf5Qn0+V4vyBa38m1m
 CIgjMTF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1044603594-1476451159=:197091
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

This makes the code consistent by fixing quite a couple of error messages.

Suggested by Jakub Nar=C4=99bski.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index af88753..3e26631 100644
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
@@ -955,16 +955,16 @@ static int read_populate_todo(struct todo_list *todo_=
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
@@ -1055,7 +1055,7 @@ static int read_populate_opts(struct replay_opts *opt=
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
@@ -1098,7 +1098,7 @@ static int create_seq_dir(void)
 =09=09return -1;
 =09}
 =09else if (mkdir(git_path_seq_dir(), 0777) < 0)
-=09=09return error_errno(_("Could not create sequencer directory %s"),
+=09=09return error_errno(_("Could not create sequencer directory '%s'"),
 =09=09=09=09   git_path_seq_dir());
 =09return 0;
 }
@@ -1117,12 +1117,12 @@ static int save_head(const char *head)
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
@@ -1167,9 +1167,9 @@ int sequencer_rollback(struct replay_opts *opts)
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
@@ -1208,7 +1208,7 @@ static int save_todo(struct todo_list *todo_list, str=
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
2.10.1.513.g00ef6dd


--8323329-1044603594-1476451159=:197091--
