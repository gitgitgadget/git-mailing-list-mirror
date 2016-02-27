From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/22] remote-curl.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:42:06 +0700
Message-ID: <1456555333-5853-16-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:43:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYbO-0003e7-0z
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085AbcB0Gni convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:43:38 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35097 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbcB0Gnh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:43:37 -0500
Received: by mail-pa0-f41.google.com with SMTP id ho8so64265780pac.2
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afcbKHQHPGiSGswc/THJwVnA3E63Hw2Y72y1k/2fFTI=;
        b=A8xDT+3dY3ewgWifWZQ+dpNv+0qzw4xZJuGZu745qDBu6AGktApXAhipF+mmYKAibi
         yQ5oldRMBj+28Nck8LZu77GCrmQk1CHY32HCoYRm93JNyNCGmgcb9XZrobViC8Tne40X
         moFpE9kYLHDgk7VNFGW2xU4XJY8VC2k3CLsQQkZJVhZ58Axkv/K77Enk303ugkEDjgvc
         QyAz/eoq4Ow+IVfeGhpS6ttLY2xme45ESWZdD3Eeu2MM2/bwY5mD3LZHSOAZqZGrKiQ2
         GeLIWsJfKQAvf2QlND1/sghMq9HudKzc5u8I6xYDFKSUe99q5qWoJ5IuVz5r8yRMIvK5
         PjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afcbKHQHPGiSGswc/THJwVnA3E63Hw2Y72y1k/2fFTI=;
        b=QML9IaZbBs2z19ww7hnICuB8jRYa2JbqZI9I40OTp0XKSg8+AEfKXl2mPeEiolUh3b
         ON5BEm8675+SK4ZS19+CAwkW15orGtOjLHtDsibTq3ICXTsP5yb2skvZbHc9nsQVh0oZ
         j4aZs9PaVmN8bSx7RVWTxj0GNes/7RoRAM7DOPdV6hEneHtPZUlXzSneexAQLpbz1wtl
         nF2CfHg4IcjLUxcapdiTDir7ScchFzOQqWffxJ6ntVx1zaTyNQKS/M8f2yvvXH/rZCem
         FfQqpoPgM6QkQ0YTtVnKXGIxB75K1Uxn7R9+fzf0OgwjpOS5bCjHKf/rOG5kYKeegYpl
         1MyQ==
X-Gm-Message-State: AD7BkJJiH+JiEWqHwSSE0wWH1bbm/z3f89quVxvXL0O1JtADNxSG1VGroI1ygjB65pZM8w==
X-Received: by 10.66.220.66 with SMTP id pu2mr7545987pac.115.1456555416151;
        Fri, 26 Feb 2016 22:43:36 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id q16sm23450807pfi.80.2016.02.26.22.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:43:35 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:44:09 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287676>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 remote-curl.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 15e48e2..d5b33aa 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -177,7 +177,7 @@ static struct ref *parse_info_refs(struct discovery=
 *heads)
 			mid =3D &data[i];
 		if (data[i] =3D=3D '\n') {
 			if (mid - start !=3D 40)
-				die("%sinfo/refs not valid: is this a git repository?",
+				die(_("%sinfo/refs not valid: is this a git repository?"),
 				    url.buf);
 			data[i] =3D 0;
 			ref_name =3D mid + 1;
@@ -285,13 +285,13 @@ static struct discovery *discover_refs(const char=
 *service, int for_push)
 		break;
 	case HTTP_MISSING_TARGET:
 		show_http_message(&type, &charset, &buffer);
-		die("repository '%s' not found", url.buf);
+		die(_("repository '%s' not found"), url.buf);
 	case HTTP_NOAUTH:
 		show_http_message(&type, &charset, &buffer);
-		die("Authentication failed for '%s'", url.buf);
+		die(_("Authentication failed for '%s'"), url.buf);
 	default:
 		show_http_message(&type, &charset, &buffer);
-		die("unable to access '%s': %s", url.buf, curl_errorstr);
+		die(_("unable to access '%s': %s"), url.buf, curl_errorstr);
 	}
=20
 	last=3D xcalloc(1, sizeof(*last_discovery));
@@ -314,7 +314,7 @@ static struct discovery *discover_refs(const char *=
service, int for_push)
 		strbuf_reset(&exp);
 		strbuf_addf(&exp, "# service=3D%s", service);
 		if (strcmp(line, exp.buf))
-			die("invalid server response; got '%s'", line);
+			die(_("invalid server response; got '%s'"), line);
 		strbuf_release(&exp);
=20
 		/* The header can include additional metadata lines, up
@@ -422,7 +422,7 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, v=
oid *clientp)
 			rpc->pos =3D 0;
 			return CURLIOE_OK;
 		}
-		error("unable to rewind rpc post data - try increasing http.postBuff=
er");
+		error(_("unable to rewind rpc post data - try increasing http.postBu=
ffer"));
 		return CURLIOE_FAILRESTART;
=20
 	default:
@@ -604,11 +604,11 @@ retry:
=20
 		ret =3D git_deflate(&stream, Z_FINISH);
 		if (ret !=3D Z_STREAM_END)
-			die("cannot deflate request; zlib deflate error %d", ret);
+			die(_("cannot deflate request; zlib deflate error %d"), ret);
=20
 		ret =3D git_deflate_end_gently(&stream);
 		if (ret !=3D Z_OK)
-			die("cannot deflate request; zlib end error %d", ret);
+			die(_("cannot deflate request; zlib end error %d"), ret);
=20
 		gzip_size =3D stream.total_out;
=20
@@ -726,7 +726,7 @@ static int fetch_dumb(int nr_heads, struct ref **to=
_fetch)
=20
 	ALLOC_ARRAY(targets, nr_heads);
 	if (options.depth)
-		die("dumb http transport does not support --depth");
+		die(_("dumb http transport does not support --depth"));
 	for (i =3D 0; i < nr_heads; i++)
 		targets[i] =3D xstrdup(oid_to_hex(&to_fetch[i]->old_oid));
=20
@@ -743,7 +743,7 @@ static int fetch_dumb(int nr_heads, struct ref **to=
_fetch)
 		free(targets[i]);
 	free(targets);
=20
-	return ret ? error("fetch failed.") : 0;
+	return ret ? error(_("fetch failed.")) : 0;
 }
=20
 static int fetch_git(struct discovery *heads,
@@ -787,7 +787,7 @@ static int fetch_git(struct discovery *heads,
 	for (i =3D 0; i < nr_heads; i++) {
 		struct ref *ref =3D to_fetch[i];
 		if (!*ref->name)
-			die("cannot fetch by sha1 over smart http");
+			die(_("cannot fetch by sha1 over smart http"));
 		packet_buf_write(&preamble, "%s %s\n",
 				 oid_to_hex(&ref->old_oid), ref->name);
 	}
@@ -832,13 +832,13 @@ static void parse_fetch(struct strbuf *buf)
 			struct object_id old_oid;
=20
 			if (get_oid_hex(p, &old_oid))
-				die("protocol error: expected sha/ref, got %s'", p);
+				die(_("protocol error: expected sha/ref, got %s'"), p);
 			if (p[GIT_SHA1_HEXSZ] =3D=3D ' ')
 				name =3D p + GIT_SHA1_HEXSZ + 1;
 			else if (!p[GIT_SHA1_HEXSZ])
 				name =3D "";
 			else
-				die("protocol error: expected sha/ref, got %s'", p);
+				die(_("protocol error: expected sha/ref, got %s'"), p);
=20
 			ref =3D alloc_ref(name);
 			oidcpy(&ref->old_oid, &old_oid);
@@ -850,7 +850,7 @@ static void parse_fetch(struct strbuf *buf)
 			to_fetch[nr_heads++] =3D ref;
 		}
 		else
-			die("http transport does not support %s", buf->buf);
+			die(_("http transport does not support %s"), buf->buf);
=20
 		strbuf_reset(buf);
 		if (strbuf_getline_lf(buf, stdin) =3D=3D EOF)
@@ -886,7 +886,7 @@ static int push_dav(int nr_spec, char **specs)
 		argv_array_push(&child.args, specs[i]);
=20
 	if (run_command(&child))
-		die("git-http-push failed");
+		die(_("git-http-push failed"));
 	return 0;
 }
=20
@@ -962,7 +962,7 @@ static void parse_push(struct strbuf *buf)
 			specs[nr_spec++] =3D xstrdup(buf->buf + 5);
 		}
 		else
-			die("http transport does not support %s", buf->buf);
+			die(_("http transport does not support %s"), buf->buf);
=20
 		strbuf_reset(buf);
 		if (strbuf_getline_lf(buf, stdin) =3D=3D EOF)
@@ -994,7 +994,7 @@ int main(int argc, const char **argv)
 	git_extract_argv0_path(argv[0]);
 	setup_git_directory_gently(&nongit);
 	if (argc < 2) {
-		error("remote-curl: usage: git remote-curl <remote> [<url>]");
+		error(_("remote-curl: usage: git remote-curl <remote> [<url>]"));
 		return 1;
 	}
=20
@@ -1017,14 +1017,14 @@ int main(int argc, const char **argv)
=20
 		if (strbuf_getline_lf(&buf, stdin) =3D=3D EOF) {
 			if (ferror(stdin))
-				error("remote-curl: error reading command stream from git");
+				error(_("remote-curl: error reading command stream from git"));
 			return 1;
 		}
 		if (buf.len =3D=3D 0)
 			break;
 		if (starts_with(buf.buf, "fetch ")) {
 			if (nongit)
-				die("remote-curl: fetch attempted without a local repo");
+				die(_("remote-curl: fetch attempted without a local repo"));
 			parse_fetch(&buf);
=20
 		} else if (!strcmp(buf.buf, "list") || starts_with(buf.buf, "list ")=
) {
@@ -1060,7 +1060,7 @@ int main(int argc, const char **argv)
 			printf("\n");
 			fflush(stdout);
 		} else {
-			error("remote-curl: unknown command '%s' from git", buf.buf);
+			error(_("remote-curl: unknown command '%s' from git"), buf.buf);
 			return 1;
 		}
 		strbuf_reset(&buf);
--=20
2.8.0.rc0.205.g7ec8cf1
