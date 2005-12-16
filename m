From: Sam Ravnborg <sam@ravnborg.org>
Subject: Why do we need [PATCH]?
Date: Fri, 16 Dec 2005 22:01:45 +0100
Message-ID: <20051216210145.GA25311@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 16 22:01:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnMhA-0003qE-7Y
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 22:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbVLPVAt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 16:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbVLPVAt
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 16:00:49 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:6950 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1750823AbVLPVAs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 16:00:48 -0500
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepb.post.tele.dk (Postfix) with ESMTP id CCB3E5EE047
	for <git@vger.kernel.org>; Fri, 16 Dec 2005 22:00:47 +0100 (CET)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 694C06AC07C; Fri, 16 Dec 2005 22:01:45 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13749>

Hi git's.

I've just applied a patch to my git tree using git-applymbox.
It worked like a charm as it often do.
But then when I did a quick check with gitk it stuck me that
the subject was prefixed with [PATCH].
I am aware that the [PATCH] in subject tell me:
"patch is received from somewhere and applied by me to the .git tree".
This is in comparsion to patches received when I merge a git tree for
example.

But with common practice to use sign-off I wonder the value of this
patch marker.
When browsing the kernel shortlog I often focus on first word in subject
- cause this tells me what system/drivers is changed. But with the
  [PATCH] marker I have to read some non-sense to see actual subject.

The information is redundant since metadata already tell me who is the
author and who committed the change.
So could we have it removed or if people continue to find it usefull
then at least hide it behind some option. Using the [PATCH] prefix is
not the natural thing to do with git.

I looked at the source and found the -k option, but adding [PATCH]
should not be default behaviour so this is not the correct solution.

	Sam
