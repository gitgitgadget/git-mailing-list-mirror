From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 03/20] gettextize: git-stash say + gettext messages
Date: Tue, 14 Sep 2010 13:52:03 +0000
Message-ID: <1284472340-7049-4-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 15:52:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvVwM-00046h-Mw
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800Ab0INNww convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:52:52 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48198 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab0INNwv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:52:51 -0400
Received: by eyb6 with SMTP id 6so3084372eyb.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=kAMZF5RqSrMM6wldcnkMa20+iC9si06VGkrTg6xKvPE=;
        b=cHIYdeJSbmaRI6FNuEtijbVOx3WshC+oHaaHC9QpDDBl2045BTSWduGQcpVxCI+7t6
         g1CoeNgMTWe8AdKyAAXyUlqa+pPo0tx1zEL2ND2lUeNq4MIugzh9jgTPWlouMWK5MYgT
         LpX4OvJyW3TINazLPo5hD5wk/xiW2f91yqbAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wQWLp4+5FVxhtYE6RdnBKCNBIp3YRcm+BkHG6+HISIfXab9W9j4sTcj0lbN2eKiXg0
         KyFTc2FhakPumOWbhWk9uylSXyy+xCmHht8YGiNublToKlhboZuU9fFPfKAkU3cGEhFu
         BIzgzmppIHeIAgkHdu7guW0591V+9oZ/v+s4A=
Received: by 10.216.12.139 with SMTP id 11mr5766366wez.63.1284472369819;
        Tue, 14 Sep 2010 06:52:49 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.52.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:52:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156175>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index efffdce..78f392a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -167,7 +167,7 @@ save_stash () {
 	git update-index -q --refresh
 	if no_changes
 	then
-		say 'No local changes to save'
+		say "$(gettext "No local changes to save")"
 		exit 0
 	fi
 	test -f "$GIT_DIR/logs/$ref_stash" ||
@@ -503,7 +503,7 @@ branch)
 	case $# in
 	0)
 		save_stash &&
-		say '(To restore them type "git stash apply")'
+		say "$(gettext "(To restore them type \"git stash apply\")")"
 		;;
 	*)
 		usage
--=20
1.7.3.rc1.234.g8dc15
