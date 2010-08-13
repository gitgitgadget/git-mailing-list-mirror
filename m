From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/2] merge-recursive: Workaround unused variable warning
Date: Thu, 12 Aug 2010 20:09:11 -0600
Message-ID: <1281665352-10533-2-git-send-email-newren@gmail.com>
References: <1281665352-10533-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Johannes Sixt <j.sixt@viscovery.net>,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 04:02:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojjar-0007Bj-Jh
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 04:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761267Ab0HMCB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 22:01:59 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61612 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761191Ab0HMCBv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 22:01:51 -0400
Received: by gwb20 with SMTP id 20so698934gwb.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 19:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=utx6TgrDuERT5xrmitOM4kOuzSIay4XyMBhxqzJ/S4A=;
        b=iA+p+62rFQ2gnO4HlUChLR51g7esni3FWW7NcnrHxU9M7k0uT1k8zNQf9DSRILVV9a
         QyHFts/Fdk9MNBMJmWsVfvfP7eQccB4odDaVx619bF0tUewbqpq551a3iMxETPsjIVKq
         a9nCdIVnuFesU0mSCbqeq8zTdD2vU39ScrnD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vtp0HmlB+1uqR0IGPSWEPzPQjcnDCo7IvYfX9owFGJDMGoXho616RrKwdAly2vtWFy
         Lpjxdg+nsusshG9zaI5ibKtukWVGKU7WwWvxK/uO4E601+RJzKhuM7boBVVluvdRQYiP
         LeUYxqgnfd/mtt+lPjrY/4EuvRGj/qc3rJf/Y=
Received: by 10.231.190.10 with SMTP id dg10mr950290ibb.46.1281664909956;
        Thu, 12 Aug 2010 19:01:49 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id h8sm625597ibk.21.2010.08.12.19.01.47
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 19:01:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.121.gb1ae7a
In-Reply-To: <1281665352-10533-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153458>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9678c1d..7e32498 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1214,6 +1214,7 @@ static int process_df_entry(struct merge_options *o,
 	/* We currently only handle D->F cases */
 	assert((!o_sha && a_sha && !b_sha) ||
 	       (!o_sha && !a_sha && b_sha));
+	(void)o_sha;
 
 	entry->processed = 1;
 
-- 
1.7.2.1.119.gca9fe.dirty
