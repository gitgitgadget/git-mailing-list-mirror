From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/22] transport.c: mark strings for translating
Date: Sat, 27 Feb 2016 13:42:12 +0700
Message-ID: <1456555333-5853-22-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:44:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYby-00041c-Es
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122AbcB0GoO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:44:14 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33416 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105AbcB0GoN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:44:13 -0500
Received: by mail-pf0-f178.google.com with SMTP id 124so568330pfg.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wNeXpykqMJsopdcqDm7YLIwbm8qQ8nYkcrXD1OtlVpU=;
        b=HS6CBxAFn6evUgHuoP26yR/6x+kRtEl/YDtTEV4P6oysi3ShaWfeFmEWrvvN/n4xpl
         5ah6U9bEj/CqT53WPxRcYm5CCpFfdZJlbuHYVNRpZkUZqwgGzR8T5o4sLcXNt5sRX7Cq
         fc/eWufHbsPpx58FA0LBn+STla8LK94zSRB7xlCdqgHtZCMsA9jJhK3VQ81rifmomNki
         TIT+VzO/6ymhQ2T2Nhuvpca+G9V0zNbNboCPvQlLwfnNvSoW1251GrVq8ukbHhiEtKQ2
         U/srTQf9bYtpCoQ0xv6rd4t8+e+9pnGmTwj7MmLhETYoknUQkFnAK0e04BosdFOCER7B
         5LIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wNeXpykqMJsopdcqDm7YLIwbm8qQ8nYkcrXD1OtlVpU=;
        b=HjfKsVq2zp966fFhv2H8ylpfcyLNdXIQyMEjBKBND0hcBHLylWokppQDFDnjK9vt5c
         HOR3Gf8LUZ2DY5g2CXpZDlxChYnCyIpsUqhupY/nrDFZZr3IWr9BsUoIhx8ojXByLXKW
         zPrtPOeHweQn80bR8OcV4Ti+2bOiMSCLkp5aP/tla9EstKUxbrGWroSd8ro4qjqZHmQb
         JoqA9gaxNZBEC559qD2Q+tlQcLNdlTCAaw4ypVOzOT3ZqvQELZ/bio9DfyFbCQKZ6CVg
         9Hk9Lbj1urOd1JcCsVq6rD3G8jFb3LZAgG+OFtaR/8gGA00WtEzkRgA9dLRVRTduasDN
         IHsg==
X-Gm-Message-State: AD7BkJI+5+t0jxGB7GysEOcZixPVNVg+W8dXyICDP8ByV+0TY2UaJzQ4rijLXBpNf7uXdA==
X-Received: by 10.98.13.154 with SMTP id 26mr7667050pfn.164.1456555452240;
        Fri, 26 Feb 2016 22:44:12 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id o90sm23515295pfi.17.2016.02.26.22.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:44:10 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:44:45 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287682>

More strings can be translated in print_ref_status() at least, but we
need to deal with utf-8 string length there. Let's stick with a safe
subset for now.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 transport.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/transport.c b/transport.c
index ca3cfa4..93be900 100644
--- a/transport.c
+++ b/transport.c
@@ -83,7 +83,7 @@ static struct ref *get_refs_from_bundle(struct transp=
ort *transport, int for_pus
 		close(data->fd);
 	data->fd =3D read_bundle_header(transport->url, &data->header);
 	if (data->fd < 0)
-		die ("Could not read bundle '%s'.", transport->url);
+		die(_("Could not read bundle '%s'."), transport->url);
 	for (i =3D 0; i < data->header.references.nr; i++) {
 		struct ref_list_entry *e =3D data->header.references.list + i;
 		struct ref *ref =3D alloc_ref(e->name);
@@ -148,7 +148,7 @@ static int set_git_option(struct git_transport_opti=
ons *opts,
 			char *end;
 			opts->depth =3D strtol(value, &end, 0);
 			if (*end)
-				die("transport: invalid depth option '%s'", value);
+				die(_("transport: invalid depth option '%s'"), value);
 		}
 		return 0;
 	}
@@ -285,7 +285,7 @@ void transport_update_tracking_ref(struct remote *r=
emote, struct ref *ref, int v
=20
 	if (!remote_find_tracking(remote, &rs)) {
 		if (verbose)
-			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
+			fprintf_ln(stderr, _("updating local tracking ref '%s'"), rs.dst);
 		if (ref->deletion) {
 			delete_ref(rs.dst, NULL, 0);
 		} else
@@ -480,8 +480,8 @@ void transport_verify_remote_names(int nr_heads, co=
nst char **heads)
 		remote =3D remote ? (remote + 1) : local;
 		if (check_refname_format(remote,
 				REFNAME_ALLOW_ONELEVEL|REFNAME_REFSPEC_PATTERN))
-			die("remote part of refspec is not a valid name in %s",
-				heads[i]);
+			die(_("remote part of refspec is not a valid name in %s"),
+			    heads[i]);
 	}
 }
=20
@@ -626,7 +626,7 @@ int is_transport_allowed(const char *type)
 void transport_check_allowed(const char *type)
 {
 	if (!is_transport_allowed(type))
-		die("transport '%s' not allowed", type);
+		die(_("transport '%s' not allowed"), type);
 }
=20
 int transport_restrict_protocols(void)
@@ -665,7 +665,7 @@ struct transport *transport_get(struct remote *remo=
te, const char *url)
 	if (helper) {
 		transport_helper_init(ret, helper);
 	} else if (starts_with(url, "rsync:")) {
-		die("git-over-rsync is no longer supported");
+		die(_("git-over-rsync is no longer supported"));
 	} else if (url_is_local_not_ssh(url) && is_file(url) && is_bundle(url=
, 1)) {
 		struct bundle_transport_data *data =3D xcalloc(1, sizeof(*data));
 		transport_check_allowed("file");
@@ -766,19 +766,22 @@ static void die_with_unpushed_submodules(struct s=
tring_list *needs_pushing)
 {
 	int i;
=20
-	fprintf(stderr, "The following submodule paths contain changes that c=
an\n"
-			"not be found on any remote:\n");
+	fprintf_ln(stderr, _("The following submodule paths contain changes t=
hat can\n"
+			     "not be found on any remote:"));
 	for (i =3D 0; i < needs_pushing->nr; i++)
 		printf("  %s\n", needs_pushing->items[i].string);
-	fprintf(stderr, "\nPlease try\n\n"
-			"	git push --recurse-submodules=3Don-demand\n\n"
-			"or cd to the path and use\n\n"
-			"	git push\n\n"
-			"to push them to a remote.\n\n");
+	fputc('\n', stderr);
+	fprintf_ln(stderr,
+		   _("Please try\n\n"
+		     "	git push --recurse-submodules=3Don-demand\n\n"
+		     "or cd to the path and use\n\n"
+		     "	git push\n\n"
+		     "to push them to a remote."));
+	fprintf(stderr, "\n\n");
=20
 	string_list_clear(needs_pushing, 0);
=20
-	die("Aborting.");
+	die(_("Aborting."));
 }
=20
 static int run_pre_push_hook(struct transport *transport,
@@ -853,7 +856,7 @@ int transport_push(struct transport *transport,
 	if (transport->push) {
 		/* Maybe FIXME. But no important transport uses this case. */
 		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
-			die("This transport does not support using --set-upstream");
+			die(_("This transport does not support using --set-upstream"));
=20
 		return transport->push(transport, refspec_nr, refspec, flags);
 	} else if (transport->push_refs) {
@@ -905,7 +908,7 @@ int transport_push(struct transport *transport,
 				if (!is_null_oid(&ref->new_oid) &&
 				    !push_unpushed_submodules(ref->new_oid.hash,
 					    transport->remote->name))
-				    die ("Failed to push all needed submodules!");
+				    die(_("Failed to push all needed submodules!"));
 		}
=20
 		if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
@@ -941,7 +944,7 @@ int transport_push(struct transport *transport,
 		if (porcelain && !push_ret)
 			puts("Done");
 		else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
-			fprintf(stderr, "Everything up-to-date\n");
+			fprintf_ln(stderr, _("Everything up-to-date"));
=20
 		return ret;
 	}
@@ -1009,7 +1012,7 @@ int transport_connect(struct transport *transport=
, const char *name,
 	if (transport->connect)
 		return transport->connect(transport, name, exec, fd);
 	else
-		die("Operation not supported by protocol");
+		die(_("Operation not supported by protocol"));
 }
=20
 int transport_disconnect(struct transport *transport)
--=20
2.8.0.rc0.205.g7ec8cf1
