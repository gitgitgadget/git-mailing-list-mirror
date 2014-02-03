From: Andreas Krey <a.krey@gmx.de>
Subject: Bug: git repack keeps temps on ENOSPC
Date: Mon, 3 Feb 2014 20:55:32 +0100
Message-ID: <20140203195532.GA13988@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 20:55:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPcK-0003Kn-Ey
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 20:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbaBCTzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 14:55:36 -0500
Received: from continuum.iocl.org ([217.140.74.2]:45915 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686AbaBCTzg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 14:55:36 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id s13JtWQ14724;
	Mon, 3 Feb 2014 20:55:32 +0100
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241466>

Hi,

I noticed that, when a git repack fails due to insufficient
disk space, the newly created partial pack file isn't unlinked
(which doesn't help at all in that situation).

(Will venture a look myself when time permits.)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
