From: Alexander Litvinov <lan@academsoft.ru>
Subject: Re: Collecting cvsps patches
Date: Thu, 15 Jun 2006 09:21:34 +0700
Organization: AcademSoft Ltd.
Message-ID: <200606150921.34690.lan@academsoft.ru>
References: <20060611122746.GB7766@nowhere.earth> <46a038f90606111516v2c8c68e2v818a0a0f9dca2da6@mail.gmail.com> <20060611224205.GF1297@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 15 04:22:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqhUg-00063C-Ia
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 04:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWFOCVv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 22:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWFOCVv
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 22:21:51 -0400
Received: from gw.ac-sw.com ([81.1.223.2]:14802 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S1750740AbWFOCVu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 22:21:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 0CC33BDDD; Thu, 15 Jun 2006 09:21:47 +0700 (NOVST)
Received: from gw.ac-sw.com ([127.0.0.1])
 by localhost (gw.ac-sw.com [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 11608-09; Thu, 15 Jun 2006 09:21:37 +0700 (NOVST)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP
	id C95CEBDC5; Thu, 15 Jun 2006 09:21:37 +0700 (NOVST)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id B9FC18D943C5; Thu, 15 Jun 2006 09:21:37 +0700 (NOVST)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 3336E8D943C2;
	Thu, 15 Jun 2006 09:21:35 +0700 (NOVST)
To: Yann Dirson <ydirson@altern.org>
User-Agent: KMail/1.8
In-Reply-To: <20060611224205.GF1297@nowhere.earth>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21876>

Your master branch is not compilable. This is the fix for it.

---
 cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cache.c b/cache.c
index 409392d..2b2179a 100644
--- a/cache.c
+++ b/cache.c
@@ -501,7 +501,7 @@ static void dump_patch_set(FILE * fp, Pa
        struct list_head * tag;
        for (tag = ps->tags.next; tag != &ps->tags; tag = tag->next)
        {
-            TagName* tagname = list_entry (tag, TagName, tagnames);
+            TagName* tagname = list_entry (tag, TagName, name);

            fprintf(fp, " %s %d%s", tagname->name, tagname->flags,
                    (tag->next == &ps->tags) ? "" : ",");
--
1.4.0
