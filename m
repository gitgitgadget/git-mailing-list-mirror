From: Daryl Van Den Brink <daryl.vandenbrink@maptek.com.au>
Subject: Gitk "External diff" broken when using worktree
Date: Thu, 24 Mar 2016 13:25:41 +1030
Message-ID: <CAC4jX8FWs30v-Vh7XyPP9_ba3HKd4hAhRBrwfMpBPZd5ku8rUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 03:55:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aivR6-00081d-Vu
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 03:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755043AbcCXCzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 22:55:43 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36408 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbcCXCzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 22:55:43 -0400
Received: by mail-yw0-f182.google.com with SMTP id g3so43724905ywa.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 19:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maptek-com-au.20150623.gappssmtp.com; s=20150623;
        h=mime-version:date:message-id:subject:from:to;
        bh=uDCPr1kWI5zkLrL5N94HMcNO8wUc2RFGaXcRgYPq+rI=;
        b=VKROH8r9Zw3vhTWaIxFB/tsBhOpAQlMQJtrBlyFoKOnlWdqEphztggxXMU19/+Dec+
         vCXI3JcfIvQEV863qxrUEyBLsyw1Z35tdYpV7ICVYEHhXjvtFPUglejgyJTEnJ0MyqC8
         qxMlphVRrl5cLf+GPV4XweAdvXCKRhFufBKVKE3nxYdWzv25tbgGKwwfCM+yb/NAr1ad
         hJprmPIwvluQFH6o8mbgMcsEgTM/aWqChhgUG48o+wT63Cfl0Tqd8MuCd6KjV21Ur+A4
         O7wI33v3hsjD+GCwjxoWZr3a97ZEe72CiztSB9PCyP24qtinl34jjkNvUxHGx9n9bsyz
         qpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uDCPr1kWI5zkLrL5N94HMcNO8wUc2RFGaXcRgYPq+rI=;
        b=cX7H+vZrmH0s3B8Nct9/C5JFXeGojqO1lOKcqLZfXh2G3pncfSV9R6nLMMgZSmlP7l
         J/d4Jo02s04iF9ThzTCukMQdasHIYPFQcgQxsjbZqVUZsGW4PdcTBZu68tAIawTDphcb
         4UyWSHTP35DpFaVLjKFQCUSRfpeNkahXDtjDFYmUpDnZ89eNx96Jk4tChYKjb6T2thTE
         sNbXD1AXhezDsexFNwQnmzmd7JXudXl8kDEIJnf+F/FsnmkYDXPH9CJkpf1LPzYAhE+l
         cIBULOB8Dpb+gao3wfbjuSGE0X6GZ+16291po0TkiSCw+srRBSEKogXQfro+GfpAdLhI
         /0ZA==
X-Gm-Message-State: AD7BkJKcHvzr6JvjRCwnYqJvUgRmOU2GTpB+I3kL2TszDbBDcEUCIwzijt05kQIgDnN1GI1bAPZI9IW0TDZdE2ZF
X-Received: by 10.129.157.2 with SMTP id u2mr3054408ywg.198.1458788141868;
 Wed, 23 Mar 2016 19:55:41 -0700 (PDT)
Received: by 10.37.202.200 with HTTP; Wed, 23 Mar 2016 19:55:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289706>

Hi,

I'm using git 2.7.3 on cygwin, and have been taking advantage of the
new "git worktree" feature. I noticed that when I launch gitk from one
of the attached working directories, its "external diff" feature
doesn't seem to work. Nothing shows up in the diff tool at all.
However, it works if you launch gitk from the main repository.

To reproduce:
1. Create a new working tree with "git worktree add"
2. From that new worktree, launch gitk.
3. Right-click in a file in the bottom right pane and click "External diff"
4. No useful diff appears.

-- 
Daryl van den Brink
