From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/22] credential-cache--daemon.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:42:00 +0700
Message-ID: <1456555333-5853-10-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:43:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYan-0003JN-57
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056AbcB0GnC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:43:02 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35604 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbcB0GnA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:43:00 -0500
Received: by mail-pf0-f180.google.com with SMTP id w128so16213030pfb.2
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OINLBzcELhaN4+ho980OIcaApdcGSKunZuJvzRh/9ks=;
        b=QfYObGbHD1X/ldIT1XlqRs7XI7rfc3P9iCEDvyJC+E8Dm7K5OLlbQ3znlTBraTvJZg
         0PVc+FR6k1ubbwsnoVuBYr0BKAkw6j834tPXe47QuXiCW7Ob7jxMhwewAGuQHxbF9fTu
         hgJiEVOs6dGubhWKH81MYt9P4roOl8bUraCArXKcMk8l0G08xriI7SAA26gTzSwguhnt
         1N82c147BgatG2uNUwz8ha3K4Eb9Wi5jRIiaD+lpNBOgEJsEbR2DlZ27EjGmO1ojE6s0
         Ke72OSFs4F/33w57FAt5ioZQJW06OJigXNUF9+5XsrKBlXZdSOql6QzuJt+O2hNpfkw+
         5ZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OINLBzcELhaN4+ho980OIcaApdcGSKunZuJvzRh/9ks=;
        b=kMWOfqNpWGuDvCsYOCv7kmjobN+ZIEjs3iX20h3s5kwRDG4R11oOPSUUDGFhwcLWST
         ycDS+JUVrSR1lg9wtHeHj2qulow75tUtsPvxJB0c7D/AMxqV//Bh0+EVFtacByhPHquh
         zY+iezlUJFj5ewiHAdPCeFu5ZGX7lr4XxXaYoEesyH6fzLfS1paBQut4i9Gyc7ej/Jh1
         AtvUjww7oRgcz9KgZYFvzbfiYSw5qrlB6duNtsY5iN0ZVv2d0jSvfhTlpYfPcNR1qj4A
         PvL5uQlE2UV9FkUDrJR/SMHqcLtxwhw0hRMczhBUt1bo9mLifwOKRrOWibYUY9MaJkOi
         O83w==
X-Gm-Message-State: AD7BkJLsYGG1/qhYvHmtZNkkjKYIyR2AoBy3EPfXmra9eD3YI32mlWul8TOFT2HB+ABPag==
X-Received: by 10.98.75.10 with SMTP id y10mr7664598pfa.32.1456555379696;
        Fri, 26 Feb 2016 22:42:59 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id dy6sm15598478pab.48.2016.02.26.22.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:42:58 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:43:31 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287670>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 credential-cache--daemon.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 63ca7c8..ab33355 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -98,12 +98,12 @@ static int read_request(FILE *fh, struct credential=
 *c,
=20
 	strbuf_getline_lf(&item, fh);
 	if (!skip_prefix(item.buf, "action=3D", &p))
-		return error("client sent bogus action line: %s", item.buf);
+		return error(_("client sent bogus action line: %s"), item.buf);
 	strbuf_addstr(action, p);
=20
 	strbuf_getline_lf(&item, fh);
 	if (!skip_prefix(item.buf, "timeout=3D", &p))
-		return error("client sent bogus timeout line: %s", item.buf);
+		return error(_("client sent bogus timeout line: %s"), item.buf);
 	*timeout =3D atoi(p);
=20
 	if (credential_read(c, fh) < 0)
@@ -132,16 +132,16 @@ static void serve_one_client(FILE *in, FILE *out)
 		remove_credential(&c);
 	else if (!strcmp(action.buf, "store")) {
 		if (timeout < 0)
-			warning("cache client didn't specify a timeout");
+			warning(_("cache client didn't specify a timeout"));
 		else if (!c.username || !c.password)
-			warning("cache client gave us a partial credential");
+			warning(_("cache client gave us a partial credential"));
 		else {
 			remove_credential(&c);
 			cache_credential(&c, timeout);
 		}
 	}
 	else
-		warning("cache client sent unknown action: %s", action.buf);
+		warning(_("cache client sent unknown action: %s"), action.buf);
=20
 	credential_clear(&c);
 	strbuf_release(&action);
@@ -160,7 +160,7 @@ static int serve_cache_loop(int fd)
 	pfd.events =3D POLLIN;
 	if (poll(&pfd, 1, 1000 * wakeup) < 0) {
 		if (errno !=3D EINTR)
-			die_errno("poll failed");
+			die_errno(_("poll failed"));
 		return 1;
 	}
=20
@@ -170,12 +170,12 @@ static int serve_cache_loop(int fd)
=20
 		client =3D accept(fd, NULL, NULL);
 		if (client < 0) {
-			warning("accept failed: %s", strerror(errno));
+			warning(_("accept failed: %s"), strerror(errno));
 			return 1;
 		}
 		client2 =3D dup(client);
 		if (client2 < 0) {
-			warning("dup failed: %s", strerror(errno));
+			warning(_("dup failed: %s"), strerror(errno));
 			close(client);
 			return 1;
 		}
@@ -195,13 +195,13 @@ static void serve_cache(const char *socket_path, =
int debug)
=20
 	fd =3D unix_stream_listen(socket_path);
 	if (fd < 0)
-		die_errno("unable to bind to '%s'", socket_path);
+		die_errno(_("unable to bind to '%s'"), socket_path);
=20
 	printf("ok\n");
 	fclose(stdout);
 	if (!debug) {
 		if (!freopen("/dev/null", "w", stderr))
-			die_errno("unable to point stderr to /dev/null");
+			die_errno(_("unable to point stderr to /dev/null"));
 	}
=20
 	while (serve_cache_loop(fd))
@@ -211,10 +211,10 @@ static void serve_cache(const char *socket_path, =
int debug)
 }
=20
 static const char permissions_advice[] =3D
-"The permissions on your socket directory are too loose; other\n"
+N_("The permissions on your socket directory are too loose; other\n"
 "users may be able to read your cached credentials. Consider running:\=
n"
 "\n"
-"	chmod 0700 %s";
+"	chmod 0700 %s");
 static void init_socket_directory(const char *path)
 {
 	struct stat st;
@@ -223,7 +223,7 @@ static void init_socket_directory(const char *path)
=20
 	if (!stat(dir, &st)) {
 		if (st.st_mode & 077)
-			die(permissions_advice, dir);
+			die(_(permissions_advice), dir);
 	} else {
 		/*
 		 * We must be sure to create the directory with the correct mode,
@@ -232,9 +232,9 @@ static void init_socket_directory(const char *path)
 		 * our protected socket.
 		 */
 		if (safe_create_leading_directories_const(dir) < 0)
-			die_errno("unable to create directories for '%s'", dir);
+			die_errno(_("unable to create directories for '%s'"), dir);
 		if (mkdir(dir, 0700) < 0)
-			die_errno("unable to mkdir '%s'", dir);
+			die_errno(_("unable to mkdir '%s'"), dir);
 	}
=20
 	if (chdir(dir))
@@ -253,7 +253,7 @@ int main(int argc, const char **argv)
 	const char *socket_path;
 	int ignore_sighup =3D 0;
 	static const char *usage[] =3D {
-		"git-credential-cache--daemon [opts] <socket_path>",
+		N_("git-credential-cache--daemon [opts] <socket_path>"),
 		NULL
 	};
 	int debug =3D 0;
@@ -274,7 +274,7 @@ int main(int argc, const char **argv)
 		usage_with_options(usage, options);
=20
 	if (!is_absolute_path(socket_path))
-		die("socket directory must be an absolute path");
+		die(_("socket directory must be an absolute path"));
=20
 	init_socket_directory(socket_path);
 	register_tempfile(&socket_file, socket_path);
--=20
2.8.0.rc0.205.g7ec8cf1
