From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 06/19] merging change from nresni
Date: Sat, 9 Mar 2013 19:25:11 +0000
Message-ID: <CALeLG_kZbizBdXsYe-uu7ouZ_Y4Kuj88oPV0XgcjQ1Dfki+BrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:25:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPOo-0000nE-Av
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191Ab3CITZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:25:13 -0500
Received: from mail-oa0-f54.google.com ([209.85.219.54]:51628 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab3CITZM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:25:12 -0500
Received: by mail-oa0-f54.google.com with SMTP id n12so3288310oag.13
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=lNqYpzFIut5hJjrlrT8vhShcANGT2yaxu1hsdJOuLUQ=;
        b=iyMY1NrJKe00b/RRUcgy8nm9rDDBM2KcsCBeRjQApIpW3zHnGx9wZUkSYBoz3FxPcX
         Y1vuR5oY+kXHOVxXZzZzESd1P+hPg141XyqsOgYxHIoFkaDm0wYdyFwn+pViKQ6amqUf
         xT+dfHK77fjSfitSSuiHq69+/V92qc59RG8S/aei/zdQYRhFsmk7xe+LjP91pa+QAv3a
         IqHRHCEyG+yzXb99glqXfqXZ3kL38Fo+DCoJ4AQ+/OmzTD0Lk4U1hPxEPzm9ksJ9ZsAw
         FLgphrIT0qUy2duO13dmwfNMSN4a0y/FMuoh6kuMZwkXjIu/4w6c0XM3sYtm686j/5MT
         sLvA==
X-Received: by 10.60.22.34 with SMTP id a2mr5040489oef.97.1362857111568; Sat,
 09 Mar 2013 11:25:11 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:25:11 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQkvyDMIyzWErIVjx7cMpiKdBZLcqVbiMqUxaX64kR7ubKWbQIw7kI25q0BA+0eWmZPO2voH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217743>

>From b6c810480547966c73bcaaea4c069fe73dacbc05 Mon Sep 17 00:00:00 2001
From: Paul Campbell <pcampbell@kemitix.net>
Date: Sat, 9 Mar 2013 18:32:24 +0000
Subject: [PATCH 06/19] merging change from nresni

manual merge at the moment...i'll try a proper merge next now that
formatting is cleaner

Conflicts:
	git-subtree.sh

Fixes hidden carriage return

Original-Author: mhoffman <matt.hoffman@quantumretail.com>
Conflicts-resolved-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 74e4c74..8056851 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -605,8 +605,7 @@ cmd_split()
 	eval "$grl" |
 	while read rev parents; do
 		revcount=$(($revcount + 1))
-		say -n "$revcount/$revmax ($createcount)
-"
+		say -ne "$revcount/$revmax ($createcount)\r"
 		debug "Processing commit: $rev"
 		exists=$(cache_get $rev)
 		if [ -n "$exists" ]; then
-- 
1.8.2.rc1


-- 
Paul [W] Campbell
