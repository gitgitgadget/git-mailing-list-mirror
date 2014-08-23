From: Jonh Wendell <jonh.wendell@gmail.com>
Subject: [PATCH 2/2] describe: Add documentation for "--abbrev=+"
Date: Sat, 23 Aug 2014 14:13:22 -0300
Message-ID: <1408814002-6553-3-git-send-email-jonh.wendell@gmail.com>
References: <1408814002-6553-1-git-send-email-jonh.wendell@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 19:13:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLEsl-0006M9-UU
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 19:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbaHWRNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 13:13:31 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:51702 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbaHWRN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 13:13:29 -0400
Received: by mail-yk0-f182.google.com with SMTP id q9so9491163ykb.27
        for <git@vger.kernel.org>; Sat, 23 Aug 2014 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ekypeN6y0FR6E8Te+4z44M1ikTDmjWWI81f3xbNf4nY=;
        b=LA4941ikysJKMtqGzC/EjEZDut1VFg5spCezIps9+tVJKiIWQSbMcrO5vqlSYcIAAx
         F5bXRXM4C8HetSvZ39alCL6NRD3HR+9JHeFeXLzjaut/b+OM2C9q+k035l8gIEFr6azS
         bZhcPrn4rwGrSPGBjJXku2vSYd1bF6QBMlO+4y8C/9YSnOzy2CHKBvlBCxgfidcSK4t7
         0hznAL9aCYX3OhB9F1V/b7xHCDhGNYJE9qO6b+v7QaMIL4pD22BgJ+hi3JLHw2YpDXvd
         K9A6j26TY3DDjUHgcGzmH8CTxDhtaQxcMEWN0Wu6+Ab1kaKmF0rNjdo1DlhGtmLHy0zU
         u0OQ==
X-Received: by 10.236.86.101 with SMTP id v65mr18041461yhe.103.1408814009148;
        Sat, 23 Aug 2014 10:13:29 -0700 (PDT)
Received: from jwendell-mobl1.amr.corp.intel.com ([187.37.207.144])
        by mx.google.com with ESMTPSA id s9sm1485471yhp.39.2014.08.23.10.13.28
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Aug 2014 10:13:28 -0700 (PDT)
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1408814002-6553-1-git-send-email-jonh.wendell@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255758>

---
 Documentation/git-describe.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index d20ca40..e291770 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -54,6 +54,12 @@ OPTIONS
 	abbreviated object name, use <n> digits, or as many digits
 	as needed to form a unique object name.  An <n> of 0
 	will suppress long format, only showing the closest tag.
+	+
+	+
+	A special case of <n> equals to "\+" (without quotes) will print
+	just a "+" sign instead of the whole suffix. This is useful if you
+	only need to know if the supplied <commit-ish> points to an exact
+	match or if there are commits between the tag found and the <commit-ish>.
 
 --candidates=<n>::
 	Instead of considering only the 10 most recent tags as
-- 
1.9.3
