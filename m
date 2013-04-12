From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/10] kwset: fix spelling in comments
Date: Fri, 12 Apr 2013 00:09:10 -0700
Message-ID: <20130412070910.GI5710@elie.Belkin>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
 <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com>
 <7v4nfch90r.fsf@alter.siamese.dyndns.org>
 <20130412064837.GA5710@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	sunshine@sunshineco.com, git@vger.kernel.org,
	Fredrik Kuivinen <frekui@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 09:09:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQY6v-00085X-RT
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 09:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab3DLHJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 03:09:19 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:53008 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab3DLHJS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 03:09:18 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so1261052pde.9
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 00:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=8+4StLSkiproir2N9vO8aCvI/FU9k7ykJDsOQ0DKvV4=;
        b=uvWvufscXWiZouoXAzPqhjtv/CgaPqyaol1m5/x/w1zDx9YeZ+/1vWy+UG2qYU8g17
         ATzj2gqYKziFuXfmoQ5OvEZ8frhyTH4yE83ncRvk5Ly/xW558UOtlvOIHIHFvDChPb6M
         PouebOCO4QsDazSNAX/vOgtn7LrAim7O4RP4Zo2bewMnpmjqI4BPK6bfUus47ntvVcp2
         tQTgVgDXauJNqqx4ek9LTECOyo42vcKkmInPRurv6k8RVAz8/ZSA5Ey5tUMCE3EWWtXY
         Oc7tmdMBslpnvOCWU8fdLBNPpU3bbmWYB8Yd3/9ex1dvlNSRhTyYal0LhQLt/yIcMa2G
         C63g==
X-Received: by 10.66.21.38 with SMTP id s6mr3298159pae.103.1365750557066;
        Fri, 12 Apr 2013 00:09:17 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id xl10sm8309726pac.15.2013.04.12.00.09.14
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 00:09:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130412064837.GA5710@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220966>

From: Stefano Lattarini <stefano.lattarini@gmail.com>
Date: Fri, 12 Apr 2013 00:36:10 +0200

Correct spelling mistakes noticed using Lucas De Marchi's codespell
tool.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Git might be the canonical upstream for the GPL-2+ version of this
code.

 kwset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kwset.c b/kwset.c
index 51b2ab6c..5800999b 100644
--- a/kwset.c
+++ b/kwset.c
@@ -26,7 +26,7 @@
    The author may be reached (Email) at the address mike@ai.mit.edu,
    or (US mail) as Mike Haertel c/o Free Software Foundation. */
 
-/* The algorithm implemented by these routines bears a startling resemblence
+/* The algorithm implemented by these routines bears a startling resemblance
    to one discovered by Beate Commentz-Walter, although it is not identical.
    See "A String Matching Algorithm Fast on the Average," Technical Report,
    IBM-Germany, Scientific Center Heidelberg, Tiergartenstrasse 15, D-6900
@@ -435,7 +435,7 @@ kwsprep (kwset_t kws)
 	  /* Update the delta table for the descendents of this node. */
 	  treedelta(curr->links, curr->depth, delta);
 
-	  /* Compute the failure function for the decendents of this node. */
+	  /* Compute the failure function for the descendants of this node. */
 	  treefails(curr->links, curr->fail, kwset->trie);
 
 	  /* Update the shifts at each node in the current node's chain
-- 
1.8.2.1
