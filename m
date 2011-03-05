From: Adam Monsen <haircut@gmail.com>
Subject: [PATCH 1/2] documentation fix: git log -p does not imply -c.
Date: Sat,  5 Mar 2011 11:56:43 -0800
Message-ID: <1299355004-3532-2-git-send-email-haircut@gmail.com>
References: <4D724A0F.7050904@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio Hamano <gitster@pobox.com>,
	Adam Monsen <haircut@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 20:58:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvxc1-0007fD-2X
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 20:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919Ab1CET5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 14:57:48 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35816 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab1CET5p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 14:57:45 -0500
Received: by pvg12 with SMTP id 12so508123pvg.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 11:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=tyGVPGuzOVAq8gs0z2fVOue4KZrlxt0CBfs0fnnzDsc=;
        b=kmqmUDNQsLVXuMaNCzL7q7ZPAf1pWquwsGZJwYgPpAUUSY/EvilPLnWCWGYIn+UFZo
         Pa55ItZiNxazjgKt/ZFvLXIGMytJLDHFxSAhXEPjwOSxUhRTvZGamCs4MrprC2JhbZsR
         UT+MH6JteG6NlN/GOrH3MfS0fgNBSaRvMPiZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gd8P+2zzi7h2j1ItMyKDokNAERPXKUm89+8ux3YtOBeudRs7YUlnrN4lNJt0TL+zfX
         syAHYvXx1Cg8HLORz6bnFXzYVPwpdZivNn2IrhoSZAt6Exq8DZadHvA4Ic0VQr0hu1Ni
         iKweKgIQgp7NYyn0T6yksEguZzXO5VQG/7nmk=
Received: by 10.142.233.6 with SMTP id f6mr1605189wfh.306.1299355063406;
        Sat, 05 Mar 2011 11:57:43 -0800 (PST)
Received: from localhost.localdomain (c-67-183-136-182.hsd1.wa.comcast.net [67.183.136.182])
        by mx.google.com with ESMTPS id w19sm1339031wfd.8.2011.03.05.11.57.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Mar 2011 11:57:42 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <4D724A0F.7050904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168511>

Relates to the thread with subject "frustrated forensics: hard to find
diff that undid a fix" on the git mailing list.

	http://thread.gmane.org/gmane.comp.version-control.git/168481

I don't wish for anyone to repeat my bungled forensics episode.
Hopefully this will help others git along happily.

Signed-off-by: Adam Monsen <haircut@gmail.com>
---
 Documentation/diff-generate-patch.txt |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 3ac2bea..6cd5270 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -75,10 +75,9 @@ combined diff format
 --------------------
 
 "git-diff-tree", "git-diff-files" and "git-diff" can take '-c' or
-'--cc' option to produce 'combined diff'.  For showing a merge commit
-with "git log -p", this is the default format; you can force showing
-full diff with the '-m' option.
-A 'combined diff' format looks like this:
+'--cc' option to produce 'combined diff'.  You can force showing
+full diff with the '-m' option.  A 'combined diff' format looks like
+this:
 
 ------------
 diff --combined describe.c
-- 
1.7.2.3
