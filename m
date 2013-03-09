From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 17/19] Document list command
Date: Sat, 9 Mar 2013 19:30:13 +0000
Message-ID: <CALeLG_=J8bS8PdhGUj9tvrVgovBzLEuO+eGS=4p0zvMyxgqfrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:30:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPTg-0005Ch-1G
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319Ab3CITaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:30:15 -0500
Received: from mail-oa0-f53.google.com ([209.85.219.53]:40571 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab3CITaO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:30:14 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so3258744oag.26
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:30:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=EL0NftI6dIA+ouH3IRVunsidFiDIY3APNUScbXIQffY=;
        b=I+4KORdTZxwb9vk1OqnkTa6jJKe8DAzPpS8I0lZd71uu6Dd94QMoh/CijZJOBzMfsD
         gXWFVU0qLJlJ6VFNXdndiXvy6zBoPHhhFiDfljBZdtF2E/JUxiMChWoF1tEdLOpzJN+E
         VlRD7Ve9cj2lGrl6W21sA3uc3P4blXuTjKUF3s69TFShw04yl6XcteApeSA7H+ltRcGf
         OOL9Uip/Su9UKnp3YXwF0MFkl6xlCSkobqTuX+Vothj/hT8qoAbe9XuEUNThALDYOu1k
         hZ3wgD20YPKvSjJPmds970VI87Qbdgkscth6cclm0y606j8UXmGaP20rdz8XK6mbjVSh
         04+A==
X-Received: by 10.60.20.193 with SMTP id p1mr5180582oee.133.1362857413607;
 Sat, 09 Mar 2013 11:30:13 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:30:13 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQljATsmNhT1NiNph98e43opPgmCzLXksbqTRbHnpIiJya7e0/T56quG3slRWK6EvM+10JTb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217755>

>From fed80cb47dffcb805a7808e8574dda44992363b0 Mon Sep 17 00:00:00 2001
From: Paul Campbell <pcampbell@kemitix.net>
Date: Sat, 9 Mar 2013 18:35:18 +0000
Subject: [PATCH 17/19] Document list command

Conflicts:
	git-subtree.sh

Original-Author: Herman van Rink <rink@initfour.nl>
Conflicts-resolved-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh  | 1 +
 contrib/subtree/git-subtree.txt | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 84c90c7..4605203 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -15,6 +15,7 @@ git subtree pull  --prefix=<prefix> <repository> <refspec...>
 git subtree pull-all
 git subtree push-all
 git subtree push  --prefix=<prefix> <repository> <refspec...>
+git subtree list
 git subtree split --prefix=<prefix> <commit...>
 git subtree diff  --prefix=<prefix> [<repository> [<refspec>...]]
 git subtree from-submodule --prefix=<prefix>
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index b485ab5..385bde8 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 'git subtree' pull-all
 'git subtree' push-all
 'git subtree' push  --prefix=<prefix> [<repository> [<refspec>...]]
+'git subtree' list
 'git subtree' split --prefix=<prefix> <commit...>
 'git subtree' from-submodule --prefix=<prefix>
 'git subtree' prune
@@ -108,6 +109,9 @@ push::
 push-all::
 	Perform a pull operation on all in .gittrees registered subtrees.

+list::
+	Show a list of the in .gittrees registered subtrees
+
 split::
 	Extract a new, synthetic project history from the
 	history of the <prefix> subtree.  The new history
-- 
1.8.2.rc1


-- 
Paul [W] Campbell
