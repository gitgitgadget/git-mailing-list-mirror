From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 07/11] tg-mail: accept -i/-w
Date: Sat,  9 Oct 2010 22:56:58 +0200
Message-ID: <65565f00635372ad3677c0187c33da4d3ceb4b73.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
 <456834d2977615d5f5c41ca3947fb45cd82bfd87.1286657607.git.bert.wesarg@googlemail.com>
 <6e000c8cf21fac6cd4cf8608c8dc021b039e6f83.1286657607.git.bert.wesarg@googlemail.com>
 <ec70ec8e15013f663bba7f62885abe6881a1512a.1286657607.git.bert.wesarg@googlemail.com>
 <b765e0da80781182bf6c3af8f28d9496ed49cc1b.1286657607.git.bert.wesarg@googlemail.com>
 <62e3424559a93dc0f7c3ed55aafce738f2b0f6d3.1286657607.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:58:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4gVF-0000Co-PB
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760618Ab0JIU6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 16:58:45 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52677 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757190Ab0JIU6o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:58:44 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so129207ewy.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 13:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=gWMC/b5HkB1vYTdgQZByA+1vCfoBmrs6Y1W+fvs6pXs=;
        b=Xoac0dZ/37rb7FQAo3ddPX/6EPCCY4pqDxTPqjJcp5ZyvfmU6eiy/0gg1vjLY9Z7aI
         o+/Bs9v19zc4lqBjaCJSN5EB9QcuIYfHFmgAEp2YBwWMV4f3tVy9lXktsjwOjiLddvtV
         4c8hf4nHphZCY9Octk3iyLR1sfhPT3Ms1PDoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sQmzYErqbehAjmqPwyJzk8TTRcURjaR19NDsn9KSgyiUQ1+vVUbUySodEKGJjxYU1a
         zUuOkia63U9q8v+bQCApHdclCMds8ej3zc8GG9gb72Tt3O/Kl7IUiS+w2mIcmCYShMeN
         HzK4G+BRSZ8bk4nUwwsBqKmMnIyYUG5Ya1JMU=
Received: by 10.213.10.72 with SMTP id o8mr2452960ebo.73.1286657923906;
        Sat, 09 Oct 2010 13:58:43 -0700 (PDT)
Received: from localhost ([46.115.90.142])
        by mx.google.com with ESMTPS id z55sm7833085eeh.9.2010.10.09.13.58.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 13:58:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <62e3424559a93dc0f7c3ed55aafce738f2b0f6d3.1286657607.git.bert.wesarg@googlemail.com>
In-Reply-To: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158617>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 README                     |    4 ++++
 contrib/tg-completion.bash |    8 ++++++++
 tg-mail.sh                 |   12 +++++++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/README b/README
index eea0d72..538659a 100644 README
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
index 6a1e182..b7051b8 100755 contrib/tg-completion.bash
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
index 8167ade..6ddcf08 100644 tg-mail.sh
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
 
 patchfile="$(mktemp -t tg-mail.XXXXXX)"
 
-$tg patch "$name" >"$patchfile"
+# let tg patch sort out whether $head_from makes sense for $name
+$tg patch "$name" $head_from >"$patchfile"
 
 header="$(sed -e '/^$/,$d' -e "s,','\\\\'',g" "$patchfile")"
 
-- 
1.7.1.1067.g5aeb7
