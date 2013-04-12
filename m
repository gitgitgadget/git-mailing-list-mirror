From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/10] compat/nedmalloc: fix spelling in comments
Date: Fri, 12 Apr 2013 00:06:55 -0700
Message-ID: <20130412070655.GG5710@elie.Belkin>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
 <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com>
 <7v4nfch90r.fsf@alter.siamese.dyndns.org>
 <20130412064837.GA5710@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	sunshine@sunshineco.com, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 09:07:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQY4n-0004rd-97
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 09:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851Ab3DLHHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 03:07:05 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:58340 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934Ab3DLHHE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 03:07:04 -0400
Received: by mail-pa0-f41.google.com with SMTP id kx1so1324852pab.14
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 00:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=FIA36L9IZx0kZs5fj8zCOViHKHDf5QuWZ3C9l7gjOtk=;
        b=oQPWpVL5gNmEjHqzYZvU/TM+zmGh6tftf7PL4BA6EH/zuZpZT/tbRlhOw068Odvez+
         n8v0A+2STrKhlDl9NfUDyBv/p2uQGSkwQmLrG8dQD/bSQAFjTQgg1CeNLeChlgvtx15f
         g/RcN/mCnFCXtKsmKzoKergyVSaAT3MB0PTrvDwsI7+tVxVVG5+JAs7UwX7iM0i52Chm
         wqTxydF0D7ANVSgiHPbSEbVw5XGtMATCP/9HaobiQU9cFvcxxjtULBRBqKzpGIxbS0vL
         L+nxUrJUWtnW2EsbK8ayW4irqNYvIOA2tuJ02ZILD3rupiGdG4tmUxSqbz4mkj5TFp5D
         HBNg==
X-Received: by 10.68.164.193 with SMTP id ys1mr12903366pbb.80.1365750423638;
        Fri, 12 Apr 2013 00:07:03 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id lf12sm8307943pab.13.2013.04.12.00.06.59
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 00:07:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130412064837.GA5710@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220964>

From: Stefano Lattarini <stefano.lattarini@gmail.com>
Date: Fri, 12 Apr 2013 00:36:10 +0200

Correct some typos found using Lucas De Marchi's codespell tool.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
These don't seem to be fixed yet in https://github.com/ned14/nedmalloc
(pointed to from http://www.nedprod.com/programs/portable/nedmalloc/).
Would it make sense to write a note to Ned and then import a fixed
version from there?

 compat/nedmalloc/malloc.c.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index ff7c2c4f..1401a672 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -4778,7 +4778,7 @@ void* dlmalloc(size_t bytes) {
 
 void dlfree(void* mem) {
   /*
-     Consolidate freed chunks with preceeding or succeeding bordering
+     Consolidate freed chunks with preceding or succeeding bordering
      free chunks, if they exist, and then place in a bin.  Intermixed
      with special cases for top, dv, mmapped chunks, and usage errors.
   */
@@ -5680,10 +5680,10 @@ History:
 	Wolfram Gloger (Gloger@lrz.uni-muenchen.de).
       * Use last_remainder in more cases.
       * Pack bins using idea from  colin@nyx10.cs.du.edu
-      * Use ordered bins instead of best-fit threshhold
+      * Use ordered bins instead of best-fit threshold
       * Eliminate block-local decls to simplify tracing and debugging.
       * Support another case of realloc via move into top
-      * Fix error occuring when initial sbrk_base not word-aligned.
+      * Fix error occurring when initial sbrk_base not word-aligned.
       * Rely on page size for units instead of SBRK_UNIT to
 	avoid surprises about sbrk alignment conventions.
       * Add mallinfo, mallopt. Thanks to Raymond Nijssen
-- 
1.8.2.1
