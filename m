From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3 08/13] send-email: Remove superfluous `my $editor = ...'
Date: Mon, 13 Apr 2009 13:23:52 -0500
Message-ID: <1239647037-15381-9-git-send-email-mfwitten@gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-7-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-8-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:34:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtQyp-0002Xh-Ly
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbZDMScb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbZDMSca
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:32:30 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:27716 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbZDMSca (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:32:30 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2201981rvb.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GjV2mIVf292dNSA5HKBs7/hV0cwiPWrMAj5Vwi27UfU=;
        b=CDC9pTq983bOF3xT7+oGlUHQwDCWDZPyKkAafAxbpvNbKjMG+aOLjfEZqbK8QawgZc
         Mp7fKwqzEpKLb/R+iZU1wsUiLYO2PXWKvhvMJR1GDJLnpeYwU71im17ryvREU7K5Ag02
         /+Ft9Yac8zalm4WcmoLRPFBIhjVkPwemdNpL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=J+JcHdkPJnXWXMqgA6PuRQt5LfujFp1374e3WQqNOpuDJkMKfwGnlGz7dLFQ1fTQwt
         18+2IzJ5clGW2j7mL1L0lrzeMGhCVoI7P3ltuKUrgGu/uzj51C/D9fHYCg7AIO7Egt13
         K2TuK6xOFh0SQQ7x53EKaBuCflWMR2qOWoqe0=
Received: by 10.114.125.15 with SMTP id x15mr3299134wac.42.1239647548600;
        Mon, 13 Apr 2009 11:32:28 -0700 (PDT)
Received: from localhost.localdomain (97-116-116-167.mpls.qwest.net [97.116.116.167])
        by mx.google.com with ESMTPS id m30sm5963707wag.12.2009.04.13.11.32.26
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 11:32:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239647037-15381-8-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116469>

Not only was it a repeat, but it also had no effect.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-send-email.perl |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2b0ff80..6b4b257 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -549,8 +549,6 @@ EOT
 	}
 	close(C);
 
-	my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
-
 	if ($annotate) {
 		do_edit($compose_filename, @files);
 	} else {
-- 
1.6.2.2.479.g2aec
