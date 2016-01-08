From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] docs: say "commits" in the --depth option wording for
 git-clone
Date: Fri, 8 Jan 2016 10:18:21 +0100
Message-ID: <568F7EDD.9020003@gmail.com>
References: <n6j1cs$p4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 10:18:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHTBq-0006OL-Df
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 10:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521AbcAHJS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 04:18:29 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34077 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496AbcAHJSY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 04:18:24 -0500
Received: by mail-wm0-f43.google.com with SMTP id u188so129158572wmu.1
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 01:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=3fA7HMQnpNmiLsAW5yDx9NKd0pBio8JWPcVDMf3k7Iw=;
        b=D6RoxfCLhnePpRfqcQOY63XTa6ZQFagsS5OUwDFkn38iIuFd8RrBB9xXozloAw8jRv
         8az9YKjWiX9lW8szWMpzdYvt1INuLK0Vw/jQiF5hdUoFHzIBsKgsbHSPdA22RZRykh3+
         Hp0htVdAR7HY5GV4Z0eAZVVBmkcaZ1Bljaa2Tymuh6RT1H/h/ywquTPqUFBQi4hcAEO1
         b5oFA2tjbSa8lWyW1DZErBtl2WtYERALTkiRbrbltMjQiwA3am90TS4lHibne9tELi24
         Qa88oYkDxJzw13Qd8kjStCOKyTCvbQX+pkeu4u6S/KhpZKSlYt/PyyNo5tr3l+GbYbOv
         rHoQ==
X-Received: by 10.194.243.103 with SMTP id wx7mr129478135wjc.136.1452244703401;
        Fri, 08 Jan 2016 01:18:23 -0800 (PST)
Received: from [10.223.62.214] ([131.228.216.134])
        by smtp.googlemail.com with ESMTPSA id un6sm104991805wjc.34.2016.01.08.01.18.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jan 2016 01:18:22 -0800 (PST)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <n6j1cs$p4$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283529>

It is not wrong to talk about "revisions" here, but in this context
revisions are always commits, and that is how we already name it in the
git-fetch docs. So align the docs by always referring to "commits".
---
 Documentation/git-clone.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 943de8b..789b668 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -190,7 +190,7 @@ objects from the source repository into a pack in the cloned repository.
 
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
-	specified number of revisions. Implies `--single-branch` unless
+	specified number of commits. Implies `--single-branch` unless
 	`--no-single-branch` is given to fetch the histories near the
 	tips of all branches.
 
-- 
2.7.0.windows.1
