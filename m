From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] Documentation/git-cat-file.txt: add missing line break
Date: Tue,  3 Jun 2008 13:06:12 +0200
Message-ID: <1212491172-8770-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 13:07:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3UMQ-0002o3-0A
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 13:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757205AbYFCLGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 07:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754024AbYFCLGQ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 07:06:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:31499 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757125AbYFCLGO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 07:06:14 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1005313fgg.17
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=ipycGkc3aS25AZ9Mx9FEyWfpqNHUfqlWt+zvU7FUJmQ=;
        b=wwD2aAN4RxVfxsZQYGe/sRBjM+rtO1M1eZnkxH4TCzKUUauETAtnRhsrMZ+L7W5m7e9WxsUrg3X2HaG19C7PH8WDBbQL7kN3vDEC4k3+PBjuYVAFrCtPgX0ZyT00oHLpt2BB0Z/654oEHRltZcSFePxbGUR3I5srab9A7W/zG0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=usQsQh69sRffb70A1fZwZ2oJ6KXBbnfFZHQGrlq2NDYukudjliPwk/IwNswX+hROKm9BmzntzeIjtwW5ow/R0mzdGHdizErsxM/prTmE8E/bsxAWUJD+Bd18D0vZPJu+cUxyCgiVqlwNOAZvmAdnMLp0N/Z4yGZCs7n+Q0h/NyY=
Received: by 10.86.29.19 with SMTP id c19mr1235172fgc.28.1212491171048;
        Tue, 03 Jun 2008 04:06:11 -0700 (PDT)
Received: from fly ( [91.33.231.153])
        by mx.google.com with ESMTPS id f31sm13229425fkf.5.2008.06.03.04.06.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 04:06:10 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K3ULE-0002Ho-K4; Tue, 03 Jun 2008 13:06:12 +0200
X-Mailer: git-send-email 1.5.6.rc0.92.g27fd.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83639>

Without [verse], the line break between the two synopsis lines does
not make it into the man page.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
If such small patches are more annoying than helpful, please let me
know. ;)

 Documentation/git-cat-file.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index f6c394c..bcf4f88 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -8,6 +8,7 @@ git-cat-file - Provide content or type/size information for repository objects
 
 SYNOPSIS
 --------
+[verse]
 'git-cat-file' [-t | -s | -e | -p | <type>] <object>
 'git-cat-file' [--batch | --batch-check] < <list-of-objects>
 
-- 
1.5.6.rc0.92.g27fd.dirty
