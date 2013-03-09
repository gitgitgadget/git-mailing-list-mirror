From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 15/19] Document from-submodule and prune commands
Date: Sat, 9 Mar 2013 19:29:20 +0000
Message-ID: <CALeLG_kmQdyoHokna-Mg3ctFDDVxLwFLHKMcC8PDk99-Ez1+Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:29:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPSm-0004JB-2h
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307Ab3CIT3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:29:21 -0500
Received: from mail-oa0-f45.google.com ([209.85.219.45]:62991 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab3CIT3V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:29:21 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so3298872oag.18
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=449WOGUre3P3gGza7lmEoLHH1LUk0ASv8tGSFm/XOdU=;
        b=gGH+BA53UXCcp/jSYN8S4+WDDBdrq1RvpZOChi2tOLmKV+0jbXHv5inzg/2RBHM2Z0
         YNPW+VlVbt6IywwWaMxJOCRyrC/oFyPdZ5RfQxeCoTAEFf4yisK22k6xn2Hxz75GS4SH
         fN/flmnWdqpR7+sMKWdD8sJlQ1Uug+kph0lRvZrj+aj5Uyi3zaEctF2l1Vj3kCsyXdVg
         nF3B51vvrvq0cwbN3njLS+6KGYdcihZRGtBlexe0CRqSdToDIelhFrl05bV2nj+igJ/U
         pA7WPcUQjY4X507NRCc0fYEryp/wTNfPDDR97NGDysW8XJ0xPQDzzyJcOYKzaavQnwFb
         Gf7g==
X-Received: by 10.60.14.226 with SMTP id s2mr5064683oec.124.1362857360620;
 Sat, 09 Mar 2013 11:29:20 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:29:20 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQmOzUPADwEwOLxb6HjZ+bWGnhqn1E48oPqw0HvC/848n2vTVS15iPnxqt3d8Y4U3CqviAgl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217753>

>From 6dc8119a7d99f7107e32f2c5d7ec18b9fd93a6b8 Mon Sep 17 00:00:00 2001
From: Herman van Rink <rink@initfour.nl>
Date: Tue, 27 Mar 2012 14:14:54 +0200
Subject: [PATCH 15/19] Document from-submodule and prune commands

---
 contrib/subtree/git-subtree.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index c8fc103..48ba158 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -129,6 +129,16 @@ split::
 	Note that if you use '--squash' when you merge, you
 	should usually not just '--rejoin' when you split.

+from-submodule::
+	Convert a git submodule to a subtree.
+	The module is removed from the .gitmodules file and
+	the repo contents are integrated as a subtree.
+
+prune::
+	Cleanup .gittrees entries for which the subtree nolonger exists.
+
+diff::
+	TO BE DOCUMENTED

 OPTIONS
 -------
-- 
1.8.2.rc1


-- 
Paul [W] Campbell
