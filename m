From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Regarding the determinacy of 'git describe'
Date: Fri, 16 Jan 2015 14:29:17 +0100
Message-ID: <20150116132917.GB7660@inner.h.apk.li>
References: <20150116130113.GA3220@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 14:29:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YC6xr-0006bG-HY
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 14:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755976AbbAPN3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 08:29:24 -0500
Received: from continuum.iocl.org ([217.140.74.2]:57877 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631AbbAPN3T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 08:29:19 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id t0GDTH804743;
	Fri, 16 Jan 2015 14:29:17 +0100
Content-Disposition: inline
In-Reply-To: <20150116130113.GA3220@inner.h.apk.li>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262550>

To follow up on myself, this is the output of 'git describe --debug
--tags' and 'git log --oneline --decor --parents' for each of the
two repos.

The one irritating thing is that in two of them the inital commit is
not the bottommost in the log output.

To make my expectation more concrete: I would expect 'git describe'
to output the tag where the number of commits that are in HEAD but not
in the tag is the lowest, and that would (always) be the bl-1 here.


=== /tmp/tmp-ws-20150116-11061-169bt1w

searching to describe HEAD
 lightweight        3 r2.4/bl-1
 lightweight        4 r2.4/bl-0
traversed 5 commits
r2.4/bl-1-3-gd760b4b

d760b4b 6e15dfc d905814 (HEAD, origin/r2.4/feature-2, r2.4/feature-2) Merge branch 'r2.4/master' into r2.4/feature-2
6e15dfc ad4e371 feature: 1st part
d905814 86f7fcf (origin/r2.4/master, origin/HEAD, r2.4/master) main: 3rd commit
86f7fcf ad4e371 (tag: r2.4/bl-1) main: 2nd commit
ad4e371 (tag: r2.4/bl-0, origin/sidestep) module: initial

=== /tmp/tmp-ws-20150116-11355-v7zfcc

searching to describe HEAD
 lightweight        4 r2.4/bl-0
 lightweight        4 r2.4/bl-1
traversed 5 commits
r2.4/bl-0-4-g689e350

689e350 93d9eb5 d768596 (HEAD, origin/r2.4/feature-2, r2.4/feature-2) Merge branch 'r2.4/master' into r2.4/feature-2
93d9eb5 e17d86b feature: 1st part
d768596 6e35c9c (origin/r2.4/master, origin/HEAD, r2.4/master) main: 3rd commit
e17d86b (tag: r2.4/bl-0, origin/sidestep) module: initial
6e35c9c e17d86b (tag: r2.4/bl-1) main: 2nd commit

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
