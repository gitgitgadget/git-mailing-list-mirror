From: Chuck Lever <cel@citi.umich.edu>
Subject: [PATCH 0/2] allow patches called "applied", "current", and so on
Date: Sun, 29 Jan 2006 13:10:04 -0500
Message-ID: <20060129181004.1919.92166.stgit@dexter.citi.umich.edu>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 19:14:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3H3o-0001ma-M2
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 19:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWA2SN5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 13:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWA2SN5
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 13:13:57 -0500
Received: from citi.umich.edu ([141.211.133.111]:8246 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751093AbWA2SN5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 13:13:57 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id D49E81BC08;
	Sun, 29 Jan 2006 13:13:56 -0500 (EST)
To: catalin.marinas@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15227>

The following patches create a separate directory for patches so that patch
names like "applied" don't collide with the patch series control files.

A new option on the "stg branch" command allows users to convert between the
old-style (all in the same series directory) and the new-style (patches in a
separate directory).  "stg" should be good at detecting which type of
repository is in use and adapting to it, so this change should be entirely
invisible on legacy repositories.

        -- Chuck Lever
--
corporate:    <cel at netapp dot com>
personal:     <chucklever at bigfoot dot com>
