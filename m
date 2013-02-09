From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [BUG] can't switch branches with submodules
Date: Sat, 9 Feb 2013 17:55:26 +0530
Message-ID: <CALkWK0=aifKVHnPZSfqE0rLn1aUGqC0nBULaLCe6UY2=6YGZ9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 13:26:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U49VT-0006FZ-Dn
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 13:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775Ab3BIMZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 07:25:48 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:47736 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675Ab3BIMZs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 07:25:48 -0500
Received: by mail-ie0-f176.google.com with SMTP id k13so5972392iea.7
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 04:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=ZQS/+A8rpTuPqe8vChjBCzGMfqWbXbOyYUwvoRsfuvw=;
        b=micvrWvjxYZNepNWND8fD24qenfBJv346p4DaQzA5qp4T8YzFpyJE3iKi82JaCZ8Up
         7M6ZXHvQsiQsLFn7NiuBG/Xpe3v/rpkzKlNb74Voju44gEF1rnMP6ZTC6Ihq/WWQRA/X
         hRVOLQkncppOf1QA3a+JuaqCrsjlm9bvt5l3QKt+/Wp9yI3SmagjJ0qKUiNN62lxZox2
         i/8G92yn7ZhMAzOf5RjV5D9ZY0p0zw+r0koZVTtS7mrc9T9uFpBHqulMyqd1aR3o3X5/
         WJgJ9te4PSXu+fcf9/4T+Sm2EU7tFmX41TkAyrszQVCwO/cUtUv6S3OexS25y027WVG3
         LzCg==
X-Received: by 10.50.237.5 with SMTP id uy5mr7750078igc.12.1360412746539; Sat,
 09 Feb 2013 04:25:46 -0800 (PST)
Received: by 10.64.86.18 with HTTP; Sat, 9 Feb 2013 04:25:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215861>

Hi,

I have two branches: master and gh-pages.  master has one submodule
called foo that gh-pages doesn't.  When I try to check out gh-pages
from master:

    warning: unable to rmdir foo: Directory not empty

And the foo directory exists in my worktree.  This is very annoying,
and I want to fix it now.  Where is this error coming from?  How does
the worktree get updated when I checkout?
