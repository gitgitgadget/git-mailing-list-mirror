From: Adrian Stern <adrian.stern@unchained.ch>
Subject: How to merge only existing files but not delete missing files
Date: Wed, 11 Jun 2014 13:39:24 +0200
Message-ID: <CAOHZ5L7pvpj+U4rbbgXhw7G8pkESXj3gB1caoEphMVSGEnqtnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 13:39:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WugsM-0006de-PM
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 13:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbaFKLj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 07:39:27 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34772 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbaFKLj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 07:39:26 -0400
Received: by mail-lb0-f180.google.com with SMTP id p9so4606109lbv.25
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 04:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=zELLfOgWv4CuTopriK658CY9LW+agDOoIssOWbgNoZU=;
        b=EMovDgfT9lU8dLaDo4Hqd6LRn49uHXVXwAp3Gxqo6Je8o5g6JtzUzZfo3z1kzGbsve
         TiqqBlrJr1k/COkEoaxVUcdkrlX2UOmNvaLb+umyicFEq8qf4r0a+CJOrFFHg/Ore387
         GIpbtex9QbxIKp7sY5942TjiWoyLzVlT5R/UV2L4TZ8SxG88CllmQH/NgGS1jyzkYCdb
         j7M71wG77Znr4M/Fes68KA7Eo/ehS5D2lAV8f1dQiIdq2UhzQylHmpEyBAU+PufBcVXK
         TKEGU7+E9GBVc7ZmXuG511uC5Lqn816EIWy9345VzfMaIbGVRsrsHmShjvNGqxEJZSkN
         1Fkw==
X-Gm-Message-State: ALoCoQmaFK9veg41JJp3wH0Me9JSv8Stol8Iz4wEK4bnmHG7eLQ4uL43D/Ph8y6ZAKk3eNUwVC2E
X-Received: by 10.112.67.35 with SMTP id k3mr25369594lbt.17.1402486764745;
 Wed, 11 Jun 2014 04:39:24 -0700 (PDT)
Received: by 10.114.61.163 with HTTP; Wed, 11 Jun 2014 04:39:24 -0700 (PDT)
X-Originating-IP: [147.88.200.112]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251363>

Hi

I'm trying to find a setup which allows me to interact with a
writeprotected repository.

Orig: This is a SVN repo which i cannot check out with git svn. Dunno
why, but thats not the problem. I just create a new Git branch and
check it out inside. After the merge, this repo can be deleted.

Delta: This Git repo containes only files changed from Orig.

This means that Delta containes a subset of files from Orig. The
changes in Delta will have to be applied to Orig before compliling.

So i have tried various approaches and killed/recreated my Git repo a
fiew times already. All i really want to do is merge the files from
Delta into Orig while keeping the changes of Delta. But since Delta is
a subset of Orig, all files not included in Delta will get deleted.

How i expected it to work:

1. create branch Orig and check out latest source from svn
2. merge files from Delta into orig but do not delete anything

But with this all the files not present in Delta will be deleted in Orig.

I guess i just don't understand how Git really works. But there are no
tutorials for this specific situation. So what can i do?

regards,

Adrian Stern
