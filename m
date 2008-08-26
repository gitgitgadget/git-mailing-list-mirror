From: Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk>
Subject: git-svn dcommit gone wrong and git-fsck
Date: Tue, 26 Aug 2008 17:37:36 +0100
Message-ID: <g91bgi$8cm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 18:38:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY1ZE-0005WS-9m
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 18:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756604AbYHZQhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 12:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756686AbYHZQhr
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 12:37:47 -0400
Received: from main.gmane.org ([80.91.229.2]:36672 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754289AbYHZQhr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 12:37:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KY1Y9-0002qz-JF
	for git@vger.kernel.org; Tue, 26 Aug 2008 16:37:45 +0000
Received: from rain.gmane.org ([80.91.229.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 16:37:45 +0000
Received: from Bruno.Harbulot by rain.gmane.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 16:37:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: rain.gmane.org
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93759>

Hello,

I had 11 consecutive commits in my local git repository that I was 
trying to commit to an SVN repository, using "git-svn dcommit". The 
first 7 worked fine, as usual. However, when sending the 8th, I got a 
"Bus error" (on OSX -- I'm not sure what the actual cause was).

A further "git-svn dcommit" produces this error.
Cannot dcommit with a dirty index.  Commit your changes first, or stash 
them with `git stash'.
  at /opt/local/bin/git-svn line 406

In addition, "gitk --all" no longer shows commits 8->11, but the current 
files seem to correspond to the last local commit.
I've run git-fsck which shows 3 dangling trees and about a dozen 
dangling blobs.

Apologies if it's a FAQ, but I can't seem to find much documentation on 
how this can be fixed (if it can). Is there a way to recover the missing 
commits and re-attach them back on the branch? (I had pushed that branch 
up to the 10th commit into another repository, which could help.)


Thank you,

Bruno.
