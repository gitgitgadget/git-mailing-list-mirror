From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH v3 08/12] tg-mail: accept -i/-w
Date: Wed, 20 Oct 2010 22:17:53 +0200
Message-ID: <3d4e3b72d48a5227fc7a22c0e55581114a75f1b0.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
 <38d2d7e3ba54cea256bc111f50bcb8d35e7d520d.1287605587.git.bert.wesarg@googlemail.com>
 <b00fdc4e3060b7cf9f1ed25caff16799df09e414.1287605587.git.bert.wesarg@googlemail.com>
 <d9fc8653e6e4c7eb7197a0fb92cd3b8c6e058187.1287605587.git.bert.wesarg@googlemail.com>
 <d1c407c33f446a6e5c7329ba521871732a136fa6.1287605587.git.bert.wesarg@googlemail.com>
 <e3ce8e49edc363c62c6135ffe94dd1e5990cce6a.1287605587.git.bert.wesarg@googlemail.com>
 <2af535ba26e4879ef1e420900effb95f71a9e531.1287605587.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Oct 20 22:19:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8f7r-0005GB-M6
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 22:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659Ab0JTUSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 16:18:44 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40177 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755581Ab0JTUS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 16:18:27 -0400
Received: by mail-fx0-f46.google.com with SMTP id 4so3063004fxm.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=XaGrFdIjX3IMcJCiE4OgRCvByfjgd+yR7YedEl4rTc8=;
        b=CA1anN+QpDs8Az0wiOteyCHKztN5GZFZxYgnyNBAOHsOUI18kDsRPRXh8dBtBrvTJu
         4ApiGJYPSFLi6qgb4LlFcP6LaNY8GeNgfQSfnfkj8ymz6xZmFV+YQm5RNvCSfacbwzIV
         BCjgP6VnXG4URYPheXNMAeM9terG5wO0NAC+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IJndJvWRy54bCvR/FCsphCwUl0DW7zftLJTWpeuOwNhuJ5CpGlfGyX8tKW3o4seZtw
         kjdSkuRLLAWVxTrF8uGFTqW39Tgx1rF1JnAlJUcWf4n+EFFEPeTvg5WgJQ5ONK+JziZu
         LMA25z1+k5t8luP799vf3YYQLandQBIkgGFZY=
Received: by 10.103.191.18 with SMTP id t18mr1938416mup.86.1287605906057;
        Wed, 20 Oct 2010 13:18:26 -0700 (PDT)
Received: from localhost (drsd-4db3cc42.pool.mediaWays.net [77.179.204.66])
        by mx.google.com with ESMTPS id m8sm1587875faj.1.2010.10.20.13.18.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 13:18:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.1069.g89486
In-Reply-To: <2af535ba26e4879ef1e420900effb95f71a9e531.1287605587.git.bert.wesarg@googlemail.com>
In-Reply-To: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159435>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 README                     |    4 ++++
 contrib/tg-completion.bash |    8 ++++++++
 tg-mail.sh                 |   12 +++++++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/README b/README
index eea0d72..538659a 100644
--- a/README
+++ b/README
@@ -315,6 +315,10 @@ tg mail
 
 	to let `git send-email` ask for confirmation before sending any mail.
 
+	Options:
+	  -i		base patch generation on index instead of branch
+	  -w		base patch generation on working tree instead of branch
+
 	TODO: 'tg mail patchfile' to mail an already exported patch
 	TODO: mailing patch series
 	TODO: specifying additional options and addresses on command
diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index 6a1e182..b7051b8 100755
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -359,6 +359,14 @@ _tg_mail ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 
 	case "$cur" in
+	-*)
+		__tgcomp "
+			-i
+			-w
+			-s
+			-r
+		"
+		;;
 	*)
 		__tgcomp "$(__tg_topics)"
 	esac
diff --git a/tg-mail.sh b/tg-mail.sh
index dd4a95a..17ce02c 100644
--- a/tg-mail.sh
+++ b/tg-mail.sh
@@ -3,6 +3,7 @@
 # GPLv2
 
 name=
+head_from=
 send_email_args=
 in_reply_to=
 
@@ -12,12 +13,15 @@ in_reply_to=
 while [ -n "$1" ]; do
 	arg="$1"; shift
 	case "$arg" in
+	-i|-w)
+		[ -z "$head_from" ] || die "-i and -w are mutually exclusive"
+		head_from="$arg";;
 	-s)
 		send_email_args="$1"; shift;;
 	-r)
 		in_reply_to="$1"; shift;;
 	-*)
-		echo "Usage: tg [...] mail [-s SEND_EMAIL_ARGS] [-r REFERENCE_MSGID] [NAME]" >&2
+		echo "Usage: tg [...] mail [-s SEND_EMAIL_ARGS] [-r REFERENCE_MSGID] [-i | -w] [NAME]" >&2
 		exit 1;;
 	*)
 		[ -z "$name" ] || die "name already specified ($name)"
@@ -25,7 +29,8 @@ while [ -n "$1" ]; do
 	esac
 done
 
-[ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
+head="$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
+[ -n "$name" ] || name="$head"
 base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
 	die "not a TopGit-controlled branch"
 
@@ -36,7 +41,8 @@ fi
 
 patchfile="$(get_temp tg-mail)"
 
-$tg patch "$name" >"$patchfile"
+# let tg patch sort out whether $head_from makes sense for $name
+$tg patch "$name" $head_from >"$patchfile"
 
 header="$(sed -e '/^$/,$d' -e "s,','\\\\'',g" "$patchfile")"
 
-- 
1.7.3.1.1069.g89486
