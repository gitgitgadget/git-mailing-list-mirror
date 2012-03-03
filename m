From: David Barr <davidbarr@google.com>
Subject: [RFC] "Remote helper for Subversion" project
Date: Sat,  3 Mar 2012 23:27:26 +1100
Message-ID: <1330777646-28381-1-git-send-email-davidbarr@google.com>
Mime-Version: 1.0
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 03 13:29:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3o5d-000578-JA
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 13:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437Ab2CCM3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 07:29:00 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:61737 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab2CCM27 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 07:28:59 -0500
Received: by dadp12 with SMTP id p12so2963763dad.11
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 04:28:58 -0800 (PST)
Received-SPF: pass (google.com: domain of davidbarr@google.com designates 10.68.134.33 as permitted sender) client-ip=10.68.134.33;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of davidbarr@google.com designates 10.68.134.33 as permitted sender) smtp.mail=davidbarr@google.com; dkim=pass header.i=davidbarr@google.com
Received: from mr.google.com ([10.68.134.33])
        by 10.68.134.33 with SMTP id ph1mr10516606pbb.81.1330777738756 (num_hops = 1);
        Sat, 03 Mar 2012 04:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:to:cc:subject:date:message-id:x-mailer;
        bh=pGnvwSKbYf0p+SvFegnXddm3eaDShtQj1HF0vFzaAeQ=;
        b=PoFVvgcSnbbM0IpqZ/ApwUOoUf0LHS2T3D+pUITSOtJRhnpFqC3gSaXYwnZuS/dkuI
         3kLXeLSKOivoZHdCfHPiJPzF7tcLWrZ/I/05tE81cDKE+lRh7oS/3XDNp1DleVcbSvEC
         3ZFAsaDvVEFdouADaQcGxJGQ9Pbetxd/1zuzYrubcdGUkyCo+OPZ3WDUdkTnD0Blk1OQ
         BgBHerGIqrNVD5s+PCEO5CVK5EW15tZ2Q4XR6egVBVVY3kL724/qUK2zqPsi7HeKIf41
         GkPSjBb7R8zJV/AZfOU20mOI5O2tD2/w6D1N7dx3YV+0uNdjyg8dBEMcBEbLw53m6j1e
         K9mQ==
Received: by 10.68.134.33 with SMTP id ph1mr8965520pbb.81.1330777738715;
        Sat, 03 Mar 2012 04:28:58 -0800 (PST)
Received: by 10.68.134.33 with SMTP id ph1mr8965470pbb.81.1330777738475;
        Sat, 03 Mar 2012 04:28:58 -0800 (PST)
Received: from localhost.localdomain (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id m5sm7698671pbo.69.2012.03.03.04.28.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 04:28:57 -0800 (PST)
X-Mailer: git-send-email 1.7.9
X-Gm-Message-State: ALoCoQmnoUDY8p4xWPTmDyUcZHluH2rbYnusrg66W2wL7JnQrN/ac2NepR5eLoHZQaBV1kLWqS+/Isb/nQ99oUV42hiy0RCZ/FqtOTaXKV+lIA5sJo84ZZCa3KHPw2IRZiCXFsMA7D9kpXU0XV6zNYDi8sJ1Q2VoZy/ZLyKUeiZZqHbxP4uVHdw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192106>

---
 SoC-2012-Ideas.md |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

 This is simply the direct translation of last year's project idea.
 This project make significant incremental progess each year.
 I'm seeking feedback from all involved on setting the direction.

 --
 David Barr

diff --git a/SoC-2012-Ideas.md b/SoC-2012-Ideas.md
index 5e83342..4c2ab05 100644
--- a/SoC-2012-Ideas.md
+++ b/SoC-2012-Ideas.md
@@ -182,3 +182,29 @@ this project.
 
 Proposed by: Thomas Rast  
 Possible mentor(s): Thomas Rast
+
+Remote helper for Subversion
+------------------------------------
+
+Write a remote helper for Subversion. While a lot of the underlying
+infrastructure work was completed last year, the remote helper itself
+is essentially incomplete. Major work includes:
+
+* Understanding revision mapping and building a revision-commit mapper.
+
+* Working through transport and fast-import related plumbing, changing
+  whatever is necessary.
+
+* Getting an Git-to-SVN converter merged.
+
+* Building the remote helper itself.
+
+Goal: Build a full-featured bi-directional `git-remote-svn` and get it
+      merged into upstream Git.  
+Language: C  
+See: [A note on SVN history][SVN history], [svnrdump][].  
+Proposed by: David Barr  
+Possible mentors: Jonathan Nieder, Sverre Rabbelier, David Barr
+
+[SVN history]: http://article.gmane.org/gmane.comp.version-control.git/150007
+[svnrdump]: http://svn.apache.org/repos/asf/subversion/trunk/subversion/svnrdump
-- 
1.7.9
