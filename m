From: Toby Allsopp <Toby.Allsopp@navman.co.nz>
Subject: Re: [PATCH 2/2] git-svn: handle SVN merges from revisions past the tip of the branch
Date: Fri, 13 Nov 2009 14:03:19 +1300
Message-ID: <87ws1v44o8.fsf@navakl084.mitacad.com>
References: <871vk35o86.fsf@navakl084.mitacad.com>
	<4AFCAC9C.9020305@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Nov 13 02:03:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8kZe-0000Eq-5I
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 02:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbZKMBDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 20:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754067AbZKMBDS
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 20:03:18 -0500
Received: from ip-58-28-171-25.wxnz.net ([58.28.171.25]:59277 "EHLO
	AKLEXFE01.mitacad.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753594AbZKMBDS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 20:03:18 -0500
Received: from AKLEXVS01.mitacad.com ([10.112.5.36]) by AKLEXFE01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Nov 2009 14:03:21 +1300
Received: from navakl084.mitacad.com.navman.co.nz ([10.112.8.86]) by AKLEXVS01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Nov 2009 14:03:21 +1300
In-Reply-To: <4AFCAC9C.9020305@vilain.net> (Sam Vilain's message of "Fri, 13
	Nov 2009 13:47:24 +1300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
X-OriginalArrivalTime: 13 Nov 2009 01:03:21.0424 (UTC) FILETIME=[18038500:01CA63FD]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-6.000.1038-17006.003
X-TM-AS-Result: No--18.506600-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132812>

On Fri, Nov 13 2009, Sam Vilain wrote:

> Toby Allsopp wrote:
> > When recording the revisions that it has merged, SVN sets the top
> > revision to be the latest revision in the repository, which is not
> > necessarily a revision on the branch that is being merged from.  When
> > it is not on the branch, git-svn fails to add the extra parent to
> > represent the merge because it relies on finding the commit on the
> > branch that corresponds to the top of the SVN merge range.
>
> I thought, "that sounds like he's repeating himself, wait a sec..."

Hmm, it makes perfect sense to me :-)  Does the explanation in 1/2 make
more sense?

The first sentence describes what Subversion does, the second what
git-svn does in response.

> Thanks for contributing this.  There might be other bugs too, especially
> when upstream has a more complicated merge hierarchy ... apparently svn
> tends to get it wrong, so checking for all commits might not work in
> that case.

Oh yes, SVN gets the merges wrong in an alarming number of cases, it's
really shocking.  I only stay sane at work because I tell myself that
SVN is making the case for git for me :-)

> It would be nice if "dcommit" could make these commits, too...

Yes.

Toby.
