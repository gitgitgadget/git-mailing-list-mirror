From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] bash: support --delete and --set-upstream for push
Date: Fri, 02 Apr 2010 12:13:10 +0200
Message-ID: <4BB5C336.2000101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Apr 02 12:13:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxdsN-0002xd-4N
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 12:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758033Ab0DBKNP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 06:13:15 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:3104 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756045Ab0DBKNN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 06:13:13 -0400
Received: by ey-out-2122.google.com with SMTP id d26so123279eyd.19
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 03:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=boX1CJMQPPmbWCQT8wJ7uL7bDpaExLiI8FFBWVxsw9E=;
        b=MnbGSw13YUeI3b9AVxyV2lO5DlwovnM8a+6BPp9dmXxi0wDPKdH+IwdP3gq9LlirIp
         kCjoM4EubFGv9tLhchyv4tBZtQbJe0HKWxGucrZmkjbGzSyHPco2bexQHV4ZcHcylOTr
         nKGYsPsG74dsZ5PT5bYm16fuQJcJUjTpRpWEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=d3c3m0H8jIIZa+LnWWGb0yTKgIHchz99OiXUmYAoFzt0ZS6U2rtYwZ2vm9vv0fsL8N
         /r6iL3wyjMRNQFz4AYYI0CjmD+vhfbMnK2YAlSz6Em5Jr4Wu5GW/rRgn+cZSyBP7HkIK
         3k+AVOqT0Mt0eZ5M1Y/M2RVaiRdQaNVClKwKI=
Received: by 10.213.25.71 with SMTP id y7mr1115156ebb.54.1270203191786;
        Fri, 02 Apr 2010 03:13:11 -0700 (PDT)
Received: from [10.0.1.10] (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 16sm4926838ewy.7.2010.04.02.03.13.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Apr 2010 03:13:11 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (Macintosh/20100228)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143804>

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
(This is a resend. My original emails seems to have been lost or forgot=
ten.)

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
