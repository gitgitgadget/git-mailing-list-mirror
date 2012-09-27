From: Yann Dirson <ydirson@free.fr>
Subject: Showing all stashed changes in one go
Date: Thu, 27 Sep 2012 22:00:06 +0200
Message-ID: <20120927200006.GD6493@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 22:00:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THKG2-0006b2-2R
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 22:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617Ab2I0UAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 16:00:14 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:51788 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754082Ab2I0UAN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 16:00:13 -0400
X-Greylist: delayed 6247 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2012 16:00:12 EDT
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 7FC2CD48044
	for <git@vger.kernel.org>; Thu, 27 Sep 2012 22:00:07 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.80)
	(envelope-from <ydirson@free.fr>)
	id 1THKFi-0000fU-8P
	for git@vger.kernel.org; Thu, 27 Sep 2012 22:00:06 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206516>

When I have a couple of stashed changes, it gets annoying to
repeatedly call "git stash show -p stash@{N}" until finding the
correct one.

Since "git reflog show stash" already does part of the job, I thought
that adding "-p" there to see the patch would help (at least it would
show the not-yet-staged parts, which would already be a good start).

But the output is then really strange: does it really print the delta
between every two reflog entries ?  I can't think of a situation where
it would be was we want - but then, my imagination is known to be
deficient when I hit a situation that does not do what I was expecting
at first :)

Is there another way I missed to get all those stash contents listed,
besides scriptically iterating ?
