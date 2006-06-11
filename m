From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Problem upgrading to 1.4.0
Date: Sun, 11 Jun 2006 09:37:16 +0930
Message-ID: <93c3eada0606101707t5eb35a4du3ebd0fd17737943f@mail.gmail.com>
Reply-To: geoff@austrics.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jun 11 02:07:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpDUG-0005Gg-Mz
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 02:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWFKAHS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 20:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWFKAHS
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 20:07:18 -0400
Received: from wx-out-0102.google.com ([66.249.82.196]:16441 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750769AbWFKAHR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 20:07:17 -0400
Received: by wx-out-0102.google.com with SMTP id h28so670288wxd
        for <git@vger.kernel.org>; Sat, 10 Jun 2006 17:07:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gPrPFKvEZkXMBp15BXXtFbAWeAaM7q4FxjB21WCdjcleq8Os2LlDE/MAsvGakm7BhsRraYjJpIk+ualezjNjG+YT7/WZ0oYeNSGJYnq0O7q11xynBUCsTagsaXfxi1KUdury75O/laxY9gWPkzLR5GEj7thMkTrcqyj6hSqGyKM=
Received: by 10.70.25.1 with SMTP id 1mr2603278wxy;
        Sat, 10 Jun 2006 17:07:16 -0700 (PDT)
Received: by 10.70.133.1 with HTTP; Sat, 10 Jun 2006 17:07:16 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21629>

Hi,

When I do a "git pull origin" I get messages:

             error: no such remote ref refs/heads/gb/diffdelta
             error: no such remote ref refs/heads/jc/bind
             error: no such remote ref refs/heads/jc/bind-2
             ...
             Fetch failure: git://git.kernel.org/pub/scm/git/git.git

So I figured these branches were "in the way" so I deleted them:

                git branch -D gb/diffdelta
                etc.

Again "git pull origin" gives the same errors.

So I went into .git/remotes/origin and
removed the lines pointing at these branches and removed the gb and jc
directories
and did another git pull and it seems to have worked.

I would suggest that when the pull detects the missing remote ref, it
should clean
up the remotes/origin file. Or have I done entirely the wrong thing?

Cheers,
Geoff Russell.
