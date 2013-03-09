From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 14/19] Document pull-all and push-all
Date: Sat, 9 Mar 2013 19:28:54 +0000
Message-ID: <CALeLG_kdXMb8wAyAL7T9jXk3sT85uJeiNh+v3jz9tKcf25VA9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:29:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPSM-0003w8-Dz
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284Ab3CIT24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:28:56 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:51539 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab3CIT2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:28:55 -0500
Received: by mail-ob0-f171.google.com with SMTP id x4so2234266obh.30
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=28UVTK22CcUCIUD7BFk4GMhTVFeh/MFszS2gllRHIfE=;
        b=jON9qPXjG5S2m2+mVJmaj8NRvRPkzGWjP9TNrC80l42HwOlwHK6Rq4VGVHSylq46Fh
         FgWfjC0VbOTwhNrGGFySuJB2H+oroQR8Esf9MM4fV1RpqdcMpw/Ge240qHDo27mW5pLM
         VrIMmj8gA7eoyzTBS/ut91MhtW8PvAG6Yy0Jz7ApsD6ewuqAHoome5e7NzTwALpQ89K+
         TCucHCWlTteKSQWG8G5aGcf84DnP7PW4B+RfVLub3lw6iWLFIHvLPxIUL1Ccq8jlQyko
         koWCxwDB4bs5OsqUlLxYepG+QeoHx3eLCpADhRViMfpLKP/JGfOLCxZfqOKboksZ6Hms
         qtmw==
X-Received: by 10.182.222.101 with SMTP id ql5mr5024689obc.55.1362857334638;
 Sat, 09 Mar 2013 11:28:54 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:28:54 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQmYQ8vci7kmOO6qrWsk8Tk4mT9CjzRhHxW8ohauWf+vljjXA1XkwmIvrrSVlyVegLREPF6z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217751>

>From 7dcd40ab8687a588b7b0c6ff914a7cfb601b6774 Mon Sep 17 00:00:00 2001
From: Herman van Rink <rink@initfour.nl>
Date: Tue, 27 Mar 2012 13:59:16 +0200
Subject: [PATCH 14/19] Document pull-all and push-all

---
 contrib/subtree/git-subtree.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index e0957ee..c8fc103 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -92,13 +92,19 @@ pull::
 	Exactly like 'merge', but parallels 'git pull' in that
 	it fetches the given commit from the specified remote
 	repository.
-	
+
+pull-all::
+	Perform a pull operation on all in .gittrees registered subtrees.
+
 push::
 	Does a 'split' (see below) using the <prefix> supplied
 	and then does a 'git push' to push the result to the
 	repository and refspec. This can be used to push your
 	subtree to different branches of the remote repository.

+push-all::
+	Perform a pull operation on all in .gittrees registered subtrees.
+
 split::
 	Extract a new, synthetic project history from the
 	history of the <prefix> subtree.  The new history
-- 
1.8.2.rc1


-- 
Paul [W] Campbell
