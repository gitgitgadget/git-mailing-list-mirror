From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] bash: support the --autosquash option for rebase
Date: Sat, 06 Feb 2010 09:37:53 +0100
Message-ID: <4B6D2A61.3000604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 09:38:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdgBU-00035j-W9
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 09:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab0BFIh5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 03:37:57 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:45549 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab0BFIh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 03:37:56 -0500
Received: by ewy28 with SMTP id 28so815338ewy.28
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 00:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=m/ShBprteqaegU30oDeIawG1L/pfj24wac/qJccFxOg=;
        b=HbMMrfBMA8LB/1jjT7cbZJ7+vifTVETX3EpQrWxKPAi6iqJmvjPnnG44gf4fBgDBRs
         rMITIhcVjAXmuAz7VGxZIJLmYWI2ge8q0ebOp4GwRiV0qHavxCzwM6xT5BaY/8czhdAi
         8hNjBesVqBUx0Zc2b+UtO3B/OlzcSkx0ER/hE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=Y22BbdcKyL1x6GB/M79oLjyCIoTFX1DVIhKIwvf3qDBYjfCUO+5L5a7GyK8n86x0Jx
         3Q23kq7WOX8uhw6ICrz4D9Ruygsk3P1ex6uj+6EBJe29x4sHoT+dK6bkCp7eUtxrejlT
         nHuUFc4vaUWLvr/vExkMjuPBRsQGlfGeaZtso=
Received: by 10.213.102.73 with SMTP id f9mr3349549ebo.12.1265445474723;
        Sat, 06 Feb 2010 00:37:54 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 14sm1526223ewy.7.2010.02.06.00.37.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 00:37:54 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139150>

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index da46bf8..35acad0 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1386,6 +1386,7 @@ _git_rebase ()
 			--preserve-merges --stat --no-stat
 			--committer-date-is-author-date --ignore-date
 			--ignore-whitespace --whitespace=3D
+			--autosquash
 			"
=20
 		return
--=20
1.7.0.rc1.10.gb8bb
