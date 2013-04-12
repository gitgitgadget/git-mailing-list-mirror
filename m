From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/10] contrib/subtree: fix spelling of accidentally
Date: Thu, 11 Apr 2013 23:54:30 -0700
Message-ID: <20130412065430.GD5710@elie.Belkin>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
 <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com>
 <7v4nfch90r.fsf@alter.siamese.dyndns.org>
 <20130412064837.GA5710@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	sunshine@sunshineco.com, git@vger.kernel.org,
	"David A. Greene" <greened@obbligato.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 08:55:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQXt6-0005Iq-Fv
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 08:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab3DLGzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 02:55:01 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:51857 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab3DLGzA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 02:55:00 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl13so1309234pab.18
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 23:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+lVPhtKFEs9KC2Ng9wUDYc0FCUKpuwLpHq2doS5QPeU=;
        b=Qz3AXLiJ6Tvs6ckKuqTM37NOd1X2bBZqBmBDei4QFx1Svjg5JMSDWGcZwOTitzGTvy
         Qjw1SDuib4zWQ2RlhZ5TXsh7ku3Enl99f+9fDPZRMldpxWvSN0QUWifZS+VwwJKzRCLU
         JSG66zfgaL+qiSTfG9qnsHbQRZORpF5hWyfDNXbyOYapxJdgpETUi31lQIZfHq4QrBK5
         EoBot1+JP0v74Qzavw7tUR7eqZfwKViPyMuL+y9fTBP2D/hcEz9bvV7U2EUPH0lQ2H3x
         7wdLcn/SfcOqyreQhDRv1UIjzQPOwA7MwCuMEkpaTAnj5jGP69nHvZSQeHmgIreGnc4a
         IoRQ==
X-Received: by 10.66.161.33 with SMTP id xp1mr13985801pab.36.1365749700488;
        Thu, 11 Apr 2013 23:55:00 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ux10sm8309689pab.1.2013.04.11.23.54.58
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 23:54:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130412064837.GA5710@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220961>

From: Stefano Lattarini <stefano.lattarini@gmail.com>
Date: Fri, 12 Apr 2013 00:36:10 +0200

Noticed with Lucas De Marchi's codespell tool.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/subtree/t/t7900-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 80d33996..4729521f 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -419,7 +419,7 @@ test_expect_success 'add main-sub5' '
 test_expect_success 'split for main-sub5 without --onto' '
         # also test that we still can split out an entirely new subtree
         # if the parent of the first commit in the tree is not empty,
-        # then the new subtree has accidently been attached to something
+        # then the new subtree has accidentally been attached to something
         git subtree split --prefix subdir2 --branch mainsub5 &&
         check_equal ''"$(git log --pretty=format:%P -1 mainsub5)"'' ""
 '
-- 
1.8.2.1
