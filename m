From: Andreas Krey <a.krey@gmx.de>
Subject: 'Failed to create .git/index.lock'
Date: Tue, 9 Feb 2016 08:58:29 +0100
Message-ID: <20160209075829.GA12331@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 08:58:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aT3C1-0000jg-2z
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 08:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbcBIH6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 02:58:33 -0500
Received: from continuum.iocl.org ([217.140.74.2]:37675 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbcBIH6d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 02:58:33 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id u197wTA12487;
	Tue, 9 Feb 2016 08:58:29 +0100
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285831>

Hi all,

I have a single workspace where executing merges
occasionally leads to a left-over .git/index.lock file
that prevents me from adding resolved conflicted files.

I'm running a sped-up integration/feature branch process,
and the merges and conflict resolution are automated.
But the index.lock thing is happening only in one repo
of the three that are doing this.

Any hints as to debugging this?

(It is not a running background gc, the lock file
is still around when there is nothing running
any more, for hours.)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
