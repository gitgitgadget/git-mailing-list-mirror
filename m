From: Andreas Krey <a.krey@gmx.de>
Subject: Re: git clean performance issues
Date: Fri, 13 Nov 2015 15:19:07 +0100
Message-ID: <20151113141907.GB16219@inner.h.apk.li>
References: <CAMpP7NY++BwV+UygRj1C6Zsf=jE-z1AQuN3On0HeEqQpKGQtqw@mail.gmail.com> <20150404195507.GA31763@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: erik =?iso-8859-1?Q?elfstr=F6m?= <erik.elfstrom@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 13 15:19:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxFCD-0001s6-L1
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 15:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858AbbKMOTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 09:19:16 -0500
Received: from continuum.iocl.org ([217.140.74.2]:38729 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbbKMOTP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 09:19:15 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id tADEJ7V28556;
	Fri, 13 Nov 2015 15:19:07 +0100
Content-Disposition: inline
In-Reply-To: <20150404195507.GA31763@peff.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281250>

On Sat, 04 Apr 2015 15:55:07 +0000, Jeff King wrote:
...
> I think this is the same issue that was discussed here:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/265560/focus&5585
> 
> There is some discussion of a possible fix in that thread. I was hoping
> that Andreas was going to look further and produce a patch, but I
> imagine he got busy with other things.

That about sums it up. However I now have a similar issue;
git ls-files shows the same behaviour (takes relatively
forever at 100% CPU), and runs instantly with my patch
from back then. Nothing seems to have changed, so I
may have another chance to look into this.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
