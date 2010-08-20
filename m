From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 17/17] Documentation: remove stray backslashes from
 "Fighting regressions" article
Date: Fri, 20 Aug 2010 05:40:31 -0500
Message-ID: <20100820104031.GQ10407@burratino>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:42:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmP3H-0007Er-Da
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697Ab0HTKmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 06:42:20 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61333 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab0HTKmS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 06:42:18 -0400
Received: by ywe9 with SMTP id 9so505665ywe.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xhY06RIeT6q3xDDcw1z2P4tU9fsiyhDps1ZliC77h5o=;
        b=qewUhoQmuCWu80egbaAihLRQguJnrTF5uU87853oOr6IhaLgpUnYFT4ETYVS8YzIkx
         nhl4xlR6MhX93NSSbwVAkTqo7/rNyKOX+SyPBimNxJWYVM1TRmDlEHJzzYD89VnRcnu8
         D+cY43mcoPo1aTwPneraPmL02EJ4SlZSuC20w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wBXIG+N7vxhPi66u7JvUKCF/8aDzT2VhjPt596gc6WxVznkg19kdMxACs6lQaqQf5a
         J4IeX/wGgeWYAFHxkmYtlpaK/KXqd/QRKjl1+tfk8eWe9yHA7dsz94OEqrRYcF+5KJH6
         utOTqqZO2TogKjU+nryCv3VtU9ijcV3h+H0Ho=
Received: by 10.90.82.5 with SMTP id f5mr998585agb.110.1282300937543;
        Fri, 20 Aug 2010 03:42:17 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id j2sm2502212iba.18.2010.08.20.03.42.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:42:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820101902.GA10356@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154012>

The intended text is "it's O(N * T) vs O(N * T * M)".  Asciidoc
notices the spaces around the asterisks so there is no need to
escape them (and if you try, it passes the backslashes through).

Cc: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  Thanks for reading.

 Documentation/git-bisect-lk2009.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index 86b3015..ed5ea29 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -873,7 +873,7 @@ c * N * T + b * M * log2(M) tests
 where c is the number of rounds of test (so a small constant) and b is
 the ratio of bug per commit (hopefully a small constant too).
 
-So of course it's much better as it's O(N \* T) vs O(N \* T \* M) if
+So of course it's much better as it's O(N * T) vs O(N * T * M) if
 you would test everything after each commit.
 
 This means that test suites are good to prevent some bugs from being
-- 
1.7.2.2.536.g42dab.dirty
