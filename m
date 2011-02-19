From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 51/72] gettextize: git-push basic messages
Date: Sat, 19 Feb 2011 19:24:34 +0000
Message-ID: <1298143495-3681-52-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:30:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsVJ-00042j-A2
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138Ab1BST3k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:29:40 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43660 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084Ab1BST3h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:29:37 -0500
Received: by eye27 with SMTP id 27so2347458eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=QnHEWZHIFiWmXC60dHvlsr+//otEUI7XdoNestD3OgQ=;
        b=dRaN13LG97Y4eD6MxxHxABgzJgdjM5zvEOnvpXyuzgHBgGqMQxYD7JkU07oL1P1HCS
         yH6e6znyUC1gfoAb4qbgZYxa5Qt8O9cTOq/urov5t+9/+VEjbAH38zpC/suOYZY6f3Vq
         OF8FzcDpoGBs/h1A3ynVUCjFv+Mxmu+yU9tLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LBANy5MsSJOZ02Q9di2S0O7Jq5Wc+8oz9b1u9vNRaTGA7p50apVezMg3SNwu4qg0z1
         Rh0lkO+EniJbHkqMeJK82lteb3Kw7eZtkSyMBTydWY1FRbRxEigo7hFPsg1dAxTNmPNv
         fRJWGXLpYjEzgASPtJ8JdpLrm4zReeN0qUEw8=
Received: by 10.14.15.223 with SMTP id f71mr2392768eef.37.1298143689730;
        Sat, 19 Feb 2011 11:28:09 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.08
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:09 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167364>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/push.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index e655eb7..513bc57 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -40,7 +40,7 @@ static void set_refspecs(const char **refs, int nr)
 			char *tag;
 			int len;
 			if (nr <=3D ++i)
-				die("tag shorthand without <tag>");
+				die(_("tag shorthand without <tag>"));
 			len =3D strlen(refs[i]) + 11;
 			if (deleterefs) {
 				tag =3D xmalloc(len+1);
@@ -59,7 +59,7 @@ static void set_refspecs(const char **refs, int nr)
 			strcat(delref, ref);
 			ref =3D delref;
 		} else if (deleterefs)
-			die("--delete only accepts plain target ref names");
+			die(_("--delete only accepts plain target ref names"));
 		add_refspec(ref);
 	}
 }
@@ -69,13 +69,13 @@ static void setup_push_tracking(void)
 	struct strbuf refspec =3D STRBUF_INIT;
 	struct branch *branch =3D branch_get(NULL);
 	if (!branch)
-		die("You are not currently on a branch.");
+		die(_("You are not currently on a branch."));
 	if (!branch->merge_nr || !branch->merge)
-		die("The current branch %s is not tracking anything.",
+		die(_("The current branch %s is not tracking anything."),
 		    branch->name);
 	if (branch->merge_nr !=3D 1)
-		die("The current branch %s is tracking multiple branches, "
-		    "refusing to push.", branch->name);
+		die(_("The current branch %s is tracking multiple branches, "
+		    "refusing to push."), branch->name);
 	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
 	add_refspec(refspec.buf);
 }
@@ -97,8 +97,8 @@ static void setup_default_push_refspecs(void)
 		break;
=20
 	case PUSH_DEFAULT_NOTHING:
-		die("You didn't specify any refspecs to push, and "
-		    "push.default is \"nothing\".");
+		die(_("You didn't specify any refspecs to push, and "
+		    "push.default is \"nothing\"."));
 		break;
 	}
 }
@@ -117,11 +117,11 @@ static int push_with_options(struct transport *tr=
ansport, int flags)
 		transport_set_option(transport, TRANS_OPT_THIN, "yes");
=20
 	if (verbosity > 0)
-		fprintf(stderr, "Pushing to %s\n", transport->url);
+		fprintf(stderr, _("Pushing to %s\n"), transport->url);
 	err =3D transport_push(transport, refspec_nr, refspec, flags,
 			     &nonfastforward);
 	if (err !=3D 0)
-		error("failed to push some refs to '%s'", transport->url);
+		error(_("failed to push some refs to '%s'"), transport->url);
=20
 	err |=3D transport_disconnect(transport);
=20
@@ -146,8 +146,8 @@ static int do_push(const char *repo, int flags)
=20
 	if (!remote) {
 		if (repo)
-			die("bad repository '%s'", repo);
-		die("No destination configured to push to.");
+			die(_("bad repository '%s'"), repo);
+		die(_("No destination configured to push to."));
 	}
=20
 	if (remote->mirror)
@@ -155,19 +155,19 @@ static int do_push(const char *repo, int flags)
=20
 	if ((flags & TRANSPORT_PUSH_ALL) && refspec) {
 		if (!strcmp(*refspec, "refs/tags/*"))
-			return error("--all and --tags are incompatible");
-		return error("--all can't be combined with refspecs");
+			return error(_("--all and --tags are incompatible"));
+		return error(_("--all can't be combined with refspecs"));
 	}
=20
 	if ((flags & TRANSPORT_PUSH_MIRROR) && refspec) {
 		if (!strcmp(*refspec, "refs/tags/*"))
-			return error("--mirror and --tags are incompatible");
-		return error("--mirror can't be combined with refspecs");
+			return error(_("--mirror and --tags are incompatible"));
+		return error(_("--mirror can't be combined with refspecs"));
 	}
=20
 	if ((flags & (TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) =3D=3D
 				(TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) {
-		return error("--all and --mirror are incompatible");
+		return error(_("--all and --mirror are incompatible"));
 	}
=20
 	if (!refspec && !(flags & TRANSPORT_PUSH_ALL)) {
@@ -232,9 +232,9 @@ int cmd_push(int argc, const char **argv, const cha=
r *prefix)
 	argc =3D parse_options(argc, argv, prefix, options, push_usage, 0);
=20
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_P=
USH_MIRROR))))
-		die("--delete is incompatible with --all, --mirror and --tags");
+		die(_("--delete is incompatible with --all, --mirror and --tags"));
 	if (deleterefs && argc < 2)
-		die("--delete doesn't make sense without any refs");
+		die(_("--delete doesn't make sense without any refs"));
=20
 	if (tags)
 		add_refspec("refs/tags/*");
--=20
1.7.2.3
