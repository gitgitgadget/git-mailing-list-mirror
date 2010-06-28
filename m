From: Chris Packham <judge.packham@gmail.com>
Subject: [PATCH/RFC] Documentation/git-gc.txt: add reference to githooks
Date: Mon, 28 Jun 2010 10:07:14 -0700
Message-ID: <1277744834-7546-1-git-send-email-judge.packham@gmail.com>
References: <AANLkTikjbu_q6QToVUeNAAL0Fls9eQ5BZkzZ1-8L93zh@mail.gmail.com>
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jun 28 19:09:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTHqD-0007wI-TG
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 19:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab0F1RJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 13:09:45 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55923 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab0F1RJo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 13:09:44 -0400
Received: by pvg2 with SMTP id 2so2045194pvg.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 10:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AC2LlWzjGSMyEOA+yEXVBDVgGloIrD0dlVS4pBTdtw0=;
        b=mB1pQ81uiYAQ4e6Ou7LBpfvV6Nla3oOCu9YOQ0FJ2ESwBOoaxAMVLQsHvVcEdncQrJ
         e7TtJ9SjpMC+3sN0xiHnyeDH9HzwqFJgJ1/WpQb8VqqFviKKg8VLIHICTxLHfRSWciV9
         Lu5kPXSk50+oepBtSkI9vO3nNGzOIrdMfPTj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YLqhDv6CaJYsjdmWMpFcld8+0JoeaxA/OMb2gO354lBTbgLjD2SgXj2fekoELTnlNf
         4PrSjeiFYnWHsyNNlFpoACR4tiuuZHv16tOIvfmTSHdB67H8oQr19JGSWPotgh5zqJW8
         Q0jNm/TUHQo/+RI3skqGFeZYq0D1EYt7dQ99c=
Received: by 10.115.81.31 with SMTP id i31mr5734247wal.140.1277744983781;
        Mon, 28 Jun 2010 10:09:43 -0700 (PDT)
Received: from localhost.localdomain (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id s29sm38245729wak.14.2010.06.28.10.09.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 10:09:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <AANLkTikjbu_q6QToVUeNAAL0Fls9eQ5BZkzZ1-8L93zh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149842>

This advertises the existence of the 'pre-auto-gc' hook and adds a cross
reference to where the hook is documented.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
I had to go fishing in the code to find out about the pre-auto-gc hook. From
reading the git-gc man page it wasn't obvious to me that there would be a hook
for 'git gc --auto'. The relevant config variables are mentioned so it seems
logical to mention the hooks also. The only precedent I found for this was in
the git-commit man page which has a section listing the hooks that are
available.

 Documentation/git-gc.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index a9e0882..a514c52 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -137,6 +137,11 @@ If you are expecting some objects to be collected and they aren't, check
 all of those locations and decide whether it makes sense in your case to
 remove those references.
 
+HOOKS
+-----
+This command can run `pre-auto-gc` hook.  See linkgit:githooks[5] for more
+information.
+
 SEE ALSO
 --------
 linkgit:git-prune[1]
-- 
1.7.1
