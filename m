From: Luke Diamand <luke@diamand.org>
Subject: git clone - not getting the correct default branch
Date: Wed, 18 Apr 2012 14:05:14 +0100
Message-ID: <CAE5ih7-KmknO8aD=ws-GnUw2RO4fLzscdNYsxkUsFD0Y=28iew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 15:05:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKUZn-0001GQ-LC
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 15:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956Ab2DRNFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 09:05:16 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:46438 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787Ab2DRNFP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 09:05:15 -0400
Received: by wejx9 with SMTP id x9so4702393wej.19
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 06:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :x-gm-message-state;
        bh=gwtyh6sjnpgc7YolkeIJc653R+MCKTt9CA74JrcbFjs=;
        b=SGTC/z5NAF3lFGRYbfOMEVsItybbPpbV9SKQzPMKYujdaf/9FPTkMgu7dlbuJaYs7o
         5uSKWj41paYVVz8JXZgpBc+zbQNU9tRwcGopxzAifZuvYCyby5m8qIDF7LnCGYPrUI4k
         lgIOm85KiTS3tGdePZ6+Eh6GVASngdjjAxgDG6yfI+0FYjDAdSHr+KN4VDUZeegHVt2r
         T27IyWRFZmqItK0t5ViOHtl1pLvUObn0OqqV23p0aZ+EUlNLWTLazg5ou0X8Y6AYny1G
         cHgGnAA0q7NeYCd0sp35gZndixlbRVJZKzZRUjHWbsNn+4otURqBzA9RTI4XA2ki51f+
         FlUQ==
Received: by 10.216.137.30 with SMTP id x30mr1380670wei.34.1334754314074; Wed,
 18 Apr 2012 06:05:14 -0700 (PDT)
Received: by 10.216.204.27 with HTTP; Wed, 18 Apr 2012 06:05:14 -0700 (PDT)
X-Gm-Message-State: ALoCoQmMqaf2bFVU5QGxgAAP2MgKHpPRpCkWnmGCFBnF8gDIAIQYvRBSaPtSzzoDXxlzx3QKW/RA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195864>

A bit weird this.

I have a bare repo (managed with gitolite) which, when I clone it,
always comes up with origin/HEAD pointed to origin/master.

This despite the fact that on the repo, HEAD is a symbolic ref to origin/dev.

i.e.

% git clone git@myserver:myrepo
...
% git branch
* master

% ssh myserver
% cd /path/to/myrepo.git
% cat HEAD
ref: refs/heads/dev

What could be going wrong? Other repos don't have this problem.

Both machines are using 1.7.9.4.

Thanks,
Luke
