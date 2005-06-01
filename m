From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Using cvs2git to track an external CVS project
Date: Thu, 2 Jun 2005 00:35:09 +1200
Message-ID: <46a038f905060105358e24723@mail.gmail.com>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Jun 01 14:37:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdSS8-0001AY-Ol
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 14:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVFAMiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 08:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVFAMiE
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 08:38:04 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:17540 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261372AbVFAMfK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 08:35:10 -0400
Received: by rproxy.gmail.com with SMTP id i8so2251013rne
        for <git@vger.kernel.org>; Wed, 01 Jun 2005 05:35:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ff3u5inzimiR1z10oRtbaAgw/h/pI5Ax/tqe3wZbs5MXjZv9n6fMF4OgkWS8HNMb9GAeQfOBDRGfXn83NbkncTow7VerlIjvOUM01TMyCuqOIbkUCpEGwNCV2KAui0Nqs6O4bhBU5/lrmtOvsw1KY1tvYfjWSJ77fw80W5YgRqU=
Received: by 10.38.150.9 with SMTP id x9mr2295666rnd;
        Wed, 01 Jun 2005 05:35:09 -0700 (PDT)
Received: by 10.38.101.46 with HTTP; Wed, 1 Jun 2005 05:35:09 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Following the cvs2git threads, I'm left with a few doubts.

Linus has stated that it can be used incrementally to track a project
that uses CVS -- in which case I assume I would be maintaining two git
repos, one strictly tracking "upstream", pulling changes from CVS on a
crontab, and the 2nd one with my local changes. Or is it meant to work
on the "local" repo as a pull/merge/update?

What'd be the strategy in that case if I am working on patches that I
intend to feed upstream? To what degree will git try and remerge
against the local repo where the patch originates from? This kind of
smarts are nice when they work -- but I am interested in exploring
more git-style approaches, if git supports this at all.

In the scenario above, if I push _some_ patches upstream, does git
help me at all in sorting out what is upstream and what is not?

I suspect all this patch-based horsetrading amounts to cherry-picking,
and is therefore not supported. What strategy would work with git to
run local branches with a mix of patches that go upstream and others
that don't (or just may take longer to get there).

Right now we are using arch where a long-lived branch tracks
theexternal cvs repo, and we open short-lived branches where we do a
mix of development -- most of which is merged upstream in several
stages.

cheers,


martin
