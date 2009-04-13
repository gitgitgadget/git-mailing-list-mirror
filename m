From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH] builtin-merge: fix a typo in an error message
Date: Mon, 13 Apr 2009 14:10:08 -0400
Message-ID: <20090413181008.GA8273@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:15:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtQdN-0001cO-1m
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbZDMSKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbZDMSKT
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:10:19 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:1266 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbZDMSKR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:10:17 -0400
Received: by an-out-0708.google.com with SMTP id d14so2154211and.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=+38uqZTbKDeE6pDBxi2yExZ5ogzoGAEGNAoZZ8XD6Q0=;
        b=fkDZe0XPht/npSwRqaeZIRkheQ1QZXoCaD1WJ0bbWtfPgraIx+AAU6KyS7oU9gmFtD
         SuwNJlHwh2f9BY9ZEOZnXRM0zfmomNOpXP6S0+yG0ed3tFFImh9QwGIalwmjLH+oAnwx
         Bb5Bows48WOzaVZ8FKb2R/cjIGm2hyAdT8sfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=W2dvQRE7/60+YGNhRhZ8QtujWwkMA3U4QaoE6fVzYZRBI1lHZIvEBCczfsiB7Rx3Aq
         lAzP6QOGAJ7YW8Dw0rBe48XW1TKAO+Nd+w0gBKPvlXvKRke9ojahMPTZSnfAm3DHjg8p
         MWOtQ7ksV0vfQ8oBRrN+q4WI7xbN0DKSxVx2w=
Received: by 10.142.180.20 with SMTP id c20mr2712126wff.174.1239646214953;
        Mon, 13 Apr 2009 11:10:14 -0700 (PDT)
Received: from linux.vnet (n1-13-232.dhcp.drexel.edu [129.25.13.232])
        by mx.google.com with ESMTPS id 22sm19100283wfd.6.2009.04.13.11.10.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 11:10:12 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116457>


Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---
 builtin-merge.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 6a51823..0b58e5e 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -764,7 +764,7 @@ static int suggest_conflicts(void)
 
 	fp = fopen(git_path("MERGE_MSG"), "a");
 	if (!fp)
-		die("Could open %s for writing", git_path("MERGE_MSG"));
+		die("Could not open %s for writing", git_path("MERGE_MSG"));
 	fprintf(fp, "\nConflicts:\n");
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
-- 
1.5.6.3
