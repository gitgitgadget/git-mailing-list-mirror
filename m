From: Zane Bitter <zbitter@redhat.com>
Subject: [StGit PATCH] Include emacs and vim contribs in source tarball
Date: Thu, 29 Nov 2012 18:06:34 +0100
Message-ID: <20121129170451.7019.90008.stgit@zbitter.fedora>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: catalin.marinas@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 18:06:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te7Zf-0001uM-B0
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 18:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747Ab2K2RGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 12:06:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62757 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab2K2RGh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 12:06:37 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qATH6ajZ013063
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 29 Nov 2012 12:06:37 -0500
Received: from zbitter.fedora (vpn1-4-45.ams2.redhat.com [10.36.4.45])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id qATH6YM3012389;
	Thu, 29 Nov 2012 12:06:35 -0500
User-Agent: StGit/0.16
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210849>

This will enable downstream distros to package them.

Signed-off-by: Zane Bitter <zbitter@redhat.com>
---
 MANIFEST.in |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/MANIFEST.in b/MANIFEST.in
index c94eef6..a80f013 100644
--- a/MANIFEST.in
+++ b/MANIFEST.in
@@ -9,6 +9,9 @@ include examples/gitconfig
 include contrib/*.sh
 include contrib/*.bash
 include contrib/stg-*
+include contrib/Makefile
+include contrib/stgit.el
+recursive-include contrib/vim *.vim
 include t/t*.sh t/t*/* t/Makefile t/README
 include Documentation/*.txt Documentation/Makefile Documentation/*.conf
 include Documentation/build-docdep.perl Documentation/callouts.xsl
