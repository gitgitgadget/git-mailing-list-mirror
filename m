From: Andreas Krey <a.krey@gmx.de>
Subject: git gc/prune runs again and again
Date: Tue, 3 Nov 2015 13:44:20 +0100
Message-ID: <20151103124420.GA10946@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 03 14:19:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtbUa-0007gs-5G
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 14:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbbKCNTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 08:19:11 -0500
Received: from continuum.iocl.org ([217.140.74.2]:58895 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbbKCNTL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 08:19:11 -0500
X-Greylist: delayed 2088 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2015 08:19:10 EST
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id tA3CiK911272;
	Tue, 3 Nov 2015 13:44:20 +0100
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280796>

Hi all,

I have a bit of an annoying behaviour in git gc;
there is a repo I regularly do a fetch in, and
this kicks off a gc/prune every time. I remember
there being a heuristic with being that many files
in .git/objects/17 as the gc trigger.

Which is unfortunate if the gc does not actually
reduce the number of files there because they
aren't old enough => gc comes right back.

What can I do there? (This git is a bit old, 2.2.2)

Andreas


-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
