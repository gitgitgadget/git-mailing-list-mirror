From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv8 7/7] gitweb: add empty alt text to avatar img
Date: Tue, 30 Jun 2009 00:00:54 +0200
Message-ID: <1246312854-3365-8-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-6-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-7-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 00:05:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLOym-0006oe-5q
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 00:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbZF2WF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 18:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755919AbZF2WBI
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 18:01:08 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:53425 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758445AbZF2WBB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 18:01:01 -0400
Received: by mail-fx0-f218.google.com with SMTP id 18so1264489fxm.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 15:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=EjuX2D9+Vg84LufESaTWS8Bt7z6qlst1jCKN28Q0KKU=;
        b=X9hptdHCydRY6ZpFCIFJ61EunDZMCyNVxotJBVJVwvPq4cltzHQPjI8pAIzOYTNNFT
         i21JBWHGEIEfqMiz5mJEX0tkZ++5WNS7Wuipk9lRSMwzkTErchmrP+7X4bv+y7RVOGfD
         LGvCYSXEXpk6F2Skq8re7mhVUZliGVR7Bzbd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TgQkp2Zb6PfS2pDpzwP0Md7Jxm6GC3PubnxmSuSZ5VFV0ygPzxEGvcBx8gCY7eF51t
         WNYugg+yOXkehxaet0uthPhai5tvhkILk8kh5bLoQpspt0WUPpslbXlGRlK6C+yReFXn
         uXavOHst6QtATEojB7IK4+EeVM+aTNqOIaQyQ=
Received: by 10.204.120.193 with SMTP id e1mr7598423bkr.147.1246312864944;
        Mon, 29 Jun 2009 15:01:04 -0700 (PDT)
Received: from localhost (host-78-13-59-48.cust-adsl.tiscali.it [78.13.59.48])
        by mx.google.com with ESMTPS id g28sm10584245fkg.15.2009.06.29.15.01.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 15:01:04 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1246312854-3365-7-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122475>

The empty alt text optimizes screen estate in text-only browsers.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 862ea99..6a1b5b5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1574,6 +1574,7 @@ sub git_get_avatar {
 		       "<img width=\"$size\" " .
 		            "class=\"avatar\" " .
 		            "src=\"$url\" " .
+			    "alt=\"\" " .
 		       "/>" . $post_white;
 	} else {
 		return "";
-- 
1.6.3.rc1.192.gdbfcb
