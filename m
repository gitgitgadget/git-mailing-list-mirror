Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA1FC207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755991AbcIKK4E (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:56:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:52516 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755853AbcIKK4C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:56:02 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MGBdv-1bmZJp0ppH-00FAW3; Sun, 11 Sep 2016 12:55:58
 +0200
Date:   Sun, 11 Sep 2016 12:55:57 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 24/25] sequencer: quote filenames in error messages
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <db1816339ba9e259e929a45d644c33160f57c5bb.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1467825476-1473591358=:129229"
X-Provags-ID: V03:K0:eYIKnsELMk8QIsAiGxUKvqoF8kVfTssghqOMSOz1G3jpE5JuNfA
 0ndrZ83io6uWXlfwirNSD3NeT2O5pjP5f3hF0/QyTygK4/Mqki8qkbwKriEfPfbaFF6PMML
 9YHnVIZpgg6P/cdOlEq+EFPkrWoMlbuoQtBRQrh4Dly3n+sT4Zp/ubr5XbRge2XtpOORLl5
 kr4D5uGpohFOxYYiUl6Bw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LEXyo+cnhAQ=:S+QifySJu7WmtgBh4npYnN
 8WNWmE8F4VOZjwAoIrPyFuJSFMPji9i+BXNTorrTd4JzkDwsB1uJ2EdewPpACE/o8G2VwyJne
 xzb1Qi4S1Rm/CK/plVJJOlbpEA9x5qhgKAg81VeOoz5oa5SPUwlYmFs4voX1JBzH2zkIPW0Kg
 rdpAJRl+QQ+P1/Kg7sxpW37nE37Hj3XblivFczf8jkpE+XStXTJGwmTIezN05i2/pilEuKH3T
 OEvKqNK64CSPcTDi10dOlaYu/w2zvYNKIRXz0IXcFObs45vHkEjTTqk56CKIJNAz+pESY5gnP
 UzjSHBt1PoEVfyI1PgYu7fjCLfykFQmMOXPDU5jPnYhfsUINF6o0SSls6ZgxOmc4jBAmzYVfR
 h2zB74AXv68mnejWFgo6WXiPptFeoQuAKxlto9fq62UvDnZCHaL1VvvOBflP3XvOYBkRU8x3C
 A6Pywu7enJW0/e3/mRVqreYu008i0VdgGnVDiX6qwWihxQfHfQ+3CxWOCCXQYGyp+ggzer7uv
 O8FzUUO4QXxz+2gNwtbk2vXSiFQw6pcQ78sSokKVsT+m+4VPxplirZBe/byCX7mdvTwkjNplR
 SM/UBywqhmZkM+Y28einIiJZdw9Hv+EbvpdANAEXNriNpjWDLNb7ArBHUNLl+ucp2JN54HMk4
 xAbtHM88PfOzawE2mM0WzWRFVKqCZcE2tCcX8SmXgaRgxlGBfdTPNkoU28SA7VdHYt4+V68Wp
 8kuo0Us5UhPREeE0KOWbK5nOrnf0Kat1wodAoDMSVoykaIxkLpPjDFj9CN1HtADVHWctQsXZR
 PxGUo5E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1467825476-1473591358=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

This makes the code consistent by fixing quite a couple of error messages.

Suggested by Jakub Nar=C4=99bski.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1e7f29e..465e018 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -255,7 +255,7 @@ static int write_with_lock_file(const char *filename,
 =09if (append_eol && write(msg_fd, "\n", 1) < 0)
 =09=09return error_errno(_("Could not write eol to '%s"), filename);
 =09if (commit_lock_file(&msg_file) < 0)
-=09=09return error(_("Error wrapping up %s."), filename);
+=09=09return error(_("Error wrapping up '%s'."), filename);
=20
 =09return 0;
 }
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
@@ -1050,7 +1050,7 @@ static int read_populate_opts(struct replay_opts *opt=
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
@@ -1093,7 +1093,7 @@ static int create_seq_dir(void)
 =09=09return -1;
 =09}
 =09else if (mkdir(git_path_seq_dir(), 0777) < 0)
-=09=09return error_errno(_("Could not create sequencer directory %s"),
+=09=09return error_errno(_("Could not create sequencer directory '%s'"),
 =09=09=09=09   git_path_seq_dir());
 =09return 0;
 }
@@ -1112,12 +1112,12 @@ static int save_head(const char *head)
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
@@ -1162,9 +1162,9 @@ int sequencer_rollback(struct replay_opts *opts)
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
@@ -1203,7 +1203,7 @@ static int save_todo(struct todo_list *todo_list, str=
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
2.10.0.windows.1.10.g803177d


--8323329-1467825476-1473591358=:129229--
