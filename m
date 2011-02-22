From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 52/73] gettextize: git-push basic messages
Date: Tue, 22 Feb 2011 23:42:11 +0000
Message-ID: <1298418152-27789-53-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:46:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1w3-0000rs-RO
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555Ab1BVXoZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:25 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549Ab1BVXoY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:24 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=QnHEWZHIFiWmXC60dHvlsr+//otEUI7XdoNestD3OgQ=;
        b=gNK6mhE4fTpdgqK/fS+NnRRDuJ0zIDHp1L5fhFCMCnIByHwbUWPTt1lvdbAPsVq6vI
         WsUJz9TMUvTaUd6vBD9WyyAUgjKOoCVMy7QBQRvJx74iN0P23xdtCTBVIpN+7SvBs+zX
         PQJUeFH1UxusAae3aJwbHf6gEpDQgZCvGTIrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=hnCosLkIMzIP1dzhCXeDtFjm34CUoj3gklIRRiIt9cELLEwh8t4Mt6LbsWWsuS/n1g
         VEADhIzJFlfFNsA82NHMtQfCBbtmvFFmSIworYMgbCIDyANEaepAQmyZCDh5hNpNFpz2
         W7lZm7SIlniAIPz5tsbzI2TD7HzwTGMo84zFQ=
Received: by 10.204.68.81 with SMTP id u17mr2997670bki.39.1298418263950;
        Tue, 22 Feb 2011 15:44:23 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.23
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:23 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167640>

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
