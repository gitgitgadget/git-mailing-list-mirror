From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/10] obstack: fix spelling of similar
Date: Thu, 11 Apr 2013 23:57:37 -0700
Message-ID: <20130412065737.GE5710@elie.Belkin>
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
X-From: git-owner@vger.kernel.org Fri Apr 12 08:57:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQXvn-0000mz-83
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 08:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680Ab3DLG5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 02:57:51 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:63972 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab3DLG5u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 02:57:50 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so1268641pdj.30
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 23:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=TNyqSrEJt/4d/EGr1JhjUoQWL2r+5vFb1Itmj6LhHMM=;
        b=sbeK7qADY+7Pg5ijXPuXAqivq2EWJ0G5nAnDAzsG7Ci75IyGqL3ton5oJNv/ga0F1z
         0hZYKn2DJ+kn+LWj9UN2BZEa2mX9YnFzyijyXoRFjMsd/7wSZGI0ZiYo791kaHoUSMBI
         SgwUPcuWNobKErEFwPGkASCClM8RLqs2u8iJk4TIZEDO1S8dHQ3Fv2Dwg2gEGVssyNc3
         HCH6vAvKDxk97Vd4TDhUk/VWo4SA+eZ13n7VUsYEykj8FdmPnazzdlP8lBSqvpvFp0S3
         5jKWqyqGuTiHGXywHzONv4EbT7wsJe9WDsJ4ue4PTnTQQK5540C4pBpdpNUH7MEJQ5ZO
         OvLw==
X-Received: by 10.68.210.5 with SMTP id mq5mr783828pbc.44.1365749870363;
        Thu, 11 Apr 2013 23:57:50 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ms9sm7356604pbc.20.2013.04.11.23.57.48
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 23:57:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130412064837.GA5710@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220962>

From: Stefano Lattarini <stefano.lattarini@gmail.com>
Date: Fri, 12 Apr 2013 00:36:10 +0200

Noticed using Lucas De Marchi's codespell tool.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Would it be more useful to fix this in glibc and import from there?

 compat/obstack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/obstack.h b/compat/obstack.h
index d178bd67..ceb4bdbc 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -128,7 +128,7 @@ extern "C" {
 
 #define __BPTR_ALIGN(B, P, A) ((B) + (((P) - (B) + (A)) & ~(A)))
 
-/* Similiar to _BPTR_ALIGN (B, P, A), except optimize the common case
+/* Similar to _BPTR_ALIGN (B, P, A), except optimize the common case
    where pointers can be converted to integers, aligned as integers,
    and converted back again.  If PTR_INT_TYPE is narrower than a
    pointer (e.g., the AS/400), play it safe and compute the alignment
-- 
1.8.2.1
