From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 01/51] i18n: git-am add git-sh-i18n
Date: Sun,  3 Apr 2011 16:45:25 +0000
Message-ID: <1301849175-1697-2-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:46:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QRk-0004uP-2Q
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab1DCQqc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:46:32 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59126 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab1DCQqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:31 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505877ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=lmPFZrFLeImFMQAzhB0iKv2kFRTHOj/EWso+jfQCsiM=;
        b=tsvVBATQSojZOeFFPoWZ1kkqWXVZupzNsdENGiHbh9BHD/r/5IqU+gDMKxR+3PjC5F
         fucTB75uhBmjckNJv8gpEfJlJ8aY0CJdV96uFTayC/PzTbGdgrU3YigGLYsrU54ek4kf
         HNQrZ5Q9Yg8dsPdsGKQhlKVjmjJrwfeT7mcWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KG2hpHMQx9wY0RHtDUvkXAcc5X5EAl8sNdqBw1sCYnLCb8N/7OHGgO8NLpP0F6mU4N
         Hyefrt8unLQZ5yvUathAor5i+2pQfP40JVKXrlbREOOMC+2/elZ/BxOa0Z5AsTn5xSvo
         kOIZyAROmUrBYpcgZnTdXYNw5G4ONeH8AznS8=
Received: by 10.213.34.136 with SMTP id l8mr1127227ebd.96.1301849190621;
        Sun, 03 Apr 2011 09:46:30 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.29
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170708>

Source git-sh-i18n in git-am.sh, it's needed to import the Git gettext
shell functions.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 6cdd591..79c5ea2 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -37,6 +37,7 @@ rerere-autoupdate update the index with reused confli=
ct resolution if possible
 rebasing*       (internal use for git-rebase)"
=20
 . git-sh-setup
+. git-sh-i18n
 prefix=3D$(git rev-parse --show-prefix)
 set_reflog_action am
 require_work_tree
--=20
1.7.4.1
