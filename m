From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: syntax for checking out specific tag on a remote
Date: Sat, 11 Aug 2007 21:33:02 -0400
Message-ID: <9e4733910708111833r6588557al1876bd6aaae38204@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 03:33:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK2Kc-00019I-5W
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 03:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925AbXHLBdG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 21:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbXHLBdF
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 21:33:05 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:58547 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbXHLBdD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 21:33:03 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1379888wah
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 18:33:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EPl9gP/OCDi4WYjq8ZwVZnYkNJMSw637wfob45jm1NDji1zTXPpT435+rLO+CAbQtbm0hdwtm/wzFknGvQztJkhj0qOALof45IR/Pstz+81VpR+qlI7wj//YxSqeDr9MkqTL1Pa3YQ4sEBbSIrwhtMM9Zw7LMM5D5EHO3nZunuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QipXOHUr5i+YdSCiQs0AuZF4VmchcVVbkLXhhPzjf6oWAo9FwfXWRuqFM6VgTJ+fL+Xe+sXeJSjqSSUdtJUcC6puwmJ5EWs2c/Yb7KJhJRgdCfmsyKnsj6ZViFmXoP+PQyPxM0pbLPQnel7PlCoAFoSamQyvXUlkviM67mG0bBM=
Received: by 10.114.175.16 with SMTP id x16mr2930782wae.1186882382389;
        Sat, 11 Aug 2007 18:33:02 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Sat, 11 Aug 2007 18:33:02 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55655>

What's the syntax for checking out a specific tag on a remote?

I tried:
git checkout -b my19 linus/master/v2.6.19
git checkout linus/master/v2.6.19
git checkout linus/v2.6.19

jonsmirl@terra:/home/linux$ git remote show linus
* remote linus
  URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git


-- 
Jon Smirl
jonsmirl@gmail.com
