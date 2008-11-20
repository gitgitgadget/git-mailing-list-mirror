From: Jonas Fonseca <fonseca@diku.dk>
Subject: [TopGit PATCH] README: Fix spelling
Date: Thu, 20 Nov 2008 14:51:02 +0100
Message-ID: <1227189062-11951-1-git-send-email-fonseca@diku.dk>
Cc: git@vger.kernel.org
To: madduck@debian.org
X-From: git-owner@vger.kernel.org Thu Nov 20 14:52:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L39xg-00077E-E6
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 14:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417AbYKTNvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 08:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbYKTNvI
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 08:51:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:15223 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417AbYKTNvG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 08:51:06 -0500
Received: by ug-out-1314.google.com with SMTP id 39so280085ugf.37
        for <git@vger.kernel.org>; Thu, 20 Nov 2008 05:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:sender;
        bh=X9TN0YSWA5eXOnkfryJ5fMcPDWglMhUoQODOQnvspEE=;
        b=a0Cgia/39WAmUgfUH7r+/+jKNHwyOhQ1W5wJ5ke8oSUGna35t//RgxYGmIucIyVgMI
         GfYylLAiapHnw50Awf+GCLHXWehc3+bpAPMdjtegfYlxuXB4SV9yAiAMWLdTazQMnM0r
         +4I1Xg8RYnqGH6h/w5Pkgc8rD3bkxDojahYts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:sender;
        b=u81yy911cbZadwEBbKaylp5puGceOYhdQbOyKQiAGJsp920hdFcU9ImzemTRpexOOw
         CRI1gXwiKEgqqUqC/aWuTvMDRLZdGJ7fABA/l0cHVx5v/r/TptmbWKtafRlcakDAVjQF
         eJc5UuZ8FgAFxU9ESJBeL759Tm9oG71ZG3uTA=
Received: by 10.86.50.6 with SMTP id x6mr1563237fgx.71.1227189064196;
        Thu, 20 Nov 2008 05:51:04 -0800 (PST)
Received: from localhost.localdomain (shr01.u.parknet.dk [84.238.113.244])
        by mx.google.com with ESMTPS id d4sm2368811fga.5.2008.11.20.05.51.02
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 20 Nov 2008 05:51:03 -0800 (PST)
X-Mailer: git-send-email 1.6.0.4.983.ga2771.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101431>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
 README[m |   11 [32m+++++[m[31m------[m
 1 files changed, 5 insertions(+), 6 deletions(-)[m

[1mdiff --git a/README b/README[m
[1mindex 5bfe3ee..9e291da 100644[m
[1m--- a/README[m
[1m+++ b/README[m
[36m@@ -22,7 +22,7 @@ version control of patches (reordering of patches is not[m
 version-controlled at all). But there are several disadvantages -[m
 for one, these tools (especially StGIT) do not actually fit well[m
 with plain Git at all: it is basically impossible to take advantage[m
[31m-of the index efectively when using StGIT. But more importantly,[m
[32m+[m[32mof the index effectively when using StGIT. But more importantly,[m
 these tools horribly fail in the face of distributed environment.[m
 [m
 TopGit has been designed around three main tenets:[m
[36m@@ -45,7 +45,7 @@ them.[m
 [m
 As mentioned above, the main intended use-case for TopGit is tracking[m
 third-party patches, where each patch is effectively a single topic[m
[31m-branch.  In order to flexibly accomodate even complex scenarios when[m
[32m+[m[32mbranch.  In order to flexibly accommodate even complex scenarios when[m
 you track many patches where many are independent but some depend[m
 on others, TopGit ignores the ancient Quilt heritage of patch series[m
 and instead allows the patches to freely form graphs (DAGs just like[m
[36m@@ -222,7 +222,7 @@ tg create[m
 [m
 	After `tg create`, you should insert the patch description[m
 	to the '.topmsg' file, which will already contain some[m
[31m-	pre-filled bits. You can set topgit.to, topgit.cc and topgit.bcc[m
[32m+[m	[32mprefilled bits. You can set topgit.to, topgit.cc and topgit.bcc[m
 	configuration variables in order to have `tg create`[m
 	add these headers with given default values to '.topmsg'.[m
 [m
[36m@@ -350,7 +350,7 @@ tg export[m
 	in the cleaned up history (corresponding basically exactly[m
 	to `tg patch` output for the topic branch).[m
 [m
[31m-	The command has two posible outputs now - either a Git branch[m
[32m+[m	[32mThe command has two possible outputs now - either a Git branch[m
 	with the collapsed history, or a quilt series in new directory.[m
 [m
 	In case of producing collapsed history in new branch,[m
[36m@@ -455,7 +455,6 @@ tg update[m
 [m
 	TODO: tg update -a for updating all topic branches[m
 [m
[31m-TODO: tg depend for adding/removing dependencies smoothly[m
 TODO: tg rename[m
 [m
 [m
[36m@@ -485,7 +484,7 @@ whatever Cc headers you choose or the post-three-dashes message.[m
 When mailing out your patch, basically only few extra headers[m
 mail headers are inserted and the patch itself is appended.[m
 Thus, as your patches evolve, you can record nuances like whether[m
[31m-the paricular patch should have To-list/Cc-maintainer or vice[m
[32m+[m[32mthe particular patch should have To-list/Cc-maintainer or vice[m
 versa and similar nuances, if your project is into that.[m
 From is prefilled from your current GIT_AUTHOR_IDENT, other headers[m
 can be prefilled from various optional topgit.* config options.[m
-- 
tg: (f17218e..) jf/readme-update (depends on: master)
