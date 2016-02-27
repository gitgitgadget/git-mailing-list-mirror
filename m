From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/22] builtin/clone.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:41:55 +0700
Message-ID: <1456555333-5853-5-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:42:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYa2-0002sL-Ci
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821AbcB0GmO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:42:14 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34721 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536AbcB0GmM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:42:12 -0500
Received: by mail-pa0-f45.google.com with SMTP id fy10so62453380pac.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dwNq+Awv4TFBq1k5VKmLUq1WcPNwYLiEgrklO/NAMho=;
        b=DbNz09+tvTcYQP8ykRTF3x9AFqAzjs4Y4eSVAlUVwbteY7CW51lpHXuqEB/bJ0s7C5
         RGVcOKsz6+RO3h5qGHeDFuxpyP0L9ULKchOguX1kCbtQoxHMZEQCyW2Etx75H7BPqEiu
         lrbfkQkVP873B1BzJhXOZNacq1TKpFpliTrLyzQpTStTW/jYWWkP5F06lip7a0dE8wAF
         kPTZby2ytfZ9so6FFtLM8aJAgnUo9kOjT9f085dY7Z3BT35L1+z6fAfqtvPRwhkT98Xi
         jVV/yk6vB8GqJykzHae9ErPNLp9uTa/Ne3+5ZeDm4tq8D/zdyNoZzQFkbKwE/eR+gGlu
         1dTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwNq+Awv4TFBq1k5VKmLUq1WcPNwYLiEgrklO/NAMho=;
        b=EyKSDIRtStczBmeV3k10G1G2LuorQ8QrQ0ycAMTrJiAlmSzapvllkPTq/LluIBEtHh
         fD9ftz70cGCDUAqEbWdquCuplvHSQwd5vSrVb8HdB0ixDO+0PBPakL7Ad7/GkOdFpI34
         3pXnOl7LBeWniq1TZ2dt5/eezp5pxuLTtkV/RggBuhRHeNNGVN2YNzkii7Zi5/X+c+89
         ysHslktTiKrF3IoTCp0wQUHrVq66Xtx8iudg+mi6wEf0fCo1tMioM/s8lwLyyXj3y+pv
         NWeXdsPirTsn519MF9KQOqh4/mvbUXq9cZcmmo+S8xuQmQUCJ+BZR6pB1Vb4wSeHN3XE
         auUQ==
X-Gm-Message-State: AD7BkJJ2YVI5I9QhoEEPfhDeiLyjOSVmkyhfyPkQC8E9nLANchlJCxcoDO3gfYRcyg57RQ==
X-Received: by 10.66.102.104 with SMTP id fn8mr7546833pab.129.1456555331851;
        Fri, 26 Feb 2016 22:42:11 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id v71sm978178pfa.63.2016.02.26.22.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:42:10 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:42:44 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287665>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9ac6c01..6616392 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -236,8 +236,8 @@ static char *guess_dir_name(const char *repo, int i=
s_bundle, int is_bare)
 	strip_suffix_mem(start, &len, is_bundle ? ".bundle" : ".git");
=20
 	if (!len || (len =3D=3D 1 && *start =3D=3D '/'))
-	    die("No directory name could be guessed.\n"
-		"Please specify a directory on the command line");
+		die(_("No directory name could be guessed.\n"
+		      "Please specify a directory on the command line"));
=20
 	if (is_bare)
 		dir =3D xstrfmt("%.*s.git", (int)len, start);
@@ -644,7 +644,7 @@ static void update_remote_refs(const struct ref *re=
fs,
 		if (create_symref(head_ref.buf,
 				  remote_head_points_at->peer_ref->name,
 				  msg) < 0)
-			die("unable to update %s", head_ref.buf);
+			die(_("unable to update %s"), head_ref.buf);
 		strbuf_release(&head_ref);
 	}
 }
@@ -656,7 +656,7 @@ static void update_head(const struct ref *our, cons=
t struct ref *remote,
 	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
 		if (create_symref("HEAD", our->name, NULL) < 0)
-			die("unable to update HEAD");
+			die(_("unable to update HEAD"));
 		if (!option_bare) {
 			update_ref(msg, "HEAD", our->old_oid.hash, NULL, 0,
 				   UPDATE_REFS_DIE_ON_ERR);
@@ -750,7 +750,7 @@ static void write_config(struct string_list *config=
)
 	for (i =3D 0; i < config->nr; i++) {
 		if (git_config_parse_parameter(config->items[i].string,
 					       write_one_config, NULL) < 0)
-			die("unable to write parameters to config file");
+			die(_("unable to write parameters to config file"));
 	}
 }
=20
--=20
2.8.0.rc0.205.g7ec8cf1
