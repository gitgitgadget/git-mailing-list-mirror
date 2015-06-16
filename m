From: Albert Netymk <albertnetymk@gmail.com>
Subject: git-describe manual page's one sentence summary is misleading
Date: Tue, 16 Jun 2015 12:45:35 +0200
Message-ID: <CAKEGsXTY_rstoK4Gcga6XqkqKCeOkXdL-TjAWUu0Cqi6mWW7bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 12:46:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4oNb-0007Kz-VF
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 12:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbbFPKp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 06:45:59 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36058 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbbFPKp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 06:45:57 -0400
Received: by obctg8 with SMTP id tg8so8504205obc.3
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 03:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=+j7M/vPl0kSO+OjcGNZOiAxihM5TwwzUWNd4lribkpM=;
        b=NJmD4Uc9WAsPzcm4BzjjgpUIiEIfIZhXeQWjyVh8ofx/Yh/Ny3m9OLVg5xBnSAiYC5
         kGtooEYksteEDRrUSPVv1Vm7z8mjf4QuhK7yXH38iOe0wJhXqPUPRP3UYgFB9Kp2Mmk6
         bF+OLXbD46LEoBC624S8gab0PMuua09wDuGoHg6+QtEnZdPG5Ga0ikm2EDeOYiMCEekw
         C45j/dBqWB17gX1fVE+4nzbKrj4I0VYGDH1vmiCE8Q0gCWDLpNBHB9NqO3X6d++7FeH0
         wNFIOjWkt3JOmR/RRY4DcBTTlyuS0zVViAroEKNlOIrsdzcWsMFEWr9No32C0Wk/KzvY
         CebA==
X-Received: by 10.202.177.68 with SMTP id a65mr26662558oif.64.1434451555972;
 Tue, 16 Jun 2015 03:45:55 -0700 (PDT)
Received: by 10.202.174.5 with HTTP; Tue, 16 Jun 2015 03:45:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271747>

According to the man of git-describe, http://git-scm.com/docs/git-describe

git-describe - Show the most recent tag that is reachable from a commit

It means that this command shows the name of the most recent tag.

However, actually, it construct a new tag name if the current commit
is not tagged.

I think, "git-describe - Describe a commit using the most recent tag
reachable from it" is a better summary.

-- 
Best Regards

Yours faithfully
Albert Netymk
