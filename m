From: linux@horizon.com
Subject: Re: killing a branch
Date: 12 Jan 2006 04:57:02 -0500
Message-ID: <20060112095702.29064.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 10:57:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwzCn-0007kj-3u
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 10:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWALJ5O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 04:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWALJ5O
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 04:57:14 -0500
Received: from science.horizon.com ([192.35.100.1]:46650 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1030336AbWALJ5N
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 04:57:13 -0500
Received: (qmail 29065 invoked by uid 1000); 12 Jan 2006 04:57:02 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14556>

Note that "git prune" could be sped up ENORMOUSLY if git-fsck-cache
could be taught to (optionally) not open, uncompress, hash, and
verify any blob objects.  Just assume that they're okay.

I had a look at the code briefly, but it was a little bit hairier (a
more invasive change) than I felt like dealing with.
