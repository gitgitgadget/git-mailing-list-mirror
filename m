From: Chris Packham <judge.packham@gmail.com>
Subject: [PATCHv2] Documentation/git-gc.txt: add reference to githooks
Date: Wed, 30 Jun 2010 13:41:27 -0700
Message-ID: <1277930487-13831-1-git-send-email-judge.packham@gmail.com>
References: <4C2A3889.90407@gmail.com>
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 30 22:44:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU48k-0005bM-Et
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 22:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712Ab0F3UoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 16:44:06 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49207 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380Ab0F3UoE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 16:44:04 -0400
Received: by pwj8 with SMTP id 8so432795pwj.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 13:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xQxfc7dfzhIDLNG3aTeObOPCXqZspHGEir4BKPEvSZY=;
        b=DQeWtJgK4GVM5NrNj5lQYhWv56XMsyULThFGPynDalwuXSXEjBg6oKHHr2r9ciB8lN
         TLJI3UoeDbs5EVIOr3aZFrdyHVBS2g769DlyKWi5UoS4o57TO2+SuxBNWR2GlyyzSlCe
         KcU5DCsedpK5J+Jurgdj2xT0hc7l52MNxlau0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NKoMfNctjdxGE+JPvVA5X1wojMBFYczNKdm3JgIflVhX20j738l41TX6NW2zDHKuof
         ZXHY5jCMatfcQDhn25YZMPdZ42DGGt8EahDXXEiBA1pWJ/s3DqWS41McBUfSGbWWi9MP
         e7h4DDIxhQfSKWjX7+u33MDc5/zcLUwcK8MY0=
Received: by 10.114.186.14 with SMTP id j14mr10124279waf.60.1277930643267;
        Wed, 30 Jun 2010 13:44:03 -0700 (PDT)
Received: from localhost.localdomain (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id d35sm65127535waa.9.2010.06.30.13.44.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 13:44:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <4C2A3889.90407@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149996>

This advertises the existence of the 'pre-auto-gc' hook and adds a cross
reference to where the hook is documented.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

I removed the ',if enabled' part from what I suggested on the list. It never
did read quite right to me and I think it just adds confusion to what should be
a simple sentence.

 Documentation/git-gc.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index a9e0882..315f07e 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -137,6 +137,13 @@ If you are expecting some objects to be collected and they aren't, check
 all of those locations and decide whether it makes sense in your case to
 remove those references.
 
+HOOKS
+-----
+
+The 'git gc --auto' command will run the 'pre-auto-gc' hook.  See
+linkgit:githooks[5] for more information.
+
+
 SEE ALSO
 --------
 linkgit:git-prune[1]
-- 
1.7.1
