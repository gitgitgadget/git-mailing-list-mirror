From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
Subject: [PATCH] Document disabling core.whitespace values trailing-space
 and space-before-tab
Date: Thu, 24 Jul 2008 07:34:06 +0200
Message-ID: <4888144E.8090300@sneakemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080005060106030305090009"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 07:35:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLtTs-00042v-Jx
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 07:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbYGXFeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 01:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbYGXFeK
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 01:34:10 -0400
Received: from morch.com ([193.58.255.207]:42082 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbYGXFeK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 01:34:10 -0400
Received: from [192.168.1.214] (ANice-157-1-37-217.w90-28.abo.wanadoo.fr [90.28.176.217])
	by morch.com (Postfix) with ESMTP id B31EB281B
	for <git@vger.kernel.org>; Thu, 24 Jul 2008 07:35:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89836>

This is a multi-part message in MIME format.
--------------080005060106030305090009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

 From http://article.gmane.org/gmane.comp.version-control.git/68146 I got
the syntax that works:

git config core.whitespace "-trailing-space"

Is it me, or is this not readable from git help config which says:

> A comma separated list of common whitespace problems to notice.  git 
> diff will use color.diff.whitespace to highlight them, and git apply 
> --whitespace=error will consider them as errors:
> 
> ·   trailing-space treats trailing whitespaces at the end of the line
> as an error (enabled by default).

The '-trailing-space' syntax to disable the trailing-space setting is 
not obvious and not documented as far as I can see. I would have assumed 
a value of '' would disable it.

Is there a documentation bug here? If so, I suggest this patch. I didn't 
find anywhere else where the '-setting' syntax was used to disable 
something.

My first-ever git patch is attached, because Thunderbird messes up due 
to wrapping. I realize that SubmittingPatches has a mini-guide for 
reconfiguring Thunderbird (ver 1!), but I really prefer not to have to 
add extensions and reconfigure Thunderbird to send patches. (Comments to 
this and how the patch was made are welcome and encouraged)

Peter


-- 
Peter Valdemar Mørch
http://www.morch.com

--------------080005060106030305090009
Content-Type: text/x-patch;
 name="0001-Document-disabling-core.whitespace-values-trailing-s.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename*0="0001-Document-disabling-core.whitespace-values-trailing-s.pa";
 filename*1="tch"

>From 900455ce5a4e8bf771aea2e3dbdbab38e440cdf4 Mon Sep 17 00:00:00 2001
From: =?utf-8?q?Peter=20Valdemar=20M=C3=B8rch?= <peter@morch.com>
Date: Thu, 24 Jul 2008 07:18:48 +0200
Subject: [PATCH] Document disabling core.whitespace values trailing-space and space-before-tab
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Signed-off-by: Peter Valdemar MÃ¸rch <peter@morch.com>
---
 Documentation/config.txt |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e784805..a198b3c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -361,10 +361,12 @@ core.whitespace::
 	consider them as errors:
 +
 * `trailing-space` treats trailing whitespaces at the end of the line
-  as an error (enabled by default).
+  as an error (enabled by default - disable with 'git config core.whitespace
+  "-trailing-space"').
 * `space-before-tab` treats a space character that appears immediately
   before a tab character in the initial indent part of the line as an
-  error (enabled by default).
+  error (enabled by default - disable with 'git config core.whitespace
+  "-space-before-tab"').
 * `indent-with-non-tab` treats a line that is indented with 8 or more
   space characters as an error (not enabled by default).
 * `cr-at-eol` treats a carriage-return at the end of line as
-- 
1.5.6


--------------080005060106030305090009--
