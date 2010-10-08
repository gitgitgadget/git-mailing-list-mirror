From: "=?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?=" 
	<stepan.nemec@gmail.com>
Subject: [PATCH 2/6] Fix odd markup in --diff-filter documentation
Date: Fri,  8 Oct 2010 19:31:16 +0200
Message-ID: <1286559080-27257-3-git-send-email-stepnem@gmail.com>
References: <87fwwhszsf.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 19:35:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Gqi-0000hg-Nk
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 19:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758834Ab0JHReB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 13:34:01 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43636 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759260Ab0JHRd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 13:33:59 -0400
Received: by bwz15 with SMTP id 15so456748bwz.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=uYFMB1tmTSX3vAHEeWBAn1SS/cJGYLH4RnPM6+F9iPI=;
        b=ATe1qQAssw4X0olJ/NHYYOwvkjKIZEE2ObaiZZz/1yTNFSHNXq216q36XyB53ddB69
         e40MVBdZks+zGsNc3zk9EN60ZToVo7Em4CDZ2XKzlUQtoaq825Yqupq4SIK3bW+xlIiX
         VjFBZDKaVxf9AhdVJXC4Xu2xDheaEIxhIvPZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=w+nM6T7kXgbfKcSHgbz7+rhMknCEpwZnSGRVADCKlnN4ZzNTzbp2YWHUr7y43RUAFG
         1YdasmTHWGc+aBP2G+Mg4q76yqFa4UJOaGLjeubkdd6zOot0udTojgsKNAuG9KDZBoNc
         f/BxsSiCD6CQL7/dgqeeARzYheLrAwiKTjCBA=
Received: by 10.204.51.67 with SMTP id c3mr2325335bkg.69.1286559238434;
        Fri, 08 Oct 2010 10:33:58 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id x13sm2838215bki.12.2010.10.08.10.33.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 10:33:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc2.221.gbf93f.dirty
In-Reply-To: <87fwwhszsf.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158509>

Use a `<spec>' placeholder instead of the regex-like bracket expression
to make it more consistent with other similar places.

Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
---
 Documentation/diff-options.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index cbf3c92..719f589 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -248,13 +248,13 @@ endif::git-log[]
 	If `n` is specified, it has the same meaning as for `-M<n>`.
=20
 ifndef::git-format-patch[]
---diff-filter=3D[ACDMRTUXB*]::
+--diff-filter=3D<spec>::
+	'<spec>' can be any combination of the characters `ACDMRTUXB*`.
 	Select only files that are Added (`A`), Copied (`C`),
 	Deleted (`D`), Modified (`M`), Renamed (`R`), have their
 	type (i.e. regular file, symlink, submodule, ...) changed (`T`),
 	are Unmerged (`U`), are
 	Unknown (`X`), or have had their pairing Broken (`B`).
-	Any combination of the filter characters may be used.
 	When `*` (All-or-none) is added to the combination, all
 	paths are selected if there is any file that matches
 	other criteria in the comparison; if there is no file
--=20
1.7.3.rc2.221.gbf93f.dirty
