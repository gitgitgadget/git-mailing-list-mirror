From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 11/20] gettextize: git-bisect gettext + echo message
Date: Tue, 14 Sep 2010 13:52:11 +0000
Message-ID: <1284472340-7049-12-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 15:53:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvVwp-0004Ln-Kc
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261Ab0INNxV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:53:21 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48198 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab0INNxU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:53:20 -0400
Received: by mail-ey0-f174.google.com with SMTP id 6so3084372eyb.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=JueYH7XQHBlWDYO66HmLHLmexAeJGSTrXBIA9TnChak=;
        b=oSRFSfZD/xJMaZszwiCmGIE/JgOezHHqcrV7Ljt8svIjDNAPdAIdMRdcsGBluMqNR+
         juhDhsMPZfkyhNDztynEIKb3fL1oVviBOOYbrA32q5nKfQbh9JrskoIc4kv7aOrGkK5y
         6nbHCRgMdrBiRwTY1ra3ziD2iNrLigsbiX0uY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xsn7T+osq3E5cLo94k9tC2rbMiRHOdFFlRbvjyUcnNyE/gf2h8kxjqCMFyeKbZ1ntn
         ipom5Lj8nbjxzgrqC7mWs7bJzO9v2K/UWvCXmB5TGvAiwgfhItyNRMcwPqYTTMvrKinf
         9UAeK9Ja3LkzBmZ+myIXnRNYzUaFgIBmsBcqQ=
Received: by 10.216.71.85 with SMTP id q63mr5756822wed.53.1284472399675;
        Tue, 14 Sep 2010 06:53:19 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.53.18
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:53:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156180>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index d0d95f6..1274f11 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -306,7 +306,7 @@ bisect_visualize() {
=20
 bisect_reset() {
 	test -s "$GIT_DIR/BISECT_START" || {
-		echo "We are not bisecting."
+		gettext "We are not bisecting."; echo
 		return
 	}
 	case "$#" in
@@ -406,7 +406,7 @@ bisect_run () {
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
1.7.3.rc1.234.g8dc15
