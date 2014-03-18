From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Rebasing merge commits
Date: Tue, 18 Mar 2014 13:11:06 -0500
Message-ID: <CAHd499BFAmfDAjNr0RhCiy4vEBn2xJzCtTmwrB-U51qJryB+Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 18 19:11:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPyTq-0001x0-8Y
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 19:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580AbaCRSLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 14:11:09 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:50610 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788AbaCRSLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 14:11:08 -0400
Received: by mail-vc0-f171.google.com with SMTP id lg15so7663939vcb.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 11:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=EIfhcfvYGpAUigocVivyMLwZPlX8CaUf5HjZD7YW1Sk=;
        b=lUuMdqm+uKOPe9ayBBlRMF2USGpCQ1mSL8MC1JoENWqkw1vQcIggQuV9+RmdMLfJyS
         WWo8pTCw/6OUp3dFujV0fdFQ/w8iQz3RNfm3AvTXWMKMVlLlLw11nDL5ck92ERUAWlL4
         3V1oD0hCkksmLEK1X9CT+noJSOPtJc7P2gPwxqI6QN7k62wyJupS0PrLOgSfZBy4lJRX
         p8HzrBrnktUZSRgCdSARTrYylJX5AswmnmfFl6+LbEi/rYhUvQVaMt9q3x9xXe/AdDD7
         NOESGfH5WV+xddGnBAe/R416KgGKPdIff1tv3H9SaX0jggMdLZ71UCpblZN3VKkssLI+
         sQ8Q==
X-Received: by 10.58.37.232 with SMTP id b8mr5594930vek.27.1395166266739; Tue,
 18 Mar 2014 11:11:06 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.2.79 with HTTP; Tue, 18 Mar 2014 11:11:06 -0700 (PDT)
X-Google-Sender-Auth: CtQ20XzA4HQd86UJ1ISvMIVTYv8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244364>

What's the general recommendation on rebasing after creating a merge
commit on my branch? I realize rebase has the -p option but it seems
like it does a lot of complicated stuff, and it discourages
interactive rebase with the option.

My situation is simple: I have a topic1 branch that has a few commits
on it. During my work, I notice someone else implements a small bug
fix that I need. I do a `git merge --no-ff` to force that into my
branch as a separate merge commit. After that, I continue my work on
my local topic1 branch as usual. When I want latest from master, I do
`git rebase master`. However now that I have a merge commit on my
branch, things get complicated.

What's a good workflow for this, since it seems pretty common?
