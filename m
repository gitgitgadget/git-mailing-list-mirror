From: newren@gmail.com
Subject: [PATCH 7/7] fast-export: Document the fact that git-rev-list arguments are accepted
Date: Fri, 19 Jun 2009 22:37:03 -0600
Message-ID: <1245472623-28103-8-git-send-email-newren@gmail.com>
References: <1245472623-28103-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusambite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 20 06:47:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHsU9-00069I-7Q
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 06:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbZFTErM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 00:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbZFTErL
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 00:47:11 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:8779 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbZFTErK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 00:47:10 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1019569wfd.4
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 21:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MDoMiPAgHxNPNsjhfpuRZoeb/BLeN7C+wJMF9sk16fI=;
        b=Qp9Zjzb/D++Rp7hsDKUJZma3p5H+qY9NWZOQZQmlNUWoSXcgQDO3nFkiDAcJhjXxAC
         w+OeHBGx4Cns0xftGMeotZ6Kk5IWwMY3fEjr6hSpTDIirMJDUGrWv8giDtWv3HrQWN5N
         H96bJEvp/WAaKVVmA08DybNgGgmX5grwfN3lY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=avIs979VjAYDls56jrZlnlLj/E6XkMLSSAdcID9QMY/JG2evgTTB47Bx2hhnsZyOxv
         cgZF2Rxv44FkktE3oq3tFcIvTsuHek2t11ry+OhV6vWGn2yKU4NCk/d51B3CFjBCjeSo
         IMssP6w8jyAIsN7z0dltNfAEr/+pFsVnpHU6s=
Received: by 10.143.42.6 with SMTP id u6mr1664777wfj.149.1245472778130;
        Fri, 19 Jun 2009 21:39:38 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 22sm39467wfi.32.2009.06.19.21.39.36
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Jun 2009 21:39:37 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.323.gfb84f
In-Reply-To: <1245472623-28103-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121931>

From: Elijah Newren <newren@gmail.com>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-export.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 194abde..af2328d 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -82,6 +82,12 @@ marks the same across runs.
 	allow that.  So fake a tagger to be able to fast-import the
 	output.
 
+[git-rev-list-args...]::
+       A list of arguments, acceptable to 'git-rev-parse' and
+       'git-rev-list', that specifies the specific objects and references
+       to export.  For example, `master\~10..master` causes the
+       current master reference to be exported along with all objects
+       added since its 10th ancestor commit.
 
 EXAMPLES
 --------
-- 
1.6.3.2.323.gfb84f
