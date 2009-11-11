From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] bash: add the merge option --ff-only
Date: Wed, 11 Nov 2009 05:49:07 +0100
Message-ID: <4AFA4243.4090305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 11 05:49:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N858x-0004J9-Gd
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 05:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbZKKEtH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 23:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbZKKEtH
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 23:49:07 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:42568 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbZKKEtF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 23:49:05 -0500
Received: by ewy3 with SMTP id 3so804734ewy.37
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 20:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=N49OMyzjIwpONXy4FgpBQMh66Mi4KVN13wCFay6o/qw=;
        b=FbS2J8uNYpho9iJ2IdkW30lFasuZACdfeSw19dTYsXeBJ/B0MaIZRd76fm/7YFdWrd
         AyZHUdJ6w8sHjB+9B8FDAvFLgZj88dfHoR7cwwdAW6k7ZI2O+cszuDcE22ss7kFp6DaK
         w+jdWd8eoEO6OsrHonHZw+yZuYmsQjv7z97vw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=GIlAEBkmLQGc+I29545CxJsoQp4nlDUFCdCjzCx9DOgMOfeh0TY9YqFjmLHdccsjAE
         T9aVeLpo1Skv8KZubEQbZFr8wii8rxr9THxXHMc8TWdNi1QYIfboHyxxUbDewjUBpaZc
         zIunBCfmfkoYwvoQGrxBAAAQDfllhGo1wKWl4=
Received: by 10.213.2.70 with SMTP id 6mr6093456ebi.25.1257914949129;
        Tue, 10 Nov 2009 20:49:09 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm3208623eyd.6.2009.11.10.20.49.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 20:49:08 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132616>

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index e3ddecc..a0917d1 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1224,7 +1224,7 @@ _git_log ()
=20
 __git_merge_options=3D"
 	--no-commit --no-stat --log --no-log --squash --strategy
-	--commit --stat --no-squash --ff --no-ff
+	--commit --stat --no-squash --ff --no-ff --ff-only
 "
=20
 _git_merge ()
--=20
1.6.5.1.69.g36942
