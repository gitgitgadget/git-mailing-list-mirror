From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/22] transport-helper.c: mark strings for translating
Date: Sat, 27 Feb 2016 13:42:11 +0700
Message-ID: <1456555333-5853-21-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:44:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYbs-0003yH-Ep
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117AbcB0GoI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:44:08 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33395 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105AbcB0GoG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:44:06 -0500
Received: by mail-pa0-f48.google.com with SMTP id fl4so62547489pad.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U93RbCMHFysWPOC1W0KsAERCHaZPfyfZAzlyxWTIoqk=;
        b=f0PVNNThgkv4whvwEoZf8kOsn8utHkEqzjRaprOHm/sn/XSMops6aNwOVqxfNm/6Dx
         EcQxJlT9h+zYS8BDMaZYfnFGbWUjfRcGBWfxPTUsFTeml6Kj4oS2pYf0411si4r2a1GC
         l8sCyMO7o6m/giNWhciFXt5ELleICi+b5DN286/eCuIqztz8qD6dGYykRXaEftteeEfa
         td/JAkYPJOHOfHz6tfdjLWsZLnS19wP2hjw+HdXDhyilPhhMmntlY22lMVSanG5kwAQR
         esqAco21QAx8b1nQhA/VaI2qnWhpNJ7NqZsyrMUxh4z52kAyJGxWL5dm1sJBLr95QU8J
         5nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U93RbCMHFysWPOC1W0KsAERCHaZPfyfZAzlyxWTIoqk=;
        b=NBK2zbt9vC3DEv2H2yznf1nCUJ5ERjzX+7GssNkp0j725+1N16Am0N7mNIQ3TjA2Iv
         Emtnib2LSBOGMO0B3PNluV05sjscZ/6eNkXdIF8VzFDBHKdT5Enz6dFHtCLn4litF+2f
         GmU2zzjuoEw2IOQfd07stsiVjSQl5fy5gcQiPB57QmuoyzjWyrtsBL8gmfkRb2eECXcf
         Je8fftTS10AXQh0FWNrYkhyiJc9Qjtun+wP3bytmrHDB85RrnCKSlV6V5VsXYd+GHO1R
         dcuXurU2kdXRHNtFdYV6MFx+TqEesT/ujXJFKf28XnXiPXnHwGwvzPX7MUiwTUTgeZ2E
         sD9g==
X-Gm-Message-State: AD7BkJLtn7mCrgEp/09SNgmZNTHmzSX2/jngYXQX1/7Q8ZkqJGVnk8BJnl8KHED+8IxI5w==
X-Received: by 10.66.102.37 with SMTP id fl5mr7715268pab.32.1456555445890;
        Fri, 26 Feb 2016 22:44:05 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id ss5sm23551239pab.15.2016.02.26.22.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:44:04 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:44:38 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287681>

Debug printing is kept in English to reduce workload for
translators. Those rare who actually debug this can read English
anyway.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 transport-helper.c | 84 +++++++++++++++++++++++++++-------------------=
--------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index b934183..fa5c077 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -46,7 +46,7 @@ static void sendline(struct helper_data *helper, stru=
ct strbuf *buffer)
 		fprintf(stderr, "Debug: Remote helper: -> %s", buffer->buf);
 	if (write_in_full(helper->helper->in, buffer->buf, buffer->len)
 		!=3D buffer->len)
-		die_errno("Full write to remote helper failed");
+		die_errno(_("Full write to remote helper failed"));
 }
=20
 static int recvline_fh(FILE *helper, struct strbuf *buffer, const char=
 *name)
@@ -75,7 +75,7 @@ static void write_constant(int fd, const char *str)
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: -> %s", str);
 	if (write_in_full(fd, str, strlen(str)) !=3D strlen(str))
-		die_errno("Full write to remote helper failed");
+		die_errno(_("Full write to remote helper failed"));
 }
=20
 static const char *remove_ext_force(const char *url)
@@ -129,7 +129,7 @@ static struct child_process *get_helper(struct tran=
sport *transport)
=20
 	code =3D start_command(helper);
 	if (code < 0 && errno =3D=3D ENOENT)
-		die("Unable to find remote helper for '%s'", data->name);
+		die(_("Unable to find remote helper for '%s'"), data->name);
 	else if (code !=3D 0)
 		exit(code);
=20
@@ -144,7 +144,7 @@ static struct child_process *get_helper(struct tran=
sport *transport)
 	 */
 	duped =3D dup(helper->out);
 	if (duped < 0)
-		die_errno("Can't dup helper output fd");
+		die_errno(_("Can't dup helper output fd"));
 	data->out =3D xfdopen(duped, "r");
=20
 	write_constant(helper->in, "capabilities\n");
@@ -196,8 +196,8 @@ static struct child_process *get_helper(struct tran=
sport *transport)
 		} else if (starts_with(capname, "no-private-update")) {
 			data->no_private_update =3D 1;
 		} else if (mandatory) {
-			die("Unknown mandatory capability %s. This remote "
-			    "helper probably needs newer version of Git.",
+			die(_("Unknown mandatory capability %s. This remote "
+			      "helper probably needs newer version of Git."),
 			    capname);
 		}
 	}
@@ -209,7 +209,7 @@ static struct child_process *get_helper(struct tran=
sport *transport)
 			free((char *)refspecs[i]);
 		free(refspecs);
 	} else if (data->import || data->bidi_import || data->export) {
-		warning("This remote helper should implement refspec capability.");
+		warning(_("This remote helper should implement refspec capability.")=
);
 	}
 	strbuf_release(&buf);
 	if (debug)
@@ -302,7 +302,7 @@ static int set_helper_option(struct transport *tran=
sport,
 	} else if (!strcmp(buf.buf, "unsupported"))
 		ret =3D 1;
 	else {
-		warning("%s unexpectedly said: '%s'", data->name, buf.buf);
+		warning(_("%s unexpectedly said: '%s'"), data->name, buf.buf);
 		ret =3D 1;
 	}
 	strbuf_release(&buf);
@@ -319,7 +319,7 @@ static void standard_options(struct transport *t)
=20
 	n =3D snprintf(buf, sizeof(buf), "%d", v + 1);
 	if (n >=3D sizeof(buf))
-		die("impossibly large verbosity value");
+		die(_("impossibly large verbosity value"));
 	set_helper_option(t, "verbosity", buf);
=20
 	switch (t->family) {
@@ -376,7 +376,7 @@ static int fetch_with_fetch(struct transport *trans=
port,
 		if (starts_with(buf.buf, "lock ")) {
 			const char *name =3D buf.buf + 5;
 			if (transport->pack_lockfile)
-				warning("%s also locked %s", data->name, name);
+				warning(_("%s also locked %s"), data->name, name);
 			else
 				transport->pack_lockfile =3D xstrdup(name);
 		}
@@ -387,7 +387,7 @@ static int fetch_with_fetch(struct transport *trans=
port,
 		else if (!buf.len)
 			break;
 		else
-			warning("%s unexpectedly said: '%s'", data->name, buf.buf);
+			warning(_("%s unexpectedly said: '%s'"), data->name, buf.buf);
 	}
 	strbuf_release(&buf);
 	return 0;
@@ -454,7 +454,7 @@ static int fetch_with_import(struct transport *tran=
sport,
 	get_helper(transport);
=20
 	if (get_importer(transport, &fastimport))
-		die("Couldn't run fast-import");
+		die(_("Couldn't run fast-import"));
=20
 	for (i =3D 0; i < nr_heads; i++) {
 		posn =3D to_fetch[i];
@@ -477,7 +477,7 @@ static int fetch_with_import(struct transport *tran=
sport,
 	 */
=20
 	if (finish_command(&fastimport))
-		die("Error while running fast-import");
+		die(_("Error while running fast-import"));
=20
 	/*
 	 * The fast-import stream of a remote helper that advertises
@@ -533,7 +533,7 @@ static int process_connect_service(struct transport=
 *transport,
 	 */
 	duped =3D dup(helper->out);
 	if (duped < 0)
-		die_errno("Can't dup helper output fd");
+		die_errno(_("Can't dup helper output fd"));
 	input =3D xfdopen(duped, "r");
 	setvbuf(input, NULL, _IONBF, 0);
=20
@@ -544,9 +544,9 @@ static int process_connect_service(struct transport=
 *transport,
 	if (strcmp(name, exec)) {
 		r =3D set_helper_option(transport, "servpath", exec);
 		if (r > 0)
-			warning("Setting remote service path not supported by protocol.");
+			warning(_("Setting remote service path not supported by protocol.")=
);
 		else if (r < 0)
-			warning("Invalid remote service path.");
+			warning(_("Invalid remote service path."));
 	}
=20
 	if (data->connect)
@@ -569,8 +569,7 @@ static int process_connect_service(struct transport=
 *transport,
 			fprintf(stderr, "Debug: Falling back to dumb "
 				"transport.\n");
 	} else
-		die("Unknown response to connect: %s",
-			cmdbuf.buf);
+		die(_("Unknown response to connect: %s"), cmdbuf.buf);
=20
 exit:
 	fclose(input);
@@ -601,10 +600,10 @@ static int connect_helper(struct transport *trans=
port, const char *name,
 	/* Get_helper so connect is inited. */
 	get_helper(transport);
 	if (!data->connect)
-		die("Operation not supported by protocol.");
+		die(_("Operation not supported by protocol."));
=20
 	if (!process_connect_service(transport, name, exec))
-		die("Can't connect to subservice %s.", name);
+		die(_("Can't connect to subservice %s."), name);
=20
 	fd[0] =3D data->helper->out;
 	fd[1] =3D data->helper->in;
@@ -663,7 +662,7 @@ static int push_update_ref_status(struct strbuf *bu=
f,
 		status =3D REF_STATUS_REMOTE_REJECT;
 		refname =3D buf->buf + 6;
 	} else
-		die("expected ok/error, helper said '%s'", buf->buf);
+		die(_("expected ok/error, helper said '%s'"), buf->buf);
=20
 	msg =3D strchr(refname, ' ');
 	if (msg) {
@@ -724,7 +723,7 @@ static int push_update_ref_status(struct strbuf *bu=
f,
 	if (!*ref)
 		*ref =3D find_ref_by_name(remote_refs, refname);
 	if (!*ref) {
-		warning("helper reported unexpected status of %s", refname);
+		warning(_("helper reported unexpected status of %s"), refname);
 		return 1;
 	}
=20
@@ -784,13 +783,13 @@ static void set_common_push_options(struct transp=
ort *transport,
 {
 	if (flags & TRANSPORT_PUSH_DRY_RUN) {
 		if (set_helper_option(transport, "dry-run", "true") !=3D 0)
-			die("helper %s does not support dry-run", name);
+			die(_("helper %s does not support dry-run"), name);
 	} else if (flags & TRANSPORT_PUSH_CERT_ALWAYS) {
 		if (set_helper_option(transport, TRANS_OPT_PUSH_CERT, "true") !=3D 0=
)
-			die("helper %s does not support --signed", name);
+			die(_("helper %s does not support --signed"), name);
 	} else if (flags & TRANSPORT_PUSH_CERT_IF_ASKED) {
 		if (set_helper_option(transport, TRANS_OPT_PUSH_CERT, "if-asked") !=3D=
 0)
-			die("helper %s does not support --signed=3Dif-asked", name);
+			die(_("helper %s does not support --signed=3Dif-asked"), name);
 	}
 }
=20
@@ -880,12 +879,12 @@ static int push_refs_with_export(struct transport=
 *transport,
 	struct strbuf buf =3D STRBUF_INIT;
=20
 	if (!data->refspecs)
-		die("remote-helper doesn't support push; refspec needed");
+		die(_("remote-helper doesn't support push; refspec needed"));
=20
 	set_common_push_options(transport, data->name, flags);
 	if (flags & TRANSPORT_PUSH_FORCE) {
 		if (set_helper_option(transport, "force", "true") !=3D 0)
-			warning("helper %s does not support 'force'", data->name);
+			warning(_("helper %s does not support 'force'"), data->name);
 	}
=20
 	helper =3D get_helper(transport);
@@ -932,12 +931,12 @@ static int push_refs_with_export(struct transport=
 *transport,
 	}
=20
 	if (get_exporter(transport, &exporter, &revlist_args))
-		die("Couldn't run fast-export");
+		die(_("Couldn't run fast-export"));
=20
 	string_list_clear(&revlist_args, 1);
=20
 	if (finish_command(&exporter))
-		die("Error while running fast-export");
+		die(_("Error while running fast-export"));
 	if (push_update_refs_status(data, remote_refs, flags))
 		return 1;
=20
@@ -961,8 +960,9 @@ static int push_refs(struct transport *transport,
 	}
=20
 	if (!remote_refs) {
-		fprintf(stderr, "No refs in common and none specified; doing nothing=
=2E\n"
-			"Perhaps you should specify a branch such as 'master'.\n");
+		fprintf_ln(stderr,
+			   _("No refs in common and none specified; doing nothing.\n"
+			     "Perhaps you should specify a branch such as 'master'."));
 		return 0;
 	}
=20
@@ -1023,7 +1023,7 @@ static struct ref *get_refs_list(struct transport=
 *transport, int for_push)
=20
 		eov =3D strchr(buf.buf, ' ');
 		if (!eov)
-			die("Malformed response in ref list: %s", buf.buf);
+			die(_("Malformed response in ref list: %s"), buf.buf);
 		eon =3D strchr(eov + 1, ' ');
 		*eov =3D '\0';
 		if (eon)
@@ -1166,7 +1166,7 @@ static int udt_do_read(struct unidirectional_tran=
sfer *t)
 	bytes =3D read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
 	if (bytes < 0 && errno !=3D EWOULDBLOCK && errno !=3D EAGAIN &&
 		errno !=3D EINTR) {
-		error("read(%s) failed: %s", t->src_name, strerror(errno));
+		error(_("read(%s) failed: %s"), t->src_name, strerror(errno));
 		return -1;
 	} else if (bytes =3D=3D 0) {
 		transfer_debug("%s EOF (with %i bytes in buffer)",
@@ -1193,7 +1193,7 @@ static int udt_do_write(struct unidirectional_tra=
nsfer *t)
 	transfer_debug("%s is writable", t->dest_name);
 	bytes =3D xwrite(t->dest, t->buf, t->bufuse);
 	if (bytes < 0 && errno !=3D EWOULDBLOCK) {
-		error("write(%s) failed: %s", t->dest_name, strerror(errno));
+		error(_("write(%s) failed: %s"), t->dest_name, strerror(errno));
 		return -1;
 	} else if (bytes > 0) {
 		t->bufuse -=3D bytes;
@@ -1242,11 +1242,11 @@ static int tloop_join(pthread_t thread, const c=
har *name)
 	void *tret;
 	err =3D pthread_join(thread, &tret);
 	if (!tret) {
-		error("%s thread failed", name);
+		error(_("%s thread failed"), name);
 		return 1;
 	}
 	if (err) {
-		error("%s thread failed to join: %s", name, strerror(err));
+		error(_("%s thread failed to join: %s"), name, strerror(err));
 		return 1;
 	}
 	return 0;
@@ -1265,11 +1265,11 @@ static int tloop_spawnwait_tasks(struct bidirec=
tional_transfer_state *s)
 	err =3D pthread_create(&gtp_thread, NULL, udt_copy_task_routine,
 		&s->gtp);
 	if (err)
-		die("Can't start thread for copying data: %s", strerror(err));
+		die(_("Can't start thread for copying data: %s"), strerror(err));
 	err =3D pthread_create(&ptg_thread, NULL, udt_copy_task_routine,
 		&s->ptg);
 	if (err)
-		die("Can't start thread for copying data: %s", strerror(err));
+		die(_("Can't start thread for copying data: %s"), strerror(err));
=20
 	ret |=3D tloop_join(gtp_thread, "Git to program copy");
 	ret |=3D tloop_join(ptg_thread, "Program to git copy");
@@ -1306,11 +1306,11 @@ static int tloop_join(pid_t pid, const char *na=
me)
 {
 	int tret;
 	if (waitpid(pid, &tret, 0) < 0) {
-		error("%s process failed to wait: %s", name, strerror(errno));
+		error(_("%s process failed to wait: %s"), name, strerror(errno));
 		return 1;
 	}
 	if (!WIFEXITED(tret) || WEXITSTATUS(tret)) {
-		error("%s process failed", name);
+		error(_("%s process failed"), name);
 		return 1;
 	}
 	return 0;
@@ -1328,7 +1328,7 @@ static int tloop_spawnwait_tasks(struct bidirecti=
onal_transfer_state *s)
 	/* Fork thread #1: git to program. */
 	pid1 =3D fork();
 	if (pid1 < 0)
-		die_errno("Can't start thread for copying data");
+		die_errno(_("Can't start thread for copying data"));
 	else if (pid1 =3D=3D 0) {
 		udt_kill_transfer(&s->ptg);
 		exit(udt_copy_task_routine(&s->gtp) ? 0 : 1);
@@ -1337,7 +1337,7 @@ static int tloop_spawnwait_tasks(struct bidirecti=
onal_transfer_state *s)
 	/* Fork thread #2: program to git. */
 	pid2 =3D fork();
 	if (pid2 < 0)
-		die_errno("Can't start thread for copying data");
+		die_errno(_("Can't start thread for copying data"));
 	else if (pid2 =3D=3D 0) {
 		udt_kill_transfer(&s->gtp);
 		exit(udt_copy_task_routine(&s->ptg) ? 0 : 1);
--=20
2.8.0.rc0.205.g7ec8cf1
