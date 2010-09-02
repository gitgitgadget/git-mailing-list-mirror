From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 22/25] gettextize: git-push basic messages
Date: Thu,  2 Sep 2010 19:40:43 +0000
Message-ID: <1283456446-22577-23-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:42:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFgU-0006jt-Da
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692Ab0IBTmf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:42:35 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50195 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756672Ab0IBTmd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:42:33 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so81343wyb.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ErpkmZY/BETwAmXp2kHP61ajvKUF3GSQ30jQT+Nqysw=;
        b=mRSWVC9uGbJNHeJKBvTjbDzjel2QXKds+eqbN3jh9/AOvGVKBGAx95xJnF/LZJ6a9V
         A2YGolB8bltJnGPDmeX8wEQ0dNOEXSAN69S5QHBxgE6hf02xbP1hDj88nDOBcznugE23
         fmdcbJMBMUuSD0EMpm04uLgc4nwup8i2RXq3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Gr9Dys8YZY+WZ8+h2HJTcrqpABKLhg8c4pVoO5wM/a4Ju5druq3V0h8v/AOaq6VVHA
         +gz/a8ksMhbH4K1Yy8/4MmfU6HEQT+FdLChZWGKxmcgikkmADlVNfypv9oa2fEu8LP39
         zqZmLq51zPb7AtYi6BjSwUD2Pn6nkDOTnps10=
Received: by 10.227.43.9 with SMTP id u9mr6055wbe.41.1283456551625;
        Thu, 02 Sep 2010 12:42:31 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.42.30
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:42:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155183>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/push.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index e655eb7..8c8d8c7 100644
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
@@ -129,9 +129,9 @@ static int push_with_options(struct transport *tran=
sport, int flags)
 		return 0;
=20
 	if (nonfastforward && advice_push_nonfastforward) {
-		fprintf(stderr, "To prevent you from losing history, non-fast-forwar=
d updates were rejected\n"
+		fprintf(stderr, _("To prevent you from losing history, non-fast-forw=
ard updates were rejected\n"
 				"Merge the remote changes (e.g. 'git pull') before pushing again. =
 See the\n"
-				"'Note about fast-forwards' section of 'git push --help' for detai=
ls.\n");
+				"'Note about fast-forwards' section of 'git push --help' for detai=
ls.\n"));
 	}
=20
 	return 1;
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
1.7.2.2.614.g1dc9
