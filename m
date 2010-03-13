From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] bash: support --delete and --set-upstream for push
Date: Sat, 13 Mar 2010 08:10:03 +0100
Message-ID: <4B9B3A4B.9010509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 13 08:10:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqLUX-00044O-GC
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 08:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758844Ab0CMHKI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Mar 2010 02:10:08 -0500
Received: from mail-ew0-f216.google.com ([209.85.219.216]:52960 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab0CMHKG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 02:10:06 -0500
Received: by ewy8 with SMTP id 8so570438ewy.28
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 23:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=AUSh+KwVqLjguNWjGFZnySDuWdfqK3heXzh1xbafgUs=;
        b=nvaukkfJ80O6jrhKBJYNwcfoxXd7dw/0afn2o+YDbOvaFZCmj4EOs88MUkj5/iFuCn
         k8v4vRK+Q389f6NfhYA6Wusrrm5mwL2AZKZd0PUYltzYZiulxTggq13ELQGpm+sKEq/k
         gLvcUKinf05wnUitcRW2wNaQHsDws9eWkTt4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=GmBVLZbKM50BRkV4OMuzRgFYxTeCsB0eT+hRJHwkQdNVC8dwKtyR1ZZS/sopz1Ic83
         GpJFzpWl4syw8BUR9fExst0P64tG5l18HYycMUuFAsKgcgayebr6wiaWlMy7NXbNCNPd
         aeXL4MnqKD/ASJGtDlhAa/Ok3wRqLgJofstJs=
Received: by 10.213.98.143 with SMTP id q15mr3650615ebn.67.1268464204946;
        Fri, 12 Mar 2010 23:10:04 -0800 (PST)
Received: from [10.0.1.10] (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 16sm1428446ewy.3.2010.03.12.23.10.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 23:10:04 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142088>

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index fe93747..c3b4ffc 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1359,7 +1359,7 @@ _git_push ()
 	--*)
 		__gitcomp "
 			--all --mirror --tags --dry-run --force --verbose
-			--receive-pack=3D --repo=3D
+			--receive-pack=3D --repo=3D --delete --set-upstream
 		"
 		return
 		;;
--=20
1.7.0.2.157.gb7e7f
