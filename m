From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit RFC/PATCH v3 12/12] tg-patch: simulate mnemonic prefixes
Date: Wed, 20 Oct 2010 22:17:57 +0200
Message-ID: <24183272016f41b5351f25e5143043a9f3327a78.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
 <38d2d7e3ba54cea256bc111f50bcb8d35e7d520d.1287605587.git.bert.wesarg@googlemail.com>
 <b00fdc4e3060b7cf9f1ed25caff16799df09e414.1287605587.git.bert.wesarg@googlemail.com>
 <d9fc8653e6e4c7eb7197a0fb92cd3b8c6e058187.1287605587.git.bert.wesarg@googlemail.com>
 <d1c407c33f446a6e5c7329ba521871732a136fa6.1287605587.git.bert.wesarg@googlemail.com>
 <e3ce8e49edc363c62c6135ffe94dd1e5990cce6a.1287605587.git.bert.wesarg@googlemail.com>
 <2af535ba26e4879ef1e420900effb95f71a9e531.1287605587.git.bert.wesarg@googlemail.com>
 <3d4e3b72d48a5227fc7a22c0e55581114a75f1b0.1287605587.git.bert.wesarg@googlemail.com>
 <1bf3b3656a23c2de123c749524fcd6df09d9bf87.1287605587.git.bert.wesarg@googlemail.com>
 <8bd4da13a1c992ece87b4c742d75dad3b6776acf.1287605587.git.bert.wesarg@googlemail.com>
 <cb28181bc3cc0cfbf19926aa9dabf3d1d1f643b0.1287605587.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Oct 20 22:19:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8f7q-0005GB-53
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 22:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633Ab0JTUSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 16:18:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40177 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755620Ab0JTUSe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 16:18:34 -0400
Received: by mail-fx0-f46.google.com with SMTP id 4so3063004fxm.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=j2g1JRxRZOYaQE3g9D8K3U56G4jdkkaGKjYCnCKGwy0=;
        b=bB4ShFz6iPn2KRpbL9CEVpe5VzC7F1hMPPriQkfOsnPdpGA7yNvBQU22smcpGmwnSO
         X63wSwc9JGR/KGBtQpMiRUoKV+Wui6OTrIE0HHJ2iMR1Z14sNFCJeXG6UeiQQ+qTZZSd
         MwCkeNrbP8/dk7sUpojsKJJ9YzaM6Cjh4NE0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HKsOzpptrnzyk0SsO3QMSiuo5TKaE+0whkAERc43BpgSaNaTFcoB/BPBFvtX9Ql7Gf
         xjhN8ErFJxxHXoxSS4CQgW24ccgSXseiMjJ2wjdCw3BNWZqilPdF/ijJGZB5TJrQnnxD
         KuF6Jaa2A4AewkFhDoea7dpIaJKDAxn0fORGo=
Received: by 10.103.246.19 with SMTP id y19mr7519780mur.87.1287605913454;
        Wed, 20 Oct 2010 13:18:33 -0700 (PDT)
Received: from localhost (drsd-4db3cc42.pool.mediaWays.net [77.179.204.66])
        by mx.google.com with ESMTPS id z19sm404650fam.40.2010.10.20.13.18.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 13:18:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.1069.g89486
In-Reply-To: <cb28181bc3cc0cfbf19926aa9dabf3d1d1f643b0.1287605587.git.bert.wesarg@googlemail.com>
In-Reply-To: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159429>

b/ is for base, i/ and w/ correspond to -i/-w and t/ is the committed
topic.

diff.mnemonicprefix needs to be set to true. See git-config(1) for more
information.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg-patch.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tg-patch.sh b/tg-patch.sh
index dcce672..c8ad723 100644
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -6,7 +6,7 @@
 name=
 
 head_from=
-
+dst_prefix="t/"
 
 ## Parse options
 
@@ -15,7 +15,8 @@ while [ -n "$1" ]; do
 	case "$arg" in
 	-i|-w)
 		[ -z "$head_from" ] || die "-i and -w are mutually exclusive"
-		head_from="$arg";;
+		head_from="$arg"
+		dst_prefix="${arg#-}/";;
 	-*)
 		echo "Usage: tg [...] patch [-i | -w] [NAME]" >&2
 		exit 1;;
@@ -72,6 +73,9 @@ if [ $b_tree = $t_tree ]; then
 else
 	# use the ui diff command when the pager is active
 	diff_command=diff
+	if $(git config --bool diff.mnemonicprefix); then
+		diff_command="$diff_command --src-prefix=b/ --dst-prefix=$dst_prefix"
+	fi
 	[ "x$GIT_PAGER_IN_USE" = "x1" ] ||
 		diff_command=diff-tree
 
-- 
1.7.3.1.1069.g89486
