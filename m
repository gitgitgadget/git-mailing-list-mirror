From: Seth House <seth@eseth.com>
Subject: Conflict markers in mergetool $LOCAL ?
Date: Tue, 17 Aug 2010 04:34:20 +0000 (UTC)
Message-ID: <loom.20100817T054731-955@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 06:35:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlDtd-0001XB-Ku
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 06:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215Ab0HQEfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 00:35:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:54377 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938Ab0HQEfG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 00:35:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OlDt8-0001Pr-UQ
	for git@vger.kernel.org; Tue, 17 Aug 2010 06:35:03 +0200
Received: from ip65-44-116-164.z116-44-65.sendoutcards.net ([65.44.116.164])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 06:35:02 +0200
Received: from seth by ip65-44-116-164.z116-44-65.sendoutcards.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 06:35:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 65.44.116.164 (Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/534.6 (KHTML, like Gecko) Chrome/6.0.493.0 Safari/534.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153695>

Hello. I'm a recent convert from Mercurial; I'm enjoying the transition and am
feeling pretty comfortable with most of Git. However, I haven't used mergetool
much yet because it puts conflict markers in the "ours" pane -- but (even after
a chat in #git on IRC) I'm not sure if that is intended behavior or if my setup
is broken. I would appreciate some guidance.

For small conflicts, I like the conflict markers and simply editing the
conflicted file with Vim. For files with lots of conflicts I would like to use
vimdiff but I wouldn't expect the conflict markers to appear there -- it's
redundant information in a 3-way merge.

Is there a better Git Way (TM) that I'm missing? Is my Git setup borked
somehow?

I have the following in my ~/.gitconfig and a stock Git installation on Arch
Linux.

[merge]
    tool = vimdiff

[mergetool "vimdiff"]
    cmd = vimdiff
    trustExitCode = true
