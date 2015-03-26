From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] docs: Clarify "preserve" option wording for git-pull
Date: Thu, 26 Mar 2015 21:11:21 +0100
Message-ID: <551467E9.8080409@gmail.com>
References: <CAHGBnuMcKAhW+_Ho8X1kzZd3B57ogu2Anb1nuPmKwRQD=OYrZQ@mail.gmail.com> <xmqqh9t7zmkt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 21:11:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbE7p-0004rL-6H
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 21:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbbCZUL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 16:11:27 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35670 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016AbbCZUL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 16:11:26 -0400
Received: by wgdm6 with SMTP id m6so77109258wgd.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2015 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=d5dYcjoy0Xs2nDPTWGdGlnGW5Wiq4Hc+A66IRjdjs+A=;
        b=eB6L9w2vYW3ZrStzgdhePRRuuAVEvJbpuGVP0y2bgeB61DVNbGiHT70batbNxcrBG3
         UjhiaFrpo7pMRjV//wrblRma5FKHZevbiuYhQycvAS20t4viebtCccGzK1ZRvu3QfK/U
         PScIQnch5OAgBxVDS3y+E5nUhAe8VktbFpTZfylhdxh9bFZA9pbWTO9WTBigqjxKT9Oz
         fxiqgvLjxb+4J1Kk7QYzYXR0I/4lyzBym//aCHX3WA/je9O+Vxx+QMF9S1yYteaYFu47
         +HNU2Eqb/Dm9XyzK0esk1S7O1aeM/D+0E+hb0c8vvaMP+etirX4nrNzHNX7mZ8rZ9JHc
         V0Bw==
X-Received: by 10.180.78.202 with SMTP id d10mr50655593wix.25.1427400684878;
        Thu, 26 Mar 2015 13:11:24 -0700 (PDT)
Received: from [192.168.188.20] (p4FF45F99.dip0.t-ipconnect.de. [79.244.95.153])
        by mx.google.com with ESMTPSA id i5sm400537wiz.0.2015.03.26.13.11.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2015 13:11:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <xmqqh9t7zmkt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266343>

Before this path, the "also" sounded as if "preserve" was doing a rebase
as additional work that "true" would not do. Clarify this by omitting the
"also" and rewording the sentence a bit.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-pull.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index d3d236c..712ab4b 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -111,9 +111,8 @@ include::merge-options.txt[]
 	was rebased since last fetched, the rebase uses that information
 	to avoid rebasing non-local changes.
 +
-When preserve, also rebase the current branch on top of the upstream
-branch, but pass `--preserve-merges` along to `git rebase` so that
-locally created merge commits will not be flattened.
+When set to preserve, rebase with the `--preserve-merges` option passed
+to `git rebase` so that locally created merge commits will not be flattened.
 +
 When false, merge the current branch into the upstream branch.
 +
-- 
1.9.5.msysgit.1
