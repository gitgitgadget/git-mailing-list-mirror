From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] typofix in 2.6.0 relnotes
Date: Tue, 18 Aug 2015 19:38:45 +0200 (CEST)
Message-ID: <337411778.234721.1439919525643.JavaMail.ngmail@webmail20.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 19:38:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRkqa-0005gT-Tp
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 19:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbbHRRis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 13:38:48 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:50742 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753342AbbHRRir (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2015 13:38:47 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mx.arcor.de (Postfix) with ESMTP id 3mwfc55SGdzB2QY;
	Tue, 18 Aug 2015 19:38:45 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id A779A71E756;
	Tue, 18 Aug 2015 19:38:45 +0200 (CEST)
Received: from webmail20.arcor-online.net (webmail20.arcor-online.net [151.189.8.201])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 3mwfc54fwnzFQpW;
	Tue, 18 Aug 2015 19:38:45 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-01.arcor-online.net 3mwfc54fwnzFQpW
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1439919525; bh=sLW9NHx7NoeAH/FI9wOWAgFIMRKSTOF/scH3EXCexPI=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=LH8P4KcWaOmRKJDY76/aNSg5MLDTI4wGNet7r6OkFTI7wk9jJWn26HBznptOFKE9z
	 5yC+1d1ouZYolUBJfuqZvnCPYbIa/ZyFcLwiN7LERvUQ909EBwvG/uvQliYGm52teE
	 MHfnnb2dlNNl2k8/KE2L7CeA9QE/oKgWlKuViq2s=
Received: from [92.72.232.250] by webmail20.arcor-online.net (151.189.8.201) with HTTP (Arcor Webmail); Tue, 18 Aug 2015 19:38:45 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 92.72.232.250
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276131>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/RelNotes/2.6.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.6.0.txt b/Documentation/RelNotes/2.6.0.txt
index 4a0a589..e86de81 100644
--- a/Documentation/RelNotes/2.6.0.txt
+++ b/Documentation/RelNotes/2.6.0.txt
@@ -117,7 +117,7 @@ notes for details).
    particular date format.
    (merge e7aac44 da/subtree-date-confusion later to maint).
 
- * An attempt to delete a ref by pushing into a repositorywhose HEAD
+ * An attempt to delete a ref by pushing into a repository whose HEAD
    symbolic reference points at an unborn branch that cannot be
    created due to ref D/F conflict (e.g. refs/heads/a/b exists, HEAD
    points at refs/heads/a) failed.
-- 
1.9.5.msysgit.0
