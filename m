From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 7/9] Add the accurate changeset applyer
Date: Fri, 2 Dec 2005 18:51:50 -0800
Message-ID: <20051203025150.GA13179@mail.yhbt.net>
References: <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com> <20051124074605.GA4789@mail.yhbt.net> <20051124074739.GB4789@mail.yhbt.net> <20051124074857.GC4789@mail.yhbt.net> <20051124075027.GD4789@mail.yhbt.net> <20051124075133.GE4789@mail.yhbt.net> <20051124075243.GF4789@mail.yhbt.net> <20051124075355.GG4789@mail.yhbt.net> <20051124075504.GH4789@mail.yhbt.net> <46a038f90512010902lb11c326p99af9ff99dacf9b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Dec 03 03:54:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiNVC-0004PO-TC
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 03:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVLCCvw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 21:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVLCCvw
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 21:51:52 -0500
Received: from hand.yhbt.net ([66.150.188.102]:65200 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1751170AbVLCCvv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 21:51:51 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 01BCC2DC03A; Fri,  2 Dec 2005 18:51:50 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90512010902lb11c326p99af9ff99dacf9b4@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13143>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Eric,
> 
> My test results are a bit of a mixed bag. On one hand, I'm satisfied
> that both fast and correct imports reach the same tree (minus file
> modes) for the same commit with the arch repos I imported.
> 
> On the other hand, with my "moodle" repo, the 'correct' import seems
> to have stop importing a lot earlier than it should have. I am
> re-running it now to try to continue from where it left off, but it's
> unclear why it abandoned -- I didn't see any error. How widely have
> you tested this method?

This was from the moodle repo I archive-mirrored locally a few weeks ago
for testing:

get_new: 6
get_tag: 0
import_or_tag: 0
replay: 356

Rerunning it doesn't seem to pull anymore.  IIRC, My previous times
only imported around ~150 patchsets.  The time it took to run this
was certainly longer than the last run (~4 hours here, vs ~2 hours
I mentioned in <20051124074605.GA4789@mail.yhbt.net>, so there may
be a bug somewhere...  Unfortunately, I no longer have those old
trees around.

I've imported several trees with >1000 revisions without problems,
mpd-uclinux is among them:

http://mpd.bogomips.org/mpd-uclinux.git/

-- 
Eric Wong
