From: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: FFmpeg considering GIT
Date: Wed, 2 May 2007 09:29:33 +0000 (UTC)
Message-ID: <loom.20070502T111026-882@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 11:30:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjB9t-0000Wg-CE
	for gcvg-git@gmane.org; Wed, 02 May 2007 11:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992949AbXEBJ35 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 05:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992954AbXEBJ35
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 05:29:57 -0400
Received: from main.gmane.org ([80.91.229.2]:51563 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992949AbXEBJ34 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 05:29:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HjB9d-0000Xd-HD
	for git@vger.kernel.org; Wed, 02 May 2007 11:29:45 +0200
Received: from edm-005.edm.uhasselt.be ([193.190.10.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 May 2007 11:29:45 +0200
Received: from takis.issaris by edm-005.edm.uhasselt.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 May 2007 11:29:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.190.10.5 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.3) Gecko/20061201 Firefox/2.0.0.3 (Ubuntu-feisty))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46008>

Hi,

Some of the people of the FFmpeg project are looking at both GIT and Mercurial
as possible replacements for the current Subversion repository. They have some
questions regarding the possibility of doing certain things, which I prefer not
to answer as I am not sure my answer would be correct :) Which is why I am
posting here...

The questions are stated in this e-mail [1]. One of the things that are being
discussed is the following action on a publicly mirrored repository:
git branch -m master dead_end
git branch -m last_good master

I'd think this would fail as people could have pulled from the repository while
the "dead_end" commit was already available, right?

There are some other things the FFmpeg maintainer mentions, namely:
* He wants to be able to revert a commit in some way without "wiping" history.
That is without committing a patch which reverses the broken commit, as this
would pollute "git blame". The maintainer sees this as critical feature for
switching to git as it apparently can be doing using Subversion:
"in svn we can do this with svn cp from a specific
revission git and mercurial lack proper copy support"

* And finally, he noticed that when copying files, history is sometimes lost
(mentioned at the bottom of [1]).


Any answers are greatly appreciated, as I'd really like to see FFmpeg switch to
GIT.

With friendly regards,
Takis

[1]
http://article.gmane.org/gmane.comp.video.ffmpeg.devel/49673
[2]
http://article.gmane.org/gmane.comp.video.ffmpeg.devel/49656
