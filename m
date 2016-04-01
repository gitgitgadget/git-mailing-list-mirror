From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git.spec: use README.md, not README
Date: Fri,  1 Apr 2016 09:10:51 +0200
Message-ID: <1459494651-32618-1-git-send-email-Matthieu.Moy@imag.fr>
References: <CADrzLrOaeQXjWeCnZSJfWWyfr3kzgm59QvR6SeTiw_E2Xg7ugQ@mail.gmail.com>
Cc: git@vger.kernel.org, Ron Isaacson <isaacson.ljits@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 01 09:11:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1altEg-0006Ry-Pi
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 09:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbcDAHLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 03:11:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45666 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280AbcDAHLD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 03:11:03 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u317Aqwl011230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 1 Apr 2016 09:10:52 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u317AqeB003964;
	Fri, 1 Apr 2016 09:10:53 +0200
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <CADrzLrOaeQXjWeCnZSJfWWyfr3kzgm59QvR6SeTiw_E2Xg7ugQ@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Fri, 01 Apr 2016 09:10:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u317Aqwl011230
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1460099456.5773@LS2sFCs+Te/QPw9mnQpG0Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290510>

The file was renamed in 4ad21f5 (README: use markdown syntax,
2016-02-25), but that commit forgot to update git.spec.in.

Reported-by: Ron Isaacson <isaacson.ljits@gmail.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git.spec.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git.spec.in b/git.spec.in
index d61d537..bfd1cfb 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -146,7 +146,7 @@ rm -rf $RPM_BUILD_ROOT
 %files -f bin-man-doc-files
 %defattr(-,root,root)
 %{_datadir}/git-core/
-%doc README COPYING Documentation/*.txt
+%doc README.md COPYING Documentation/*.txt
 %{!?_without_docs: %doc Documentation/*.html Documentation/howto}
 %{!?_without_docs: %doc Documentation/technical}
 %{_sysconfdir}/bash_completion.d
-- 
2.7.2.334.g35ed2ae.dirty
