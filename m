From: Paul Collins <paul@briny.ondioline.org>
Subject: Re: What's in git.git tonight
Date: Sun, 06 Nov 2005 21:07:45 +0000
Message-ID: <87mzkh8oym.fsf@briny.internal.ondioline.org>
References: <7v3bmayu2r.fsf@assigned-by-dhcp.cox.net>
	<86acgiujuk.fsf@blue.stonehenge.com>
	<87y8427zvn.fsf@briny.internal.ondioline.org>
	<868xw2t1vg.fsf@blue.stonehenge.com>
	<86u0eqrm64.fsf@blue.stonehenge.com>
	<7vmzkhy5on.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 22:14:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYrok-0003Aa-2Y
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 22:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVKFVMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 16:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVKFVMZ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 16:12:25 -0500
Received: from jenny.ondioline.org ([66.220.1.122]:10513 "EHLO
	jenny.ondioline.org") by vger.kernel.org with ESMTP
	id S1750800AbVKFVMY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 16:12:24 -0500
Received: by jenny.ondioline.org (Postfix, from userid 10)
	id F3F32AE22; Sun,  6 Nov 2005 21:12:23 +0000 (GMT)
Received: by briny.internal.ondioline.org (Postfix, from userid 1000)
	id 2126EF933; Sun,  6 Nov 2005 21:07:46 +0000 (GMT)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <7vmzkhy5on.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 06 Nov 2005 10:47:20 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11228>

Junio C Hamano <junkio@cox.net> writes:

> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>
>> And, I've confirmed that this patch does the trick, and will probably
>> defer any other issues with "optional" packages in the future:
>
> Thanks.  Next time around could you sign-off your patch?

A tiny nit:

---

Consistency is the hobgoblin of small minds, and mine is tiny indeed.
Do not search the current directory when including expat.h, since it
is not supplied by git.

Signed-off-by: Paul Collins <paul@briny.ondioline.org>

diff --git a/http-push.c b/http-push.c
index c10067c..89fda42 100644
--- a/http-push.c
+++ b/http-push.c
@@ -7,7 +7,7 @@
 
 #include <curl/curl.h>
 #include <curl/easy.h>
-#include "expat.h"
+#include <expat.h>
 
 static const char http_push_usage[] =
 "git-http-push [--complete] [--force] [--verbose] <url> <ref> [<ref>...]\n";


-- 
Dag vijandelijk luchtschip de huismeester is dood
