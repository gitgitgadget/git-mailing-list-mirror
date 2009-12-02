From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Describe (possible) gitweb.js minification in gitweb/README
Date: Wed,  2 Dec 2009 22:14:36 +0100
Message-ID: <1259788476-9697-1-git-send-email-jnareb@gmail.com>
References: <7vaay2tkfh.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 22:15:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFwXv-0000rG-Ji
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 22:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316AbZLBVPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 16:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755266AbZLBVPX
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 16:15:23 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:45021 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120AbZLBVPX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 16:15:23 -0500
Received: by fxm21 with SMTP id 21so786376fxm.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 13:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DGRQmpMeF9FC0JDFbkPkb2Xj2UtfOrnwtgfyzvG1g18=;
        b=fFUBP2OxGOYjalIxGi5Vy9k6z5jSbw9oFhzC3fSNi37xCOPCjP2Lune9KihCEGRj+s
         cx1DQ7pSdAVm+ytkGpdrWZ37Rs26VA2OhfeaYXGx2wegH+w4JNBFVG/qwLqUbRyoMPzm
         +ABMZ5A/ExqJa3dtm7kNSbDZ917Ytn6lt8+sU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EU4XNBRCJWjV6KeIwpvxeiXiKQBdppjjoX6Bi9OyTTiiMuFsDZTCm6nvvbgH3eHkg9
         iocml5Q5Z4Wx3IwTzrJ4YxsGfd8BrLm5SgV6gzeS/b5hIPuZPZ1XqyWs76mQwMPDeGwI
         1zH4xckbu+L3dJnLzQFZzAF8eG1E1vU1hcJo4=
Received: by 10.103.48.19 with SMTP id a19mr215467muk.136.1259788528076;
        Wed, 02 Dec 2009 13:15:28 -0800 (PST)
Received: from localhost.localdomain (abvj160.neoplus.adsl.tpnet.pl [83.8.207.160])
        by mx.google.com with ESMTPS id i7sm4122183mue.46.2009.12.02.13.15.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Dec 2009 13:15:25 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nB2LEw37009729;
	Wed, 2 Dec 2009 22:15:03 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nB2LEg0n009727;
	Wed, 2 Dec 2009 22:14:42 +0100
X-Mailer: git-send-email 1.6.5.3
In-Reply-To: <7vaay2tkfh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134401>

On Tue, 1 Dec 2009, Junio C Hamano wrote:

> * jn/gitweb-blame (2009-11-24) 8 commits.
>   (merged to 'next' on 2009-11-25 at 0a5b649)
>  + gitweb.js: fix padLeftStr() and its usage
>  + gitweb.js: Harden setting blamed commit info in incremental blame
>  + gitweb.js: fix null object exception in initials calculation
>  + gitweb: Minify gitweb.js if JSMIN is defined

This commit is somehow missing description of JSMIn in gitweb/README
from the original patch.  Here is its completion.

>  + gitweb: Create links leading to 'blame_incremental' using JavaScript
>   (merged to 'next' on 2009-10-11 at 73c4a83)
>  + gitweb: Colorize 'blame_incremental' view during processing
>  + gitweb: Incremental blame (using JavaScript)
>  + gitweb: Add optional "time to generate page" info in footer
> 
> With two more changes to disable this by default to make it
> suitable as "new feature with known breakages" for 1.6.6

-- >8 --
Subject: [PATCH] gitweb: Describe (possible) gitweb.js minification in gitweb/README

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/README |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index b69b0e5..e34ee79 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -95,7 +95,8 @@ You can specify the following configuration variables when building GIT:
  * GITWEB_JS
    Points to the localtion where you put gitweb.js on your web server
    (or to be more generic URI of JavaScript code used by gitweb).
-   Relative to base URI of gitweb.  [Default: gitweb.js]
+   Relative to base URI of gitweb.  [Default: gitweb.js (or gitweb.min.js
+   if JSMIN build variable is defined / JavaScript minifier is used)]
  * GITWEB_CONFIG
    This Perl file will be loaded using 'do' and can be used to override any
    of the options above as well as some other options -- see the "Runtime
-- 
1.6.5.3
