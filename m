From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 16/19] Update SYNOPSIS
Date: Sat, 9 Mar 2013 19:29:52 +0000
Message-ID: <CALeLG_=A8G76ALi3gNpQsKfhVW7BbZA=HiMWSuUuNBXDwU_t6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:30:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPTI-0004nj-9H
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297Ab3CIT3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:29:54 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33299 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab3CIT3x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:29:53 -0500
Received: by mail-ob0-f176.google.com with SMTP id v19so2182158obq.7
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:29:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=f2PDlMZY/62fBYDLxYnqdjk04gIAy2YsPu8k11Ep6p4=;
        b=LWK0C3uoZ/CEQnocxHHvSIFocKcYUZchrxKEe/T1XXLzX3rcfBuPkAogGiLWueMj5C
         +ardnpAJ8jNjwAX2qPlPcqXT5jXDG7oyLmlDgHAFIvvFMWGL4fW0HG1rF21qQWfdbgk5
         voe7XA+pVMkPjUuq1A8CcRyhgQTYQ0dqkhrD16tYzUu1xeNoU0zTeeMbpSSxMvTw4Q5+
         9DqKuH5SxELr9U26rDSMYfb06i5WIcubgJQQ5Cs2cewxoneS5a6bBkIOsWHOWrv8YBYp
         Kau0AskJ4M+UbjTvP9+sQTMPJ1SwZzEHTa8Cu+xKaewvrEUYVyuxJYH6fhtDxyNdNbBe
         tRAw==
X-Received: by 10.182.116.70 with SMTP id ju6mr5027643obb.48.1362857393157;
 Sat, 09 Mar 2013 11:29:53 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:29:52 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQmUvbgrc9cEB7pW9cv118X6/4ZpJa48XBDIlMXFLF0arTe6qrD/gh1Bvm6JfXWxai4sFEyn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217754>

>From 6024d877e6c3beebe4c11bd060553d06af422680 Mon Sep 17 00:00:00 2001
From: Paul Campbell <pcampbell@kemitix.net>
Date: Sat, 9 Mar 2013 18:34:54 +0000
Subject: [PATCH 16/19] Update SYNOPSIS

Conflicts:
	contrib/subtree/git-subtree.txt

Original-Author: Herman van Rink <rink@initfour.nl>
Conflicts-resolved-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 48ba158..b485ab5 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -9,13 +9,16 @@ git-subtree - Merge subtrees together and split
repository into subtrees
 SYNOPSIS
 --------
 [verse]
-'git subtree' add   -P <prefix> <refspec>
-'git subtree' add   -P <prefix> <repository> <refspec>
-'git subtree' pull  -P <prefix> <repository> <refspec...>
-'git subtree' push  -P <prefix> <repository> <refspec...>
-'git subtree' merge -P <prefix> <commit>
-'git subtree' split -P <prefix> [OPTIONS] [<commit>]
-
+'git subtree' add   --prefix=<prefix> <repository> <refspec>
+'git subtree' merge --prefix=<prefix> <commit>
+'git subtree' pull  --prefix=<prefix> [<repository> [<refspec>...]]
+'git subtree' pull-all
+'git subtree' push-all
+'git subtree' push  --prefix=<prefix> [<repository> [<refspec>...]]
+'git subtree' split --prefix=<prefix> <commit...>
+'git subtree' from-submodule --prefix=<prefix>
+'git subtree' prune
+'git subtree' diff  --prefix=<prefix> [<repository> [<refspec>...]]

 DESCRIPTION
 -----------
-- 
1.8.2.rc1


-- 
Paul [W] Campbell
