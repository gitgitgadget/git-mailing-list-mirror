From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 01/48] i18n: git-am add git-sh-i18n
Date: Sat, 21 May 2011 18:43:42 +0000
Message-ID: <1306003469-22939-2-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:45:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrAn-00009h-J6
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081Ab1EUSpG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:06 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42788 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686Ab1EUSpF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:05 -0400
Received: by eyx24 with SMTP id 24so1444603eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=n2fEHa8pMY/3XZtetAF430ancit6x8qtleZBglOB/4s=;
        b=JIfSQUGLMAvcRvzARs4lrbXl9cZMpz6KGkcWzlZDCgFMgqtepkvg+cNaDzzoN42i4/
         xTd69B8t3Uqzg2/46kMpwpzdq1S48Ehz9/PPioLGr/rweTPVh3K23lXet6gFJGcYBY98
         OHat0gWCOu8S+mQBuUiexefI+M/WQlVilKxQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Od+n1tGYC0tFm3HqDZbdP47WVM0T70WEl/EieCe6S3msEHTzcof8y6uFSLRh7k332s
         7Q/cbA3r1zixAj3p/IbF57XF6hvBzoOuEub+CIFJF0IPiL+M0Sky05kMkmLWueeSi3hd
         2YAguHAitbQzb7j20dveE+xzX1ewQgwhf+UBk=
Received: by 10.14.101.68 with SMTP id a44mr273451eeg.47.1306003502924;
        Sat, 21 May 2011 11:45:02 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.01
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174118>

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
1.7.5.1
