From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] fetch: better alignment in ref summary
Date: Sun, 22 May 2016 18:20:18 +0700
Message-ID: <20160522112019.26516-2-pclouds@gmail.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 13:20:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4RQy-0003mK-Oo
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 13:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbcEVLUc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 07:20:32 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32869 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbcEVLUa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 07:20:30 -0400
Received: by mail-pf0-f193.google.com with SMTP id y7so15875030pfb.0
        for <git@vger.kernel.org>; Sun, 22 May 2016 04:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uftr9y8+ShPQf+bVJnUq5RkjSHA9j87cJOTyHu1y7Zo=;
        b=r2Dow8EEodS2moCa/juhpqVioV4Zj8/MRS268JwILztO6aX8o08HQEy43wcRp7bsXS
         SfUvtkIT+ZrRDZCH0N/TrzX9g58ukzOYQLApNnQvUXlbXQrXRNE4UBxLBzArpFtPcexv
         IGhW7ufhp9lOwe0KUYgNfgv9BNMcBhDHR8kLA2aJKZ5ApefIqx2f5uj+8YadPNd1uhqs
         Xt9gA3KlRaZNNXIhnhqFnLDd+FM6TuAFjnE6mDYka4iPrCIEy2BTRgWFbaY/11LtIq1B
         jUxeDqbFPEqDqsENRIvS+x18HdsDvgL/GofoCBIwuX7Ob9o8rMpEJGcUhbfrcixxUCm7
         SKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uftr9y8+ShPQf+bVJnUq5RkjSHA9j87cJOTyHu1y7Zo=;
        b=ekjDo7ZNXR0ML+ElGZLXG+lg9XDtcBHxIlpvy65p1oZPJw2Cs6LAkVZDe8LaZM95kA
         6KPZjxW03krG2KNV+/cOYYoyM4P9Irfw21c6jOGtdMxSQqCZH+Dz9u5MN1Rfan1nuXvU
         HHx/cLuYpbnu3kXa7lYT50SOhKjMRA0ptCPyQXbJT3UtyqDiDeHw3dLxC15WX5p41FI6
         o+bHCnfVc3514bdpydrgVy10194owCuIPzHqW88NfL89JfbeMV/yqXFC65Bv2cuJhdCk
         Dxd0HS1udgAWLkIDpTtAJBy43HbLBMHz3UP4OT4cFKZuZVTTNLpFaj8c4QvWW+1OLkO6
         Cq0w==
X-Gm-Message-State: ALyK8tItYWUY5kA8/Dg20GZO6dOEVl3lIJrRH9VzZka41611n3/1gVmX59Uy1MqVs4wy6g==
X-Received: by 10.98.65.209 with SMTP id g78mr7900865pfd.163.1463916029718;
        Sun, 22 May 2016 04:20:29 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id c190sm39183203pfb.33.2016.05.22.04.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2016 04:20:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 22 May 2016 18:20:25 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160522112019.26516-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295282>

Currently fetch hard-codes the "remote" column to be 10. For repos
with long branch names, the output could look ugly like this

=46rom github.com:pclouds/git
 * [new branch]      2nd-index  -> pclouds/2nd-index
 * [new branch]      3nd-index  -> pclouds/3nd-index
 * [new branch]      file-watcher -> pclouds/file-watcher
 * [new branch]      inst       -> pclouds/inst
 * [new branch]      large-file-fixes -> pclouds/large-file-fixes
 * [new branch]      ls         -> pclouds/ls
 * [new branch]      master     -> pclouds/master
 * [new branch]      multiple-work-trees -> pclouds/multiple-work-trees
 * [new branch]      mv         -> pclouds/mv
 * [new branch]      read-cache-daemon -> pclouds/read-cache-daemon
 * [new branch]      split-blob -> pclouds/split-blob
 * [new branch]      split-index -> pclouds/split-index
 * [new branch]      status-fast-fast -> pclouds/status-fast-fast
 * [new branch]      untracked-cache -> pclouds/untracked-cache

This patch makes the output a bit better with minimum code change

=46rom github.com:pclouds/git
 * [new branch]      2nd-index  -> pclouds/2nd-index
 * [new branch]      3nd-index  -> pclouds/3nd-index
 * [new branch]      file-watcher -> pclouds/file-watcher
 * [new branch]      inst         -> pclouds/inst
 * [new branch]      large-file-fixes -> pclouds/large-file-fixes
 * [new branch]      ls               -> pclouds/ls
 * [new branch]      master           -> pclouds/master
 * [new branch]      multiple-work-trees -> pclouds/multiple-work-trees
 * [new branch]      mv                  -> pclouds/mv
 * [new branch]      read-cache-daemon   -> pclouds/read-cache-daemon
 * [new branch]      split-blob          -> pclouds/split-blob
 * [new branch]      split-index         -> pclouds/split-index
 * [new branch]      status-fast-fast    -> pclouds/status-fast-fast
 * [new branch]      untracked-cache     -> pclouds/untracked-cache

To make all "->" aligned, we may need to go through the ref list
twice, or buffer the output and let column.c align it. Either way
needs a lot more work than this.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1cf15d0..223e09b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -465,7 +465,14 @@ fail:
 			   : STORE_REF_ERROR_OTHER;
 }
=20
-#define REFCOL_WIDTH  10
+static int REFCOL_WIDTH =3D 10;
+
+static void adjust_refcol_width(int len)
+{
+	if (REFCOL_WIDTH < len) {
+		REFCOL_WIDTH =3D len;
+	}
+}
=20
 static int update_local_ref(struct ref *ref,
 			    const char *remote,
@@ -477,6 +484,8 @@ static int update_local_ref(struct ref *ref,
 	struct branch *current_branch =3D branch_get(NULL);
 	const char *pretty_ref =3D prettify_refname(ref->name);
=20
+	adjust_refcol_width(gettext_width(remote));
+
 	type =3D sha1_object_info(ref->new_oid.hash, NULL);
 	if (type < 0)
 		die(_("object %s not found"), oid_to_hex(&ref->new_oid));
--=20
2.8.2.524.g6ff3d78
