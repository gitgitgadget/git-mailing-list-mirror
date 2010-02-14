From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/6] Fix 'git var' usage synopsis
Date: Sun, 14 Feb 2010 05:55:53 -0600
Message-ID: <20100214115533.GA3499@progeny.tock>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Celis <sebastian@sebastiancelis.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 12:56:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngd53-00071u-AG
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 12:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152Ab0BNLz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 06:55:58 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:62135 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145Ab0BNLz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 06:55:57 -0500
Received: by iwn39 with SMTP id 39so1360791iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 03:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=OcP5veCvj2YK4Q/g7i83Vw9dpAsCF+wZhCEE6vplXp0=;
        b=b2OdMe1hUtGJvOT5Aw6PwJI3BOOpxQGadZh3yhaxSRlYqGCpfAoab4aagXv7HNByMf
         EWswWzsTeLxHXbgqjD/M8nCEoanv7bj07YD5iMFEU44m0ZJpP1eb6/KKKFsnhs3A8R87
         WN1oNIBUfWo1u7zyThk0zOZYfNZvqmZ0epeRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Xy3in9+w3wom+SiFv+F7aevVG0w77yb/lDa0Tg59vipr36AMjT4UbSjl6n6IcwHIse
         2iTr7dfQLnfXVwz16208FBJ2yR0FFpDupU0oRr24Be4VHhEc3N7ygkb+HR/9htt8BoqW
         NCX8VRhCPXG4iTt6BX8A07e9cdU+JUmTYQqDw=
Received: by 10.231.151.197 with SMTP id d5mr1670144ibw.73.1266148557350;
        Sun, 14 Feb 2010 03:55:57 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm5126065iwn.12.2010.02.14.03.55.56
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 03:55:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100214115430.GA1849@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139901>

The parameter to 'git var' is not optional.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Noticed while considering changing the usage.

 Documentation/git-var.txt |    2 +-
 builtin-var.c             |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index bb98182..458f3e2 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -8,7 +8,7 @@ git-var - Show a git logical variable
 
 SYNOPSIS
 --------
-'git var' [ -l | <variable> ]
+'git var' ( -l | <variable> )
 
 DESCRIPTION
 -----------
diff --git a/builtin-var.c b/builtin-var.c
index 2280518..e6ee7bc 100644
--- a/builtin-var.c
+++ b/builtin-var.c
@@ -6,7 +6,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 
-static const char var_usage[] = "git var [-l | <variable>]";
+static const char var_usage[] = "git var (-l | <variable>)";
 static const char *editor(int flag)
 {
-- 
1.7.0
