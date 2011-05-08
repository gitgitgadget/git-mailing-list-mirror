From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 39/48] i18n: git-bisect gettext + echo message
Date: Sun,  8 May 2011 12:21:11 +0000
Message-ID: <1304857280-14773-40-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ31M-0004a3-Tj
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954Ab1EHMXS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:23:18 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35010 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab1EHMWK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:10 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327054ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=zX9Oh8Djn9aUKJa22m6lYB+eHAGEEiEaJX+1V5HJfUA=;
        b=FoO25Scnu6GzKXW01h+SCYGr1i/tSpoLfULy/7AkCzsid5B4vwY95RrxaRm3npqozq
         ARCqVssCm+5KsdupXISA/WDVnMucXGJq8KvWEYDsR+idceOqeGwGOuuitS6tTspYsxCs
         scW9KUNFtHXZUTZ8K4bleT5XqVCIVlZL6ogIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ly7l96yP0L3Wv9oVV3tlzBqO13qc4e9wYVH/+jii0+plGrJqD8lzNL25/tx35fcv2q
         bLKpNCz1uAHChViz4qkv2zi47tovtg0q0yfQx5GgBwvZIAdUWZZN68OsJUqqs0zrXQug
         tTR8D5jTzhr9ZxrY7SfgupBc7MBOMVsVCWY1c=
Received: by 10.213.21.2 with SMTP id h2mr622315ebb.51.1304857329735;
        Sun, 08 May 2011 05:22:09 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.08
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173142>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 751c733..4420b46 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -308,7 +308,7 @@ bisect_visualize() {
=20
 bisect_reset() {
 	test -s "$GIT_DIR/BISECT_START" || {
-		echo "We are not bisecting."
+		gettext "We are not bisecting."; echo
 		return
 	}
 	case "$#" in
@@ -414,7 +414,7 @@ bisect_run () {
       fi
=20
       if sane_grep "is the first bad commit" "$GIT_DIR/BISECT_RUN" > /=
dev/null; then
-	  echo "bisect run success"
+	  gettext "bisect run success"; echo
 	  exit 0;
       fi
=20
--=20
1.7.4.4
