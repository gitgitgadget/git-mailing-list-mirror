From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Small team cogito/git setup
Date: Thu, 18 Aug 2005 16:14:30 +1200
Message-ID: <46a038f9050817211446684aac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Aug 18 06:15:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5bnk-0001RX-65
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 06:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVHREOc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 00:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVHREOc
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 00:14:32 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:16683 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932123AbVHREOb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 00:14:31 -0400
Received: by rproxy.gmail.com with SMTP id i8so252341rne
        for <git@vger.kernel.org>; Wed, 17 Aug 2005 21:14:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tJfpp87j+XUfAYIUxF15LBg0LwZ4MV+oEtQat+Mwst4B1Fh+Z9UOIe8SZD2TFYQVdsC+hfxzJrWuNOuFhRv3TvDpr8KHrStYVkS8urFHLmoxPL/xe0JwLalsZt9+AvWuZu5qz9kGhGdWW62ok7b4HxIZ526GfRqrAmn0pxL0aTU=
Received: by 10.38.75.6 with SMTP id x6mr438941rna;
        Wed, 17 Aug 2005 21:14:31 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Wed, 17 Aug 2005 21:14:30 -0700 (PDT)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

We have a small team of 3, and our main activity is to run local
branches of upstream projects, plus some local development. In that
context, I am designing our cogito/git usage strategy, and I'm
interested in comments.

My intention is to use cogito as much as possible, and insulate our
team from git internals. I find that using cogito is actually easier
than cvs, and a mile easier than Arch (the two tools we use currently)
and I rather keep it that way: simple.

The upstream projects run on CVS, so I am setting up a repo fed by
git-cvsimport for each of those. We all pull from that repo
(cg-clone), so we can all see the upstream in its git representation.
Now, we are going to run a few branches off that, and I want to have
those branches _teamwide_ with the same name, so it is trivial for us
to keep synching.

All our work directories on our LAN will available via HTTP, so we can
pull from the team repositories easily. Is there a good technique with
cogito to have a team pull from each other, so that a single cg-update
or cg-pull when working on a branch pulls from all my teammembers.

Or are we forced to run an 'integration' repo so that we work with a
'star' arrangement? I am actually trying to avoid needing a central
repo if possible.

How should branch creation be handled for team-wide branches? I'd like
to have branches use the same name across the team to avoid confusion.

Phew. Every time I think I understand how things go with git, I find I
don't know sh*t about it yet ;)

martin
