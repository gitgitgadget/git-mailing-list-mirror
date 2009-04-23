From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 3/8] Documentation: use lowercase for shallow and deep threading
Date: Thu, 23 Apr 2009 02:37:57 -0700
Message-ID: <1240479482-31366-4-git-send-email-bebarino@gmail.com>
References: <1240479482-31366-1-git-send-email-bebarino@gmail.com>
 <1240479482-31366-2-git-send-email-bebarino@gmail.com>
 <1240479482-31366-3-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 11:39:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwvPK-0000xq-SC
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 11:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979AbZDWJiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 05:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753829AbZDWJiS
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 05:38:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:7604 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbZDWJiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 05:38:16 -0400
Received: by rv-out-0506.google.com with SMTP id f9so392313rvb.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=B8jUjzr9TVdgS3at1lDdPHcqNiXVVGSAYr0HZsr8f3w=;
        b=Zb9imOjrBBfi5Sz/2ctGXN2qyb9V9nt3ltxqnw7RLdhCmLhKz0xsYX539WNoI4Wv8z
         D7TlUfLEEdICl6jdfK09IFPrjKkcoXhPqhPFOaXUDLdnIAR+ZcyZ2HaJxL8WbqNPJZnb
         z9U6HSsTzf2v4wlwGjoV1SNG2H8FY6O4w4C4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nBHyBf2h9Ws4G0aZot3Y2l5n+hEuLA5AlsBKevmtLhkmJo8iQMIP4tcw8bkDV2uqQy
         O2tFmyi8+zThxyiJwx0bSp54uolTFFa/SxluqmbDuTITBpxSjx3WLlqfhcUIkgAmyqTG
         CV+9x376+HxecuolYcAJfEXC4BqFplO3EE6js=
Received: by 10.141.18.15 with SMTP id v15mr256340rvi.197.1240479496532;
        Thu, 23 Apr 2009 02:38:16 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id k37sm2969720rvb.2.2009.04.23.02.38.14
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 02:38:16 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 23 Apr 2009 02:38:13 -0700
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <1240479482-31366-3-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117318>

Even when a sentence is started with 'shallow' or 'deep' use the
lowercase version to maintain consistency.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/config.txt           |    4 ++--
 Documentation/git-format-patch.txt |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a8b68e2..cabac97 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -745,11 +745,11 @@ format.pretty::
 
 format.thread::
 	The default threading style for 'git-format-patch'.  Can be
-	either a boolean value, `shallow` or `deep`.  'Shallow'
+	either a boolean value, `shallow` or `deep`.  `shallow`
 	threading makes every mail a reply to the head of the series,
 	where the head is chosen from the cover letter, the
 	`\--in-reply-to`, and the first patch mail, in this order.
-	'Deep' threading makes every mail a reply to the previous one.
+	`deep` threading makes every mail a reply to the previous one.
 	A true boolean value is the same as `shallow`, and a false
 	value disables threading.
 
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 5eddca9..4a43c64 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -128,9 +128,9 @@ include::diff-options.txt[]
 	the Message-Id header to reference.
 +
 The optional <style> argument can be either `shallow` or `deep`.
-'Shallow' threading makes every mail a reply to the head of the
+'shallow' threading makes every mail a reply to the head of the
 series, where the head is chosen from the cover letter, the
-`\--in-reply-to`, and the first patch mail, in this order.  'Deep'
+`\--in-reply-to`, and the first patch mail, in this order.  'deep'
 threading makes every mail a reply to the previous one.  If not
 specified, defaults to the 'format.thread' configuration, or `shallow`
 if that is not set.
-- 
1.6.2.3
