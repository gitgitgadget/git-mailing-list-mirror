From: Martin Stjernholm <mast@lysator.liu.se>
Subject: Display bug in gitk -S
Date: Fri, 21 Aug 2009 13:46:42 +0200
Message-ID: <5bocq9jsnx.fsf@lister.roxen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 14:12:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeSyw-0006KN-TZ
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 14:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055AbZHUMMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 08:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755013AbZHUMMQ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 08:12:16 -0400
Received: from mail.roxen.com ([212.247.29.220]:47845 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754992AbZHUMMO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 08:12:14 -0400
X-Greylist: delayed 1532 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2009 08:12:14 EDT
Received: from localhost (lister.roxen.com [212.247.28.136])
	by mail.roxen.com (Postfix) with ESMTP id E7146628119
	for <git@vger.kernel.org>; Fri, 21 Aug 2009 13:46:42 +0200 (CEST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126705>

The following applies to git 1.6.4.

I did a "git log -S" with some search term, and it filtered out seven
disconnected commits from a fairly large repository.

Then I tried "gitk -S" with the same term. In the upper pane I briefly
see the seven commits, each with a dot in a different column and a
down-pointing arrow. After a while (presumably when it has searched
through the whole repo and has discovered that the commits are
disconnected), the display is updated to include the preceding commits
as white dots. However, the total number of shown commits is still
restricted to seven, which means that I now only see the first four of
the commits I should see.
