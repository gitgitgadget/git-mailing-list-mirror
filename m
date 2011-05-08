From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 33/48] i18n: git-stash die + eval_gettext messages
Date: Sun,  8 May 2011 12:21:05 +0000
Message-ID: <1304857280-14773-34-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ30q-0004Hv-4R
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab1EHMWX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:23 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48739 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab1EHMWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:04 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1325631eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=v9BI6eEUXnsRInbTYZb4pbu6guYcZ9Oucrx2sRHcvFU=;
        b=ozg8mjr3v/o4w14CeguWG62HHF7EaJ0WN7VPW0wZy4Hcpp7b3by90zOgjQ0jtTerMj
         FA7n/z6MlWscKsQvNTK4DQwCNT9iQ+gxYXvi8EeH0K8MKHQt9Aa1qbH5fDOE3RazrkLs
         VXZSQftS9UCtXcNlBZ75oOVmR47AjlHBHSI+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=bZ0U35BIp5XWPofRUFQbZAqRtM8m6qMf31f3PNQkQ8JgUHavxuJ7tYBsx9yctLhSjj
         ju1wnGgx2Mw2TcG10eQ8pWdroP5nDPKDaxY0khzsFhs6B5vK6rSrAArHMN4xMNyf+UyX
         4dUu9KJfymjUlQh4R/GJxFCSbxfURF1ieAZKg=
Received: by 10.213.17.75 with SMTP id r11mr657758eba.128.1304857323948;
        Sun, 08 May 2011 05:22:03 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.03
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173125>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index bd394fd..8388f78 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -295,7 +295,7 @@ parse_flags_and_rev()
 			:
 		;;
 		*)
-			die "Too many revisions specified: $REV"
+			die "$(eval_gettext "Too many revisions specified: \$REV")"
 		;;
 	esac
=20
--=20
1.7.4.4
